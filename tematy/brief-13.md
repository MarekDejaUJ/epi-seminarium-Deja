# Temat 13. Kiedy użytkownik przestaje szukać

## Metryka

| | |
|---|---|
| Artykuł źródłowy | Chapelle, Olivier; Metzler, Donald; Zhang, Ya; Grinspan, Pierre (2009). *Expected Reciprocal Rank for Graded Relevance*. CIKM '09, s. 621-630 |
| Identyfikator | [10.1145/1645953.1646033](https://doi.org/10.1145/1645953.1646033), [kopia autorska](http://olivier.chapelle.cc/pub/err.pdf) |
| Dostęp | wolny |
| Dziedzina | zachowania informacyjne, ocena systemów |
| Proponowany tytuł pracy | Pakiet R do oceny rankingu w modelu kaskadowym jako przykład zastosowania modeli zatrzymania w badaniach nad zachowaniami informacyjnymi |
| Proponowana nazwa pakietu | `KaskadaR` |
| Trudność | ●● |

## Po co to badaczowi

Miary skuteczności wyszukiwania przypisują pozycjom wagi malejące: pierwszy wynik waży
więcej niż dziesiąty. Wagi te są jednak **ustalone z góry** i nie zależą od tego, co na
tych pozycjach stoi. W najpopularniejszej mierze waga dziesiątej pozycji jest taka sama
niezależnie od tego, czy pozycje od pierwszej do dziewiątej były znakomite, czy bezużyteczne.

Ludzie tak nie czytają. Użytkownik, który znalazł odpowiedź na pozycji drugiej, **nie
ogląda dziesiątej w ogóle**. Wartość dziesiątej pozycji zależy więc od tego, czy
użytkownik do niej dotarł, a to zależy od jakości pozycji wcześniejszych. Miara,
która tego nie uwzględnia, przecenia znaczenie dalszych pozycji w rankingach dobrych
i niedocenia w rankingach słabych.

Artykuł buduje miarę na **modelu kaskadowym**: użytkownik ogląda wyniki po kolei od
góry, przy każdym decyduje, czy jest usatysfakcjonowany, a jeżeli tak, kończy
przeszukiwanie. Prawdopodobieństwo zatrzymania rośnie ze stopniem trafności dokumentu.
Miarą skuteczności jest wtedy oczekiwana odwrotność pozycji, na której użytkownik
przestaje szukać.

Dla badacza zachowań informacyjnych jest to miara, której każdy składnik ma odpowiednik
w obserwowalnym zachowaniu, a nie w konstrukcji wzoru. To odróżnia ją od miar
z ustalonymi wagami, w tym od tej z tematu 07, która model użytkownika ma, ale nie
uzależnia go od zawartości rankingu.

## Algorytm

**Wejście.** Ranking dokumentów ze stopniowaną oceną trafności; maksymalny stopień skali;
głębokość oceny.

**Wyjście.** Wartość miary, prawdopodobieństwo zatrzymania na każdej pozycji, oczekiwana
pozycja zatrzymania, wartości miar porównawczych.

**Wzory.** Stopień trafności $g$ przekłada się na prawdopodobieństwo satysfakcji

$$R_g = \frac{2^{g}-1}{2^{g_{\max}}}$$

gdzie $g_{\max}$ to najwyższy stopień skali. Dla skali od zera do czterech dokument
o stopniu zero daje zero, o stopniu czwartym piętnaście szesnastych. Przekształcenie
jest wypukłe: różnica między stopniem trzecim a czwartym waży więcej niż między zerowym
a pierwszym.

Miarą jest oczekiwana odwrotność pozycji zatrzymania:

$$\mathrm{ERR} = \sum_{r=1}^{n} \frac{1}{r} \left(\prod_{i=1}^{r-1} (1-R_i)\right) R_r$$

Iloczyn to prawdopodobieństwo, że użytkownik **nie zatrzymał się** na żadnej
z wcześniejszych pozycji, a czynnik $R_r$ to prawdopodobieństwo, że zatrzymuje się na
bieżącej. Całość jest więc wartością oczekiwaną wielkości $1/r$ względem rozkładu pozycji
zatrzymania.

Wynikają z tego dwie własności, których miary z ustalonymi wagami nie mają. Wkład pozycji
$r$ **maleje**, gdy poprawia się jakość pozycji wcześniejszych, bo iloczyn się kurczy.
Suma prawdopodobieństw zatrzymania po wszystkich pozycjach nie przekracza jedności,
a reszta odpowiada użytkownikowi, który nie znalazł nic.

**Kroki.**

1. Sprawdzenie danych: stopnie trafności w zakresie skali, ranking bez powtórzeń,
   dodatni maksymalny stopień.
2. Przeliczenie stopni na prawdopodobieństwa satysfakcji.
3. Wyznaczenie iloczynów częściowych, czyli prawdopodobieństwa dotarcia do pozycji.
4. Złożenie sumy ważonej odwrotnościami pozycji.
5. Wyznaczenie rozkładu pozycji zatrzymania i wartości oczekiwanej.
6. Porównanie z miarami o ustalonych wagach na tych samych danych.

**Co wynotować z artykułu.** Wyprowadzenie miary z modelu kaskadowego; uzasadnienie
postaci przekształcenia stopni na prawdopodobieństwa; omówienie zachowania miary przy
rankingu obciętym; wyniki porównania z miarami klasycznymi pod względem zgodności
z obserwowanym zachowaniem użytkowników.

## Kontrakt

**Warunki wstępne.** Stopnie trafności całkowite, nieujemne, nie większe od maksymalnego
stopnia skali; maksymalny stopień dodatni; ranking bez powtórzeń i niepusty.

**Niezmienniki.** Wynik należy do przedziału od zera do jedności. Prawdopodobieństwa
dotarcia są nierosnące wzdłuż rankingu. Suma prawdopodobieństw zatrzymania nie przekracza
jedności. Przeniesienie dokumentu o wyższym stopniu na wyższą pozycję nie zmniejsza
wyniku. Ranking, w którym pierwszy dokument ma stopień maksymalny, daje wynik bliski
jedności niezależnie od reszty.

**Wyjście.** Klasa `ocena_kaskadowa` ze składnikami: wartość miary, prawdopodobieństwa
satysfakcji, prawdopodobieństwa dotarcia, rozkład pozycji zatrzymania, oczekiwana pozycja.

**Błędy zatrzymujące wykonanie.** Stopień spoza skali; maksymalny stopień równy zeru;
ranking pusty; powtórzone pozycje.

## Plan pakietu

| Plik | Odpowiedzialność |
|---|---|
| `R/przygotowanie_danych.R` | walidacja rankingu i skali stopni |
| `R/satysfakcja.R` | przeliczenie stopni na prawdopodobieństwa |
| `R/err.R` | iloczyny częściowe i suma ważona |
| `R/rozklad.R` | rozkład pozycji zatrzymania, wartość oczekiwana |
| `R/klasy_s3.R` | obiekt wyniku, metody `print` i `summary` |
| `R/wizualizacja.R` | rozkład zatrzymania, wkład pozycji w wynik |

Zależności: `stats` i `ggplot2`. Iloczyny częściowe licz funkcją skumulowanego iloczynu
na wektorze, nie pętlą – jedno wywołanie zamiast przejścia po pozycjach.

## Dane

**Procedura generowania.** Generujesz rankingi o **zadanym rozkładzie stopni trafności**
i kontrolowanej kolejności: od najlepszego uporządkowania po losowe. Znasz wtedy kierunek,
w jakim miara ma się zmieniać. Osobno budujesz pary rankingów o identycznej wartości
miary z ustalonymi wagami i różnej wartości miary kaskadowej – to jest materiał, który
wprost pokazuje różnicę między podejściami.

Parametry: długość rankingu, rozkład stopni trafności, maksymalny stopień, stopień
wymieszania, ziarno.

**Przypadki o znanym wyniku.** Pierwszy dokument o stopniu maksymalnym przy skali
czterostopniowej: prawdopodobieństwo satysfakcji piętnaście szesnastych, wynik równy
piętnaście szesnastych powiększone o niewielki wkład dalszych pozycji. Wszystkie stopnie
zerowe: wynik zero. Ranking dwuelementowy: cały rachunek policzalny ręcznie.

**Przypadki patologiczne.** Ranking jednoelementowy; wszystkie dokumenty o stopniu
maksymalnym; skala dwustopniowa, czyli trafność zerojedynkowa.

**Zbiór empiryczny.** Kolekcja testowa ze stopniowanymi sądami o trafności. Jeżeli
dostępne są wyłącznie sądy zerojedynkowe, opisz w pracy, jak przełożyłeś je na skalę
i co to zmienia w wyniku – jest to decyzja metodologiczna, nie techniczna.

## Mapowanie na pracę

| Sekcja briefu | Rozdział pracy |
|---|---|
| Po co to badaczowi, zależność wagi od zawartości | Wprowadzenie: tło i luka |
| Wzory, model kaskadowy, przeliczenie stopni | Rozdział 1: aparat formalny |
| Kontrakt, niezmienniki, zachowanie graniczne | Rozdział 1: granice stosowalności |
| Plan pakietu, procedura generowania, pary rankingów | Rozdział 2 |
| Zbiór empiryczny, porównanie z miarami o ustalonych wagach | Rozdział 3 |

**Wstępne pytanie badawcze.** Jak często uporządkowanie systemów według miary kaskadowej
różni się od uporządkowania według miary o ustalonych wagach, i czy różnice skupiają się
w rankingach o określonej charakterystyce?

## Polecenia startowe

1. Walidacja rankingu i skali stopni trafności.
2. Przeliczenie stopni na prawdopodobieństwa satysfakcji zgodnie z Twoimi notatkami.
3. Iloczyny częściowe i suma ważona odwrotnościami pozycji, na operacjach wektorowych.
4. Rozkład pozycji zatrzymania i wartość oczekiwana.
5. Procedura generowania rankingów o zadanym rozkładzie stopni i wymieszaniu.
6. Budowa par rankingów nierozróżnialnych miarą o ustalonych wagach.

## Pułapki

**Wagi niezależne od zawartości.** Agent napisze sumę ważoną odwrotnościami pozycji, bo
tak wygląda typowa miara rankingowa. Brak iloczynu prawdopodobieństw dotarcia usuwa
z metody całą jej treść, a wynik nadal wygląda sensownie.

**Przesunięcie indeksu w iloczynie.** Iloczyn obejmuje pozycje **przed** bieżącą, nie
włącznie z nią. Pomyłka o jeden daje wartości systematycznie zaniżone i trudna jest do
wykrycia bez przypadku policzonego ręcznie.

**Przeliczenie stopni.** Przekształcenie jest wypukłe i zależy od maksymalnego stopnia
skali. Użycie stopni wprost, bez przeliczenia, albo przyjęcie złego maksimum daje inną
miarę.

**Interpretacja jako prawdopodobieństwa.** Wynik nie jest prawdopodobieństwem
znalezienia odpowiedzi, tylko wartością oczekiwaną odwrotności pozycji. Praca musi to
rozróżnić, bo pomyłka prowadzi do zdań nieprawdziwych o użytkownikach.

**Na obronie** musisz umieć wyjaśnić, dlaczego wkład dziesiątej pozycji zależy od tego,
co stoi na pierwszej, i podać parę rankingów o tej samej wartości miary klasycznej
i różnej wartości miary kaskadowej.

## Literatura

Artykuł źródłowy: `chapelle2009err`.

Wprowadzenie: podręcznikowe omówienie miar rankingowych z dyskontem pozycyjnym;
opracowanie o modelach klikania i zachowania użytkownika wyszukiwarki. Dwie do czterech
pozycji dobierasz sam. Tematy pokrewne: 07 – miara wyprowadzona z modelu użytkownika
z wagami niezależnymi od zawartości, dobra do bezpośredniego porównania; 12 – zysk
zależny od pozycji wcześniejszych.

Środowisko: `rcore2026`. Wymagania formalne: `standardyEPI`.
