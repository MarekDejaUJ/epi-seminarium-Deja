# Listy kontrolne

Cztery listy: dwie dla studenta, jedna dla promotora, jedna dla recenzenta. Każdą
przechodzi się od góry do dołu, odhaczając. Pozycja, przy której trzeba się
zastanowić, czy liczyć ją za spełnioną, jest niespełniona.

## Student: projekt dyplomowy

Do przejścia przed [kamieniem milowym
5](../harmonogram/kamienie-milowe.md#kamień-milowy-5-projekt-dyplomowy), w tygodniu 26.

### Instalacja i działanie

- [ ] Pakiet instaluje się z publicznego repozytorium na czystym systemie
- [ ] Przykład z pliku `README` działa po skopiowaniu, bez poprawek
- [ ] Sprawdzenie w trybie zgodności daje 0 błędów, 0 ostrzeżeń, 0 uwag
- [ ] Ciągła integracja jest zielona na Linuksie, Windowsie i macOS
- [ ] Wszystkie testy przechodzą po świeżym sklonowaniu repozytorium
- [ ] Analiza z rozdziału trzeciego odtwarza się z zamrożonego środowiska

### Serwis

- [ ] Serwis działa pod adresem podanym na stronie tytułowej pracy
- [ ] Opis algorytmu zawiera wzory i powołania
- [ ] Bibliografia serwisu jest zgodna z bibliografią pracy
- [ ] Dokumentacja obejmuje wszystkie funkcje eksportowane
- [ ] Nota wymagana przez Standardy znajduje się w zakładce o serwisie
- [ ] Nota podaje autora, przynależność serwisu do pracy licencjackiej, promotora i jednostkę
- [ ] Odnośniki w nawigacji prowadzą tam, gdzie zapowiadają

### Aplikacja

- [ ] Aplikacja uruchamia się pod adresem serwisu
- [ ] Da się zmienić parametry metody i zobaczyć zmianę wyniku
- [ ] Da się wczytać własne dane
- [ ] Błędne dane dają komunikat, a nie zatrzymanie
- [ ] Komunikat jest zrozumiały dla kogoś, kto nie zna kodu
- [ ] Aplikacja działa w przeglądarce innej niż ta, w której powstawała
- [ ] Aplikacja działa na ekranie telefonu na tyle, żeby dało się odczytać wynik

### Repozytorium

- [ ] Repozytorium jest publiczne
- [ ] Historia obejmuje cały rok, nie jeden commit z całością
- [ ] Licencja jest wskazana i zgodna z ustaleniami seminarium
- [ ] Plik `inst/CITATION` pozwala zacytować pakiet
- [ ] Znacznik `1.0.0` wskazuje wersję opisaną w pracy
- [ ] Rejestr poleceń wydanych agentowi jest kompletny

## Student: praca licencjacka

Pełna lista formalna jest w przewodniku: [lista kontrolna przed
oddaniem](../przewodniki/06-wymogi.md#lista-kontrolna-przed-oddaniem). Przejdź ją
w całości.

Poniżej cztery pozycje, których tamta lista nie obejmuje, bo dotyczą zgodności między
pracą a projektem. To one najczęściej rozjeżdżają się w ostatnim tygodniu.

- [ ] Wersja pakietu opisana w pracy odpowiada znacznikowi w repozytorium
- [ ] Zrzuty ekranu aplikacji pokazują jej stan bieżący, nie sprzed dwóch miesięcy
- [ ] Nazwy funkcji i argumentów w pracy odpowiadają nazwom w kodzie
- [ ] Liczby w rozdziale trzecim pochodzą z ostatniego przebiegu analizy

Ostatni punkt wymaga uruchomienia analizy jeszcze raz, po ostatniej poprawce w kodzie.
Wynik zmieniony na trzecim miejscu po przecinku i tak trzeba poprawić w tabeli.

## Promotor: przed dopuszczeniem do obrony

### Projekt

- [ ] Projekt przyjęty, zaliczenie seminarium wystawione
- [ ] Serwis i aplikacja działają w dniu sprawdzenia, pod adresami z pracy
- [ ] Repozytorium publiczne, historia obejmuje cały rok
- [ ] Sprawdzenie pakietu odtworzone niezależnie i czyste

### Praca

- [ ] Objętość mieści się w limicie liczonym od wstępu do wniosków
- [ ] Skład zgodny ze Standardami: krój, stopień, interlinia, marginesy, numeracja
- [ ] Strona tytułowa zgodna z załącznikiem do Standardów
- [ ] Opisy bibliograficzne zgodne z wymaganym stylem
- [ ] Każde powołanie ma pozycję w bibliografii i odwrotnie
- [ ] Powołania sprawdzone wyrywkowo: treść źródła odpowiada twierdzeniu
- [ ] Materiał ilustracyjny ma tytuł nad i źródło pod obiektem
- [ ] Aneksy kompletne: metadane oprogramowania, nota serwisu, oświadczenie, wykaz poleceń
- [ ] Praca wolna od śladów redakcji roboczej i komentarzy w plikach źródłowych

### Samodzielność

- [ ] Historia repozytorium pokazuje pracę rozłożoną w czasie
- [ ] Rejestr poleceń jest wiarygodny: zawiera także nieudane próby
- [ ] Student objaśnia wybrane fragmenty własnego kodu bez przygotowania
- [ ] Rozstrzygnięcia w specyfikacji student potrafi uzasadnić
- [ ] Oświadczenie o wykorzystaniu sztucznej inteligencji zgodne ze stanem faktycznym

Trzeci punkt sprawdza się w rozmowie, przez wskazanie losowej funkcji i pytanie, co
robi jej trzecia linia i dlaczego jest właśnie tam. Zestaw pytań pomocniczych jest
[tutaj](pytania-na-obrone.md).

## Recenzent

Lista pomocnicza, porządkująca lekturę według [ośmiu kryteriów](rubryka-pracy.md).

- [ ] Czy tytuł odpowiada zawartości, w obu swoich częściach?
- [ ] Czy wprowadzenie stawia lukę, a podsumowanie do niej wraca?
- [ ] Czy przegląd obejmuje istniejące implementacje metody?
- [ ] Czy każdy wzór ma objaśnienie, a każdy symbol definicję?
- [ ] Czy widać granicę między dorobkiem cudzym a własnym opracowaniem?
- [ ] Czy praca mówi, skąd wiadomo, że program liczy poprawnie?
- [ ] Czy ograniczenia metody i danych zostały nazwane?
- [ ] Czy wnioski mieszczą się w tym, co pokazują wyniki?
- [ ] Czy terminologia jest konsekwentna w całej pracy?
- [ ] Czy aplikacja działa i odpowiada opisowi?
- [ ] Czy bibliografia jest spójna z tekstem i zgodna ze stylem?
- [ ] Czy praca zawiera element własny, nie tylko wykonanie cudzego pomysłu?

Ostatnie pytanie jest w tym seminarium szczególne. Metoda pochodzi z artykułu, a jej
implementacja jest zadaniem wykonawczym. Element własny to zwykle jedno z trzech:
rozstrzygnięcie czegoś, czego artykuł nie dopowiada; zbadanie zachowania metody
w warunkach, których artykuł nie sprawdzał; albo zastosowanie do danych z innej
dziedziny niż ta, dla której metoda powstała.
