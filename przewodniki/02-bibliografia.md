<!-- Plik powstaje automatycznie z przewodnik/rozdzialy/02-bibliografia.tex.
     Zmiany nanos w pliku zrodlowym, nie tutaj. -->

# Bibliografia: plik BibTeX i Zotero

Bibliografia w pracy powstaje automatycznie z pliku `bibliografia/literatura.bib`. Nie składasz jej ręcznie i nie sortujesz – robi to styl odwzorowujący opisy z Instrukcji (Instrukcja ISI). Twoje zadanie sprowadza się do jednego: poprawnych wpisów w pliku. Opis wychodzi wtedy zgodny z wymogami sam.

Zasada, której pilnuje recenzent: bibliografia zawiera wyłącznie pozycje faktycznie wykorzystane, do których odsyłają powołania w tekście. Pozycje przeczytane, ale niewykorzystane, do bibliografii nie trafiają.

**Prowadź plik bibliograficzny od pierwszego dnia.** Odtwarzanie bibliografii po napisaniu pracy zajmuje kilka dni i zawsze kończy się brakującym numerem strony.

## Anatomia wpisu

```latex
@book{cisek2002filozoficzne,
  author    = {Cisek, Sabina},
  year      = {2002},
  title     = {Filozoficzne aspekty informacji naukowej},
  location  = {Krakow},
  publisher = {Wydaw. UJ},
  langid    = {polish},
}
```

Pierwsza linia podaje typ wpisu, który decyduje o postaci opisu, oraz klucz cytowania, którym powołujesz się w tekście. Dalej idą pola; wartość zawsze w nawiasach klamrowych. Powołanie `\parencite{cisek2002filozoficzne}` daje w tekście „(Cisek 2002)”.

### Klucze

Klucz jest Twój i nigdzie nie widać go w gotowym dokumencie, ale przy stu pozycjach zaczyna mieć znaczenie. Konwencja przyjęta w seminarium to nazwisko, rok i pierwsze znaczące słowo tytułu, bez znaków diakrytycznych i bez spacji: `cisek2002filozoficzne`, `callaway2024continuous`, `liPearl2024probabilities`.

Klucz raz nadany zostaje na zawsze. Zmiana klucza po napisaniu połowy pracy oznacza przeszukanie wszystkich rozdziałów.

### Pola nazwisk

Autorów rozdziela słowo `and`, **nigdy przecinek**. Zapis `Nazwisko, Imie` jest jednoznaczny i jego się trzymaj. Przy nazwisku złożonym albo nazwie instytucji użyj podwójnych nawiasów, żeby całość została potraktowana jako jedna jednostka:

```latex
author = {Nowak, Jan and Zielinski, Kazimierz}
author = {{Biblioteka Jagiellonska}}
author = {van Dijk, Teun A.}
```

Imiona podawaj w pełnym brzmieniu – Instrukcja wymaga pełnych imion w opisie bibliograficznym. Inicjały w powołaniu styl doda sam, gdy będą potrzebne do odróżnienia dwóch autorów o tym samym nazwisku.

Polskie znaki wpisuj wprost, a plik zapisz w UTF-8. LaTeX zmienia wielkość liter w tytułach w części stylów, więc skrót albo nazwę własną otocz dodatkowymi nawiasami klamrowymi: `title = {Zastosowanie metody {TOPSIS}}`.

## Typy wpisów

Poniższe wpisy odpowiadają wprost przykładom opisu z Instrukcji. Komplet z komentarzami znajdziesz w pliku bibliograficznym dołączonym do wzoru – zacznij od skopiowania właściwego wzorca i podmiany wartości.

### Książka i praca zbiorowa

Książka wielu autorów różni się od pojedynczej tylko listą w polu `author`. Praca zbiorowa ma redaktora zamiast autora, a styl sam dopisze skrót „red.”:

