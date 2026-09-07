# Trzydzieści tygodni

Każdy wiersz tabeli to jeden tydzień: temat części wykładowej na zajęciach oraz to,
co ma powstać do następnego spotkania po stronie pakietu i po stronie pracy. Kreska
w kolumnie oznacza, że w tym tygodniu ta ścieżka nie ma nowego produktu – to jest
zaplanowane, takich pól wypada kilkanaście na trzydzieści tygodni.

Kolumna z miesiącem jest przybliżona. Wiążące są numery tygodni.

## Semestr zimowy

### Faza pierwsza: narzędzia i temat (tygodnie 1–3)

Zanim zaczniesz cokolwiek liczyć, potrzebujesz trzech rzeczy, które działają:
repozytorium, dokumentu pracy, który się składa, oraz pustego pakietu, który przechodzi
sprawdzenie. Wszystkie trzy da się zbudować w trzy tygodnie i wszystkich trzech będziesz
używać codziennie przez następne dwadzieścia siedem.

| Tydzień | Miesiąc | Część wykładowa | Pakiet | Praca |
|---|---|---|---|---|
| 1 | X | Czym jest oprogramowanie badawcze; jak czytać brief tematu | repozytorium założone, `README` z tematem | notatka z lektury: po co to badaczowi |
| 2 | X | Wzór pracy, Overleaf, pierwsze złożenie | – | projekt z wzoru kompiluje się, strona tytułowa wypełniona |
| 3 | X | Anatomia pakietu R: `DESCRIPTION`, `roxygen2`, `testthat` | pusty pakiet przechodzi sprawdzenie | szkielet rozdziałów w pliku pracy |

### Faza druga: lektura i kontrakt (tygodnie 4–6)

Tu powstaje dokument, od którego zależy reszta roku. Specyfikacja jest jedynym
miejscem, w którym rozstrzygasz, co program ma robić. Wszystko późniejsze jest
wykonaniem tego rozstrzygnięcia.

| Tydzień | Miesiąc | Część wykładowa | Pakiet | Praca |
|---|---|---|---|---|
| 4 | X | Czytanie artykułu metodycznego: co czytać najpierw | – | notatki z wzorami, lista symboli z definicjami |
| 5 | XI | Kontrakt: warunki wstępne, niezmienniki, kontrakt błędów | specyfikacja w wersji pierwszej | pytanie analityczne i cel pracy |
| 6 | XI | Bibliografia i Zotero; przegląd wzajemny specyfikacji | specyfikacja po recenzji koleżeńskiej | piętnaście pozycji w Zotero, plan rozdziału pierwszego |

