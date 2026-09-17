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

Badacz oceniający wyszukiwarkę musi zdecydować, jak duże znaczenie mają kolejne pozycje. Przejrzenie pierwszych kilku wyników i długie poszukiwanie mogą prowadzić do innych ocen tej samej listy. Parametr miary powinien mieć interpretację w odniesieniu do zachowania użytkownika.

RBP opiera się na modelu, w którym prawdopodobieństwo kontynuowania przeglądania jest stałe po każdej pozycji. Z tego założenia wynikają malejące wagi dalszych dokumentów. Można też obliczyć maksymalny nierozpoznany wkład pozycji bez oceny i nieznanej dalszej części listy.

Projekt pozwala ocenić system przy kilku scenariuszach długości poszukiwania i wskazać, jak wiele niewiedzy pozostaje w wyniku. Badacz może planować dodatkowe ocenianie dokumentów na podstawie ich wag. Zakres wynikający z braków trzeba interpretować osobno od losowej niepewności średniej po próbie zapytań.

## Algorytm

**Wejście.** Uporządkowana lista trafności $r_i\in[0,1]$, z możliwymi `NA`, oraz prawdopodobieństwo kontynuacji $0<p<1$. Model użytkownika zakłada jednakowe p po każdej pozycji. Dla znanej głębokości d:

$$B=(1-p)\sum_{i=1}^{d}p^{i-1}\widetilde r_i,\qquad
\varepsilon=p^d+(1-p)\sum_{i:r_i\ \mathrm{nieznane}}p^{i-1},$$
$$\operatorname{RBP}\in[B,B+\varepsilon].$$

$\widetilde r_i$ jest znaną trafnością, a dla nieznanej ma zerowy wkład w dolną granicę. $B$ jest znanym wkładem, $\varepsilon$ maksymalnym wkładem nieocenionych pozycji i nieznanego końca listy. Wagi sumują się do 1 dla nieskończonej listy. Przedział jest deterministycznym zakresem możliwych wartości, a nie przedziałem ufności 95%.

Kroki: wyznacz wagi geometryczne, zsumuj znane wkłady, dodaj masę nieznanych wag i ogona, zwróć składowe osobno. Wariant `koniec = "pelny"` oznacza znany koniec listy, z zerową trafnością poza d; wtedy pomija się $p^d$, lecz zachowuje nieocenione wewnętrzne pozycje. Podstawowy wariant `nieznany` zachowuje ogon.

Przy trafności Bernoulliego o prawdopodobieństwie q wartość oczekiwana skończonego wkładu wynosi $q(1-p^d)$; dopiero dla nieskończonego modelu wynosi q. Koszt $O(d)$, pamięć robocza $O(d)$ lub $O(1)$ przy przetwarzaniu strumieniowym. Parametr p odzwierciedla założenie zachowania, nie jest jakością systemu ani prawdopodobieństwem trafności.

## Kontrakt

`trafnosc` to wektor liczbowy z wartościami w [0,1] lub `NA`; `NaN` i nieskończoności są błędem. `p` skończone w (0,1); `koniec` wybiera znany lub nieznany ogon. Pusty ranking przy nieznanym ogonie daje [0,1], przy pełnym [0,0]. Przekształcenie ocen stopniowanych do [0,1] musi być jawne, nie wykonywane przez nieopisane dzielenie przez maksimum obserwowanej próby.

Niezmienniki: $0\le B\le B+\varepsilon\le1$; ujawnienie dodatkowej trafności bez zmiany pozostałych danych daje podprzedział poprzedniego; wydłużenie znanego prefiksu usuwa jego wagę z ogona. Przy kompletnie ocenionym prefiksie reszta nadal wynosi $p^d$, jeśli ogon nieznany. Same jedynki dają $B=1-p^d$, a nie skończony wkład równy 1.

S3 `wynik_rbp`: `wartosc` równa B, `dolna`, `gorna`, `reszta_ogon`, `reszta_braki`, `p`, `glebokosc`, `koniec`, `status`. Błędy: „Trafność musi należeć do [0, 1] albo być NA”, „Parametr p musi należeć do (0, 1)”, „Nieznana reguła końca rankingu”.

## Plan pakietu

Pakiet `RBPmiaraR`, licencja GPL-3. Publiczne funkcje:

