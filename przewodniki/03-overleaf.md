# Overleaf i współpraca

Rozdział dotyczy ścieżki przeglądarkowej z podrozdziału
ef{sec:sciezki}; praca lokalna opisana jest w podrozdziale
ef{sec:lokalnie}.

Overleaf to LaTeX w przeglądarce. Nie trzeba nic instalować, projekt jest dostępny z każdego komputera, a promotor widzi tę samą wersję co Ty. Uniwersytet prowadzi **własną instalację** pod adresem `overleaf.uj.edu.pl` i to na niej pracujemy: projekty zostają w infrastrukturze uczelni, a udostępnianie działa wewnątrz Uniwersytetu. Dla pracy licencjackiej pisanej pod opieką promotora to najmniej kłopotliwe środowisko. Praca lokalna też jest możliwa i opisana jest w podrozdziale [Praca lokalna w Positronie](#praca-lokalna-w-positronie).

## Ścieżka studenta

### Konto i projekt

Konta nie zakładasz. Logujesz się przez **centralny punkt logowania** Uniwersytetu, kontem w domenie `@student.uj.edu.pl`. Jeżeli masz konto w serwisie publicznym Overleaf, jest ono niezależne: projektów między jednym a drugim nie widać i nie da się ich przenieść inaczej niż przez pobranie i wgranie archiwum.

Wzór wgrywasz jako **paczkę**. Pobierz plik `wzor-overleaf.zip` ze strony seminarium (<https://marekdejauj.github.io/epi-seminarium-Deja/>), a na Overleaf wybierz zakładanie nowego projektu z przesłanego archiwum i wskaż pobrany plik. Projekt powstaje od razu z gotową strukturą katalogów i niczego nie trzeba układać ręcznie.

Paczka powstaje z repozytorium przy każdej zmianie wzoru, więc pobrana dziś jest zgodna z bieżącą wersją klasy i stylu bibliograficznego. Wariant zapasowy, gdy strona seminarium jest niedostępna: pobierz archiwum całego repozytorium, rozpakuj je i spakuj **zawartość katalogu wzoru** do nowego archiwum.

### Ustawienia

**Tabela 12. Ustawienia projektu na Overleaf**

| Ustawienie | Wartość | Dlaczego |
|---|---|---|
| Compiler | LuaLaTeX | kod składa się wtedy właściwym krojem pisma |
| Main document | `main.tex` | inaczej kompiluje się dokument pokazowy |
| Spell check | polski | podkreśla literówki w trakcie pisania |

Ustawienie kompilatora jest jednorazowe i **łatwe do przeoczenia**. Objaw pominięcia: praca kompiluje się poprawnie, ale kod i nazwy funkcji mają inny krój pisma niż powinny.

### Co jest czym w projekcie

W pliku głównym uzupełniasz metadane na górze i nic więcej. Piszesz w plikach rozdziałów. Wpisy bibliograficzne trafiają do pliku w katalogu bibliografii, a grafiki do katalogu rysunków. Dokument pokazowy służy do zaglądania, gdy nie pamiętasz zapisu.

Klasy dokumentu ani plików stylu bibliograficznego **nie ruszasz**. Zmiana czegokolwiek w nich oznacza, że praca przestaje odpowiadać wymogom Instytutu, a odpowiedzialność za to spada na Ciebie, nie na wzór. Jeżeli czegoś nie da się zrobić dostępnymi poleceniami, zgłoś to promotorowi – brakuje wtedy polecenia we wzorze.

### Kompilacja i kopie

Pierwsza kompilacja po dodaniu nowego cytowania albo etykiety może pokazać znaki zapytania; po drugiej znikną. Rozwijane menu obok przycisku kompilacji zawiera polecenie pełnego przebiegu od zera – użyj go, gdy dokument przestaje odpowiadać zmianom albo gdy bibliografia nie chce się odświeżyć.

Kompilacja ma ograniczenie czasu. Praca licencjacka mieści się w nim spokojnie, ale gdy zaczniesz się o nie ocierać, zakomentuj w pliku głównym włączenia rozdziałów, nad którymi akurat nie pracujesz. Przed oddaniem odkomentuj wszystkie.

Projekt leży na serwerze uczelni i ma historię zmian, ale **to nie jest kopia zapasowa**. Historia chroni przed Twoim błędem, nie przed awarią serwera ani przed utratą dostępu do konta. Raz w tygodniu pobierz źródła projektu i zapisz je poza tą instalacją; przed każdym większym przemeblowaniem pracy dodatkowo.

### Udostępnienie i oddanie

Udostępnij projekt promotorowi **na adres uczelniany**, z prawem edycji. Udostępnianie działa wewnątrz instalacji uczelnianej, więc adres prywatny nie zadziała. Recenzentowi, gdy zajdzie potrzeba, wystarczy łącze tylko do odczytu.

Do Archiwum Prac trafia plik wynikowy pobrany z projektu. Przed pobraniem wykonaj pełną kompilację od zera, sprawdź brak nierozwiązanych cytowań i odsyłaczy oraz przejdź listę kontrolną z podrozdziału [Lista kontrolna przed oddaniem](06-wymogi.md#lista-kontrolna-przed-oddaniem).

## Plik bibliograficzny a Zotero

Dodatek Better BibTeX odświeża plik bibliograficzny **na Twoim dysku**. Overleaf o tym nie wie, więc plik trzeba do projektu przenieść. Najprostszy sposób to wgranie ręczne: w drzewie plików wskaż katalog bibliografii, prześlij zaktualizowany plik i potwierdź nadpisanie. Wystarczająco dobre, jeżeli robisz to raz na tydzień. Instalacja może mieć wczytywanie biblioteki Zotero na żądanie; sprawdź w ustawieniach projektu, czy jest dostępne, bo wymaga osobnej konfiguracji po stronie serwera. Przy synchronizacji z repozytorium plik odświeża się razem z resztą projektu.

Niezależnie od sposobu: **po każdej podmianie pliku uruchom pełną kompilację od zera**. Bibliografia budowana jest z pliku pomocniczego, który potrafi zostać na starej wersji.

## Ścieżka promotora

### Rozdanie wzoru grupie

Wzór rozdaje się **jako paczkę**, nie jako projekt do skopiowania. Prowadzący podaje jedno łącze do pliku `wzor-overleaf.zip` na stronie seminarium, każda osoba zakłada z niego własny projekt i udostępnia go prowadzącemu z prawem edycji.

Zalety układu: jedno łącze wystarcza dla całej grupy, paczka jest zawsze zgodna z repozytorium, projekty studentów są od początku niezależne, a prowadzący ma dostęp do wszystkich z jednego pulpitu. Wadą jest to, że poprawka we wzorze nie trafia do projektów już założonych – dlatego **wzór zamyka się przed pierwszymi zajęciami**, a późniejsze zmiany rozsyła się jako opis, co podmienić.

### Przegląd prac

Instalacja uczelniana daje trzy narzędzia: tryb przeglądu, historię zmian i zwykłą edycję.

*Tryb przeglądu* to boczny panel z komentarzami. Zaznaczasz fragment tekstu i dopisujesz do niego uwagę; uwaga zostaje przypięta do tego fragmentu, widzą ją obie strony, a po naniesieniu poprawki oznacza się ją jako załatwioną i znika z panelu. To jest podstawowy kanał uwag w seminarium.

Czego **nie ma**: śledzenia zmian. Zdanie poprawione przez prowadzącego wygląda w tekście dokładnie tak samo jak zdanie napisane przez studenta i nie da się go ani wyróżnić, ani odrzucić jednym kliknięciem. Wynika stąd zasada obowiązująca przez cały rok: **prowadzący komentuje, student poprawia**. Jeżeli prowadzący poprawi coś sam, bo tak jest szybciej, zostawia przy tym komentarz mówiący, co zmienił – inaczej zmiana we własnym tekście przejdzie studentowi niezauważona.

Historia zmian pozwala obejrzeć stan projektu z dowolnego dnia i porównać go z bieżącym. Żeby dało się z niej korzystać, **oznaczaj wersję etykietą przy każdym oddaniu fragmentu**. Bez etykiet historia jest ciągłym strumieniem zmian, w którym nie ma punktu odniesienia.

Przy pracy lokalnej w Positronie panelu komentarzy nie ma, więc uwagi zapisuje się jako komentarze LaTeX-a, które **nie pojawiają się w gotowym dokumencie**:

```latex
%% UWAGA: teza z tego akapitu nie wynika z cytowanego zrodla.
%% UWAGA: brakuje cytowania.
%% PYTANIE: skad wartosc progu 0,7?
```

Uwaga stoi wtedy dokładnie przy problematycznym zdaniu, student widzi ją przy pisaniu, a gotowy dokument pozostaje czysty. Wyszukanie wszystkich uwag w projekcie to jedno kliknięcie w polu wyszukiwania.

Zasada zamykająca jest w obu trybach ta sama: **uwagę zamyka się dopiero po naniesieniu poprawki**. Brak otwartych komentarzy w panelu i pusty wynik wyszukiwania w źródle oznaczają, że wszystkie uwagi zostały zaadresowane; ten punkt jest na liście kontrolnej przed oddaniem.

### Kontrola formalna

Kontrolę formalną prowadź **na złożonym dokumencie, nie w źródle**. Marginesy, interlinia, numeracja stron i układ elementów końcowych widać dopiero w składzie. Zestawienie wymogów wraz ze wskazaniem, co realizuje klasa, a co pozostaje po stronie autora, zawiera rozdział [Wymogi formalne](06-wymogi.md#wymogi-formalne).

W źródle warto sprawdzić dwie rzeczy: czy student nie zmieniał klasy dokumentu ani plików stylu bibliograficznego, co załatwia porównanie z wzorcem, oraz czy w projekcie nie zostały komentarze robocze i uwagi.

Przy kilkunastu pracach przegląd na żądanie nie działa. Sprawdzony układ to stałe okna: oddanie fragmentu do ustalonej daty, przegląd w ciągu tygodnia, omówienie na zajęciach. Fragmenty oddawane w kolejności pisania, a nie w kolejności rozdziałów – kolejność jest w tabeli **Kolejność pisania rozdziałów**.

## Praca lokalna w Positronie

Skoro pakiet R budujesz w Positronie, możesz w nim też pisać pracę. Kod i tekst są wtedy w jednym środowisku, a wykresy trafiają prosto do katalogu rysunków. Potrzebujesz dystrybucji TeX-a oraz rozszerzenia do LaTeX-a.

```bash
cd wzor-pracy
latexmk -lualatex main.tex
```

Zaletami są brak limitu czasu kompilacji, praca bez dostępu do sieci i pełna historia w repozytorium. Wadami – konieczność zainstalowania i utrzymania dystrybucji TeX-a oraz to, że udostępnienie promotorowi wymaga repozytorium zamiast jednego kliknięcia. Układ mieszany bywa najwygodniejszy: pakiet i wykresy lokalnie, tekst na Overleaf.

Repozytorium pakietu i pracę trzymaj **osobno**. Praca zawiera pliki, które nie mają nic wspólnego z pakietem, a repozytorium pakietu ma być czyste – to ono jest oceniane jako projekt dyplomowy i to jego adres podajesz na stronie tytułowej. Jeżeli prowadzisz pracę w repozytorium, ignoruj artefakty kompilacji.

## Problemy specyficzne dla Overleaf

**Tabela 13. Problemy w pracy na Overleaf**

| Objaw | Przyczyna | Naprawa |
|---|---|---|
| kod bez właściwego kroju pisma | kompilator ustawiony na pdfLaTeX | zmień kompilator na LuaLaTeX |
| kompiluje się dokument pokazowy | zły dokument główny | wskaż plik główny pracy |
| bibliografia nie odświeża się | stary plik pomocniczy | pełna kompilacja od zera |
| kompilacja przerwana limitem czasu | za dużo naraz przy szkicowaniu | zakomentuj nieużywane włączenia |
| grafika nie znaleziona | plik poza katalogiem rysunków | przenieś plik, podawaj samą nazwę |
| polskie znaki jako znaki zastępcze | plik w innym kodowaniu | zapisz ponownie w UTF-8 |
| zmiany współpracownika niewidoczne | stara karta przeglądarki | odśwież stronę |
| projekt niewidoczny dla promotora | udostępniony na adres prywatny | udostępnij na adres uczelniany |
| brak katalogów po wgraniu | spakowany katalog zamiast jego zawartości | spakuj zawartość, nie katalog |

Katalog błędów kompilacji niezależnych od Overleaf zawiera podrozdział [Diagnostyka](01-latex.md#diagnostyka).

---

Wersja do druku obejmująca wszystkie rozdziały: [przewodnik.pdf](../przewodnik/przewodnik.pdf).