```latex
@collection{zielinski1998swiat,
  editor    = {Zielinski, Jan},
  year      = {1998},
  title     = {Swiat komputerow},
  location  = {Wroclaw},
  publisher = {Globus},
  langid    = {polish},
}
```

Daje to opis „Zieliński, Jan red. (1998). *Świat komputerów*. Wrocław: Globus.”, a w tekście powołanie „(Zieliński red. 1998)”.

### Rozdział w pracy zbiorowej

```latex
@incollection{nowak2004srodowisko,
  author    = {Nowak, Jan},
  year      = {2004},
  title     = {Srodowisko informacyjne},
  editor    = {Makowski, Eugeniusz},
  booktitle = {Czlowiek wspolczesny},
  location  = {Warszawa},
  publisher = {Wydaw. Atrakcja},
  pages     = {11-28},
  langid    = {polish},
}
```

### Artykuł

W pozycjach polskich podajesz **numer** w polu `number`, w obcojęzycznych zwyczajowo **tom** w polu `volume`. Pole `langid` przełącza skróty na oryginalne, dzięki czemu artykuł angielski dostaje oznaczenia „vol.” i „pp.” zamiast „nr” i „s.”:

```latex
@article{hjorland1998theory,
  author       = {Hjorland, Birger},
  year         = {1998},
  title        = {Theory and metatheory of information science},
  journaltitle = {Journal of Documentation},
  volume       = {5},
  pages        = {606-621},
  langid       = {english},
}
```

W artykule prasowym datę dzienną wpisz w pole `issue`; stanie wtedy między numerem a stronami, zgodnie z przykładem z Instrukcji.

### Hasło w wydawnictwie informacyjnym

Hasło z własnym autorem opisuje się jak rozdział w pracy zbiorowej. Hasło bez autora wymaga podania autora dzieła nadrzędnego w polu `bookauthor`:

```latex
@incollection{apoteoza1996,
  title      = {Apoteoza},
  bookauthor = {Kopalinski, Wladyslaw},
  year       = {1996},
  booktitle  = {Slownik wyrazow obcych},
  location   = {Warszawa},
  publisher  = {Wiedza Powszechna},
  pages      = {14},
  langid     = {polish},
}
```

### Dokumenty sieciowe

Do wpisu drukowanego dodajesz pola `doi`, `url` i `urldate`. Datę odczytu zapisuj w formacie rok-miesiąc-dzień; styl przestawi ją na polską postać z kropkami. Strony internetowe i wpisy w blogach opisuje typ `@online`, a pole `keywords` o wartości `netografia` pozwala złożyć te pozycje w odrębnym wykazie, jeżeli uzgodnisz to z promotorem.

### Pozycje szczególne

Dokument na nośniku materialnym opisuje typ nośnika w polu `howpublished`. Norma wymaga pól `entrysubtype` o wartości `norma` oraz `shorthand`, bo rok wchodzi w skład jej oznaczenia i nie powtarza się go w nawiasie (PN-ISO 690: 2012). Pozycja bez autora potrzebuje pola `shorttitle` z dwoma pierwszymi słowami tytułu, żeby powołanie miało postać wymaganą przez Instrukcję.

## Zestawienie pól

**Tabela 7. Pola wpisu bibliograficznego**

| Pole | Kiedy | Uwaga |
|---|---|---|
| `author` lub `editor` | zawsze, gdy są | zapis nazwisko, imię; rozdzielone słowem `and` |
| `year` | zawsze | sam rok; brak roku wolno pominąć |
| `title` | zawsze |  |
| `shorttitle` | pozycje bez autora | dwa pierwsze słowa tytułu |
| `journaltitle` | artykuł | pełny tytuł, bez skrótów |
| `booktitle` | rozdział, hasło | tytuł dzieła nadrzędnego |
| `bookauthor` | hasło bez autora | autor dzieła nadrzędnego |
| `number` | pozycje polskie | daje oznaczenie „nr 2” |
| `volume` | pozycje obcojęzyczne | daje oznaczenie „vol. 5” |
| `issue` | gazeta | data dzienna |
| `pages` | artykuł, rozdział | zakres zapisany łącznikiem |
| `location` | wydawnictwo zwarte | miasto |
| `publisher` | wydawnictwo zwarte |  |
| `doi` | gdy jest | sam identyfikator, bez adresu |
| `url` | dokument sieciowy |  |
| `urldate` | zawsze przy adresie | format rok-miesiąc-dzień |
| `langid` | zawsze | `polish` albo `english` |
| `keywords` | opcjonalnie | wartość `netografia` |
| `howpublished` | nośnik materialny | na przykład płyta DVD |
| `entrysubtype` | norma | wartość `norma` |
| `shorthand` | norma | oznaczenie do powołania |

