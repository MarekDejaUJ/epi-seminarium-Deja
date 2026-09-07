#' Wagi obiektywne metoda entropii Shannona
#'
#' Kryterium, w ktorym oceny alternatyw sa do siebie zblizone, niesie malo
#' informacji rozniczujacej i otrzymuje wage nizsza. Procedura sklada sie
#' z trzech krokow: normalizacji sumacyjnej, wyznaczenia entropii kolumny
#' oraz zamiany rozbieznosci na wagi sumujace sie do jednosci.
#'
#' Dla macierzy o \eqn{m} alternatywach entropia kolumny \eqn{j} wynosi
#' \eqn{e_j = -k \sum_i p_{ij} \ln p_{ij}}, gdzie \eqn{k = 1 / \ln(m)},
#' a \eqn{p_{ij}} to udzial alternatywy w sumie kolumny. Waga powstaje
#' z rozbieznosci \eqn{d_j = 1 - e_j} po znormalizowaniu do sumy jeden.
#'
#' Kolumna o zerowym rozrzucie ma entropie rowna jednosci, wiec jej
#' rozbieznosc wynosi zero. Gdy wszystkie kolumny sa stale, wagi nie daja
#' sie wyznaczyc i funkcja zwraca rozklad rownomierny.
#'
#' @param macierz Macierz liczbowa o nieujemnych wartosciach: wiersze to
#'   alternatywy, kolumny to kryteria.
#'
#' @return Nazwany wektor wag sumujacych sie do jednosci.
#'
#' @examples
#' m <- matrix(c(1, 2, 3, 4, 4, 4), nrow = 3,
#'             dimnames = list(NULL, c("a", "b")))
#' oblicz_wagi_entropia(m)
#'
#' @export
oblicz_wagi_entropia <- function(macierz) {
  macierz <- sprawdz_macierz(macierz)

  m <- nrow(macierz)
  if (m < 2L) {
    stop("Entropia wymaga co najmniej dwoch alternatyw.", call. = FALSE)
  }

  sumy <- colSums(macierz)
  if (any(sumy <= 0)) {
    stop("Kazde kryterium musi miec dodatnia sume ocen.", call. = FALSE)
  }

  p <- sweep(macierz, 2L, sumy, "/")
  skladnik <- ifelse(p > 0, p * log(p), 0)
  e <- -colSums(skladnik) / log(m)
  d <- pmax(1 - e, 0)

  if (sum(d) <= .Machine$double.eps) {
    return(rownomierne(macierz))
  }
  stats::setNames(d / sum(d), colnames(macierz))
}


#' Wagi obiektywne oparte na odchyleniu standardowym
#'
#' Waga kryterium jest proporcjonalna do odchylenia standardowego jego ocen.
#' Metoda jest prostsza od entropii i sluzy jako punkt odniesienia przy
#' sprawdzaniu, czy wynik rankingu nie zalezy nadmiernie od sposobu wazenia.
#'
#' @inheritParams oblicz_wagi_entropia
#'
#' @return Nazwany wektor wag sumujacych sie do jednosci.
#'
#' @examples
#' m <- matrix(c(1, 2, 3, 4, 4, 4), nrow = 3,
#'             dimnames = list(NULL, c("a", "b")))
#' oblicz_wagi_std(m)
#'
#' @export
oblicz_wagi_std <- function(macierz) {
  macierz <- sprawdz_macierz(macierz)

  if (nrow(macierz) < 2L) {
    stop("Odchylenie standardowe wymaga co najmniej dwoch alternatyw.",
         call. = FALSE)
  }

  s <- apply(macierz, 2L, stats::sd)
  if (sum(s) <= .Machine$double.eps) {
    return(rownomierne(macierz))
  }
  stats::setNames(s / sum(s), colnames(macierz))
}


#' Wagi rownomierne
#'
#' @inheritParams oblicz_wagi_entropia
#'
#' @return Nazwany wektor wag o rownych wartosciach.
#'
#' @keywords internal
#' @noRd
rownomierne <- function(macierz) {
  n <- ncol(macierz)
  stats::setNames(rep(1 / n, n), colnames(macierz))
}


sprawdz_macierz <- function(macierz) {
  if (inherits(macierz, "macierz_decyzyjna")) {
    macierz <- unclass(macierz)
    attr(macierz, "skladniki") <- NULL
    attr(macierz, "liczba_obserwacji") <- NULL
  }
  if (!is.matrix(macierz) || !is.numeric(macierz)) {
    stop("Argument `macierz` musi byc liczbowa macierza.", call. = FALSE)
  }
  if (nrow(macierz) < 1L || ncol(macierz) < 1L) {
    stop("Macierz musi miec co najmniej jeden wiersz i jedna kolumne.",
         call. = FALSE)
  }
  if (anyNA(macierz)) {
    stop("Macierz zawiera braki danych.", call. = FALSE)
  }
  if (!all(is.finite(macierz))) {
    stop("Macierz zawiera wartosci nieskonczone.", call. = FALSE)
  }
  if (any(macierz < 0)) {
    stop("Macierz zawiera wartosci ujemne, ktorych metody wazenia nie obsluguja.",
         call. = FALSE)
  }
  if (is.null(colnames(macierz))) {
    colnames(macierz) <- paste0("kryterium_", seq_len(ncol(macierz)))
  }
  macierz
}
