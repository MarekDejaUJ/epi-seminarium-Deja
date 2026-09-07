# Overleaf i współpraca

Overleaf to LaTeX w przeglądarce. Nie trzeba nic instalować, projekt jest dostępny
z każdego komputera, a promotor widzi tę samą wersję co Ty. Dla pracy licencjackiej
pisanej pod opieką promotora to najmniej kłopotliwe środowisko.

Praca lokalna też jest możliwa i opisana [na końcu](#praca-lokalna-w-positronie).

---

## Ścieżka studenta

### Konto

Załóż konto na [overleaf.com](https://www.overleaf.com/) **na adres uczelniany**.
Sprawdź, czy Uniwersytet Jagielloński udostępnia licencję instytucjonalną — jeżeli tak,
konto założone na adres w domenie uczelni dostaje funkcje płatne. Cała ścieżka opisana
niżej działa również na planie bezpłatnym.

### Założenie projektu

Wzór pobierasz z repozytorium seminarium:

1. Na stronie repozytorium *Code → Download ZIP*, rozpakuj archiwum.
2. Spakuj **sam katalog `wzor-pracy`** do nowego pliku ZIP.
3. W Overleaf *New Project → Upload Project* i wskaż to archiwum.

Alternatywnie promotor udostępni gotowy projekt wzorcowy łączem tylko do odczytu —
wtedy wystarczy *Menu → Copy Project* i masz własną kopię.

### Ustawienia projektu

Zaraz po utworzeniu projektu, w *Menu* po lewej stronie:

| Ustawienie | Wartość | Dlaczego |
|---|---|---|
| **Compiler** | LuaLaTeX | kod składa się wtedy krojem JetBrains Mono |
| **Main document** | `main.tex` | Overleaf inaczej wybiera `przyklad.tex` |
| **Spell check** | Polski | podkreśla literówki w trakcie pisania |

Ustawienie kompilatora jest **jednorazowe i łatwe do przeoczenia**. Objaw pominięcia:
praca kompiluje się poprawnie, ale kod i nazwy funkcji mają inny krój pisma niż powinny.

### Co jest czym w projekcie

| Plik | Co z nim robisz |
|---|---|
| `main.tex` | uzupełniasz metadane na górze; nic więcej |
| `rozdzialy/*.tex` | **tu piszesz** |
| `bibliografia/literatura.bib` | wpisy bibliograficzne albo eksport z Zotero |
| `rysunki/` | pliki graficzne |
| `przyklad.tex` | dokument pokazowy; zaglądasz, gdy nie pamiętasz zapisu |
| `epi-praca.cls`, `isi-uj.*`, `polish-apa.lbx` | **nie ruszasz** |

Zmiana czegokolwiek w klasie albo w stylu bibliograficznym oznacza, że praca przestaje
odpowiadać wymogom Instytutu, a odpowiedzialność za to spada na Ciebie, nie na wzór.
Jeżeli czegoś nie da się zrobić dostępnymi poleceniami, zgłoś to promotorowi — brakuje
wtedy polecenia we wzorze.

### Kompilacja

Przycisk *Recompile*. Pierwsza kompilacja po dodaniu nowego powołania albo etykiety
może pokazać znaki zapytania — to normalne, po drugiej znikną.

Rozwijane menu obok przycisku zawiera *Recompile from scratch*. Użyj go, gdy PDF
przestaje odpowiadać zmianom albo gdy bibliografia nie chce się odświeżyć.

Plan bezpłatny ma **limit czasu kompilacji**. Praca licencjacka mieści się w nim
spokojnie, ale gdy zaczniesz się o niego ocierać, zakomentuj w `main.tex` polecenia
`\input` rozdziałów, nad którymi akurat nie pracujesz. Przed oddaniem odkomentuj wszystkie.

### Udostępnienie promotorowi

*Share → Share with your collaborators*, adres promotora, uprawnienie **Can edit**.

Na planie bezpłatnym każdy projekt można udostępnić jednej osobie — dokładnie tyle,
ile trzeba. Recenzentowi, gdy zajdzie potrzeba, udostępnij **łącze tylko do odczytu**
(*Share → Turn on link sharing → Anyone with this link can view*); łącza nie liczą się
do limitu współpracowników.

### Kopie zapasowe

Overleaf przechowuje projekt na swoich serwerach, ale to nie jest kopia zapasowa.
Raz w tygodniu: *Menu → Download → Source* i zapisz archiwum poza komputerem, na którym
pracujesz. Przed każdym większym przemeblowaniem pracy — dodatkowo.

Historia zmian na planie bezpłatnym jest ograniczona i **nie zastępuje kopii zapasowej**.

### Oddanie pracy

*Menu → Download → PDF*. Ten plik trafia do Archiwum Prac UJ.

Przed pobraniem sprawdź: pełna kompilacja od zera, brak nierozwiązanych powołań
i odsyłaczy, zgodność z [listą kontrolną](06-wymogi-formalne-isi-epi.md#lista-kontrolna-przed-oddaniem).

---

## Plik `.bib` a Zotero

Better BibTeX odświeża plik `.bib` **na Twoim dysku**. Overleaf o tym nie wie, więc plik
trzeba do projektu przenieść. Trzy sposoby, od najprostszego:

**Wgrywanie ręczne.** W drzewie plików Overleaf kliknij `bibliografia`, potem ikonę
przesyłania, wskaż zaktualizowany `literatura.bib` i potwierdź nadpisanie. Wystarczająco
dobre, jeżeli robisz to raz na tydzień.

**Biblioteka Zotero jako źródło.** Overleaf potrafi wczytać publiczną bibliotekę Zotero
i odświeżać ją na żądanie. Wygodne, ale wymaga ustawienia biblioteki jako publicznej —
sprawdź, czy Ci to odpowiada.

**Repozytorium.** Jeżeli masz dostęp do synchronizacji z repozytorium (funkcja płatna),
plik odświeża się razem z resztą projektu.

Niezależnie od sposobu: **po każdej podmianie pliku uruchom pełną kompilację od zera**.
Bibliografia budowana jest z pliku pomocniczego, który potrafi zostać na starej wersji.

---

## Ścieżka promotora

### Rozdanie wzoru czternastu osobom

Najmniej kłopotliwy układ, działający również na kontach bezpłatnych:

1. Załóż **jeden projekt wzorcowy** z zawartości `wzor-pracy/`.
2. Włącz w nim łącze tylko do odczytu (*Share → Turn on link sharing*).
3. Rozdaj to jedno łącze wszystkim.
4. Każda osoba robi *Menu → Copy Project* — dostaje własną, niezależną kopię.
5. Każda osoba udostępnia swoją kopię Tobie z uprawnieniem **Can edit**.

Zalety tego układu: łącze do odczytu nie zużywa limitu współpracowników, poprawka we
wzorcu nie psuje niczyjej pracy, a Ty masz dostęp do wszystkich czternastu projektów
z jednego pulpitu.

Wada: poprawka we wzorcu nie trafia do kopii już wykonanych. Dlatego **wzór zamknij
przed pierwszymi zajęciami**, a późniejsze zmiany rozsyłaj jako opis, co podmienić.

### Przegląd prac

Bez funkcji płatnych masz do dyspozycji zwykłą edycję i komentarze w treści. Przy
czternastu pracach warto ustalić jedną konwencję i trzymać się jej przez cały rok.

Konwencja proponowana — uwagi jako komentarze LaTeX-a, które **nie pojawiają się
w PDF-ie**:

```latex
%% UWAGA: teza z tego akapitu nie wynika z przywołanego źródła.
%% UWAGA: brakuje powołania.
%% PYTANIA: skąd wartość progu 0,7?
```

Zalety: uwaga stoi dokładnie przy problematycznym zdaniu, student widzi ją przy pisaniu,
a gotowy PDF pozostaje czysty. Wyszukanie wszystkich uwag w projekcie to jedno kliknięcie
w polu wyszukiwania.

Zasada zamykająca: **student usuwa komentarz dopiero po naniesieniu poprawki**. Pusty
wynik wyszukiwania `%% UWAGA` oznacza, że wszystkie uwagi zostały zaadresowane. Do listy
kontrolnej przed oddaniem warto dopisać ten punkt.

Jeżeli Uniwersytet udostępnia licencję instytucjonalną, dochodzą śledzenie zmian,
komentarze w panelu bocznym i pełna historia wersji — wtedy powyższa konwencja staje
się zbędna.

### Kontrola formalna

Kontrolę formalną prowadź **na PDF-ie, nie w źródle**. Marginesy, interlinia, numeracja
stron i układ elementów końcowych widać dopiero w składzie.

Zestawienie wymogów wraz ze wskazaniem, co realizuje klasa, a co pozostaje po stronie
autora: [`06-wymogi-formalne-isi-epi.md`](06-wymogi-formalne-isi-epi.md).

Dwie rzeczy warto sprawdzić w źródle:

- czy student nie zmieniał `epi-praca.cls` ani plików stylu bibliograficznego —
  porównanie z wzorcem załatwia sprawę;
- czy w projekcie nie zostały komentarze robocze i uwagi.

### Rytm pracy

Przy czternastu pracach przegląd na żądanie nie działa. Sprawdzony układ to stałe okna:
oddanie fragmentu do ustalonej daty, przegląd w ciągu tygodnia, omówienie na zajęciach.
Fragmenty oddawane w kolejności pisania, a nie w kolejności rozdziałów — tabelę podaje
[przewodnik o pisaniu](04-jak-pisac-prace.md#w-jakiej-kolejności-pisać).

---

## Praca lokalna w Positronie

Skoro pakiet R budujesz w Positronie, możesz w nim też pisać pracę — wtedy kod
i tekst są w jednym środowisku, a wykresy trafiają prosto do katalogu `rysunki/`.

Potrzebujesz dystrybucji TeX-a (TinyTeX albo TeX Live) oraz rozszerzenia do LaTeX-a
w Positronie. Kompilacja:

```
cd wzor-pracy
latexmk -lualatex main.tex
```

Zalety: brak limitu czasu kompilacji, praca bez internetu, pełna historia w repozytorium.
Wady: trzeba zainstalować i utrzymać dystrybucję TeX-a, a udostępnienie promotorowi
wymaga repozytorium zamiast jednego kliknięcia.

Układ mieszany bywa najwygodniejszy: **pakiet i wykresy lokalnie, tekst na Overleaf**.
Wykres wygenerowany w Positronie wgrywasz do `rysunki/` w projekcie.

### Wersjonowanie

Repozytorium pakietu i pracę trzymaj **osobno**. Praca zawiera pliki, które nie mają
nic wspólnego z pakietem, a repozytorium pakietu ma być czyste — to ono jest oceniane
jako projekt dyplomowy i to jego adres podajesz na stronie tytułowej.

Jeżeli prowadzisz pracę w repozytorium, ignoruj artefakty kompilacji. Gotowy `.gitignore`
jest w [repozytorium seminarium](../.gitignore).

---

## Problemy specyficzne dla Overleaf

| Objaw | Przyczyna | Naprawa |
|---|---|---|
| kod bez kroju JetBrains Mono | kompilator ustawiony na pdfLaTeX | *Menu → Compiler → LuaLaTeX* |
| kompiluje się `przyklad.tex` zamiast pracy | zły dokument główny | *Menu → Main document → `main.tex`* |
| bibliografia nie odświeża się po podmianie `.bib` | stary plik pomocniczy | *Recompile from scratch* |
| kompilacja przerwana limitem czasu | za dużo naraz przy szkicowaniu | zakomentuj nieużywane `\input` |
| `File not found` przy grafice | plik wgrany poza katalog `rysunki/` | przenieś plik; podawaj samą nazwę |
| polskie znaki jako krzaczki po wgraniu pliku | plik zapisany w innym kodowaniu | zapisz ponownie w UTF-8 |
| zmiany współpracownika nie widać | otwarta stara karta przeglądarki | odśwież stronę |
| projekt nie chce się skopiować z łącza | łącze udostępnione bez prawa kopiowania | poproś o łącze do odczytu |

Katalog błędów kompilacji niezależnych od Overleaf:
[przewodnik o LaTeX-u](01-latex-od-podstaw.md#diagnostyka).