- `oblicz_rbp(trafnosc, p = 0.8, koniec = "nieznany")` – wkład i granice.
- `profil_rbp(trafnosc, p = c(0.5, 0.8, 0.95), koniec = "nieznany")` – tabela parametrów.
- `porownaj_rbp(rankingi, oceny, p = 0.8, k = 100)` – wyniki po zapytaniach.
- `generuj_ranking(d = 100, q = 0.2, ziarno = 202707)` – pełna trafność i maska.

Moduły: `R/walidacja.R`, `R/rbp.R`, `R/porownanie.R`, `R/generator.R`, `R/metody_s3.R`. Klasa S3 `wynik_rbp` ma metody `print()`, `summary()` i `plot()`: skrócony wynik, zestawienie diagnostyki oraz wykres zgodny z rodzajem wyniku. Wartości i parametry pozostają dostępne bez odczytywania tekstu wydruku.

`Imports`: `stats`. `Suggests`: `testthat`, `knitr`, `rmarkdown`, `pkgdown`, `shiny`. Funkcje obliczeniowe nie instalują zależności ani nie korzystają z sieci. Dokumentacja `pkgdown` zawiera przykład od wejścia do interpretacji; aplikacja pod `/app/` korzysta z tego samego interfejsu i jawnie prezentuje parametry. Sprawdzenie: instalacja pakietu, uruchomienie przykładu i metod S3 oraz `R CMD check --as-cran`.

## Dane

**Generator.** `ziarno = 202707`. Dla 500 zapytań i d = 100 losuj $r_i\sim\operatorname{Bernoulli}(q)$, q = 0,1, 0,3, 0,5. Zachowaj pełne listy jako punkt odniesienia skończonego wkładu; ukrywaj 10% i 50% trafności losowo, a osobno pozycje 1–10 albo 51–100. Dla p = 0,5, 0,8, 0,95 sprawdź zawieranie każdego ujawnionego pełnego wkładu w granicach `pelny`. Przy `nieznany` sprawdź dowolne uzupełnienia ogona, a wartość oczekiwaną prefiksu porównaj z $q(1-p^d)$. Nie określaj pełnej nieskończonej prawdy na podstawie samego skończonego wektora.

**Obliczenia kontrolne.** Trafności $(1,0,1)$ i p = 0,8: $B=0{,}2(1+0{,}64)=0{,}328$, ogon 0,512, granice [0,328; 0,84]. Dla $(1,NA,1)$ dodatkowa reszta to 0,16, granice [0,328; 1]. Przy q = 0,5 i d = 3 wartość oczekiwana B wynosi 0,244. Przy znanym końcu $(1,0,1)$ granice są punktem 0,328.

**Przypadki brzegowe.** Pusta lista; same `NA`; same zera lub jedynki; p bliskie 1; p = 0 lub 1 odrzucone przez zakres; nieznany element w pierwszej pozycji.

