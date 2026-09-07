<!-- Plik powstaje automatycznie z przewodnik/rozdzialy/03-overleaf.tex.
     Zmiany nanos w pliku zrodlowym, nie tutaj. -->

# Overleaf i współpraca

Overleaf to LaTeX w przeglądarce. Nie trzeba nic instalować, projekt jest dostępny z każdego komputera, a promotor widzi tę samą wersję co Ty. Dla pracy licencjackiej pisanej pod opieką promotora to najmniej kłopotliwe środowisko. Praca lokalna też jest możliwa i opisuje ją podrozdział [Praca lokalna w Positronie](#praca-lokalna-w-positronie).

## Ścieżka studenta

### Konto i projekt

Załóż konto **na adres uczelniany**. Sprawdź, czy Uniwersytet udostępnia licencję instytucjonalną — jeżeli tak, konto w domenie uczelni otrzymuje funkcje płatne. Cała ścieżka opisana niżej działa również na planie bezpłatnym.

Wzór pobierasz z repozytorium seminarium: pobierz archiwum całego repozytorium, rozpakuj je, spakuj **sam katalog wzoru** do nowego archiwum i wgraj je jako nowy projekt. Alternatywnie promotor udostępni gotowy projekt wzorcowy łączem tylko do odczytu; wtedy wystarczy skopiować projekt do własnego konta.

### Ustawienia

**Tabela 10. Ustawienia projektu na Overleaf**

| Ustawienie | Wartość | Dlaczego |
|---|---|---|
| Compiler | LuaLaTeX | kod składa się wtedy właściwym krojem pisma |
| Main document | `main.tex` | inaczej kompiluje się dokument pokazowy |
| Spell check | polski | podkreśla literówki w trakcie pisania |

Ustawienie kompilatora jest jednorazowe i **łatwe do przeoczenia**. Objaw pominięcia: praca kompiluje się poprawnie, ale kod i nazwy funkcji mają inny krój pisma niż powinny.

### Co jest czym w projekcie

W pliku głównym uzupełniasz metadane na górze i nic więcej. Piszesz w plikach rozdziałów. Wpisy bibliograficzne trafiają do pliku w katalogu bibliografii, a grafiki do katalogu rysunków. Dokument pokazowy służy do zaglądania, gdy nie pamiętasz zapisu.

Klasy dokumentu ani plików stylu bibliograficznego **nie ruszasz**. Zmiana czegokolwiek w nich oznacza, że praca przestaje odpowiadać wymogom Instytutu, a odpowiedzialność za to spada na Ciebie, nie na wzór. Jeżeli czegoś nie da się zrobić dostępnymi poleceniami, zgłoś to promotorowi — brakuje wtedy polecenia we wzorze.

### Kompilacja i kopie

Pierwsza kompilacja po dodaniu nowego powołania albo etykiety może pokazać znaki zapytania; po drugiej znikną. Rozwijane menu obok przycisku kompilacji zawiera polecenie pełnego przebiegu od zera — użyj go, gdy dokument przestaje odpowiadać zmianom albo gdy bibliografia nie chce się odświeżyć.

Plan bezpłatny ma limit czasu kompilacji. Praca licencjacka mieści się w nim spokojnie, ale gdy zaczniesz się o niego ocierać, zakomentuj w pliku głównym włączenia rozdziałów, nad którymi akurat nie pracujesz. Przed oddaniem odkomentuj wszystkie.

Overleaf przechowuje projekt na swoich serwerach, ale **to nie jest kopia zapasowa**. Raz w tygodniu pobierz źródła projektu i zapisz je poza komputerem, na którym pracujesz; przed każdym większym przemeblowaniem pracy dodatkowo. Historia zmian na planie bezpłatnym jest ograniczona i kopii zapasowej nie zastępuje.

### Udostępnienie i oddanie

Udostępnij projekt promotorowi na jego adres, z prawem edycji. Na planie bezpłatnym każdy projekt można udostępnić jednej osobie — dokładnie tyle, ile trzeba. Recenzentowi, gdy zajdzie potrzeba, udostępnij łącze tylko do odczytu; łącza nie liczą się do limitu współpracowników.

Do Archiwum Prac trafia plik wynikowy pobrany z projektu. Przed pobraniem wykonaj pełną kompilację od zera, sprawdź brak nierozwiązanych powołań i odsyłaczy oraz przejdź listę kontrolną z podrozdziału [Lista kontrolna przed oddaniem](06-wymogi.md#lista-kontrolna-przed-oddaniem).

## Plik bibliograficzny a Zotero

Dodatek Better BibTeX odświeża plik bibliograficzny **na Twoim dysku**. Overleaf o tym nie wie, więc plik trzeba do projektu przenieść. Najprostszy sposób to wgranie ręczne: w drzewie plików wskaż katalog bibliografii, prześlij zaktualizowany plik i potwierdź nadpisanie. Wystarczająco dobre, jeżeli robisz to raz na tydzień. Overleaf potrafi też wczytać publiczną bibliotekę Zotero i odświeżać ją na żądanie, co jest wygodne, ale wymaga ustawienia biblioteki jako publicznej. Przy dostępie do synchronizacji z repozytorium plik odświeża się razem z resztą projektu.

Niezależnie od sposobu: **po każdej podmianie pliku uruchom pełną kompilację od zera**. Bibliografia budowana jest z pliku pomocniczego, który potrafi zostać na starej wersji.

## Ścieżka promotora

### Rozdanie wzoru grupie

Najmniej kłopotliwy układ, działający również na kontach bezpłatnych, wygląda tak. Prowadzący zakłada **jeden projekt wzorcowy** z zawartości katalogu wzoru i włącza w nim łącze tylko do odczytu. Rozdaje to jedno łącze wszystkim uczestnikom. Każda osoba kopiuje projekt do własnego konta, otrzymując niezależną kopię, i udostępnia ją prowadzącemu z prawem edycji.

Zalety układu: łącze do odczytu nie zużywa limitu współpracowników, poprawka we wzorcu nie psuje niczyjej pracy, a prowadzący ma dostęp do wszystkich projektów z jednego pulpitu. Wadą jest to, że poprawka we wzorcu nie trafia do kopii już wykonanych — dlatego **wzór zamyka się przed pierwszymi zajęciami**, a późniejsze zmiany rozsyła jako opis, co podmienić.

### Przegląd prac

Bez funkcji płatnych do dyspozycji pozostaje zwykła edycja i komentarze w treści. Przy kilkunastu pracach warto ustalić jedną konwencję i trzymać się jej przez cały rok. Konwencja proponowana w seminarium to uwagi zapisane jako komentarze LaTeX-a, które **nie pojawiają się w gotowym dokumencie**:

```latex
%% UWAGA: teza z tego akapitu nie wynika z przywolanego zrodla.
%% UWAGA: brakuje powolania.
%% PYTANIE: skad wartosc progu 0,7?
```

Uwaga stoi wtedy dokładnie przy problematycznym zdaniu, student widzi ją przy pisaniu, a gotowy dokument pozostaje czysty. Wyszukanie wszystkich uwag w projekcie to jedno kliknięcie w polu wyszukiwania.

Zasada zamykająca: **student usuwa komentarz dopiero po naniesieniu poprawki**. Pusty wynik wyszukiwania oznacza, że wszystkie uwagi zostały zaadresowane; ten punkt znajduje się na liście kontrolnej przed oddaniem.

Przy licencji instytucjonalnej dochodzą śledzenie zmian, komentarze w panelu bocznym i pełna historia wersji — wtedy powyższa konwencja staje się zbędna.

### Kontrola formalna

Kontrolę formalną prowadź **na złożonym dokumencie, nie w źródle**. Marginesy, interlinia, numeracja stron i układ elementów końcowych widać dopiero w składzie. Zestawienie wymogów wraz ze wskazaniem, co realizuje klasa, a co pozostaje po stronie autora, zawiera rozdział [Wymogi formalne](06-wymogi.md#wymogi-formalne).

W źródle warto sprawdzić dwie rzeczy: czy student nie zmieniał klasy dokumentu ani plików stylu bibliograficznego, co załatwia porównanie z wzorcem, oraz czy w projekcie nie zostały komentarze robocze i uwagi.

Przy kilkunastu pracach przegląd na żądanie nie działa. Sprawdzony układ to stałe okna: oddanie fragmentu do ustalonej daty, przegląd w ciągu tygodnia, omówienie na zajęciach. Fragmenty oddawane w kolejności pisania, a nie w kolejności rozdziałów — kolejność podaje tabela **Kolejność pisania rozdziałów**.

## Praca lokalna w Positronie

Skoro pakiet R budujesz w Positronie, możesz w nim też pisać pracę. Kod i tekst są wtedy w jednym środowisku, a wykresy trafiają prosto do katalogu rysunków. Potrzebujesz dystrybucji TeX-a oraz rozszerzenia do LaTeX-a.

```bash
cd wzor-pracy
latexmk -lualatex main.tex
```

Zaletami są brak limitu czasu kompilacji, praca bez dostępu do sieci i pełna historia w repozytorium. Wadami — konieczność zainstalowania i utrzymania dystrybucji TeX-a oraz to, że udostępnienie promotorowi wymaga repozytorium zamiast jednego kliknięcia. Układ mieszany bywa najwygodniejszy: pakiet i wykresy lokalnie, tekst na Overleaf.

Repozytorium pakietu i pracę trzymaj **osobno**. Praca zawiera pliki, które nie mają nic wspólnego z pakietem, a repozytorium pakietu ma być czyste — to ono jest oceniane jako projekt dyplomowy i to jego adres podajesz na stronie tytułowej. Jeżeli prowadzisz pracę w repozytorium, ignoruj artefakty kompilacji.

## Problemy specyficzne dla Overleaf

**Tabela 11. Problemy w pracy na Overleaf**

| Objaw | Przyczyna | Naprawa |
|---|---|---|
| kod bez właściwego kroju pisma | kompilator ustawiony na pdfLaTeX | zmień kompilator na LuaLaTeX |
| kompiluje się dokument pokazowy | zły dokument główny | wskaż plik główny pracy |
| bibliografia nie odświeża się | stary plik pomocniczy | pełna kompilacja od zera |
| kompilacja przerwana limitem czasu | za dużo naraz przy szkicowaniu | zakomentuj nieużywane włączenia |
| grafika nie znaleziona | plik poza katalogiem rysunków | przenieś plik, podawaj samą nazwę |
| polskie znaki jako znaki zastępcze | plik w innym kodowaniu | zapisz ponownie w UTF-8 |
| zmiany współpracownika niewidoczne | stara karta przeglądarki | odśwież stronę |
| projekt nie chce się skopiować | łącze bez prawa kopiowania | poproś o łącze do odczytu |

Katalog błędów kompilacji niezależnych od Overleaf zawiera podrozdział [Diagnostyka](01-latex.md#diagnostyka).

---

Wersja do druku obejmująca wszystkie rozdziały: [przewodnik.pdf](../przewodnik/przewodnik.pdf).
