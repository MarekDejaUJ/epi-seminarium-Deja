# Bibliografia: plik `.bib` i Zotero

Bibliografia w Twojej pracy powstaje automatycznie z pliku
`wzor-pracy/bibliografia/literatura.bib`. Nie składasz jej ręcznie i nie sortujesz —
robi to styl `isi-uj`, odwzorowujący opisy z Instrukcji ISI.

Twoje zadanie sprowadza się do jednego: **poprawnych wpisów w pliku `.bib`**.
Opis wychodzi wtedy zgodny z wymogami sam.

Zasada, której pilnuje recenzent: *bibliografia zawiera wyłącznie pozycje faktycznie
wykorzystane, do których odsyłają powołania w tekście*. Pozycje przeczytane, ale
niewykorzystane, do bibliografii nie trafiają.

**Prowadź plik `.bib` od pierwszego dnia.** Odtwarzanie bibliografii po napisaniu pracy
zajmuje kilka dni i zawsze kończy się brakującym numerem strony.

---

## Anatomia wpisu

```bibtex
@book{cisek2002filozoficzne,
  author    = {Cisek, Sabina},
  year      = {2002},
  title     = {Filozoficzne aspekty informacji naukowej},
  location  = {Kraków},
  publisher = {Wydaw. UJ},
  langid    = {polish},
}
```

| Element | Znaczenie |
|---|---|
| `@book` | typ wpisu — decyduje o postaci opisu |
| `cisek2002filozoficzne` | klucz cytowania, którym powołujesz się w tekście |
| `author = {...}` | pole; wartość zawsze w nawiasach klamrowych |

Powołanie: `\parencite{cisek2002filozoficzne}` daje `(Cisek 2002)`.

### Klucze

Klucz jest Twój i nigdzie nie widać go w PDF-ie, ale przy stu pozycjach zaczyna mieć
znaczenie. Konwencja przyjęta w seminarium: **nazwisko + rok + pierwsze znaczące słowo
tytułu**, bez znaków diakrytycznych i bez spacji:

```
cisek2002filozoficzne
callaway2024continuous
liPearl2024probabilities
```

Klucz raz nadany zostaje na zawsze. Zmiana klucza po napisaniu połowy pracy oznacza
przeszukanie wszystkich rozdziałów.

### Pola nazwisk

Autorów rozdziela słowo `and`, **nigdy przecinek**:

```bibtex
author = {Nowak, Jan and Zieliński, Kazimierz}
```

Zapis `Nazwisko, Imię` jest jednoznaczny i jego się trzymaj. Przy nazwisku złożonym
albo nazwie instytucji użyj podwójnych nawiasów, żeby całość została potraktowana
jako jedna jednostka:

```bibtex
author = {{Biblioteka Jagiellońska}}
author = {{R Core Team}}
author = {van Dijk, Teun A.}
```

Imiona podawaj w pełnym brzmieniu — Instrukcja ISI wymaga pełnych imion w opisie
bibliograficznym. Inicjały w powołaniu w tekście styl doda sam, gdy będą potrzebne
do odróżnienia dwóch autorów o tym samym nazwisku.

### Znaki diakrytyczne i wielkie litery

Polskie znaki wpisuj wprost: `Woźniak`, `Żółkiewski`. Plik zapisz w UTF-8.

LaTeX zmienia wielkość liter w tytułach części stylów. Żeby uchronić skrót albo nazwę
własną, otocz ją dodatkowymi nawiasami klamrowymi:

```bibtex
title = {Zastosowanie metody {TOPSIS} w ocenie {SMM}}
```

---

## Typy wpisów

Poniższe wpisy odpowiadają wprost przykładom opisu z Instrukcji ISI. Komplet
z komentarzami znajdziesz w `wzor-pracy/bibliografia/literatura.bib` — zacznij od
skopiowania właściwego wzorca i podmiany wartości.

### Książka

```bibtex
@book{nowak2009postrzeganie,
  author    = {Nowak, Jan and Zieliński, Kazimierz},
  year      = {2009},
  title     = {Postrzeganie zmiany},
  location  = {Wrocław},
  publisher = {Wydaw. Media},
  langid    = {polish},
}
```

