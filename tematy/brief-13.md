# Temat 13. Kiedy użytkownik przestaje szukać

## Metryka

| | |
|---|---|
| Artykuł źródłowy | Chapelle, Olivier; Metzler, Donald; Zhang, Ya; Grinspan, Pierre (2009). *Expected Reciprocal Rank for Graded Relevance*. Proceedings of the 18th ACM CIKM, 621–630 |
| Identyfikator | [10.1145/1645953.1646033](https://doi.org/10.1145/1645953.1646033), [kopia autorska](http://olivier.chapelle.cc/pub/err.pdf) |
| Dostęp | wolny |
| Dziedzina | zachowania informacyjne, ocena systemów |
| Proponowany tytuł pracy | Pakiet R do oceny rankingu w modelu kaskadowym jako przykład zastosowania modeli zatrzymania w badaniach nad zachowaniami informacyjnymi |
| Proponowana nazwa pakietu | `KaskadaR` |
| Trudność | ●● |

## Po co to badaczowi

Pierwszy bardzo dobry wynik może zakończyć poszukiwanie. Wtedy trafność dalszych pozycji ma inne znaczenie niż w modelu, w którym użytkownik kontynuuje przeglądanie niezależnie od tego, co już znalazł. Ocena wyszukiwarki może więc zależeć od zakładanego mechanizmu satysfakcji.

ERR opiera się na modelu kaskadowym: użytkownik przegląda wyniki kolejno i może zatrzymać się po każdym dokumencie. Stopień trafności wyznacza prawdopodobieństwo satysfakcji, a prawdopodobieństwo dotarcia do pozycji zależy od wcześniejszych wyników. Miara jest oczekiwaną odwrotnością pozycji pierwszego zatrzymania.

Projekt ma przedstawiać także cały profil zatrzymania i masę użytkowników, którzy nie zakończyli poszukiwania w widocznej części. Symulacja pozwala sprawdzić związek między modelem a wynikiem liczbowym. Badacz może ocenić, czy takie założenie pasuje do jego zadania i jak różni się od modelu stałej kontynuacji.

## Algorytm

**Wejście.** Uporządkowane stopnie trafności $g_i\in\{0,\ldots,g_{\max}\}$, ustalone maksimum skali $g_{\max}\ge1$ oraz głębokość k. Model kaskadowy zakłada przeglądanie dokumentów po kolei i zakończenie po uzyskaniu satysfakcjonującego wyniku.

$$R_i=\frac{2^{g_i}-1}{2^{g_{\max}}},\qquad
q_i=R_i\prod_{j<i}(1-R_j),\qquad
\operatorname{ERR}@k=\sum_{i=1}^{k}\frac{q_i}{i}.$$

$R_i$ jest prawdopodobieństwem satysfakcji w pozycji i, $q_i$ bezwarunkowym prawdopodobieństwem pierwszego zatrzymania właśnie tam. ERR to oczekiwana odwrotność pozycji zatrzymania, z zerowym wkładem niezatrzymania w widocznej części. Prawdopodobieństwo niezatrzymania wynosi $q_{\rm dalej}=\prod_{j=1}^{k}(1-R_j)$.

$$E[I\mid I\le k]=\frac{\sum_{i=1}^{k}i q_i}{1-q_{\rm dalej}}.$$

To pomocnicza średnia pozycji warunkowo względem zatrzymania w top-k, a nie bezwarunkowa oczekiwana pozycja w nieznanym ogonie. Przy zerowym prawdopodobieństwie zatrzymania jest niezdefiniowana. Suma $\sum_iq_i+q_{\rm dalej}=1$ jest podstawowym warunkiem kontroli modelu.

Kroki: przekształć stopnie w satysfakcję, przejdź po pozycjach, mnożąc dotychczasowe prawdopodobieństwo dalszego szukania, zsumuj odwrotności i zachowaj rozkład zatrzymania. Koszt $O(k)$ i pamięć $O(k)$ dla pełnego profilu lub $O(1)$ dla samej miary. Duże skale obsłuż stabilnie, np. obliczając $2^{g_i-g_{\max}}-2^{-g_{\max}}$, bez przepełnienia potęg.

Maksimum skali jest parametrem definicji ocen, nie maksimum tego rankingu. Stopnie 0..4 oznaczają pięć poziomów. Dla binarnych ocen stosuj $g_{\max}=1$ bez dorabiania stopni pośrednich. Model nie zakłada, że maksymalnie trafny dokument zatrzymuje każdego: $R_{\max}=1-2^{-g_{\max}}$.

## Kontrakt

`stopnie`: wektor całkowity 0..`maksimum`, bez braków; `maksimum` dodatnie całkowite, ustalone wspólnie dla systemów; `k` dodatnie całkowite. Krótszą listę dopełnia się zerową trafnością, zachowując w diagnostyce liczbę faktycznych pozycji. `NA` nie może być niejawnie zastąpione przez zero. Pusta lista daje ERR = 0, masę niezatrzymania = 1 i średnią warunkową `NA`.

Niezmienniki: $q_i\ge0$, suma mas z niezatrzymaniem równa 1 z tolerancją `1e-12`, ERR w [0,1]; dodanie pozycji na końcu nie obniża ERR; podniesienie jednego stopnia przy niezmiennym maksimum nie obniża ERR. Nie wymagaj wartości bliskiej 1 dla każdego dopuszczalnego maksimum.

S3 `wynik_err`: `err`, `satysfakcja`, `zatrzymanie`, `dalej`, `pozycja_warunkowa`, `parametry`, `status`. Błędy: „Stopnie muszą być całkowite i należeć do ustalonej skali”, „Maksimum skali musi być dodatnią liczbą całkowitą”, „Stopnie trafności nie mogą zawierać braków”.

## Plan pakietu

Pakiet `KaskadaR`, licencja GPL-3. Publiczne funkcje:

- `oblicz_err(stopnie, maksimum, k = length(stopnie))` – ERR i rozkład zatrzymania.
- `profil_zatrzymania(stopnie, maksimum, k = length(stopnie))` – jawna tabela pozycji.
- `porownaj_err(rankingi, oceny, maksimum, k = 10)` – miara po zapytaniach.
- `symuluj_uzytkownikow(stopnie, maksimum, n = 10000, ziarno = 202713)` – kontrola modelu.

Moduły: `R/skala.R`, `R/err.R`, `R/symulacja.R`, `R/metody_s3.R`. Klasa S3 `wynik_err` ma metody `print()`, `summary()` i `plot()`: skrócony wynik, zestawienie diagnostyki oraz wykres zgodny z rodzajem wyniku. Wartości i parametry pozostają dostępne bez odczytywania tekstu wydruku.

`Imports`: `stats`. `Suggests`: `testthat`, `knitr`, `rmarkdown`, `pkgdown`, `shiny`. Funkcje obliczeniowe nie instalują zależności ani nie korzystają z sieci. Dokumentacja `pkgdown` zawiera przykład od wejścia do interpretacji; aplikacja pod `/app/` korzysta z tego samego interfejsu i jawnie prezentuje parametry. Sprawdzenie: instalacja pakietu, uruchomienie przykładu i metod S3 oraz `R CMD check --as-cran`.

## Dane

**Generator.** `ziarno = 202713`. Dla 100 zapytań i 50 dokumentów losuj stopnie 0..4 z prawdopodobieństwami (0,5; 0,2; 0,15; 0,1; 0,05). Systemy porządkują $g_i+\varepsilon_i$, z $\varepsilon\sim N(0,\sigma^2)$, sigma = 0,5, 1, 3. Pełne stopnie i dokładny profil q stanowią prawdę. Dla każdego rankingu symuluj 10000 użytkowników: w każdej kolejnej pozycji Bernoulli($R_i$), zakończenie przy pierwszym sukcesie. Niezatrzymanie w top-k wnosi 0 do odwrotności. Porównuj empiryczną średnią z ERR oraz rozkład zatrzymania z q, z tolerancją wynikającą z błędu Monte Carlo. Braki są tylko testem odrzucenia. Osobno podmień pierwszą pozycję na stopień maksymalny i analizuj wpływ bardzo wczesnego wyniku.

**Obliczenia kontrolne.** Skala 0..1, ranking (1,0): R=(0,5; 0), q=(0,5; 0), ERR = 0,5, dalej = 0,5, średnia warunkowa pozycji = 1. Ranking (0,1): ERR = 0,25, średnia warunkowa = 2. Skala 0..2, ranking (2,1): R=(0,75; 0,25), q=(0,75; 0,0625), ERR = 0,78125, dalej = 0,1875, średnia warunkowa = 14/13. Same zera dają ERR = 0 i niezdefiniowaną średnią warunkową.

**Przypadki brzegowe.** Pusta lista; same zera; maksimum = 1; stopień powyżej maksimum; duże maksimum; `NA` na pierwszej pozycji; różne skale w porównywanych systemach.

**Zbiór empiryczny.** [Reuters-21578, Distribution 1.0](https://archive.ics.uci.edu/dataset/137/reuters+21578+text+categorization+collection), DOI [10.24432/C52G6M](https://doi.org/10.24432/C52G6M), licencja CC BY 4.0 wskazana przez UCI. Dokumenty prasowe mają kategorie przypisane przez osoby indeksujące. W studium przypadku kategoria jest umownym zapytaniem, a przynależność do niej binarną oceną trafności. Jest to adaptacja zbioru klasyfikacyjnego, więc wynik dotyczy odnajdywania kategorii, a nie pełnej oceny potrzeb informacyjnych użytkownika.

Wybierz dokumenty z niepustym tekstem i oznaczeniem `TOPICS="YES"` ze zbioru testowego podziału ModApte. Zapisz identyfikatory dokumentów, wybór kategorii i liczności. Zbuduj co najmniej trzy rankingi na tej samej puli: podobieństwo tekstu do nazwy i opisu kategorii, jego wariant oparty tylko na tytule oraz ranking losowy. Ustal preprocessing i rozstrzyganie remisów identyfikatorem przed porównaniem wyników. Pełne etykiety kategorii są punktem odniesienia dla kontrolowanego ukrywania ocen. Pobranie i przekształcenie wykonaj osobnym skryptem; zachowaj opis źródła, a w testach pakietu używaj małych przykładów bez pobierania danych z sieci.

W tym studium etykiety kategorii są binarne, więc maksimum = 1. Do prezentacji bogatszej skali wykorzystaj generator, zachowując oddzielnie wyniki empiryczne i syntetyczne.

## Mapowanie na pracę

| Materiał | Część pracy |
|---|---|
| Problem zastosowania, pytanie analityczne i zakres wkładu | Wprowadzenie |
| Definicje, wzory, założenia i porównanie dostępnych rozwiązań | Rozdział 1: Podstawy metodyczne |
| Kontrakt, moduły, klasy wyniku, generator i wyniki testów | Rozdział 2: Implementacja i architektura pakietu |
| Charakterystyka danych, analiza, interpretacja i porównanie | Rozdział 3: Studium przypadku |
| Odpowiedź na pytanie, ograniczenia i kierunek rozwoju | Zakończenie |

**Wstępne pytanie analityczne.** Jak model pierwszego zatrzymania zmienia ocenę rankingu i interpretację kolejnych trafnych dokumentów względem miary sumującej niezależne wkłady?

**Proponowany wkład.** Sprawdzony interfejs ERR wraz z pełnym profilem zatrzymania i kontrolą symulacyjną, pokazujący mechanizm miary zamiast tylko pojedynczej liczby.

## Polecenia startowe

1. **Specyfikacja.** Zdefiniuj skalę, maksymalną satysfakcję i warunkową średnią pozycji. Wynik: `SPEC.md` z sygnaturami, definicjami i obsługą przypadków brzegowych. Sprawdzenie: każdy argument i każda kolumna wyniku mają opis; zakres odpowiada wskazanym częściom artykułu.
2. **Przykłady analityczne.** Sprawdź ERR 0,5, 0,25 i 0,78125 oraz masy niezatrzymania. Wynik: testy z liczbowymi wartościami oczekiwanymi. Sprawdzenie: odtwórz rachunki na kartce lub osobnym, prostym skryptem; nie wyznaczaj oczekiwanych wartości testowaną funkcją.
3. **Walidacja.** Zapisz testy wszystkich błędów wymienionych w kontrakcie oraz poprawnych danych prowadzących do `NA`. Wynik: konstruktor wejścia i stabilne komunikaty. Sprawdzenie: błędne dane zatrzymują obliczenia, a niezdefiniowana miara ma opisany status.
4. **Rdzeń.** Implementuj skumulowany iloczyn i niezależną rekurencję jako kontrolę; zachowaj wszystkie q. Wynik: działające funkcje i obiekt S3. Sprawdzenie: testy analityczne oraz porównanie z niezależną, najprostszą wersją obliczenia.
5. **Eksperyment.** Porównaj miarę z symulacją użytkowników i z RBP na tej samej jawnie przekształconej trafności. Wynik: skrypt z konfiguracją, ziarnami i tabelą wyników. Sprawdzenie: powtórzenie daje te same dane i odtwarza tabelę; raport obejmuje wszystkie zaplanowane warianty.
6. **Udostępnienie.** Dodaj dokumentację, metodę wykresu, winietę i przykład w aplikacji. Wynik: instalowalny pakiet i działająca strona. Sprawdzenie: przykład działa po instalacji w czystej sesji R; opis odróżnia wynik liczbowy od jego interpretacji.

## Pułapki

Zmiana maksimum na największy stopień konkretnego rankingu zmienia definicję porównania. Binarne etykiety nie stają się stopniowanymi przez dowolne dodanie poziomów. Prawdopodobieństwo satysfakcji na pozycji jest inne niż bezwarunkowa masa zatrzymania tam. Średnia warunkowa nie opisuje czasu użytkownika, który nie zatrzymał się w top-k.

Na obronie należy powiązać zależność między pozycjami z modelem użytkownika i omówić, kiedy założenie zakończenia po pierwszej satysfakcji jest adekwatne.

## Literatura

Artykuł źródłowy: `chapelle2009err`.

Wprowadzenie: `manning2008ir`, `moffatZobel2008rbp`. Klucze i pełne opisy są w [`zrodla/tematy.bib`](zrodla/tematy.bib).

Środowisko: `rcore2026`. Wymagania formalne: `standardyEPI`. Źródła danych opisano w sekcji „Dane”; w pracy należy podać ich opis bibliograficzny, wersję wykorzystanego zbioru i zakres przekształceń.

Dane: `reuters21578`.
