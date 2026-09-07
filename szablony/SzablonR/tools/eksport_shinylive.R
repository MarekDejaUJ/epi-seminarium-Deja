# Eksport aplikacji do postaci dzialajacej w przegladarce.
#
# Wynik trafia do katalogu docs/app, obok strony budowanej przez pkgdown.
# Aplikacja dziala wtedy bez serwera R: obliczenia wykonuja sie w przegladarce.
#
# Uruchomienie z katalogu glownego pakietu:
#     Rscript tools/eksport_shinylive.R
#
# Uwaga o rozmiarze. Eksport wazy okolo stu megabajtow, bo zawiera cale
# srodowisko R skompilowane do postaci uruchamialnej w przegladarce. Katalogu
# docs nie wysylamy do repozytorium: kazda przebudowa dokladalaby do historii
# kolejna kopie tej samej wagi, a historii Gita nie da sie potem zmniejszyc.
# Strone publikuje przeplyw pracy w katalogu .github/workflows, ktory buduje ja
# przy kazdej zmianie i wysyla na osobna galaz.

if (!requireNamespace("shinylive", quietly = TRUE)) {
  stop("Zainstaluj pakiet shinylive: install.packages(\"shinylive\")",
       call. = FALSE)
}

KATALOG_APLIKACJI <- "inst/shiny-app"
KATALOG_DOCELOWY  <- file.path("docs", "app")

if (!dir.exists(KATALOG_APLIKACJI)) {
  stop("Nie znaleziono katalogu ", KATALOG_APLIKACJI, call. = FALSE)
}

# Aplikacja uruchamiana w przegladarce nie ma zainstalowanego pakietu, wiec
# potrzebuje kopii plikow z katalogu R oraz danych w formacie czytanym bez
# mechanizmu lazy loading.
tymczasowy <- tempfile("aplikacja-")
dir.create(tymczasowy, recursive = TRUE)
on.exit(unlink(tymczasowy, recursive = TRUE, force = TRUE), add = TRUE)

file.copy(file.path(KATALOG_APLIKACJI, "app.R"), tymczasowy)

pliki_r <- c("przygotowanie_danych.R", "wagi.R", "ranking.R",
             "klasy_s3.R", "wizualizacja.R")
for (plik in pliki_r) {
  zrodlo <- file.path("R", plik)
  if (!file.exists(zrodlo)) {
    stop("Brak pliku ", zrodlo, " wymaganego przez aplikacje.", call. = FALSE)
  }
  file.copy(zrodlo, file.path(tymczasowy, plik))
}

if (!file.exists("data/dane_przykladowe.rda")) {
  stop("Brak zbioru danych. Uruchom najpierw data-raw/generuj_dane.R",
       call. = FALSE)
}
srodowisko <- new.env()
load("data/dane_przykladowe.rda", envir = srodowisko)
saveRDS(srodowisko$dane_przykladowe,
        file.path(tymczasowy, "dane_przykladowe.rds"))

if (dir.exists(KATALOG_DOCELOWY)) {
  unlink(KATALOG_DOCELOWY, recursive = TRUE, force = TRUE)
}
dir.create(KATALOG_DOCELOWY, recursive = TRUE, showWarnings = FALSE)

message("Eksport aplikacji do ", KATALOG_DOCELOWY, " ...")
shinylive::export(appdir = tymczasowy, destdir = KATALOG_DOCELOWY)

rozmiar <- sum(file.size(list.files(KATALOG_DOCELOWY, recursive = TRUE,
                                    full.names = TRUE)), na.rm = TRUE)
message(sprintf("Gotowe. Rozmiar eksportu: %.0f MB.", rozmiar / 1024^2))
message("Podglad lokalny: httpuv::runStaticServer(\"", KATALOG_DOCELOWY, "\")")