→ Nowak, Jan; Zieliński, Kazimierz (2009). *Postrzeganie zmiany*. Wrocław: Wydaw. Media.

### Praca zbiorowa

Redaktor zamiast autora — styl sam dopisze „red.".

```bibtex
@collection{zielinski1998swiat,
  editor    = {Zieliński, Jan},
  year      = {1998},
  title     = {Świat komputerów},
  location  = {Wrocław},
  publisher = {Globus},
  langid    = {polish},
}
```

→ Zieliński, Jan red. (1998). *Świat komputerów*. Wrocław: Globus.
W tekście: `(Zieliński red. 1998)`.

### Rozdział w pracy zbiorowej

```bibtex
@incollection{nowak2004srodowisko,
  author    = {Nowak, Jan},
  year      = {2004},
  title     = {Środowisko informacyjne},
  editor    = {Makowski, Eugeniusz},
  booktitle = {Człowiek współczesny},
  location  = {Warszawa},
  publisher = {Wydaw. Atrakcja},
  pages     = {11-28},
  langid    = {polish},
}
```

→ Nowak, Jan (2004). Środowisko informacyjne. W: Eugeniusz Makowski red.
*Człowiek współczesny*. Warszawa: Wydaw. Atrakcja, s. 11–28.

### Artykuł w czasopiśmie polskim

```bibtex
@article{wozniak1997kognitywizm,
  author       = {Woźniak, Jadwiga},
  year         = {1997},
  title        = {Kognitywizm w informacji},
  journaltitle = {Zagadnienia Informacji Naukowej},
  number       = {2},
  pages        = {3-16},
  langid       = {polish},
}
```

→ Woźniak, Jadwiga (1997). Kognitywizm w informacji. *Zagadnienia Informacji Naukowej*,
nr 2, s. 3–16.

### Artykuł w czasopiśmie obcojęzycznym

Pole `langid` przełącza skróty na oryginalne. W pozycjach polskich podajesz **numer**,
w obcojęzycznych zwyczajowo **tom**.

```bibtex
@article{hjorland1998theory,
  author       = {Hjørland, Birger},
  year         = {1998},
  title        = {Theory and metatheory of information science},
  journaltitle = {Journal of Documentation},
  volume       = {5},
  pages        = {606-621},
  langid       = {english},
}
```

→ Hjørland, Birger (1998). Theory and metatheory of information science.
*Journal of Documentation*, vol. 5, pp. 606–621.

### Artykuł w gazecie

Datę dzienną wpisz w pole `issue`.

```bibtex
@article{nowak2000jutro,
  author       = {Nowak, Jan},
  year         = {2000},
  title        = {O lepsze jutro},
  journaltitle = {Dziennik Polski},
  number       = {56},
  issue        = {12.06.2001},
  pages        = {4-5},
  langid       = {polish},
}
```

### Hasło w wydawnictwie informacyjnym

Z autorem hasła — jak rozdział w pracy zbiorowej. Bez autora hasła — autora dzieła
nadrzędnego podajesz w polu `bookauthor`:

```bibtex
@incollection{apoteoza1996,
  title      = {Apoteoza},
  bookauthor = {Kopaliński, Władysław},
  year       = {1996},
  booktitle  = {Słownik wyrazów obcych},
  location   = {Warszawa},
  publisher  = {Wiedza Powszechna},
  pages      = {14},
  langid     = {polish},
}
```

→ Apoteoza. W: Kopaliński, Władysław (1996). *Słownik wyrazów obcych*.
Warszawa: Wiedza Powszechna, s. 14.

### Dokument dostępny w internecie

Do wpisu drukowanego dodajesz `doi`, `url` i `urldate`. Datę odczytu zapisuj
w formacie `RRRR-MM-DD` — styl przestawi ją na polską postać `20.05.2011`.

