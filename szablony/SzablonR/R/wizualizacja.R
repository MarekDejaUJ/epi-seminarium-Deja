#' Wykres rankingu alternatyw
#'
#' Wykres slupkowy uporzadkowany wedlug wskaznika. Alternatywy o wskazniku
#' zblizonym do siebie widac na nim od razu, co jest istotniejsze niz sama
#' kolejnosc: bliskie slupki oznaczaja, ze roznica moze wynikac z szumu
#' w danych, a nie z rzeczywistej przewagi.
#'
#' @param x Obiekt klasy \code{ranking_epi}.
#' @param tytul Tytul wykresu.
#' @param ... Argumenty przekazywane dalej, obecnie nieuzywane.
#'
#' @return Obiekt klasy \code{ggplot}.
#'
#' @examples
#' macierz <- przygotuj_dane(dane_przykladowe, "Koszt =~ koszt_surowce")
#' plot(oblicz_ranking(macierz))
#'
#' @export
plot.ranking_epi <- function(x, tytul = "Ranking alternatyw", ...) {
  dane <- x$wynik
  dane$alternatywa <- factor(dane$alternatywa,
                             levels = rev(dane$alternatywa[order(dane$pozycja)]))

  ggplot2::ggplot(
    dane,
    ggplot2::aes(x = wskaznik, y = alternatywa)
  ) +
    ggplot2::geom_col(fill = "#2E5E9E", width = 0.65) +
    ggplot2::geom_text(
      ggplot2::aes(label = sprintf("%.3f", wskaznik)),
      hjust = -0.15, size = 3.2
    ) +
    ggplot2::scale_x_continuous(expand = ggplot2::expansion(mult = c(0, 0.12))) +
    ggplot2::labs(x = "Wskaznik", y = NULL, title = tytul) +
    ggplot2::theme_minimal(base_size = 11) +
    ggplot2::theme(panel.grid.major.y = ggplot2::element_blank())
}


#' Wykres udzialu kryteriow we wskazniku
#'
#' Rozklada wskaznik kazdej alternatywy na wklady poszczegolnych kryteriow.
#' Pozwala odpowiedziec na pytanie, dlaczego dana alternatywa zajela swoja
#' pozycje, a nie tylko jaka pozycje zajela.
#'
#' @param x Obiekt klasy \code{ranking_epi}.
#' @param tytul Tytul wykresu.
#'
#' @return Obiekt klasy \code{ggplot}.
#'
#' @examples
#' model <- "Koszt  =~ koszt_surowce + koszt_praca
#'           Jakosc =~ jakosc_trwalosc + jakosc_ux"
#' macierz <- przygotuj_dane(dane_przykladowe, model)
#' wykres_udzialow(oblicz_ranking(macierz))
#'
#' @export
wykres_udzialow <- function(x, tytul = "Udzial kryteriow we wskazniku") {
  if (!inherits(x, "ranking_epi")) {
    stop("Argument `x` musi byc obiektem klasy `ranking_epi`.", call. = FALSE)
  }

  macierz <- x$macierz
  dlugie <- data.frame(
    alternatywa = rep(rownames(macierz), times = ncol(macierz)),
    kryterium = rep(colnames(macierz), each = nrow(macierz)),
    wklad = as.numeric(macierz),
    stringsAsFactors = FALSE
  )
  kolejnosc <- x$wynik$alternatywa[order(x$wynik$pozycja)]
  dlugie$alternatywa <- factor(dlugie$alternatywa, levels = rev(kolejnosc))

  ggplot2::ggplot(
    dlugie,
    ggplot2::aes(x = wklad, y = alternatywa, fill = kryterium)
  ) +
    ggplot2::geom_col(width = 0.65) +
    ggplot2::labs(x = "Wklad we wskaznik", y = NULL, fill = "Kryterium",
                  title = tytul) +
    ggplot2::theme_minimal(base_size = 11) +
    ggplot2::theme(panel.grid.major.y = ggplot2::element_blank())
}
