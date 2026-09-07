#' Przykladowy zbior ocen alternatyw
#'
#' Zbior wygenerowany procedura o znanej strukturze zaleznosci, opisana
#' w pliku \code{data-raw/generuj_dane.R}. Kazda z szesciu alternatyw ma ukryta
#' jakosc malejaca od A do F, a zmienne surowe powstaja jako funkcje tej
#' jakosci powiekszone o szum. Poprawnie dzialajacy ranking powinien odtworzyc
#' kolejnosc liter, wiec odchylenie od niej wskazuje na blad implementacji.
#'
#' Zbior zawiera kontrolowane zanieczyszczenia: wartosc 999 w kolumnie
#' \code{jakosc_ux} odpowiada bledowi wprowadzania danych, a braki w kolumnie
#' \code{eko_odpady} pominietym odpowiedziom. Oba przypadki sluza do sprawdzania
#' odpornosci funkcji przygotowujacej dane.
#'
#' @format Ramka danych o 120 wierszach i 10 zmiennych:
#' \describe{
#'   \item{alternatywa}{Oznaczenie alternatywy, od A do F}
#'   \item{ekspert}{Numer oceniajacego w obrebie alternatywy}
#'   \item{koszt_surowce}{Koszt surowcow, rozklad log-normalny}
#'   \item{koszt_praca}{Koszt robocizny, rozklad log-normalny}
#'   \item{jakosc_trwalosc}{Ocena trwalosci w skali od 1 do 5}
#'   \item{jakosc_ux}{Ocena wygody uzytkowania w skali od 1 do 5; zawiera kod 999}
#'   \item{dostawa_czas}{Sredni czas dostawy w dniach}
#'   \item{dostawa_niezawodnosc}{Odsetek dostaw terminowych}
#'   \item{eko_co2}{Ocena emisji w skali od 1 do 7}
#'   \item{eko_odpady}{Ocena gospodarki odpadami w skali od 1 do 7; zawiera braki}
#' }
#'
#' @source Dane symulowane, \code{data-raw/generuj_dane.R}.
#'
#' @examples
#' summary(dane_przykladowe$koszt_surowce)
#' table(dane_przykladowe$alternatywa)
"dane_przykladowe"
