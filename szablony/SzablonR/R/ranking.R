#' Ranking alternatyw wazona suma ocen
#'
#' Funkcja normalizuje macierz decyzyjna, uwzglednia kierunek optymalizacji
#' kazdego kryterium, waży oceny i sumuje je do jednego wskaznika. Alternatywa
#' o najwyzszym wskazniku zajmuje pierwsze miejsce.
#'
#' Kierunek \code{"max"} oznacza kryterium, ktorego wysokie wartosci sa
#' pozadane, a \code{"min"} kryterium kosztowe, ktore przed wazeniem zostaje
#' odwrocone.
#'
#' @param macierz Macierz decyzyjna, zwykle wynik \code{\link{przygotuj_dane}}.
#' @param wagi Sposob wyznaczenia wag: \code{"entropia"}, \code{"std"},
#'   \code{"rowne"} albo wlasny wektor liczbowy o dlugosci rownej liczbie
#'   kryteriow.
#' @param kierunki Wektor znakowy o wartosciach \code{"max"} lub \code{"min"},
#'   dlugosci rownej liczbie kryteriow. Wartosc \code{NULL} oznacza, ze
#'   wszystkie kryteria sa maksymalizowane.
#'
#' @return Obiekt klasy \code{ranking_epi} zawierajacy skladniki:
#'   \describe{
#'     \item{wynik}{ramka danych z alternatywa, wskaznikiem i pozycja}
#'     \item{wagi}{wektor wag uzytych w obliczeniu}
#'     \item{kierunki}{kierunki optymalizacji kryteriow}
#'     \item{macierz}{macierz znormalizowana i zwazona}
#'   }
#'
#' @examples
#' model <- "Koszt  =~ koszt_surowce + koszt_praca
#'           Jakosc =~ jakosc_trwalosc + jakosc_ux"
#' macierz <- przygotuj_dane(dane_przykladowe, model)
#' wynik <- oblicz_ranking(macierz, wagi = "entropia",
#'                         kierunki = c("min", "max"))
#' wynik
#'
#' @export
oblicz_ranking <- function(macierz, wagi = "entropia", kierunki = NULL) {
  macierz <- sprawdz_macierz(macierz)
  n <- ncol(macierz)

  kierunki <- sprawdz_kierunki(kierunki, n, colnames(macierz))
  wagi <- ustal_wagi(wagi, macierz)

  znormalizowana <- macierz
  for (j in seq_len(n)) {
    kolumna <- skaluj_min_max(macierz[, j])
    if (kierunki[[j]] == "min") {
      kolumna <- 1 - kolumna
    }
    znormalizowana[, j] <- kolumna
  }

  zwazona <- sweep(znormalizowana, 2L, wagi, "*")
  wskaznik <- rowSums(zwazona)

  wynik <- data.frame(
    alternatywa = rownames(macierz) %||% paste0("A", seq_len(nrow(macierz))),
    wskaznik = as.numeric(wskaznik),
    pozycja = rank(-wskaznik, ties.method = "min"),
    stringsAsFactors = FALSE
  )
  wynik <- wynik[order(wynik$pozycja, wynik$alternatywa), , drop = FALSE]
  rownames(wynik) <- NULL

  structure(
    list(
      wynik = wynik,
      wagi = wagi,
      kierunki = kierunki,
      macierz = zwazona
    ),
    class = "ranking_epi"
  )
}


sprawdz_kierunki <- function(kierunki, n, nazwy) {
  if (is.null(kierunki)) {
    return(stats::setNames(rep("max", n), nazwy))
  }
  if (!is.character(kierunki) || length(kierunki) != n) {
    stop(sprintf("Argument `kierunki` musi byc wektorem znakowym dlugosci %d.", n),
         call. = FALSE)
  }
  niepoprawne <- setdiff(kierunki, c("max", "min"))
  if (length(niepoprawne)) {
    stop("Dozwolone kierunki to `max` i `min`. Otrzymano: ",
         paste(unique(niepoprawne), collapse = ", "), ".", call. = FALSE)
  }
  stats::setNames(kierunki, nazwy)
}


ustal_wagi <- function(wagi, macierz) {
  n <- ncol(macierz)

  if (is.character(wagi)) {
    if (length(wagi) != 1L) {
      stop("Nazwa metody wazenia musi byc pojedynczym lancuchem znakow.",
           call. = FALSE)
    }
    metoda <- match.arg(wagi, c("entropia", "std", "rowne"))
    return(switch(
      metoda,
      entropia = oblicz_wagi_entropia(macierz),
      std      = oblicz_wagi_std(macierz),
      rowne    = rownomierne(macierz)
    ))
  }

  if (!is.numeric(wagi) || length(wagi) != n) {
    stop(sprintf("Wektor wag musi byc liczbowy i miec dlugosc %d.", n),
         call. = FALSE)
  }
  if (any(wagi < 0)) {
    stop("Wagi nie moga byc ujemne.", call. = FALSE)
  }
  if (sum(wagi) <= .Machine$double.eps) {
    stop("Suma wag musi byc dodatnia.", call. = FALSE)
  }
  stats::setNames(wagi / sum(wagi), colnames(macierz))
}


`%||%` <- function(x, y) if (is.null(x)) y else x
