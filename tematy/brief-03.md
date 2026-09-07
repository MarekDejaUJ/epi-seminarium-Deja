# Temat 03. Walidacja macierzy Q metodą detekcji sygnału

## Metryka

| | |
|---|---|
| Artykuł źródłowy | Li, Jia; Chen, Ping (2024). *A new Q-matrix validation method based on signal detection theory*. British Journal of Mathematical and Statistical Psychology |
| Identyfikator | [10.1111/bmsp.12371](https://doi.org/10.1111/bmsp.12371) |
| **Errata** | *Correction to „A new Q-matrix validation method based on signal detection theory"*, [10.1111/bmsp.12385](https://doi.org/10.1111/bmsp.12385) (2025) |
| Dostęp | przez bibliotekę UJ |
| Dziedzina | psychometria, pomiar kompetencji |
| Proponowany tytuł pracy | Pakiet R do walidacji macierzy specyfikacji zadań jako przykład zastosowania teorii detekcji sygnału w diagnozie kompetencji |
| Proponowana nazwa pakietu | `WalidacjaQR` |
| Trudność | ●●● |

> **Zanim zaczniesz:** pobierz **oba** teksty. Errata zmienia treść artykułu.
> Praca oparta na wersji pierwotnej będzie zawierać błąd, którego autorzy sami się
> wyrzekli.

## Po co to badaczowi

Testy kompetencyjne mają mierzyć konkretne umiejętności. Żeby z odpowiedzi wyczytać,
które umiejętności uczeń opanował, trzeba wiedzieć, **które zadanie mierzy co**.
Zapisuje się to w tablicy zero-jedynkowej: wiersze to zadania, kolumny umiejętności,
jedynka oznacza, że zadanie wymaga danej umiejętności.

Tablicę tę wypełniają eksperci – autorzy testu, metodycy, nauczyciele. I tu leży
problem, o którym mówi cała literatura przedmiotu: **eksperci się mylą**. Przypisują
zadaniu umiejętność, której ono w istocie nie sprawdza, albo pomijają taką, która
jest potrzebna. Skutek jest poważniejszy, niż się wydaje: diagnoza wystawiona na
podstawie błędnej tablicy przypisuje uczniowi braki, których nie ma, albo przeocza
te, które ma.

Metody walidacji tej tablicy istnieją od lat, ale opierają się na dopasowaniu modelu
i bywają trudne do zinterpretowania. Artykuł proponuje inne podejście: potraktować
zadanie jak **detektor**. Dobry detektor umiejętności reaguje, gdy uczeń ją ma,
i milczy, gdy jej nie ma. Teoria detekcji sygnału daje gotowy aparat do mierzenia,
jak dobrym detektorem jest dane zadanie względem danej umiejętności – ten sam, który
w psychologii służy do oceny wykrywalności bodźców.

Dla badacza edukacji oznacza to narzędzie, które wskazuje konkretne komórki tablicy
wymagające przemyślenia, wraz z miarą siły tego wskazania.

## Algorytm

**Wejście.** Macierz odpowiedzi zero-jedynkowych: uczniowie w wierszach, zadania
w kolumnach. Wstępna macierz specyfikacji wypełniona przez ekspertów. Opcjonalnie
wagi próby.

**Wyjście.** Poprawiona macierz specyfikacji, miary jakości detekcji dla każdej pary
zadanie–umiejętność oraz wykaz komórek, które metoda proponuje zmienić.

**Kroki.**

1. Sprawdzenie wejścia: macierz odpowiedzi zero-jedynkowa, macierz specyfikacji
   bez wiersza samych zer.
2. Oszacowanie rozkładu opanowania umiejętności przez uczniów przy zadanej macierzy
   specyfikacji.
3. Dla każdej pary zadanie–umiejętność wyznaczenie miar detekcji: skłonności do
   reagowania oraz zdolności rozróżniania.
4. Przeszukiwanie: rozważenie zamiany wartości w komórkach i przyjęcie zmian
   poprawiających kryterium.
5. Powtórzenie do stabilizacji.

**Co wynotować z artykułu i erraty.** Z sekcji metodycznej: definicję obu miar
detekcji w kategoriach prawdopodobieństw warunkowych, dokładną postać kryterium
optymalizowanego w przeszukiwaniu, sposób szacowania rozkładu opanowania oraz
warunek zatrzymania. **Sprawdź w erracie, który z tych elementów uległ zmianie** i
zapisz to w tabeli niedopowiedzeń specyfikacji – to gotowy materiał do wniosków pracy.

## Kontrakt

**Warunki wstępne.** Macierz odpowiedzi zawiera wyłącznie zera i jedynki bez braków
albo z jawnie zadeklarowaną obsługą braków; macierz specyfikacji zero-jedynkowa
o liczbie wierszy równej liczbie zadań; żaden wiersz specyfikacji nie jest zerowy;
co najmniej dwie umiejętności.

**Niezmienniki.** Poprawiona macierz pozostaje zero-jedynkowa. Kryterium nie pogarsza
się między iteracjami. Przy macierzy specyfikacji zgodnej z prawdziwą metoda nie
proponuje zmian.

**Wyjście.** Klasa `walidacja_q` ze składnikami: macierz poprawiona, macierz
wejściowa, miary detekcji, wykaz zmian, liczba iteracji.

**Błędy zatrzymujące wykonanie.** Macierz odpowiedzi spoza zbioru zero-jedynkowego;
zerowy wiersz specyfikacji; niezgodność wymiarów; brak zbieżności w zadanej liczbie
iteracji.

## Plan pakietu

| Plik | Odpowiedzialność |
|---|---|
| `R/przygotowanie_danych.R` | walidacja macierzy, obsługa braków, wagi |
| `R/detekcja.R` | miary detekcji dla pary zadanie–umiejętność |
| `R/przeszukiwanie.R` | procedura poprawiania macierzy |
| `R/klasy_s3.R` | obiekt wyniku, metody `print` i `summary` |
| `R/wizualizacja.R` | mapa cieplna zmian i miar detekcji |

Zależności: `stats`, `ggplot2`. Jeżeli sięgasz po istniejący pakiet do modeli
diagnostycznych, uzasadnij to w pracy i sprawdź, czy nie przenosisz do niego całej
metody.

## Dane

**Procedura generowania.** Ustalasz prawdziwą macierz specyfikacji, losujesz
opanowanie umiejętności przez uczniów, generujesz odpowiedzi zgodnie z modelem
diagnostycznym. Następnie **psujesz** macierz: zamieniasz zadaną liczbę komórek.
Metoda powinna te komórki wskazać. Odsetek poprawnie wskazanych komórek jest
naturalną miarą skuteczności i wprost odpowiada na pytanie badawcze.

Parametry: liczba uczniów, zadań, umiejętności, odsetek zepsutych komórek, parametry
zgadywania i przeoczenia, ziarno.

**Przypadki o znanym wyniku.** Macierz nieuszkodzona: brak proponowanych zmian.
Jedna komórka zepsuta przy dużej próbie: metoda wskazuje dokładnie ją. Zadanie
mierzące wszystkie umiejętności: miary detekcji identyczne dla każdej.

**Przypadki patologiczne.** Uczeń odpowiadający na wszystko poprawnie; zadanie,
na które nikt nie odpowiedział poprawnie; jedna umiejętność.

**Zbiór empiryczny.** Otwarte zbiory odpowiedzi z badań edukacyjnych, na przykład
dane towarzyszące pakietom do modeli diagnostycznych albo udostępniane przez
międzynarodowe badania osiągnięć. Sprawdź licencję i warunki cytowania.

## Mapowanie na pracę

| Sekcja briefu | Rozdział pracy |
|---|---|
| Po co to badaczowi | Wprowadzenie: tło i luka |
| Algorytm, co wynotować | Rozdział 1: aparat formalny |
| Errata i jej skutki | Rozdział 1 oraz Podsumowanie |
| Plan pakietu, dane, badanie skuteczności | Rozdział 2 |
| Zbiór empiryczny | Rozdział 3 |

**Wstępne pytanie badawcze.** Przy jakiej liczbie uczniów metoda zaczyna wiarygodnie
wskazywać błędne komórki tablicy specyfikacji i jak zależy to od liczby umiejętności?

## Polecenia startowe

1. Miary detekcji jako funkcja pary zadanie–umiejętność, zgodnie z Twoimi notatkami
   z artykułu **i erraty**.
2. Procedura przeszukiwania z jawnym warunkiem zatrzymania.
3. Procedura generowania z kontrolowanym psuciem macierzy.
4. Dane naruszające warunki wstępne wraz z oczekiwanym zachowaniem.
5. Badanie skuteczności: odsetek poprawnie wskazanych komórek w funkcji liczby uczniów.
6. Dokumentacja funkcji eksportowanych.

## Pułapki

**Wersja przed erratą.** Narzędzie może znać pierwotną wersję metody z materiałów
w sieci. Ty pracujesz na poprawionej. Sprawdź każdy wzór.

**Przeszukiwanie zachłanne nie daje optimum globalnego.** To nie jest wada
implementacji, tylko własność metody. Praca musi to powiedzieć, a nie ukrywać za
sformułowaniem o „optymalnej macierzy".

**Wiersz samych zer.** Zadanie niemierzące żadnej umiejętności psuje szacowanie.
Metoda musi to wykluczyć na wejściu, a nie radzić sobie z tym po drodze.

**Interpretacja wskazań.** Metoda wskazuje komórki podejrzane, a nie błędne.
Ostateczna decyzja należy do eksperta przedmiotowego. Praca, która przedstawia
wynik jako poprawioną tablicę bez tego zastrzeżenia, nadinterpretuje metodę.

**Na obronie** musisz umieć wyjaśnić, czym w tej metodzie jest sygnał, czym szum
i dlaczego akurat aparat z psychologii percepcji nadaje się do oceny zadań testowych.

## Literatura

Artykuł źródłowy: `liChen2024qmatrix` wraz z erratą `liChen2025korekta`.

Wprowadzenie: podręcznikowe omówienie modeli diagnostycznych i roli tablicy
specyfikacji; klasyczne opracowanie teorii detekcji sygnału. Dwie do czterech
pozycji dobierasz sam.

Środowisko: `rcore2026`. Wymagania formalne: `standardyEPI`.
