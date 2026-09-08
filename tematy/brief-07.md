# Temat 07. Miara skuteczności wyprowadzona z modelu użytkownika

## Metryka

| | |
|---|---|
| Artykuł źródłowy | Moffat, Alistair; Zobel, Justin (2008). *Rank-Biased Precision for Measurement of Retrieval Effectiveness*. ACM Transactions on Information Systems 27(1) |
| Identyfikator | [10.1145/1416950.1416952](https://doi.org/10.1145/1416950.1416952), [kopia autorska](https://people.eng.unimelb.edu.au/jzobel/fulltext/acmtois08.pdf) |
| Dostęp | wolny |
| Dziedzina | wyszukiwanie informacji, zachowania informacyjne |
| Proponowany tytuł pracy | Pakiet R do pomiaru skuteczności wyszukiwania jako przykład zastosowania modeli zachowania użytkownika w ocenie systemów informacyjnych |
| Proponowana nazwa pakietu | `RBPmiaraR` |
| Trudność | ●● |

## Po co to badaczowi

Miary skuteczności wyszukiwania wzięły się z pomysłu, że można policzyć, ile spośród
dokumentów trafnych system znalazł. Kłopot polega na tym, że przy dużej kolekcji nikt
nie wie, ile ich jest, więc **pełności nie da się zmierzyć**, a średnia precyzja, którą
stosuje się najczęściej, jest z pełności wyprowadzona i dziedziczy jej wadę.

Jest jeszcze druga rzecz, dziwna, gdy się ją zauważy. Klasyczne miary wagują pozycje
w rankingu, ale wagi biorą się z konstrukcji miary, nie z tego, jak ludzie czytają
wyniki wyszukiwania. Nie ma w nich żadnego założenia o użytkowniku.

Artykuł odwraca kolejność. Najpierw stawia **model zachowania**: użytkownik ogląda
wynik pierwszy, potem z prawdopodobieństwem $p$ przechodzi do następnego, a z
prawdopodobieństwem $1-p$ kończy. Dopiero z tego modelu wyprowadza miarę. Wagi pozycji
przestają być umowne, a parametr $p$ ma znaczenie, które da się opisać słowami:
niecierpliwy użytkownik to małe $p$, wytrwały to duże.

Model daje jeszcze jedną rzecz, której klasyczne miary nie mają. Skoro wagi maleją
geometrycznie, to **da się policzyć, ile wyniku brakuje** z powodu dokumentów
nieocenionych albo obciętego rankingu. Wynik przestaje być liczbą, a staje się
przedziałem z jawnie podaną niepewnością.

Dla badacza zachowań informacyjnych jest to miara, której parametr odpowiada
obserwowalnej własności użytkownika, a nie decyzji projektanta miary.

## Algorytm

**Wejście.** Ranking dokumentów, sądy o trafności (zerojedynkowe lub stopniowane),
parametr wytrwałości $p$ z przedziału otwartego od zera do jedności.

**Wyjście.** Wartość miary, wartość resztowa opisująca niepewność, przedział, w którym
mieści się wynik przy pełnych sądach, oczekiwana liczba obejrzanych dokumentów.

**Wzór podstawowy.** Niech $r_i$ oznacza trafność dokumentu na pozycji $i$, a $d$
głębokość rankingu. Wtedy

$$\mathrm{RBP} = (1-p)\sum_{i=1}^{d} r_i\, p^{\,i-1}$$

Czynnik $(1-p)$ normalizuje sumę, bo $\sum_{i=1}^{\infty} p^{\,i-1} = 1/(1-p)$. Miara
przyjmuje wartości od zera włącznie do jedności wyłącznie.

**Model użytkownika.** Przy tak przyjętym zachowaniu użytkownik ogląda średnio

$$\frac{1}{1-p}$$

dokumentów. Dla $p = 0{,}5$ są to dwa dokumenty, dla $p = 0{,}8$ pięć, dla
$p = 0{,}95$ dwadzieścia. Jest to jedyna interpretacja parametru, jakiej potrzebujesz,
i warto ją podać w pracy, bo tłumaczy dobór wartości.

**Wartość resztowa.** Jeżeli ranking urwano na głębokości $d$, to nieznany wkład
dalszych pozycji wynosi

$$(1-p)\sum_{i=d+1}^{\infty} p^{\,i-1} = p^{\,d}$$

Jeżeli natomiast w obrębie rankingu część dokumentów nie ma oceny, każdy z nich dokłada
do reszty wagę, którą miałby, gdyby okazał się trafny. Dla zbioru pozycji nieocenionych
$U$ reszta wynosi

$$p^{\,d} + (1-p)\sum_{i \in U} p^{\,i-1}$$

Wynik prawdziwy leży wtedy między wartością policzoną a wartością powiększoną o resztę.

**Kroki.**

1. Sprawdzenie danych: zakres parametru, zgodność identyfikatorów, brak powtórzeń.
2. Rozdzielenie pozycji rankingu na trzy kategorie: ocenione trafne, ocenione nietrafne,
   nieocenione.
3. Złożenie sumy ważonej po pozycjach ocenionych jako trafne.
4. Policzenie reszty z obcięcia rankingu i z pozycji nieocenionych.
5. Złożenie przedziału i miar pomocniczych.
6. Powtórzenie dla siatki wartości parametru.

**Co wynotować z artykułu.** Wyprowadzenie miary z modelu użytkownika, krok po kroku;
dokładną postać reszty w obu przypadkach; przykład rankingu z dokumentami nieocenionymi
wraz z policzonymi granicami przedziału dla trzech wartości parametru; argumentację,
dlaczego miara jest odporna na wydłużenie rankingu, czego średnia precyzja nie jest.

## Kontrakt

**Warunki wstępne.** Parametr ściśle między zerem a jednością; ranking bez powtórzeń;
trafności w przedziale od zera do jedności; sądy o trafności rozłączne z listą pozycji
nieocenionych.

**Niezmienniki.** Wynik należy do przedziału od zera włącznie do jedności wyłącznie.
Reszta jest nieujemna i nie większa niż jeden minus wynik. Dopisanie dokumentów na koniec
rankingu nie zmniejsza wyniku i nie zwiększa reszty ponad wartość sprzed dopisania.
Przy wszystkich dokumentach trafnych i nieskończonym rankingu wynik dąży do jedności.
Przy parametrze bliskim zeru wynik dąży do trafności pierwszego dokumentu.

**Wyjście.** Klasa `rbp` ze składnikami: wartość, reszta, granice przedziału, wartość
parametru, oczekiwana liczba obejrzanych dokumentów, liczba pozycji nieocenionych.

**Błędy zatrzymujące wykonanie.** Parametr równy zero albo jeden; trafność spoza
przedziału; powtórzone pozycje w rankingu; pusty ranking.

## Plan pakietu

| Plik | Odpowiedzialność |
|---|---|
| `R/przygotowanie_danych.R` | walidacja rankingu, sądów i parametru |
| `R/rbp.R` | miara podstawowa na operacjach wektorowych |
| `R/reszta.R` | wartość resztowa z obcięcia i z pozycji nieocenionych |
| `R/porownanie.R` | miary klasyczne do zestawienia |
| `R/klasy_s3.R` | obiekt wyniku, metody `print` i `summary` |
| `R/wizualizacja.R` | wynik z przedziałem w funkcji parametru |

Zależności: `stats` i `ggplot2`. Wagi licz jako `(1 - p) * p^(seq_along(x) - 1)`, jednym
działaniem na wektorze, bez pętli po pozycjach.

## Dane

**Procedura generowania.** Generujesz ranking o zadanej jakości i **znanej wartości
oczekiwanej miary**: przy niezależnym losowaniu trafności z prawdopodobieństwem $q$ na
każdej pozycji wartość oczekiwana miary wynosi dokładnie $q$, co daje przypadek
o wyniku znanym z rachunku, a nie z uruchomienia kodu. Następnie usuwasz część sądów
i sprawdzasz, czy prawdziwa wartość mieści się w wyznaczonym przedziale.

Parametry: długość rankingu, prawdopodobieństwo trafności, odsetek pozycji nieocenionych,
wartość parametru wytrwałości, ziarno.

**Przypadki o znanym wyniku.** Wszystkie pozycje trafne, ranking o długości $d$: wynik
równy $1 - p^{\,d}$. Tylko pierwsza pozycja trafna: wynik równy $1-p$. Żadna pozycja
trafna: zero, reszta równa $p^{\,d}$ powiększona o wkład pozycji nieocenionych.

**Przypadki patologiczne.** Ranking jednoelementowy; wszystkie pozycje nieocenione;
parametr bardzo bliski jedności przy krótkim rankingu, gdy reszta przewyższa wynik.

**Zbiór empiryczny.** Publiczna kolekcja testowa z sądami o trafności i kilkoma
rankingami. Ten sam zbiór, którego używa temat 03, co pozwala porównać wyniki obu miar
na identycznych danych.

## Mapowanie na pracę

| Sekcja briefu | Rozdział pracy |
|---|---|
| Po co to badaczowi, model użytkownika | Wprowadzenie: tło i luka |
| Wzory, wyprowadzenie z modelu, reszta | Rozdział 1: aparat formalny |
| Kontrakt, zachowanie graniczne parametru | Rozdział 1: granice stosowalności |
| Plan pakietu, procedura generowania, pokrycie przedziału | Rozdział 2 |
| Zbiór empiryczny, porównanie z miarą klasyczną | Rozdział 3 |

**Wstępne pytanie badawcze.** Jak dobór parametru wytrwałości wpływa na uporządkowanie
systemów i przy jakim odsetku dokumentów nieocenionych przedział niepewności staje się
tak szeroki, że uporządkowania nie da się rozstrzygnąć?

## Polecenia startowe

1. Walidacja wejścia z jawnym sprawdzeniem zakresu parametru.
2. Miara podstawowa na wektorze wag, zgodnie ze wzorem z notatek.
3. Wartość resztowa w obu przypadkach: obcięcie rankingu i pozycje nieocenione.
4. Procedura generowania rankingu o znanej wartości oczekiwanej miary.
5. Dane naruszające warunki wstępne wraz z oczekiwanym zachowaniem.
6. Badanie pokrycia: czy prawdziwa wartość mieści się w przedziale przy rosnącym
   odsetku pozycji nieocenionych.

## Pułapki

**Reszta pominięta.** Najłatwiej zaimplementować samą sumę i uznać temat za skończony.
Reszta jest tym, co odróżnia tę miarę od zwykłej sumy ważonej, i bez niej praca traci
swoją tezę.

**Normalizacja przez sumę wag policzoną na skończonym rankingu.** Czynnik $(1-p)$
pochodzi z sumy szeregu nieskończonego. Dzielenie przez sumę wag pierwszych $d$ pozycji
daje inną miarę, wyglądającą podobnie i zachowującą się inaczej przy wydłużaniu rankingu.

**Pozycje nieocenione traktowane jak nietrafne.** Wtedy reszta wychodzi zero i cała
konstrukcja przestaje działać. Ten sam błąd co w temacie 03 i ta sama metoda wykrycia.

**Jedna wartość parametru.** Wynik zależy od parametru, więc podanie jednej liczby bez
uzasadnienia jest decyzją ukrytą. W pracy podaj siatkę wartości i interpretację każdej
przez oczekiwaną liczbę obejrzanych dokumentów.

**Na obronie** musisz umieć wyprowadzić czynnik normalizujący z sumy szeregu
geometrycznego i wyjaśnić, co dokładnie oznacza wartość resztowa dla czytelnika wyników.

## Literatura

Artykuł źródłowy: `moffatZobel2008rbp`.

Wprowadzenie: podręcznikowe omówienie miar oceny wyszukiwania; opracowanie o modelach
zachowania użytkownika w ocenie systemów. Dwie do czterech pozycji dobierasz sam.
Tematy pokrewne: 03 i 13 dotyczą tego samego problemu z innej strony, 02 przedziałów
niepewności w ocenie.

Środowisko: `rcore2026`. Wymagania formalne: `standardyEPI`.