Pole `langid` decyduje o skrótach w opisie, a jego brak jest traktowany jak pozycja polska. **Wypełniaj je zawsze** – inaczej artykuł angielski dostanie polskie oznaczenia tomu i stron.

## Zotero

Ręczne pisanie stu wpisów jest wykonalne, ale nierozsądne. Zotero zbiera metadane z przeglądarki i eksportuje je do pliku bibliograficznego.

### Konfiguracja

Zainstaluj Zotero wraz z wtyczką do przeglądarki, a następnie dodatek Better BibTeX. Dodatek jest niezbędny: daje stabilne klucze cytowania, eksport w formacie biblatex i automatyczne odświeżanie pliku. Utwórz kolekcję dla pracy, a w niej podkolekcje na metodę, dziedzinę i narzędzia.

W ustawieniach dodatku ustaw wzorzec klucza odpowiadający konwencji seminaryjnej i **włącz pinowanie kluczy**. Bez tego klucz może się zmienić po edycji metadanych i powołania w pracy przestaną działać.

Eksport ustawia się raz: menu podręczne kolekcji, polecenie eksportu, format *Better BibLaTeX*, opcja utrzymywania pliku w aktualności. Jako cel wskaż plik bibliograficzny w projekcie pracy. Wybieraj format biblatex, a nie starszy BibTeX – styl korzysta z pól, których starszy format nie zna.

### Odpowiedniki typów

**Tabela 8. Typy dokumentów w Zotero i we wpisie bibliograficznym**

| Typ w Zotero | Typ wpisu |
|---|---|
| Book | `@book` |
| Book Section | `@incollection` |
| Journal Article | `@article` |
| Magazine, Newspaper Article | `@article` |
| Conference Paper | `@inproceedings` |
| Thesis | `@thesis` |
| Report | `@report` |
| Web Page, Blog Post | `@online` |
| Computer Program | `@software` |
| Dictionary, Encyclopedia Entry | `@incollection` |

### Poprawki po imporcie

Metadane z baz bibliograficznych bywają niekompletne. Po każdym imporcie sprawdź imiona, bo bazy notorycznie zostawiają inicjały, a Instrukcja wymaga pełnych imion. Uzupełnij pole języka wartością `polish` albo `english`, bo stąd bierze się `langid`, i po eksporcie zajrzyj do pliku, czy pole rzeczywiście przeszło. Rozwiń skrócone tytuły czasopism. Sprawdź typ dokumentu, bo rozdział zaimportowany jako artykuł da zły opis. Uzupełnij miejsce wydania, które Zotero często gubi przy książkach. Usuń przedrostek adresowy z identyfikatora cyfrowego. Zapisz tytuł tak, jak w oryginale publikacji, bo bazy anglojęzyczne stosują kapitaliki wyrazowe.

Zasada praktyczna: **nigdy nie ufaj pierwszemu importowi**. Sprawdzenie wpisu zajmuje minutę, a poprawianie bibliografii tydzień przed obroną – znacznie więcej.

## Powołania w tekście

**Tabela 9. Postacie powołania**

