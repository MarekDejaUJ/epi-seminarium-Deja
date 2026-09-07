# SzablonR

<!-- badge: podmień nazwę użytkownika i repozytorium na własne -->
[![R-CMD-check](https://github.com/nazwauzytkownika/SzablonR/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/nazwauzytkownika/SzablonR/actions/workflows/R-CMD-check.yaml)

Szkielet pakietu badawczego przygotowany na seminarium licencjackie kierunku
elektroniczne przetwarzanie informacji. Nie jest gotowym narzędziem – jest
punktem wyjścia, który pokazuje układ oczekiwany przy sprawdzaniu zgodności
z repozytorium CRAN.

Zaimplementowana metoda jest celowo prosta: ważona suma znormalizowanych ocen
z wagami wyznaczanymi entropią Shannona. Chodzi o to, żeby każdy wynik dało się
policzyć ręcznie, a więc żeby testy mogły sprawdzać poprawność, a nie tylko
niezmienność.

## Co tu jest

| Ścieżka | Zawartość |
|---|---|
| `R/przygotowanie_danych.R` | walidacja wejścia, kody błędne, braki, agregacja do kryteriów |
| `R/wagi.R` | dwie metody wag obiektywnych, wspólna kontrola wejścia |
| `R/ranking.R` | silnik obliczeniowy, kierunki optymalizacji, obsługa wag własnych |
| `R/klasy_s3.R` | klasy wyniku z metodami `print` i `summary` |
| `R/wizualizacja.R` | metoda `plot` oraz wykres udziałów kryteriów |
| `data-raw/generuj_dane.R` | procedura generowania danych o znanej strukturze |
| `tests/testthat/` | trzy warstwy sprawdzania, opisane niżej |
| `vignettes/poradnik.Rmd` | pełna ścieżka analizy krok po kroku |
| `.github/workflows/` | sprawdzanie na macOS, Windows i Linuksie |

## Uruchomienie

```r
devtools::load_all()

model <- "Koszt   =~ koszt_surowce + koszt_praca
          Jakosc  =~ jakosc_trwalosc + jakosc_ux
          Dostawa =~ dostawa_niezawodnosc
          Rozwoj  =~ eko_co2 + eko_odpady"

macierz <- przygotuj_dane(dane_przykladowe, model)
wynik <- oblicz_ranking(macierz, wagi = "entropia",
                        kierunki = c("min", "max", "max", "max"))
summary(wynik)
plot(wynik)
```

## Trzy warstwy sprawdzania

Podział testów nie jest kwestią porządku, tylko tego, co każdy rodzaj testu
potrafi wykryć.

**Przypadki analityczne** (`test-wagi.R`, `test-ranking.R`) mają wynik
wyprowadzony ze wzoru, a nie zapisany po uruchomieniu kodu. Kryterium o stałej
wartości musi dostać wagę zero, bo jego entropia wynosi jeden – to wynika
z definicji, nie z implementacji. Test, którego oczekiwana wartość pochodzi
z własnego kodu, sprawdza jedynie, czy kod się nie zmienił.

**Testy własności** sprawdzają, co musi zachodzić niezależnie od danych: wagi
entropii nie zmieniają się po przeskalowaniu kryterium, ranking nie zależy od
kolejności wierszy, wskaźnik mieści się w przedziale jednostkowym. Wychwytują
błędy, których pojedynczy przypadek nie pokaże.

**Testy odporności** (`test-odpornosc.R`) podają dane, przy których metoda nie
ma sensu: braki, wartości nieskończone, wartości ujemne, jedna alternatywa.
Oczekiwanym wynikiem nie jest poprawna liczba, lecz **zatrzymanie wykonania
z czytelnym komunikatem**. Funkcja, która na takich danych zwraca wynik, jest
groźniejsza od tej, która odmawia działania.

Do tego dochodzi test odtwarzający strukturę zapisaną w procedurze generowania
danych: skoro alternatywy mają znaną ukrytą jakość malejącą od A do F, ranking
musi je ustawić w tej kolejności.

## Sprawdzenie lokalne

```r
devtools::document()
devtools::test()
devtools::check(args = c("--as-cran"), error_on = "note")
```

Cel to **0 błędów, 0 ostrzeżeń, 0 uwag**. Jeżeli pojawia się uwaga
`unable to verify current time`, ustaw zmienną środowiskową
`_R_CHECK_SYSTEM_CLOCK_=0` – dotyczy ona dostępu do zewnętrznego serwera czasu,
a nie pakietu.

## Zanim zaczniesz zmieniać

1. Zmień nazwę pakietu w pliku `DESCRIPTION`, w nazwie katalogu, w `tests/testthat.R`,
   w `inst/CITATION` i w nagłówku pliku `R/SzablonR-package.R`.
2. Wpisz swoje dane w polu `Authors@R` i w pliku `inst/CITATION`.
3. Napisz `SPEC.md` – kontrakt algorytmu spisuje się **przed** kodem.
4. Podmień procedurę w `data-raw/generuj_dane.R` na własną, ze strukturą właściwą
   dla Twojej metody.
5. Napisz testy analityczne dla swojego algorytmu, dopiero potem implementację.

## Konwencje

Nazwy funkcji i argumentów po polsku, wyłącznie znakami ASCII, bez znaków
diakrytycznych. Treść dokumentacji i komunikatów po polsku, w UTF-8. Pola
`DESCRIPTION` bez znaków diakrytycznych – sprawdzanie zgłasza je jako problem
przenośności.

## Licencja

GPL-3.
