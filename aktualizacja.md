# Aktualizacja zasobu na kolejny rocznik

Zasób jest przygotowany do corocznego użycia. Poniżej to, co zmienia się co roku,
i to, co zmienia się rzadziej.

## Co roku

### Rocznik

Rok obrony pojawia się w trzech miejscach, zawsze jako wartość polecenia `\rok`:

| Plik | Wiersz |
|---|---|
| `wzor-pracy/main.tex` | `\rok{2027}` |
| `wzor-pracy/przyklad.tex` | `\rok{2027}` |
| `przewodnik/przewodnik.tex` | `\rok{2027}` |

Po zmianie złóż wzór i przewodnik od nowa, żeby odświeżyć pliki PDF:

```bash
cd wzor-pracy && latexmk -lualatex przyklad.tex
cd ../przewodnik && latexmk -lualatex przewodnik.tex
```

Wersja przewodnika w Markdown powstaje z plików LaTeX i trzeba ją wygenerować po
każdej zmianie treści:

```bash
python przewodnik/tools/generuj_md.py
```

### Harmonogram

[Trzydzieści tygodni](harmonogram/tygodnie.md) jest przypięte do numerów tygodni, nie
do dat, więc plik nie wymaga zmian. Na początek roku wystarczy raz przypisać tygodnie
do dat zgodnie z zarządzeniem o organizacji roku akademickiego i rozesłać tę tabelę.

Sprawdź, czy przerwy nadal wypadają tam, gdzie zakłada plan: świąteczna między
tygodniem 12 a 13, wielkanocna wewnątrz fazy siódmej. Jeżeli układ kalendarza jest
inny, przesuń granice faz, zachowując kolejność kamieni milowych.

### Przydział tematów

Tabela przydziału jest na końcu [zestawienia tematów](tematy/README.md) i czeka pusta
na wpisanie nazwisk po pierwszych zajęciach.

## Co kilka lat

### Wymiana tematów

Tematy opierają się na artykułach z ostatnich dwóch lat i po trzech lub czterech
latach część z nich się zestarzeje: powstaną implementacje autorskie, ukażą się prace
rozwijające metodę. Wymiana tematu obejmuje cztery kroki:

1. Weryfikacja artykułu według procedury opisanej w [nocie o doborze
   tematów](tematy/dobor-tematow.md). Krok obowiązkowy, nie formalność.
2. Sprawdzenie, czy autorzy nie udostępnili już gotowego pakietu.
3. Nowy plik `tematy/brief-NN.md` w układzie takim jak pozostałe.
4. Wpis w `tematy/zrodla/tematy.bib` oraz wiersz w tabeli w `tematy/README.md`.

Brief nie przepisuje wzorów z artykułu. Zawiera sekcję „co wynotować z artykułu",
która kieruje do właściwej sekcji publikacji. Zasada jest celowa: wzór przepisany bez
sprawdzenia w źródle powiela błąd, a student i tak musi przeczytać artykuł.

### Wymogi Instytutu

Wzór realizuje wymagania *Standardów prac dyplomowych na kierunku EPI* oraz
*Instrukcji ISI*. Przy nowelizacji któregokolwiek z tych dokumentów sprawdź:

- skład: krój, stopień pisma, interlinię, marginesy, numerację stron,
- układ elementów obowiązkowych i warunkowych,
- postać strony tytułowej wobec załącznika do Standardów,
- postać opisów bibliograficznych i powołań,
- treść noty wymaganej w serwisie.

Skład jest sterowany klasą `wzor-pracy/epi-praca.cls`, opisy bibliograficzne stylem
`isi-uj` w tym samym katalogu. Zmiana w jednym miejscu przechodzi na wszystkie
dokumenty, łącznie z przewodnikiem, który składa się tą samą klasą.

## Witryna

Witryna powstaje z plików Markdown w repozytorium. Nie ma osobnego źródła treści:
strona i repozytorium pokazują te same pliki.

**Włączenie.** W ustawieniach repozytorium, w sekcji Pages, źródłem publikacji ma być
GitHub Actions. Po każdej zmianie na gałęzi głównej przepływ pracy `Witryna` buduje
i publikuje serwis.

**Dodanie strony.** Nowy plik `.md` w dowolnym katalogu staje się podstroną
automatycznie. Plik `README.md` w katalogu staje się jego stroną główną. Odsyłacze
zapisuje się jako względne ścieżki do plików `.md`; działają wtedy zarówno w widoku
repozytorium, jak i na witrynie.

**Nawigacja.** Pozycje paska górnego są w `_config.yml`, w kluczu `nawigacja`.

**Wygląd.** Cały wygląd jest w `assets/style.css`. Nie ma zależności od zewnętrznego
motywu.

**Budowa lokalna**, jeżeli chcesz zobaczyć zmianę przed wysłaniem:

```bash
bundle install
bundle exec jekyll serve
```

## Przed rozdaniem materiałów

- [ ] Rok w trzech plikach `.tex` zgodny z rokiem obrony
- [ ] Wzór i przewodnik złożone od nowa, pliki PDF aktualne
- [ ] Wersja przewodnika w Markdown wygenerowana po zmianach w plikach LaTeX
- [ ] Szkielet pakietu przechodzi sprawdzenie w trybie zgodności
- [ ] Wszystkie briefy mają poprawne identyfikatory artykułów
- [ ] Tabela przydziału tematów pusta i gotowa do wypełnienia
- [ ] Witryna zbudowana bez błędów, odsyłacze działają
- [ ] Adres witryny w pliku `README.md` zgodny z rzeczywistym
