#' Przygotowanie macierzy decyzyjnej z surowej ramki danych
#'
#' Funkcja przeprowadza surowe dane przez cztery kroki: sprawdzenie warunkow
#' wstepnych, zamiane kodow bledych na braki danych, obsluge brakow oraz
#' agregacje zmiennych do kryteriow zadeklarowanych w modelu.
#'
#' Model zapisuje sie w skladni zblizonej do pakietu lavaan. Kazdy wiersz
#' deklaruje jedno kryterium i wymienia zmienne, ktore sie na nie skladaja:
#'
#' \preformatted{
#' Koszt  =~ koszt_surowce + koszt_praca
#' Jakosc =~ jakosc_trwalosc + jakosc_ux
#' }
#'
#' @param dane Ramka danych z kolumna identyfikujaca alternatywy oraz
#'   zmiennymi surowymi.
#' @param model Znakowy opis modelu w skladni opisanej wyzej.
#' @param alternatywa Nazwa kolumny identyfikujacej alternatywy.
#' @param braki Sposob obslugi brakow danych: \code{"mediana"} zastepuje brak
#'   mediana kolumny, \code{"usun"} usuwa wiersz, \code{"blad"} zatrzymuje
#'   wykonanie.
#' @param kody_bledne Wektor wartosci traktowanych jako kod bledu i zamienianych
#'   na brak danych przed dalszym przetwarzaniem.
#'
#' @return Obiekt klasy \code{macierz_decyzyjna}: macierz o wierszach
#'   odpowiadajacych alternatywom i kolumnach odpowiadajacych kryteriom,
#'   z atrybutami \code{skladniki} oraz \code{liczba_obserwacji}.
#'
#' @examples
#' model <- "Koszt  =~ koszt_surowce + koszt_praca
#'           Jakosc =~ jakosc_trwalosc + jakosc_ux"
#' macierz <- przygotuj_dane(dane_przykladowe, model)
#' macierz
#'
#' @export
przygotuj_dane <- function(dane,
                           model,
                           alternatywa = "alternatywa",
                           braki = c("mediana", "usun", "blad"),
                           kody_bledne = c(-999, 999)) {
  braki <- match.arg(braki)

  if (!is.data.frame(dane)) {
    stop("Argument `dane` musi byc ramka danych.", call. = FALSE)
  }
  if (!nrow(dane)) {
    stop("Ramka danych jest pusta.", call. = FALSE)
  }
  if (!alternatywa %in% names(dane)) {
    stop(sprintf("Brak kolumny `%s` identyfikujacej alternatywy.", alternatywa),
         call. = FALSE)
  }

  skladniki <- rozbierz_model(model)
  wymagane <- unlist(skladniki, use.names = FALSE)
  brakujace <- setdiff(wymagane, names(dane))
  if (length(brakujace)) {
    stop("Zmienne zadeklarowane w modelu, a nieobecne w danych: ",
         paste(brakujace, collapse = ", "), ".", call. = FALSE)
  }

  liczbowe <- vapply(dane[wymagane], is.numeric, logical(1))
  if (!all(liczbowe)) {
    stop("Zmienne modelu musza byc liczbowe. Nieliczbowe: ",
         paste(wymagane[!liczbowe], collapse = ", "), ".", call. = FALSE)
  }

  robocze <- dane
  if (length(kody_bledne)) {
    for (zm in wymagane) {
      robocze[[zm]][robocze[[zm]] %in% kody_bledne] <- NA_real_
    }
  }
  robocze <- obsluz_braki(robocze, wymagane, braki)

  grupa <- as.character(robocze[[alternatywa]])
  etykiety <- unique(grupa)
  macierz <- matrix(NA_real_, nrow = length(etykiety), ncol = length(skladniki),
                    dimnames = list(etykiety, names(skladniki)))

  for (kryterium in names(skladniki)) {
    zmienne <- skladniki[[kryterium]]
    znormalizowane <- vapply(robocze[zmienne], skaluj_min_max, numeric(nrow(robocze)))
    if (!is.matrix(znormalizowane)) {
      znormalizowane <- matrix(znormalizowane, ncol = length(zmienne))
    }
    wartosci <- rowMeans(znormalizowane)
    macierz[, kryterium] <- vapply(
      etykiety,
      function(e) mean(wartosci[grupa == e]),
      numeric(1)
    )
  }

  if (anyNA(macierz)) {
    stop("Macierz decyzyjna zawiera braki danych po agregacji. ",
         "Sprawdz, czy kazda alternatywa ma obserwacje dla kazdego kryterium.",
         call. = FALSE)
  }

  structure(
    macierz,
    skladniki = skladniki,
    liczba_obserwacji = nrow(robocze),
    class = c("macierz_decyzyjna", "matrix", "array")
  )
}