```bibtex
@article{kowalski2009zmiany,
  author       = {Kowalski, Marek},
  year         = {2009},
  title        = {Zmiany paradygmatu w naukach ekonomicznych},
  journaltitle = {Biuletyn Naukoznawczy},
  number       = {3},
  pages        = {12-19},
  doi          = {10.1429/1528-3542.7.4.376},
  url          = {http://www.biulnauk.edu/nr3/kowal},
  urldate      = {2011-05-20},
  langid       = {polish},
}
```

### Strona internetowa, wpis w blogu

Typ `@online`. Pole `keywords = {netografia}` pozwala złożyć te pozycje w odrębnym
wykazie, jeżeli uzgodnisz to z promotorem.

```bibtex
@online{cisek2019informacja,
  author   = {Cisek, Sabina},
  year     = {2019},
  title    = {Informacja o przedsiębiorstwach i innych organizacjach},
  url      = {http://sabinacisek.blogspot.com/2019/10/informacja.html},
  urldate  = {2021-11-21},
  keywords = {netografia},
  langid   = {polish},
}
```

### Dokument na nośniku materialnym

Typ nośnika w polu `howpublished`:

```bibtex
@book{kopalinski1998slownik,
  author       = {Kopaliński, Władysław},
  year         = {1998},
  title        = {Słownik wyrazów obcych i zwrotów obcojęzycznych},
  howpublished = {płyta DVD},
  location     = {Łódź},
  publisher    = {PRO-media},
  langid       = {polish},
}
```

### Norma

Rok wchodzi w skład oznaczenia normy, więc nie powtarza się go w nawiasie. Służy do tego
`entrysubtype = {norma}`, a `shorthand` daje czytelne powołanie w tekście.

```bibtex
@misc{pniso690,
  entrysubtype = {norma},
  shorthand    = {PN-ISO 690: 2012},
  title        = {PN-ISO 690: 2012. Informacja i dokumentacja --- Wytyczne
                  opracowania przypisów bibliograficznych i powołań na zasoby
                  informacji},
  year         = {2012},
  langid       = {polish},
}
```

### Pozycja bez autora

Powołanie ma zawierać dwa pierwsze słowa tytułu — podaj je w polu `shorttitle`:

```bibtex
@book{elektroniczne2008,
  title      = {Elektroniczne publikacje w bibliotekach},
  shorttitle = {Elektroniczne publikacje},
  year       = {2008},
  location   = {Kraków},
  publisher  = {Wydaw. UJ},
  langid     = {polish},
}
```

→ w tekście `(Elektroniczne publikacje 2008)`.

---

## Zestawienie pól

| Pole | Kiedy | Uwaga |
|---|---|---|
| `author` / `editor` | zawsze, gdy są | `Nazwisko, Imię`, rozdzielone `and` |
| `year` | zawsze | sam rok; brak roku wolno pominąć |
| `title` | zawsze | |
| `shorttitle` | pozycje bez autora | dwa pierwsze słowa tytułu |
| `journaltitle` | artykuł | pełny tytuł, bez skrótów |
| `booktitle` | rozdział, hasło | tytuł dzieła nadrzędnego |
| `bookauthor` | hasło bez własnego autora | autor dzieła nadrzędnego |
| `number` | pozycje polskie | daje „nr 2" |
| `volume` | pozycje obcojęzyczne | daje „vol. 5" |
| `issue` | gazeta | data dzienna |
| `pages` | artykuł, rozdział | zakres `3-16` |
| `location` | wydawnictwo zwarte | miasto |
| `publisher` | wydawnictwo zwarte | |
| `doi` | gdy jest | sam identyfikator, bez `https://doi.org/` |
| `url` | dokument sieciowy | |
| `urldate` | zawsze przy `url` | format `RRRR-MM-DD` |
| `langid` | **zawsze** | `polish` albo `english` |
| `keywords` | opcjonalnie | `netografia` do odrębnego wykazu |
| `howpublished` | nośnik materialny | np. `płyta DVD` |
| `entrysubtype` | norma | wartość `norma` |
| `shorthand` | norma | oznaczenie do powołania |

Pole `langid` decyduje o skrótach w opisie. Brak `langid` jest traktowany jak pozycja
polska. **Wypełniaj je zawsze** — inaczej artykuł angielski dostanie „t. 5, s. 606–621"
zamiast „vol. 5, pp. 606–621".

