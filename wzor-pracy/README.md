# Wzór pracy licencjackiej EPI

Wzór składa pracę zgodnie ze *Standardami prac dyplomowych EPI* oraz *Instrukcją ISI*:
pismo 12 pkt, interlinia 1,5, marginesy 2,5 cm, tytuły rozdziałów 18 pkt wytłuszczone
i wyśrodkowane, podrozdziały 14 pkt wytłuszczone do lewej, numeracja 1 / 1.1 / 1.1.1,
rozdziały od nowej strony, numer strony w prawym dolnym rogu, strona tytułowa liczona
bez numeru.

Na uczelnianą instalację Overleaf wzór wgrywasz jako gotową paczkę:
**[wzor-overleaf.zip](https://marekdejauj.github.io/epi-seminarium-Deja/wzor-pracy/wzor-overleaf.zip)**.
Paczka składana jest z tego katalogu przy każdej publikacji witryny, więc zawsze
odpowiada bieżącej wersji klasy i stylu bibliograficznego.

## Pliki

| Plik | Do czego służy |
|---|---|
| `main.tex` | Twoja praca. Uzupełniasz metadane, treść piszesz w `rozdzialy/` |
| `przyklad.tex` | dokument pokazowy ze wszystkimi elementami składu i wszystkimi postaciami powołań |
| `rozdzialy/*.tex` | rozdziały pracy z wbudowanymi wskazówkami do usunięcia |
| `bibliografia/literatura.bib` | bibliografia; wpisy wzorcowe odpowiadają przykładom z Instrukcji ISI |
| `epi-praca.cls` | klasa dokumentu – nie zmieniaj |
| `isi-uj.bbx`, `isi-uj.cbx` | styl bibliograficzny instytutowy – nie zmieniaj |
| `polish-apa.lbx` | polska lokalizacja wariantu APA 7 |
| `tools/policz_znaki.R` | kontrola objętości części zasadniczej |
| `tools/sprawdz-listingi.R` | kontrola znaków w listingach kodu |

## Kompilacja

Zalecany silnik to **LuaLaTeX**. Kod źródłowy oraz nazwy funkcji, argumentów i pakietów
w tekście składane są wtedy krojem JetBrains Mono.

Na Overleaf: *Menu → Compiler → LuaLaTeX*. Lokalnie:

```
latexmk -lualatex main.tex
```

Wzór kompiluje się także pod pdfLaTeX-em (`latexmk -pdf main.tex`). Klasa wykrywa silnik
sama; pod pdfLaTeX-em kod składany jest krojem Inconsolata.

## Przeniesienie na Overleaf

Pobierz repozytorium jako archiwum (*Code → Download ZIP* na GitHubie), rozpakuj,
spakuj sam katalog `wzor-pracy` i wgraj przez *New Project → Upload Project*.
Po utworzeniu projektu ustaw kompilator na LuaLaTeX i dokument główny na `main.tex`.

## Opcje klasy

Dopisujesz je w nawiasie kwadratowym: `\documentclass[stronyinfo,oprawa]{epi-praca}`.

| Opcja | Działanie |
|---|---|
| `stronyinfo` | dodaje stronę informacyjną z opisem bibliograficznym pracy, abstraktem i słowami kluczowymi; strona angielska powstaje, gdy wypełnisz `\tytulen`, `\abstrakten` i `\keywords` |
| `oprawa` | margines wewnętrzny 3,5 cm, zewnętrzny 1,5 cm |
| `dwustronnie` | druk dwustronny, numer strony w rogu zewnętrznym |
| `apa` | bibliografia w stylu APA 7 zamiast instytutowego |

## Polecenia wzoru

| Polecenie | Zastosowanie |
|---|---|
| `\fun{nazwa}` | nazwa funkcji, dopisuje nawiasy |
| `\argument{nazwa}` | nazwa argumentu |
| `\pkg{nazwa}` | nazwa pakietu |
| `\plik{ścieżka}` | nazwa pliku lub katalogu |
| `\kod{fragment}` | krótki fragment kodu w zdaniu |
| `\termin{słowo}` | wprowadzany termin, wyraz obcy, tytuł dzieła – kursywa |
| `\wyroznienie{tekst}` | wyróżnienie treściowe – wytłuszczenie |
| `\osoba{Nazwisko}{Imię}` | składa „Imię Nazwisko" i dopisuje pozycję do indeksu nazwisk |
| `\zrodlo{opis}` | wiersz źródła pod tabelą, rysunkiem lub wykresem |

Materiał ilustracyjny wstawiasz przez środowiska `tabelaepi`, `rysunekepi` i `wykresepi`.
Każde przyjmuje tytuł i etykietę, składa tytuł nad obiektem, a `\zrodlo` pod nim.
Numeracja jest ciągła przez całą pracę, osobna dla tabel, rysunków, wykresów i listingów.

```latex
\begin{rysunekepi}{Mapa decyzyjna wariantów}{rys:mapa}
\includegraphics[width=0.78\textwidth]{nazwa-pliku.png}
\zrodlo{oprac. własne}
\end{rysunekepi}
```

## Bibliografia

Styl domyślny odwzorowuje opisy z Instrukcji ISI: `Nazwisko, Imię (rok). Tytuł.
Miasto: Wydawca.` Powołania mają postać `(Kowalski 2010, s. 15-21)`.

W pliku `.bib`:

- pozycje obcojęzyczne oznacz `langid = {english}` – otrzymają oryginalne skróty
  `vol.` i `pp.` zamiast `nr` i `s.`;
- w pozycjach polskich numer czasopisma podawaj w polu `number`, w obcojęzycznych
  tom w polu `volume`;
- datę dzienną gazety wpisz w pole `issue`;
- normy opisuj wpisem `@misc` z polami `entrysubtype = {norma}` i `shorthand`;
- hasło encyklopedyczne bez własnego autora opisuj wpisem `@incollection` z polem
  `bookauthor`;
- pozycje sieciowe, które mają trafić do odrębnej netografii, oznacz
  `keywords = {netografia}`.

Powołania: `\parencite{klucz}`, `\parencite[s.~15-21]{klucz}`,
`\parencite{klucz1,klucz2}`, `\textcite{klucz}` w zdaniu.

Wariant `apa` używa pakietu `biblatex-apa` z polskimi łącznikami z pliku
`polish-apa.lbx`. Nazwy miesięcy w datach dostępu pozostają w formie właściwej dla
angielskiego zapisu APA, ponieważ styl definiuje własne makra składania dat.

## Kontrola przed oddaniem

```
Rscript tools/policz_znaki.R
Rscript tools/sprawdz-listingi.R
```

Pierwszy skrypt sprawdza limit 72 000 znaków ze spacjami dla części zasadniczej
(od Wprowadzenia do Podsumowania). Drugi sprawdza, czy wnętrza listingów zawierają
wyłącznie znaki ASCII.

Wnętrze listingu musi być zapisane bez polskich znaków diakrytycznych. Tablica znaków
pakietu `listings` obejmuje wyłącznie ASCII, więc pod LuaLaTeX-em polskie litery
w kodzie wychodzą przestawione. To samo ograniczenie nakłada sprawdzanie pakietu R,
które zgłasza znaki spoza ASCII w kodzie źródłowym jako problem przenośności.
Podpisy listingów są zwykłym tekstem pracy i polskich znaków używać mogą.

## Najczęstsze problemy

| Objaw | Przyczyna |
|---|---|
| pusta bibliografia | brak powołań w tekście albo klucz nieobecny w pliku `.bib` |
| `Citation ... undefined` | literówka w kluczu; po poprawce potrzebny pełny przebieg `latexmk` |
| brak indeksu nazwisk | żadnego `\osoba{}{}` w tekście albo przerwany przebieg `makeindex` |
| kod bez kroju JetBrains Mono | dokument skompilowany pdfLaTeX-em zamiast LuaLaTeX-em |
| przestawione litery w listingu | polskie znaki wewnątrz listingu |
