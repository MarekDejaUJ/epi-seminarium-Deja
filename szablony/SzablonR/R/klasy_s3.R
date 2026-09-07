#' Wypisanie macierzy decyzyjnej
#'
#' @param x Obiekt klasy \code{macierz_decyzyjna}.
#' @param ... Argumenty przekazywane dalej, obecnie nieuzywane.
#'
#' @return Niewidocznie zwraca \code{x}. Wywolywana dla efektu ubocznego.
#'
#' @examples
#' macierz <- przygotuj_dane(dane_przykladowe, "Koszt =~ koszt_surowce")
#' print(macierz)
#'
#' @export
print.macierz_decyzyjna <- function(x, ...) {
  skladniki <- attr(x, "skladniki")
  cat("Macierz decyzyjna\n")
  cat(sprintf("  alternatywy: %d\n", nrow(x)))
  cat(sprintf("  kryteria:    %d\n", ncol(x)))
  cat(sprintf("  obserwacje:  %d\n\n", attr(x, "liczba_obserwacji")))
  for (kryterium in names(skladniki)) {
    cat(sprintf("  %s =~ %s\n", kryterium,
                paste(skladniki[[kryterium]], collapse = " + ")))
  }
  cat("\n")
  print(round(unclass(x)[, , drop = FALSE], 3))
  invisible(x)
}


#' Wypisanie rankingu
#'
#' @param x Obiekt klasy \code{ranking_epi}.
#' @param ... Argumenty przekazywane dalej, obecnie nieuzywane.
#'
#' @return Niewidocznie zwraca \code{x}. Wywolywana dla efektu ubocznego.
#'
#' @examples
#' macierz <- przygotuj_dane(dane_przykladowe, "Koszt =~ koszt_surowce")
#' print(oblicz_ranking(macierz))
#'
#' @export
print.ranking_epi <- function(x, ...) {
  cat("Ranking alternatyw\n\n")
  wynik <- x$wynik
  wynik$wskaznik <- round(wynik$wskaznik, 4)
  print(wynik, row.names = FALSE)
  cat("\n")
  invisible(x)
}


#' Podsumowanie rankingu
#'
#' Poza uporzadkowana lista alternatyw podsumowanie podaje wagi kryteriow
#' oraz rozpietosc wskaznika, ktora informuje, jak wyraznie ranking rozroznia
#' alternatywy. Rozpietosc bliska zeru oznacza, ze wynik jest wrazliwy na
#' drobne zmiany danych.
#'
#' @param object Obiekt klasy \code{ranking_epi}.
#' @param ... Argumenty przekazywane dalej, obecnie nieuzywane.
#'
#' @return Niewidocznie zwraca liste ze skladnikami \code{wynik}, \code{wagi}
#'   i \code{rozpietosc}. Wywolywana glownie dla efektu ubocznego.
#'
#' @examples
#' macierz <- przygotuj_dane(dane_przykladowe, "Koszt =~ koszt_surowce")
#' summary(oblicz_ranking(macierz))
#'
#' @export
summary.ranking_epi <- function(object, ...) {
  rozpietosc <- diff(range(object$wynik$wskaznik))

  cat("Ranking alternatyw\n\n")
  wynik <- object$wynik
  wynik$wskaznik <- round(wynik$wskaznik, 4)
  print(wynik, row.names = FALSE)

  cat("\nWagi kryteriow\n")
  print(round(object$wagi, 4))

  cat("\nKierunki optymalizacji\n")
  print(object$kierunki)

  cat(sprintf("\nRozpietosc wskaznika: %.4f\n", rozpietosc))
  if (rozpietosc < 0.05) {
    cat("Uwaga: alternatywy roznia sie nieznacznie, wynik jest niestabilny.\n")
  }

  invisible(list(wynik = object$wynik, wagi = object$wagi,
                 rozpietosc = rozpietosc))
}
