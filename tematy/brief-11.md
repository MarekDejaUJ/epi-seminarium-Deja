# Temat 11. Wyniki porównywalne między różnymi zestawami zapytań

## Metryka

| | |
|---|---|
| Artykuł źródłowy | Webber, William; Moffat, Alistair; Zobel, Justin (2008). *Score Standardization for Inter-Collection Comparison of Retrieval Systems*. SIGIR '08, s. 51-58 |
| Identyfikator | [kopia autorska](https://people.eng.unimelb.edu.au/jzobel/fulltext/sigir08.pdf) |
| Dostęp | wolny |
| Dziedzina | wyszukiwanie informacji, metodologia eksperymentu |
| Proponowany tytuł pracy | Pakiet R do standaryzacji wyników oceny systemów wyszukiwawczych jako przykład zastosowania normalizacji rozkładowej w badaniach porównawczych |
| Proponowana nazwa pakietu | `StandaryzacjaR` |
| Trudność | ●● |

## Po co to badaczowi

Kiedy w artykule pada zdanie, że system osiągnął wynik 0,32, czytelnik nie wie o nim
prawie nic. Nie wie, czy to dużo. Nie wie, czy wynik 0,28 z innego artykułu jest gorszy,
czy tylko zmierzony na trudniejszym zestawie zapytań. **Wyniki miar skuteczności są
względne wobec kolekcji** i poza nią nie znaczą nic.

Powód jest prosty i widać go w danych. Zapytania różnią się trudnością znacznie bardziej
niż systemy jakością. W typowym zestawie średnie wyniki dla poszczególnych zapytań
rozciągają się kilkunastokrotnie, podczas gdy średnie wyniki systemów mieszczą się
w przedziale dwu-, trzykrotnym. O wartości wyniku decyduje więc głównie to, jakie
zapytania trafiły do kolekcji, a nie to, jak dobry jest system.

Ma to trzy skutki. Wyników z dwóch artykułów nie da się zestawić. Pojedyncza liczba nie
mówi nic o tym, czy system jest dobry. A w testach istotności zapytania o dużym rozrzucie
ważą wielokrotnie więcej niż pozostałe, więc wnioski o różnicach między systemami są
mniej pewne, niż wskazuje sam test.

Artykuł proponuje rozwiązanie zapożyczone ze statystyki stosowanej w badaniach nad
ludźmi, a wcześniej niestosowane w ocenie wyszukiwarek: **standaryzację wyniku względem
rozkładu wyników na tym samym zapytaniu**. Trudność zapytania szacuje się z próby
systemów, a potem używa do przeliczenia wyników wszystkich systemów, także tych, które
powstaną później.

Dla badacza jest to warunek, żeby liczba w tabeli znaczyła coś sama z siebie.

## Algorytm

**Wejście.** Macierz wyników: dla każdego systemu i każdego zapytania jedna wartość
miary skuteczności. Wskazanie, które systemy tworzą próbę odniesienia.

**Wyjście.** Wyniki standaryzowane, czynniki standaryzacyjne dla każdego zapytania,
wyniki przeniesione na przedział jednostkowy, uporządkowanie systemów przed i po.

**Wzory.** Niech $m_{st}$ oznacza wynik systemu $s$ na zapytaniu $t$, a $\mu_t$ i
$\sigma_t$ średnią i odchylenie standardowe wyników na tym zapytaniu w próbie systemów
odniesienia. Wynik standaryzowany to

$$m'_{st} = \frac{m_{st} - \mu_t}{\sigma_t}$$

Wielkości $\mu_t$ i $\sigma_t$ nazywa się **czynnikami standaryzacyjnymi** zapytania $t$.
Wynik standaryzowany mówi, o ile odchyleń standardowych system odbiega od przeciętnej
na tym zapytaniu.

Tak policzona wartość jest wyśrodkowana na zerze i nieograniczona, a miary skuteczności
zwyczajowo mieszczą się w przedziale jednostkowym. Autorzy przenoszą ją tam dystrybuantą
rozkładu normalnego standardowego:

$$F(m') = \int_{-\infty}^{m'} \frac{1}{\sqrt{2\pi}}\, e^{-x^2/2}\, dx$$

Po przeniesieniu wartość 0,5 oznacza wynik przeciętny, 0,84 jedno odchylenie powyżej
przeciętnej, a 0,16 jedno odchylenie poniżej. Jest to interpretacja, której surowy wynik
miary nie ma.

Przeniesienie ma jeszcze jeden skutek: **tłumi wpływ wartości skrajnych**, na przykład
sytuacji, w której tylko jeden system znalazł cokolwiek trafnego dla danego zapytania.

**Kroki.**

1. Sprawdzenie danych: kompletność macierzy wyników, liczebność próby odniesienia,
   niezerowe odchylenie standardowe na każdym zapytaniu.
2. Wyznaczenie czynników standaryzacyjnych z próby systemów odniesienia.
3. Przeliczenie wyników wszystkich systemów na wartości standaryzowane.
4. Przeniesienie na przedział jednostkowy dystrybuantą.
5. Uśrednienie po zapytaniach i uporządkowanie systemów.
6. Porównanie uporządkowań oraz rozkładów wyników przed i po standaryzacji.

**Co wynotować z artykułu.** Sposób doboru próby systemów odniesienia i jej wymaganą
liczebność; postępowanie przy zapytaniach o zerowym odchyleniu standardowym; wykazanie,
że standaryzacja wyniku surowego i wyniku znormalizowanego przez liczbę dokumentów
trafnych daje ten sam rezultat, wraz z uzasadnieniem; wyniki porównania rozkładów przed
i po standaryzacji.

## Kontrakt

**Warunki wstępne.** Macierz wyników bez braków albo z jawnie zadeklarowaną obsługą
braków; co najmniej dwa systemy w próbie odniesienia; dodatnie odchylenie standardowe
na każdym zapytaniu; wyniki miary w skali ilorazowej.

**Niezmienniki.** Średnia wyników standaryzowanych w próbie odniesienia wynosi zero
dla każdego zapytania, a odchylenie standardowe jeden. Wartości po przeniesieniu mieszczą
się w przedziale od zera do jedności. Przekształcenie jest ściśle rosnące, więc
uporządkowanie systemów **w obrębie jednego zapytania** się nie zmienia. Uporządkowanie
po uśrednieniu po zapytaniach zmienić się może i właśnie o to chodzi.

**Wyjście.** Klasa `wyniki_standaryzowane` ze składnikami: macierz wyników
standaryzowanych, macierz po przeniesieniu, czynniki standaryzacyjne, uporządkowanie
przed i po, miara zgodności uporządkowań.

**Błędy zatrzymujące wykonanie.** Zerowe odchylenie standardowe na zapytaniu; mniej niż
dwa systemy odniesienia; macierz z brakami przy niezadeklarowanej obsłudze; wyniki spoza
dziedziny miary.

## Plan pakietu

| Plik | Odpowiedzialność |
|---|---|
| `R/przygotowanie_danych.R` | walidacja macierzy wyników i próby odniesienia |
| `R/czynniki.R` | średnie i odchylenia dla zapytań |
| `R/standaryzacja.R` | przeliczenie i przeniesienie na przedział jednostkowy |
| `R/uporzadkowanie.R` | uporządkowanie systemów, zgodność uporządkowań |
| `R/klasy_s3.R` | obiekt wyniku, metody `print` i `summary` |
| `R/wizualizacja.R` | rozkłady przed i po, wpływ zapytań o dużym rozrzucie |

Zależności: `stats` i `ggplot2`. Całość to operacje na macierzy: odjęcie wektora średnich
i podzielenie przez wektor odchyleń wykonuje się jednym działaniem, bez pętli po
zapytaniach.

## Dane

**Procedura generowania.** Generujesz macierz wyników z **jawnie rozdzielonym wpływem
systemu i zapytania**: wynik jest funkcją jakości systemu, trudności zapytania i szumu.
Znasz wtedy prawdziwe uporządkowanie systemów i możesz sprawdzić, które podejście je
odtwarza. Następnie zwiększasz rozrzut trudności zapytań i obserwujesz, kiedy
uporządkowanie na wynikach surowych zaczyna się psuć.

Parametry: liczba systemów, liczba zapytań, rozrzut jakości systemów, rozrzut trudności
zapytań, poziom szumu, ziarno.

**Przypadki o znanym wyniku.** Wszystkie systemy o identycznym wyniku na zapytaniu:
odchylenie zerowe, przypadek błędu. Trzy systemy o wynikach 0,1, 0,2 i 0,3 na jednym
zapytaniu: wartości standaryzowane policzalne ręcznie. System o wyniku równym średniej:
wartość zero, po przeniesieniu 0,5.

**Przypadki patologiczne.** Jedno zapytanie w kolekcji; jeden system w próbie odniesienia;
zapytanie, na którym wszystkie systemy dają zero.

**Zbiór empiryczny.** Publicznie dostępne wyniki przebiegów z konferencji ewaluacyjnych
albo własne wyniki kilku konfiguracji wyszukiwarki na wspólnym zestawie zapytań. Ten sam
materiał można uzyskać, uruchamiając kilka wariantów prostej wyszukiwarki na otwartej
kolekcji. Sprawdź warunki licencyjne.

## Mapowanie na pracę

| Sekcja briefu | Rozdział pracy |
|---|---|
| Po co to badaczowi, zmienność trudności zapytań | Wprowadzenie: tło i luka |
| Wzory, czynniki standaryzacyjne, przeniesienie | Rozdział 1: aparat formalny |
| Kontrakt, niezmienniki, monotoniczność | Rozdział 1: granice stosowalności |
| Plan pakietu, procedura generowania, odtwarzanie uporządkowania | Rozdział 2 |
| Zbiór empiryczny, porównanie przed i po | Rozdział 3 |

**Wstępne pytanie badawcze.** Przy jakim stosunku rozrzutu trudności zapytań do rozrzutu
jakości systemów uporządkowanie oparte na wynikach surowych przestaje odtwarzać
prawdziwe uporządkowanie systemów, i o ile poprawia to standaryzacja?

## Polecenia startowe

1. Walidacja macierzy wyników wraz z wykryciem zapytań o zerowym odchyleniu.
2. Czynniki standaryzacyjne liczone na próbie odniesienia, na operacjach macierzowych.
3. Przeliczenie i przeniesienie na przedział jednostkowy dystrybuantą.
4. Procedura generowania macierzy z rozdzielonym wpływem systemu i zapytania.
5. Dane naruszające warunki wstępne wraz z oczekiwanym zachowaniem.
6. Badanie odtwarzania prawdziwego uporządkowania przy rosnącym rozrzucie trudności.

## Pułapki

**Standaryzacja po systemach zamiast po zapytaniach.** Macierz ma dwa wymiary i pomyłka
jest łatwa, a wynik wygląda sensownie. Test sprawdzający, że średnia w próbie odniesienia
wynosi zero **dla każdego zapytania**, wychwytuje to natychmiast.

**Czynniki liczone na wszystkich systemach.** Sens metody polega na tym, że czynniki
pochodzą z ustalonej próby odniesienia i pozostają stałe, także dla systemów ocenianych
później. Przeliczanie ich przy każdym nowym systemie odbiera metodzie jej jedyną zaletę.

**Zapytania o zerowym odchyleniu.** Dzielenie przez zero. Postępowanie jest w artykule
i nie należy go wymyślać ani po cichu podmieniać na małą stałą.

**Utożsamianie standaryzacji z normalizacją przez wynik idealny.** To dwie różne rzeczy
i artykuł pokazuje, dlaczego druga nie wystarcza. Praca musi je rozróżnić.

**Na obronie** musisz umieć wyjaśnić, dlaczego wynik 0,32 sam z siebie nic nie znaczy,
i powiedzieć, co dokładnie oznacza wartość 0,84 po standaryzacji.

## Literatura

Artykuł źródłowy: `webber2008standaryzacja`.

Wprowadzenie: podręcznikowe omówienie metodyki eksperymentu w wyszukiwaniu informacji;
opracowanie o zmienności trudności zapytań. Dwie do czterech pozycji dobierasz sam.
Tematy pokrewne: 02, 03, 07 – wszystkie dotyczą wiarygodności pomiaru skuteczności.

Środowisko: `rcore2026`. Wymagania formalne: `standardyEPI`.
