# Kamienie milowe

Sześć punktów, w których sprawdzane jest, czy praca idzie do przodu. Każdy ma
warunki przyjęcia sformułowane tak, żeby dało się je sprawdzić w kilka minut
i żeby odpowiedź brzmiała „tak" albo „nie", a nie „raczej".

| Nr | Kiedy | Co domyka | Waga |
|---|---|---|---|
| [1](#kamień-milowy-1-specyfikacja) | koniec tygodnia 6 | specyfikacja | warunek przejścia do implementacji |
| [2](#kamień-milowy-2-testy-przed-implementacją) | koniec tygodnia 9 | testy | warunek przejścia do implementacji |
| [3](#kamień-milowy-3-silnik-i-część-pierwsza-pracy) | koniec tygodnia 15 | pierwszy semestr | ocena okresowa |
| [4](#kamień-milowy-4-pakiet-zgodny-i-udokumentowany) | koniec tygodnia 19 | jakość pakietu | ocena okresowa |
| [5](#kamień-milowy-5-projekt-dyplomowy) | koniec tygodnia 26 | projekt dyplomowy | **zaliczenie seminarium** |
| [6](#kamień-milowy-6-praca-złożona) | tydzień 30 | praca licencjacka | dopuszczenie do obrony |

Formalnie zaliczenie seminarium następuje po przyjęciu projektu dyplomowego, czyli
po kamieniu milowym 5. Pozostałe pięć służy temu, żeby piąty był osiągalny.

Sposób punktowania i przełożenie na ocenę opisuje [rubryka
projektu](../ocenianie/rubryka-projektu.md).

## Kamień milowy 1: specyfikacja

Koniec tygodnia 6. Domyka fazę lektury.

**Co oddajesz.** Plik `SPEC.md` w repozytorium pakietu, zbudowany według
[szablonu](../szablony/spec/SPEC-szablon.md), po recenzji koleżeńskiej i po
naniesieniu uwag.

**Warunki przyjęcia.**

- [ ] Wejście opisane z kształtami, typami i dopuszczalnymi zakresami
- [ ] Wszystkie symbole z artykułu wypisane z definicjami
- [ ] Warunki wstępne wyliczone jako lista, każdy sprawdzalny programowo
- [ ] Niezmienniki wypisane wraz ze sposobem sprawdzenia
- [ ] Struktura wyniku podana z nazwami pól i typami
- [ ] Kontrakt błędów: które naruszenie zatrzymuje wykonanie i z jakim komunikatem
- [ ] Sekcja niedopowiedzeń artykułu wypełniona wraz z przyjętym rozstrzygnięciem
- [ ] Recenzent koleżeński podpisany, uwagi rozstrzygnięte

Ostatnie dwa punkty są tymi, które najczęściej blokują przyjęcie. Sekcja
niedopowiedzeń jest miejscem, w którym przyznajesz, czego artykuł nie mówi wprost –
i decydujesz za autorów. Ta decyzja wraca później w rozdziale pierwszym pracy jako
opis granic stosowalności.

**Jeżeli warunki nie są spełnione**, specyfikacja wraca do poprawy i tydzień 7 idzie
na jej domknięcie. Faza testów przesuwa się o tydzień, faza implementacji nie.
Nie zaczyna się implementacji przed przyjęciem specyfikacji, bo wtedy specyfikacja
przestaje być projektem, a staje się opisem tego, co przypadkiem powstało.

## Kamień milowy 2: testy przed implementacją

Koniec tygodnia 9. Domyka fazę testów.

**Co oddajesz.** Katalog `tests/testthat/` z kompletem testów, w którym **wszystkie
testy są czerwone**, bo nie ma jeszcze czego testować, oraz `data-raw/` z procedurą
generowania danych.

**Warunki przyjęcia.**

- [ ] Co najmniej trzy przypadki analityczne o wyniku policzonym ręcznie, z rachunkiem w komentarzu testu
- [ ] Każdy niezmiennik ze specyfikacji ma swój test
- [ ] Każdy błąd zatrzymujący wykonanie ma test sprawdzający komunikat
- [ ] Procedura generowania danych ma ustalone ziarno i zwraca wynik powtarzalny
- [ ] Procedura generuje dane o **znanym prawdziwym wyniku**, nie tylko dane losowe
- [ ] Jest wariant danych naruszających założenia metody
- [ ] `devtools::test()` uruchamia się i raportuje same porażki, bez błędów wykonania

Ostatni warunek jest istotny: test, który się wywala z powodu literówki, nie jest
testem czerwonym. Jest testem zepsutym. Różnicę widać w komunikacie.

**Jeżeli warunki nie są spełnione**, brakujące testy dopisujesz w tygodniu 10
równolegle z walidacją wejścia. Zaległość powyżej jednego tygodnia zgłaszasz
na konsultacjach.

## Kamień milowy 3: silnik i część pierwsza pracy

Koniec tygodnia 15. Domyka semestr zimowy.

**Co oddajesz.** Działający silnik obliczeniowy oznaczony znacznikiem `0.1.0` oraz
część pierwszą pracy: wprowadzenie i rozdział pierwszy.

**Warunki przyjęcia po stronie pakietu.**

- [ ] Wszystkie testy przechodzą na danych syntetycznych
- [ ] Wynik jest obiektem klasy S3 z metodami `print` i `summary`
- [ ] Walidacja wejścia odrzuca każdy przypadek z kontraktu błędów
- [ ] Wynik nie zależy od kolejności wierszy wejścia
- [ ] Powtórne uruchomienie z tym samym ziarnem daje identyczny wynik
- [ ] Repozytorium ma znacznik `0.1.0`

**Warunki przyjęcia po stronie pracy.**

- [ ] Wprowadzenie zawiera tło, lukę, cel, pytanie i strukturę pracy
- [ ] Rozdział pierwszy podaje aparat formalny z objaśnieniem każdego symbolu
- [ ] Po każdym wzorze jest akapit mówiący, co ten wzór robi
- [ ] Granice stosowalności metody opisane, nie pominięte
- [ ] Bibliografia liczy co najmniej piętnaście pozycji, w tym obcojęzyczne
- [ ] Każda pozycja bibliografii ma cytowanie w tekście
- [ ] Dokument składa się bez błędów i bez nierozwiązanych odsyłaczy

Objętość części pierwszej to orientacyjnie dwadzieścia stron znormalizowanych, czyli
połowa limitu pracy. Nie jest to warunek przyjęcia, tylko punkt odniesienia: część
pierwsza wyraźnie krótsza zwykle oznacza, że rozdział pierwszy referuje artykuł
zamiast go opracowywać.

## Kamień milowy 4: pakiet zgodny i udokumentowany

Koniec tygodnia 19.

**Co oddajesz.** Pakiet przechodzący sprawdzenie w trybie zgodności na trzech
systemach operacyjnych, z kompletną dokumentacją.

**Warunki przyjęcia.**

- [ ] `R CMD check --as-cran` kończy się wynikiem 0 błędów, 0 ostrzeżeń, 0 uwag
- [ ] Ciągła integracja świeci na zielono na Linuksie, Windowsie i macOS
- [ ] Każda funkcja eksportowana ma opis, opis każdego argumentu i opis wyniku
- [ ] Każda funkcja eksportowana ma przykład, który się wykonuje
- [ ] Przykłady w sumie wykonują się poniżej pięciu sekund
- [ ] Zbiór danych dołączony do pakietu ma udokumentowaną każdą zmienną
- [ ] `DESCRIPTION` ma wypełnione pola autora, licencji i opisu
- [ ] Plik `inst/CITATION` pozwala zacytować pakiet
- [ ] W kodzie nie ma znaków spoza ASCII w identyfikatorach

Uwagi sprawdzenia dotyczące znaków diakrytycznych są w polskojęzycznym pakiecie
najczęstsze. Rozwiązanie opisuje przewodnik – identyfikatory bez znaków
diakrytycznych, treść komunikatów w kodowaniu UTF-8.

**Jeżeli sprawdzenie nie jest czyste**, oddajesz je z wykazem pozostałych uwag
i planem ich usunięcia. Jedna uwaga z uzasadnieniem jest do przyjęcia. Pięć uwag
bez uzasadnienia nie jest.

## Kamień milowy 5: projekt dyplomowy

Koniec tygodnia 26. **Od tego kamienia zależy zaliczenie seminarium.**

Projekt dyplomowy to całość: pakiet, serwis z opisem metody i działające narzędzie
pod publicznym adresem. Standardy wymagają samodzielnie zaprojektowanej i wykonanej
aplikacji z interfejsem internetowym, a zaliczenie seminarium następuje dopiero po
przyjęciu projektu.

**Warunki przyjęcia.**

- [ ] Pakiet w wersji `1.0.0` ze znacznikiem w repozytorium
- [ ] Sprawdzenie w trybie zgodności nadal czyste
- [ ] Serwis działa pod adresem, który wpisujesz na stronę tytułową pracy
- [ ] Serwis zawiera opis algorytmu z cytowaniami i bibliografią
- [ ] Serwis zawiera dokumentację wszystkich funkcji eksportowanych
- [ ] Aplikacja działa w przeglądarce i przyjmuje dane użytkownika
- [ ] Aplikacja obsługuje błędne dane komunikatem, a nie zatrzymaniem
- [ ] Nota wymagana przez Standardy jest w zakładce o serwisie
- [ ] Repozytorium jest publiczne i zawiera pełną historię pracy
- [ ] Środowisko zamrożone, analiza z rozdziału trzeciego odtwarzalna
- [ ] Rejestr poleceń wydanych agentowi programistycznemu kompletny

**Aplikacja musi robić coś więcej niż wyświetlać zawartość.** Wymóg pochodzi wprost
ze Standardów i w tym seminarium jest spełniony z definicji: aplikacja liczy metodę
z artykułu. Warunkiem jest jednak to, żeby dało się w niej zmienić parametry
i zobaczyć, jak zmienia się wynik. Sama prezentacja wyniku policzonego wcześniej
nie wystarcza.

## Kamień milowy 6: praca złożona

Tydzień 30.

**Co oddajesz.** Pracę licencjacką w Archiwum Prac wraz z kompletem elementów
końcowych.

**Warunki.** Przechodzisz [listę kontrolną przed
oddaniem](../przewodniki/06-wymogi.md#lista-kontrolna-przed-oddaniem) w całości.
Wszystkie pozycje muszą być odhaczone.

Dodatkowo:

- [ ] Praca mieści się w limicie objętości liczonym od wstępu do wniosków
- [ ] Adresy serwisu i repozytorium na stronie tytułowej działają
- [ ] Aneks z metadanymi oprogramowania zgodny ze stanem repozytorium
- [ ] Aneks z wykazem poleceń kompletny
- [ ] Oświadczenie o wykorzystaniu sztucznej inteligencji wypełnione, jeżeli dotyczy
- [ ] Wersja pakietu opisana w pracy zgodna ze znacznikiem w repozytorium

Ostatni punkt bywa źródłem rozbieżności: praca opisuje wersję `1.0.0`, a repozytorium
w międzyczasie doszło do `1.0.3`. Albo cofnij opis do wersji ze znacznika, albo
opisz zmiany. Rozbieżność bez komentarza to błąd rzeczowy.