**Zbiór empiryczny.** [Reuters-21578, Distribution 1.0](https://archive.ics.uci.edu/dataset/137/reuters+21578+text+categorization+collection), DOI [10.24432/C52G6M](https://doi.org/10.24432/C52G6M), licencja CC BY 4.0 wskazana przez UCI. Dokumenty prasowe mają kategorie przypisane przez osoby indeksujące. W studium przypadku kategoria jest umownym zapytaniem, a przynależność do niej binarną oceną trafności. Jest to adaptacja zbioru klasyfikacyjnego, więc wynik dotyczy odnajdywania kategorii, a nie pełnej oceny potrzeb informacyjnych użytkownika.

Wybierz dokumenty z niepustym tekstem i oznaczeniem `TOPICS="YES"` ze zbioru testowego podziału ModApte. Zapisz identyfikatory dokumentów, wybór kategorii i liczności. Zbuduj co najmniej trzy rankingi na tej samej puli: podobieństwo tekstu do nazwy i opisu kategorii, jego wariant oparty tylko na tytule oraz ranking losowy. Ustal preprocessing i rozstrzyganie remisów identyfikatorem przed porównaniem wyników. Pełne etykiety kategorii są punktem odniesienia dla kontrolowanego ukrywania ocen. Pobranie i przekształcenie wykonaj osobnym skryptem; zachowaj opis źródła, a w testach pakietu używaj małych przykładów bez pobierania danych z sieci.

## Mapowanie na pracę

| Materiał | Część pracy |
|---|---|
| Problem zastosowania, pytanie analityczne i zakres wkładu | Wprowadzenie |
| Definicje, wzory, założenia i porównanie dostępnych rozwiązań | Rozdział 1: Podstawy metodyczne |
| Kontrakt, moduły, klasy wyniku, generator i wyniki testów | Rozdział 2: Implementacja i architektura pakietu |
| Charakterystyka danych, analiza, interpretacja i porównanie | Rozdział 3: Studium przypadku |
| Odpowiedź na pytanie, ograniczenia i kierunek rozwoju | Zakończenie |

**Wstępne pytanie analityczne.** Jak parametr kontynuacji i położenie nieocenionych dokumentów wpływają na ocenę oraz nierozstrzygnięty zakres różnic między systemami?

**Proponowany wkład.** Interfejs oddzielający wkład znany, braki wewnątrz listy i nieznany ogon, z doświadczeniem pokazującym znaczenie położenia ocen zamiast tylko ich liczby.

## Polecenia startowe

1. **Specyfikacja.** Rozdziel skończony wkład i możliwą wartość całej listy oraz dwa rodzaje końca. Wynik: `SPEC.md` z sygnaturami, definicjami i obsługą przypadków brzegowych. Sprawdzenie: każdy argument i każda kolumna wyniku mają opis; zakres odpowiada wskazanym częściom artykułu.
2. **Przykłady analityczne.** Sprawdź B = 0,328, reszty 0,512 i 0,16 oraz E(B) = 0,244. Wynik: testy z liczbowymi wartościami oczekiwanymi. Sprawdzenie: odtwórz rachunki na kartce lub osobnym, prostym skryptem; nie wyznaczaj oczekiwanych wartości testowaną funkcją.
3. **Walidacja.** Zapisz testy wszystkich błędów wymienionych w kontrakcie oraz poprawnych danych prowadzących do `NA`. Wynik: konstruktor wejścia i stabilne komunikaty. Sprawdzenie: błędne dane zatrzymują obliczenia, a niezdefiniowana miara ma opisany status.
4. **Rdzeń.** Zsumuj wagi i osobno reszty; wersję wektorową porównaj z pojedynczymi krokami geometrycznymi. Wynik: działające funkcje i obiekt S3. Sprawdzenie: testy analityczne oraz porównanie z niezależną, najprostszą wersją obliczenia.
5. **Eksperyment.** Porównaj maski przy tej samej liczbie braków, kilka p i ujawnianie kolejnych ocen. Wynik: skrypt z konfiguracją, ziarnami i tabelą wyników. Sprawdzenie: powtórzenie daje te same dane i odtwarza tabelę; raport obejmuje wszystkie zaplanowane warianty.
6. **Udostępnienie.** Dodaj dokumentację, metodę wykresu, winietę i przykład w aplikacji. Wynik: instalowalny pakiet i działająca strona. Sprawdzenie: przykład działa po instalacji w czystej sesji R; opis odróżnia wynik liczbowy od jego interpretacji.

## Pułapki

Brak oceny ma zerowy znany wkład, lecz dodatni możliwy wkład. Reszta nie jest odchyleniem standardowym. Wysokie p zwiększa znaczenie dalszych pozycji i ogona. Porównanie wartości B bez reszty może pozornie rozstrzygać różnice, których znane dane nie rozstrzygają.

Na obronie należy połączyć model zachowania użytkownika z wagami i wyjaśnić, jak plan oceniania dokumentów może zmniejszać niewiedzę o wyniku.

## Literatura

Artykuł źródłowy: `moffatZobel2008rbp`.

Wprowadzenie: `manning2008ir`, `chapelle2009err`. Klucze i pełne opisy są w [`zrodla/tematy.bib`](zrodla/tematy.bib).

Środowisko: `rcore2026`. Wymagania formalne: `standardyEPI`. Źródła danych opisano w sekcji „Dane”; w pracy należy podać ich opis bibliograficzny, wersję wykorzystanego zbioru i zakres przekształceń.

Dane: `reuters21578`.