---

## Zotero

Ręczne pisanie stu wpisów jest wykonalne, ale nierozsądne. Zotero zbiera metadane
z przeglądarki i eksportuje je do `.bib`.

### Konfiguracja

1. Zainstaluj [Zotero](https://www.zotero.org/) i wtyczkę **Zotero Connector**
   do przeglądarki.
2. Zainstaluj dodatek **Better BibTeX** (BBT). Jest niezbędny: daje stabilne klucze
   cytowania, eksport w formacie biblatex i automatyczne odświeżanie pliku.
3. Utwórz kolekcję dla pracy, a w niej podkolekcje: *metoda*, *dziedzina*, *narzędzia*.

### Klucze cytowania

W ustawieniach Better BibTeX ustaw wzorzec klucza tak, żeby odpowiadał konwencji
seminaryjnej, na przykład `auth.lower + year + shorttitle(1,1).lower`. Włącz **pinowanie
kluczy** — bez tego klucz może się zmienić po edycji metadanych i powołania w pracy
przestaną działać.

### Eksport automatyczny

Kliknij kolekcję prawym przyciskiem → *Export Collection* → format **Better BibLaTeX** →
zaznacz *Keep updated*. Wskaż plik `wzor-pracy/bibliografia/literatura.bib`.

Od tej chwili każda zmiana w Zotero trafia do pliku sama. Zostaje tylko wysłać zmieniony
plik do projektu — jak, opisuje
[przewodnik o Overleaf](03-overleaf-i-wspolpraca.md#plik-bib-a-zotero).

Wybieraj **Better BibLaTeX**, nie „Better BibTeX". Styl `isi-uj` korzysta z pól
`journaltitle`, `location` i `langid`, których starszy format nie zna.

### Odpowiedniki typów

| Typ w Zotero | Typ w `.bib` |
|---|---|
| Book | `@book` |
| Book Section | `@incollection` |
| Journal Article | `@article` |
| Magazine / Newspaper Article | `@article` |
| Conference Paper | `@inproceedings` |
| Thesis | `@thesis` |
| Report | `@report` |
| Web Page | `@online` |
| Blog Post | `@online` |
| Computer Program | `@software` |
| Preprint | `@article` z polem `note` |
| Dictionary / Encyclopedia Entry | `@incollection` |

### Poprawki po imporcie

Metadane z baz bibliograficznych bywają niekompletne. Po każdym imporcie sprawdź:

- **imiona** — bazy notorycznie zostawiają inicjały; Instrukcja wymaga pełnych imion,
  więc uzupełnij ręcznie;
- **pole Language** — wpisz `polish` albo `english`; stąd bierze się `langid`.
  Po eksporcie zajrzyj do pliku i popraw, gdyby pole nie przeszło;
- **tytuł czasopisma** — bazy podają skróty (`J. Doc.`); wpisz pełną nazwę;
- **typ dokumentu** — rozdział zaimportowany jako artykuł da zły opis;
- **miejsce wydania** — Zotero często je gubi przy książkach;
- **DOI** — bez przedrostka `https://doi.org/`, sam identyfikator;
- **wielkie litery w tytule** — bazy anglojęzyczne zapisują tytuły kapitalikami
  wyrazowymi; zapisz je tak, jak w oryginale publikacji.

Zasada praktyczna: **nigdy nie ufaj pierwszemu importowi**. Sprawdzenie wpisu zajmuje
minutę, poprawianie bibliografii tydzień przed obroną — znacznie więcej.

---

## Powołania w tekście

| Sytuacja | Polecenie | Efekt |
|---|---|---|
| zwykłe | `\parencite{klucz}` | (Cisek 2002) |
| ze stroną | `\parencite[s.~15-21]{klucz}` | (Kowalski 2010a, s. 15–21) |
| kilka pozycji | `\parencite{k1,k2}` | (Cisek 2002; Nowak 2006) |
| w zdaniu | `\textcite{klucz}` | Woźniak (1997) pokazuje… |
| z przedrostkiem | `\parencite[zob.][s.~9]{klucz}` | (zob. Nowak 2006, s. 9) |

Inicjał przy zbieżnych nazwiskach, „i in." przy więcej niż trzech autorach i sufiksy
`a`/`b` przy tym samym roku styl dobiera **automatycznie**. Nie wpisuj ich ręcznie
w pliku `.bib`.

Cytat dosłowny z tłumaczeniem własnym zapisujesz tak:

```latex
\enquote{Przetłumaczony fragment} [tłum. własne --- JK]
\parencite[s.~44]{hjorland1998theory}\footnote{\enquote{Original wording here}.}
```

---

## Cytowanie oprogramowania i danych

Pakiety R i zbiory danych trafiają do **wykazu źródeł**, a nie do bibliografii —
to rozróżnienie omawia [przewodnik o pisaniu](04-jak-pisac-prace.md#wykaz-źródeł).
Jeżeli jednak powołujesz się na pakiet w tekście jak na publikację, potrzebujesz wpisu.

Dane pobierz w konsoli R:

```r
citation("ggplot2")
toBibtex(citation("ggplot2"))
```

Wynik wklej do `.bib` i uzupełnij `langid`.

### Cytowanie własnego pakietu

Twój pakiet powinien mieć plik `inst/CITATION`, żeby `citation("NazwaPakietu")` zwracało
poprawny opis. Po nadaniu wydania i uzyskaniu identyfikatora DOI w Zenodo opis wygląda tak:

```bibtex
@software{kowalski2027nazwapakietu,
  author  = {Kowalski, Jan},
  year    = {2027},
  title   = {NazwaPakietu: krótki opis przeznaczenia},
  version = {1.0.0},
  doi     = {10.5281/zenodo.0000000},
  url     = {https://github.com/nazwauzytkownika/NazwaPakietu},
  urldate = {2027-05-15},
  langid  = {polish},
}
```

### Zbiory danych

Zbiór danych opisujesz jak dokument sieciowy, z podaniem wersji albo daty pobrania
i licencji w polu `note`:

```bibtex
@online{openalex2026,
  author   = {{OpenAlex}},
  year     = {2026},
  title    = {OpenAlex snapshot},
  url      = {https://openalex.org/},
  urldate  = {2026-11-04},
  note     = {licencja CC0},
  langid   = {english},
}
```

---

## Kontrola

Przed oddaniem sprawdź trzy rzeczy.

**Zgodność w obie strony.** Każda pozycja bibliografii ma powołanie w tekście, każde
powołanie ma pozycję w bibliografii. Nierozwiązane powołania widać w logu:

```
grep -n "Citation .* undefined" main.log
```

Pozycji bez powołania LaTeX nie zgłosi — te po prostu nie pojawią się w bibliografii,
bo styl składa wyłącznie pozycje przywołane. To działa na Twoją korzyść.

**Pozycje obcojęzyczne.** Wymóg zarówno Standardów EPI, jak i Instrukcji ISI. Sprawdź,
czy są i czy mają `langid = {english}`.

**Kompletność opisów.** Przejrzyj gotową bibliografię w PDF-ie, nie plik `.bib`.
Brakujące miasto, ucięty tytuł czasopisma albo brak daty odczytu widać dopiero
w składzie.

Gdy bibliografia jest pusta albo nieaktualna po zmianach w `.bib`, uruchom pełną
kompilację od zera — `latexmk -c`, potem `latexmk -lualatex main.tex`, a na Overleaf
*Recompile from scratch*.

---

## Wariant APA 7

Jeżeli uzgodnisz z promotorem styl APA zamiast instytutowego, wystarczy dopisać opcję
klasy:

```latex
\documentclass[apa]{epi-praca}
```

Ten sam plik `.bib` obsługuje oba style. Łączniki są polskie; nazwy miesięcy w datach
dostępu pozostają w formie właściwej dla angielskiego zapisu APA.

Wybór stylu uzgadnia się **raz, na początku** — Instrukcja ISI wprost przewiduje
ustalenie preferowanego stylu z promotorem. Zmiana w trakcie pisania oznacza przegląd
wszystkich wpisów pod kątem pól wymaganych przez nowy styl.