#' Rozbior opisu modelu na kryteria i zmienne
#'
#' @param model Znakowy opis modelu w skladni opisanej w \code{\link{przygotuj_dane}}.
#'
#' @return Nazwana lista wektorow znakowych. Nazwy sa kryteriami, elementy
#'   nazwami zmiennych skladowych.
#'
#' @examples
#' rozbierz_model("Koszt =~ a + b")
#'
#' @export
rozbierz_model <- function(model) {
  if (!is.character(model) || length(model) != 1L || !nzchar(trimws(model))) {
    stop("Argument `model` musi byc niepustym lancuchem znakow.", call. = FALSE)
  }

  wiersze <- unlist(strsplit(model, "[\n;]"))
  wiersze <- trimws(wiersze)
  wiersze <- wiersze[nzchar(wiersze)]

  if (!length(wiersze)) {
    stop("Model nie zawiera zadnej deklaracji kryterium.", call. = FALSE)
  }
  if (!all(grepl("=~", wiersze, fixed = TRUE))) {
    stop("Kazdy wiersz modelu musi zawierac operator `=~`.", call. = FALSE)
  }

  skladniki <- lapply(wiersze, function(w) {
    czesci <- strsplit(w, "=~", fixed = TRUE)[[1]]
    zmienne <- trimws(unlist(strsplit(czesci[2], "+", fixed = TRUE)))
    zmienne[nzchar(zmienne)]
  })
  names(skladniki) <- vapply(
    wiersze,
    function(w) trimws(strsplit(w, "=~", fixed = TRUE)[[1]][1]),
    character(1)
  )

  puste <- names(skladniki)[lengths(skladniki) == 0L]
  if (length(puste)) {
    stop("Kryteria bez zadnej zmiennej: ", paste(puste, collapse = ", "), ".",
         call. = FALSE)
  }
  if (anyDuplicated(names(skladniki))) {
    stop("Nazwy kryteriow musza byc unikalne.", call. = FALSE)
  }

  skladniki
}


#' Skalowanie wektora do przedzialu jednostkowego
#'
#' Zmienna o zerowym rozrzucie otrzymuje wartosc stala rowna 0,5, poniewaz
#' nie rozroznia alternatyw, a jej usuniecie zmienialoby model zadeklarowany
#' przez uzytkownika.
#'
#' @param x Wektor liczbowy.
#'
#' @return Wektor liczbowy o wartosciach z przedzialu od 0 do 1.
#'
#' @examples
#' skaluj_min_max(c(2, 4, 6))
#'
#' @export
skaluj_min_max <- function(x) {
  if (!is.numeric(x)) {
    stop("Argument `x` musi byc wektorem liczbowym.", call. = FALSE)
  }
  zakres <- range(x, na.rm = TRUE)
  if (!all(is.finite(zakres))) {
    stop("Wektor nie zawiera zadnej wartosci skonczonej.", call. = FALSE)
  }
  if (isTRUE(all.equal(zakres[1], zakres[2]))) {
    return(rep(0.5, length(x)))
  }
  (x - zakres[1]) / (zakres[2] - zakres[1])
}


obsluz_braki <- function(dane, zmienne, sposob) {
  if (!anyNA(dane[zmienne])) {
    return(dane)
  }
  if (sposob == "blad") {
    stop("Dane zawieraja braki, a wybrano obsluge `blad`.", call. = FALSE)
  }
  if (sposob == "usun") {
    pelne <- stats::complete.cases(dane[zmienne])
    if (!any(pelne)) {
      stop("Po usunieciu brakow nie zostala zadna obserwacja.", call. = FALSE)
    }
    return(dane[pelne, , drop = FALSE])
  }
  for (zm in zmienne) {
    brak <- is.na(dane[[zm]])
    if (any(brak)) {
      dane[[zm]][brak] <- stats::median(dane[[zm]], na.rm = TRUE)
    }
  }
  dane
}
