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
| `vignettes/articles/` | strony serwisu: opis algorytmu z cytowaniami, nota o serwisie |
| `inst/shiny-app/app.R` | aplikacja działająca w przeglądarce |
| `_pkgdown.yml` | konfiguracja serwisu |
| `tools/` | eksport aplikacji do postaci uruchamialnej w przeglądarce |
| `.github/workflows/` | sprawdzanie na trzech systemach oraz publikacja serwisu |

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

## Serwis

Standardy prac dyplomowych EPI wymagają, żeby projektowi towarzyszył serwis
internetowy. Szkielet buduje go z trzech części.

**Dokumentacja pakietu** powstaje z bloków `roxygen2` – każda funkcja publiczna
dostaje stronę z argumentami, wartością zwracaną i przykładem.

**Opis algorytmu** (`vignettes/articles/algorytm.Rmd`) to strona z wzorami,
założeniami, granicami stosowalności i cytowaniami literatury. Cytowania
działają jak w pracy: plik `literatura.bib` obok, odwołania w nawiasach
kwadratowych, bibliografia na końcu.

**Nota o serwisie** (`vignettes/articles/o-serwisie.Rmd`) zawiera treść wymaganą
Załącznikiem nr 2 do Standardów. Ta sama treść musi znaleźć się w aneksie pracy.

**Aplikacja** działa w przeglądarce bez serwera R – obliczenia wykonują się
po stronie użytkownika, dane nie są nigdzie wysyłane.

```r
pkgdown::build_site()
```

```bash
Rscript tools/eksport_shinylive.R
```

Podgląd lokalny: otwórz `docs/index.html`, a aplikację przez
`httpuv::runStaticServer("docs/app")`.

### Dlaczego katalog `docs` nie trafia do repozytorium

Eksport aplikacji waży około osiemdziesięciu megabajtów, bo zawiera całe
środowisko R skompilowane do postaci uruchamialnej w przeglądarce. Wysłanie go
do repozytorium oznacza, że **każda przebudowa dokłada do historii kolejną kopię
tej samej wagi**, a historii Gita nie da się potem zmniejszyć bez przepisania
całego repozytorium.

Dlatego `docs/` jest w `.gitignore`, a serwis publikuje przepływ pracy
`.github/workflows/strona.yaml`: buduje dokumentację i aplikację przy każdej
zmianie i wysyła wynik na osobną gałąź `gh-pages` jako **jeden commit**, który
za każdym razem zastępuje poprzedni.

Po pierwszym przebiegu włącz publikację w ustawieniach repozytorium: *Settings →
Pages → Deploy from a branch → gh-pages / (root)*. Adres, który tam zobaczysz,
wpisujesz na stronie tytułowej pracy.

## Zanim zaczniesz zmieniać

1. Zmień nazwę pakietu w pliku `DESCRIPTION`, w nazwie katalogu, w `tests/testthat.R`,
   w `inst/CITATION`, w nagłówku pliku `R/SzablonR-package.R` oraz w adresach
   w `_pkgdown.yml`.
2. Wpisz swoje dane w polu `Authors@R`, w pliku `inst/CITATION` oraz w nocie
   w `vignettes/articles/o-serwisie.Rmd`.
3. Napisz `SPEC.md` – kontrakt algorytmu spisuje się **przed** kodem.
4. Podmień procedurę w `data-raw/generuj_dane.R` na własną, ze strukturą właściwą
   dla Twojej metody.
5. Napisz testy analityczne dla swojego algorytmu, dopiero potem implementację.
6. Przepisz `vignettes/articles/algorytm.Rmd` na swoją metodę wraz z bibliografią
   i podmień listę zmiennych w aplikacji.

## Konwencje

Nazwy funkcji i argumentów po polsku, wyłącznie znakami ASCII, bez znaków
diakrytycznych. Treść dokumentacji i komunikatów po polsku, w UTF-8. Pola
`DESCRIPTION` bez znaków diakrytycznych – sprawdzanie zgłasza je jako problem
przenośności.

## Licencja

GPL-3.