**[Kamień milowy 1](kamienie-milowe.md#kamień-milowy-1-specyfikacja) na koniec
tygodnia 6.**

### Faza trzecia: dane i testy (tygodnie 7–9)

Testy powstają **przed** implementacją i na tym polega cała ta faza. Testy napisane
po kodzie sprawdzają, czy kod robi to, co robi. Testy napisane przed kodem sprawdzają,
czy kod robi to, co ma robić. Różnica jest zasadnicza i zauważysz ją w tygodniu
jedenastym.

| Tydzień | Miesiąc | Część wykładowa | Pakiet | Praca |
|---|---|---|---|---|
| 7 | XI | Procedura generowania danych o znanym wyniku | `data-raw/` z ustalonym ziarnem, zbiór przykładowy | opis procedury generowania do rozdziału drugiego |
| 8 | XI | Testy własności i przypadki liczone ręcznie | przypadki analityczne, niezmienniki | – |
| 9 | XII | Dane, na których metoda nie ma sensu | testy odporności, komplet testów – wszystkie czerwone | rozdział pierwszy: aparat formalny, wersja pierwsza |

**[Kamień milowy 2](kamienie-milowe.md#kamień-milowy-2-testy-przed-implementacją) na
koniec tygodnia 9.**

### Faza czwarta: silnik obliczeniowy (tygodnie 10–13)

Pierwszy kod obliczeniowy piszesz w dziesiątym tygodniu, mając gotową specyfikację
i komplet testów. Od tego momentu w każdej chwili wiadomo, jak daleko jesteś: liczba
zielonych testów jest miarą postępu, a nie odczuciem.

| Tydzień | Miesiąc | Część wykładowa | Pakiet | Praca |
|---|---|---|---|---|
| 10 | XII | Wzór na kod wektorowy | walidacja wejścia i przygotowanie danych | – |
| 11 | XII | Pętla naprawcza i moment, w którym trzeba ją przerwać | rdzeń obliczeniowy, część testów zielona | rozdział pierwszy po poprawkach |
| 12 | XII | Stabilność numeryczna, zbieżność, powtarzalność | wszystkie testy zielone na danych syntetycznych | – |
| 13 | I | Klasy S3 i metody `print`, `summary`, `plot` | obiekt wyniku i metody | wprowadzenie: tło, luka, cel, struktura |

Między tygodniem 12 a 13 wypada przerwa świąteczna. Tydzień 12 domyka silnik
obliczeniowy celowo: przerwa jest znacznie przyjemniejsza, kiedy testy są zielone.

### Faza piąta: przegląd półroczny (tygodnie 14–15)

| Tydzień | Miesiąc | Część wykładowa | Pakiet | Praca |
|---|---|---|---|---|
| 14 | I | Demonstracje: każdy pokazuje działający silnik | pokaz na danych syntetycznych | wprowadzenie po poprawkach |
| 15 | I | Podsumowanie semestru, plan drugiego | znacznik wersji `0.1.0` | **oddanie części pierwszej pracy** |

**[Kamień milowy 3](kamienie-milowe.md#kamień-milowy-3-silnik-i-część-pierwsza-pracy)
na koniec tygodnia 15.**

Po tygodniu 15 przypada sesja zimowa i przerwa międzysemestralna. W tym czasie nie ma
zadań seminaryjnych.

## Semestr letni

### Faza szósta: jakość i zgodność (tygodnie 16–19)

Semestr zimowy kończy się kodem, który liczy poprawnie. Ta faza zamienia go w pakiet,
który da się zainstalować, przeczytać i zacytować.

| Tydzień | Miesiąc | Część wykładowa | Pakiet | Praca |
|---|---|---|---|---|
| 16 | II/III | Sprawdzenie w trybie zgodności: skąd się biorą uwagi | `R CMD check` w trybie zgodności, cel 0/0/0 | – |
| 17 | III | Wąskie gardła: profilowanie i zamiana pętli | wersja wektorowa najcięższych fragmentów | – |
| 18 | III | Dokumentacja funkcji i przykłady wykonywalne | komplet `roxygen2`, przykłady poniżej pięciu sekund | rozdział drugi: struktura pakietu |
| 19 | III | Ciągła integracja na trzech systemach | sprawdzenie zielone na Linuksie, Windowsie i macOS | rozdział drugi: testy jako element metodologii |

**[Kamień milowy 4](kamienie-milowe.md#kamień-milowy-4-pakiet-zgodny-i-udokumentowany)
na koniec tygodnia 19.**

### Faza siódma: zastosowanie empiryczne (tygodnie 20–23)

Tu narzędzie po raz pierwszy dotyka danych, których nie wygenerowałeś sam. Zwykle
w tym momencie okazuje się, że walidacja wejścia jest za wąska, a metoda ma założenie,
którego realny zbiór nie spełnia. To nie jest awaria. To jest treść rozdziału trzeciego.

| Tydzień | Miesiąc | Część wykładowa | Pakiet | Praca |
|---|---|---|---|---|
| 20 | IV | Otwarte zbiory danych, licencje, warunki wtórnego użycia | wczytanie zbioru empirycznego | uzasadnienie wyboru zbioru |
| 21 | IV | Porównanie z metodą odniesienia | skrypt analizy odtwarzalny od zera | rozdział trzeci: przebieg analizy |
| 22 | IV | Wykresy i tabele wynikowe | warstwa wizualizacji | rozdział trzeci: wyniki i ich interpretacja |
| 23 | IV | Winieta jako opowieść o pełnym przepływie | winieta przechodząca przez cały przepływ | rozdział drugi po poprawkach |

Przerwa wielkanocna wypada wewnątrz tej fazy i przesuwa jeden z tygodni. Zadania
przesuwają się razem z nią.

### Faza ósma: serwis i wydanie (tygodnie 24–26)

| Tydzień | Miesiąc | Część wykładowa | Pakiet | Praca |
|---|---|---|---|---|
| 24 | V | Serwis dokumentacyjny i artykuł o algorytmie | strona z dokumentacją i opisem metody | zgodność adresów na stronie tytułowej |
| 25 | V | Aplikacja działająca w przeglądarce | aplikacja osadzona pod adresem serwisu | rozdział trzeci po poprawkach |
| 26 | V | Wydanie: wersjonowanie, znacznik, identyfikator cyfrowy | wersja `1.0.0`, znacznik, zamrożone środowisko | aneksy: metadane oprogramowania, nota serwisu |

**[Kamień milowy 5](kamienie-milowe.md#kamień-milowy-5-projekt-dyplomowy) na koniec
tygodnia 26.** Od niego zależy zaliczenie seminarium: zaliczenie następuje po
przyjęciu projektu dyplomowego.

### Faza dziewiąta: domknięcie (tygodnie 27–30)

| Tydzień | Miesiąc | Część wykładowa | Pakiet | Praca |
|---|---|---|---|---|
| 27 | V | Audyt wzajemny: instalujesz i psujesz cudzy pakiet | poprawki po audycie | podsumowanie |
| 28 | VI | Elementy końcowe pracy | – | wykaz źródeł, spisy, indeks nazwisk, oświadczenie |
| 29 | VI | Próbna obrona | pokaz na żywo z konsoli | korekta całości na wydruku |
| 30 | VI | Oddanie | repozytorium publiczne, adresy trwałe | **praca złożona w Archiwum Prac** |

**[Kamień milowy 6](kamienie-milowe.md#kamień-milowy-6-praca-złożona) w tygodniu 30.**

## Kolejność pisania rozdziałów

Rozdziały powstają w innej kolejności, niż stoją w pracy. Wynika to z tego, że
o czymś można napisać dopiero wtedy, kiedy to istnieje.

| Kolejność | Część pracy | Tygodnie | Dlaczego wtedy |
|---|---|---|---|
| 1 | rozdział pierwszy: podstawy metodyczne | 9–11 | powstaje z notatek z lektury i ze specyfikacji, obu już gotowych |
| 2 | wprowadzenie | 13–14 | luka staje się widoczna dopiero po zetknięciu z metodą |
| 3 | rozdział drugi: implementacja | 18–19, 23 | architekturę opisuje się, kiedy przestaje się zmieniać |
| 4 | rozdział trzeci: studium przypadku | 21–22, 25 | powstaje razem z analizą, nie po niej |
| 5 | podsumowanie | 27 | domyka cel z wprowadzenia, więc musi być po nim |
| 6 | elementy końcowe i aneksy | 28 | zbiera to, co już jest |

Wprowadzenie pisane w pierwszym tygodniu trzeba napisać drugi raz. Nie dlatego, że
zostało źle napisane, tylko dlatego, że w październiku nie wiesz jeszcze, czego
dotyczy Twoja praca.

Szczegółowe wskazówki do każdej części są w przewodniku
[Jak napisać pracę](../przewodniki/04-jak-pisac.md).