| Sytuacja | Polecenie | Efekt |
|---|---|---|
| zwykłe | `\parencite{klucz}` | (Cisek 2002) |
| ze stroną | `\parencite[s.~15-21]{klucz}` | (Kowalski 2010a, s. 15–21) |
| kilka pozycji | `\parencite{k1,k2}` | (Cisek 2002; Nowak 2006) |
| w zdaniu | `\textcite{klucz}` | Woźniak (1997) pokazuje… |
| z przedrostkiem | `\parencite[zob.][s.~9]{klucz}` | (zob. Nowak 2006, s. 9) |

Inicjał przy zbieżnych nazwiskach, skrót przy więcej niż trzech autorach i sufiksy rocznika styl dobiera automatycznie. Nie wpisuj ich ręcznie w pliku bibliograficznym.

Cytat dosłowny z tłumaczeniem własnym zapisujesz razem z oznaczeniem tłumacza i oryginałem w przypisie dolnym:

```latex
\enquote{Przetlumaczony fragment} [tlum. wlasne -- JK]
\parencite[s.~44]{hjorland1998theory}\footnote{\enquote{Original wording}.}
```

## Cytowanie oprogramowania i danych

Pakiety R i zbiory danych trafiają do **wykazu źródeł**, a nie do bibliografii; rozróżnienie omawia podrozdział [Wykaz źródeł](04-jak-pisac.md#wykaz-źródeł). Jeżeli jednak powołujesz się na pakiet w tekście jak na publikację, potrzebujesz wpisu. Dane pobierzesz w konsoli:

```r
citation("ggplot2")
toBibtex(citation("ggplot2"))
```

Twój pakiet powinien mieć plik `inst/CITATION`, żeby polecenie `citation()` zwracało poprawny opis. Po nadaniu wydania i uzyskaniu identyfikatora cyfrowego opis własnego pakietu wygląda tak:

```latex
@software{kowalski2027nazwapakietu,
  author  = {Kowalski, Jan},
  year    = {2027},
  title   = {NazwaPakietu: krotki opis przeznaczenia},
  version = {1.0.0},
  doi     = {10.5281/zenodo.0000000},
  url     = {https://github.com/nazwauzytkownika/NazwaPakietu},
  urldate = {2027-05-15},
  langid  = {polish},
}
```

Zbiór danych opisujesz jak dokument sieciowy, z podaniem wersji albo daty pobrania oraz licencji w polu `note`.

## Kontrola

Przed oddaniem sprawdź trzy rzeczy. Po pierwsze zgodność w obie strony: każda pozycja bibliografii ma powołanie w tekście, a każde powołanie pozycję w bibliografii. Nierozwiązane powołania widać w dzienniku kompilacji; pozycji bez powołania styl po prostu nie złoży, co działa na Twoją korzyść. Po drugie obecność pozycji obcojęzycznych, wymaganych zarówno przez Standardy, jak i przez Instrukcję. Po trzecie kompletność opisów – przejrzyj gotową bibliografię w złożonym dokumencie, a nie w pliku źródłowym, bo brakujące miasto, ucięty tytuł czasopisma albo brak daty odczytu widać dopiero w składzie.

Gdy bibliografia jest pusta albo nieaktualna po zmianach w pliku, uruchom pełną kompilację od zera.

## Wariant APA

Jeżeli uzgodnisz z promotorem styl APA zamiast instytutowego, wystarczy dopisać opcję klasy `apa` w poleceniu `\documentclass`. Ten sam plik bibliograficzny obsługuje oba style. Łączniki są polskie, a nazwy miesięcy w datach dostępu pozostają w formie właściwej dla angielskiego zapisu APA.

Wybór stylu uzgadnia się **raz, na początku** – Instrukcja wprost przewiduje ustalenie preferowanego stylu z promotorem. Zmiana w trakcie pisania oznacza przegląd wszystkich wpisów pod kątem pól wymaganych przez nowy styl.

---

Wersja do druku obejmująca wszystkie rozdziały: [przewodnik.pdf](../przewodnik/przewodnik.pdf).
