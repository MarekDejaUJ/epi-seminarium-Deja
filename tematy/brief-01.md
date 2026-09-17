# Temat 01. Granice prawdopodobieństw przyczynowości

## Metryka

| | |
|---|---|
| Artykuł źródłowy | Li, Ang; Pearl, Judea (2024). *Probabilities of Causation with Nonbinary Treatment and Effect*. Proceedings of the AAAI Conference on Artificial Intelligence 38(18), 20465–20472 |
| Identyfikator | [10.1609/aaai.v38i18.30030](https://doi.org/10.1609/aaai.v38i18.30030) |
| Dostęp | materiały AAAI dostępne publicznie |
| Dziedzina | wnioskowanie przyczynowe, ocena polityk publicznych |
| Proponowany tytuł pracy | Pakiet R do wyznaczania granic prawdopodobieństw przyczynowości jako przykład zastosowania nierówności probabilistycznych w analizie decyzji |
| Proponowana nazwa pakietu | `CausalBoundsR` |
| Trudność | ●●● |

## Po co to badaczowi

Pytanie o przyczynę pojedynczego wyniku różni się od pytania o średni efekt w populacji. Można pytać, czy ukończenie szkolenia było konieczne, aby osoba znalazła pracę, albo czy osoba bez szkolenia osiągnęłaby ten sam wynik po udziale w nim. W tych pytaniach występuje wynik hipotetycznej interwencji u osoby, której znamy wynik obserwowany.

Nie obserwujemy jednocześnie wszystkich możliwych wyników tej samej osoby. Rozkład wyników w eksperymencie i dane obserwacyjne zwykle nie wystarczają do obliczenia jednej wartości takiego prawdopodobieństwa. Przy określonych założeniach można jednak wyznaczyć jego dolną i górną granicę. Granice opisują niepełną identyfikację wielkości, a nie losowy błąd jej oszacowania.

Artykuł obejmuje zabiegi i wyniki mające więcej niż dwa poziomy. W projekcie potrzebne jest narzędzie, które rozróżnia zachowanie, zastąpienie i zmianę wyniku hipotetycznego, sprawdza spójność tablic prawdopodobieństw i przedstawia granice z ich warunkami stosowalności. Wynik może służyć do analizy decyzji, lecz nie rozstrzyga automatycznie o przyczynie zdarzenia u konkretnej osoby.

## Algorytm

**Zakres obowiązkowy.** Jawne granice dla jednego zdarzenia hipotetycznego z twierdzeń 4–7 Li i Pearla. Uzupełnienie: PNS dla dwóch poziomów zabiegu jako szczególny przypadek twierdzenia 8. Pełna rekurencja twierdzeń 8–11 dla wielu interwencji jest rozszerzeniem. Programowanie liniowe jest opcjonalnym narzędziem kontroli małych przykładów.

**Wejście i oznaczenia.** $X$ ma poziomy $x_1,\ldots,x_m$, $Y$ poziomy $y_1,\ldots,y_n$. Tablica $o_{ji}=P(X=x_j,Y=y_i)$ opisuje obserwacje, a $a_{ji}=P(Y_{x_j}=y_i)$ wyniki interwencji. $Y_{x_j}$ to wynik po hipotetycznym ustawieniu zabiegu na $x_j$. Oznacz $u_j=\sum_i o_{ji}$ i $v_i=\sum_j o_{ji}$. Przyjmowana jest zgodność wyniku obserwowanego z wynikiem potencjalnym dla faktycznie otrzymanego zabiegu. Rozkład interwencyjny nie jest automatycznie rozkładem $P(Y\mid X)$.

**Kroki i wzory.** Najpierw sprawdź tablice. Potem oblicz granice wybranego zdarzenia wspólnego, a dopiero na żądanie przekształć je w granice warunkowe.

1. Zachowanie wyniku, $P(Y_{x_j}=y_i,Y=y_i)$:

$$L=\max(o_{ji},a_{ji}+v_i-1),\qquad U=\min(a_{ji},v_i).$$

Wzór ogranicza prawdopodobieństwo, że po ustawieniu zabiegu wynik pozostanie taki jak obserwowany.

2. Zastąpienie wyniku, $P(Y_{x_j}=y_i,Y=y_k)$, dla $i\ne k$:

$$L=\max\left(0,a_{ji}+v_k-1,\sum_{p\ne j}\max(0,a_{ji}+o_{pk}-1+u_j-o_{ji})\right),$$
$$U=\min(a_{ji}-o_{ji},v_k-o_{jk}).$$

Granice obejmują zmianę obserwowanego wyniku $y_k$ na hipotetyczny $y_i$.

3. Zmiana zabiegu w grupie, $P(Y_{x_j}=y_i,X=x_p)$, dla $j\ne p$:

$$L=\max(0,a_{ji}-o_{ji}-1+u_j+u_p),\qquad U=\min(a_{ji}-o_{ji},u_p).$$

Wzór dotyczy wyniku interwencji w grupie, która faktycznie otrzymała inny poziom zabiegu.

4. Wynik hipotetyczny w określonej grupie obserwowanej, $P(Y_{x_j}=y_i,X=x_p,Y=y_k)$, dla $j\ne p$:

$$L_{ji,pk}=\max(0,a_{ji}+o_{pk}-1+u_j-o_{ji}),\qquad U_{ji,pk}=\min(a_{ji}-o_{ji},o_{pk}).$$

To wspólna wielkość nazwana w twierdzeniu 7 uogólnionym PN. Granice $P(Y_{x_j}=y_i\mid X=x_p,Y=y_k)$ uzyskuje się przez podzielenie przez $o_{pk}>0$. Binarne PN i PS są odpowiednimi wyborami indeksów. Dla $j=p$ zgodność daje wynik obserwowany, więc nie używa się wzoru przeznaczonego dla $j\ne p$.

5. Dla $m=2$, $j\ne p$, wspólne zdarzenie $P(Y_{x_j}=y_i,Y_{x_p}=y_k)$ ma granice:

$$L=\max(0,a_{ji}+a_{pk}-1,L_{pk,ji}+L_{ji,pk}),$$
$$U=\min(a_{ji},a_{pk},U_{pk,ji}+U_{ji,pk}).$$

Podział według faktycznego zabiegu umożliwia wykorzystanie granic z punktu 4. Binarne PNS wybiera wynik korzystny po zabiegu i niekorzystny bez niego.

**Wyjście i ograniczenia.** Zdarzenie, granice, rodzaj warunkowania i wskazanie twierdzenia. Twierdzenia 4–7 dają granice ostre w modelu źródłowym. Dla ogólnej rekurencji z wieloma zdarzeniami artykuł nie gwarantuje ostrości. W zakresie obowiązkowym pojedyncze zapytanie kosztuje $O(m)$, a obliczenie wszystkich zastąpień $O(m^2n^2)$. Pełny rozkład stanów używany w porównawczym LP ma $mn^m$ składowych; ogranicz kontrolę do małych $m,n$.

Tablice traktowane są jako znane rozkłady. Granice obliczone z częstości próby nie mają przez to automatycznie określonego poziomu ufności.

## Kontrakt

Macierze `obserwacje` i `interwencje` mają wymiar $m\times n$, wspólne nazwy poziomów, $m,n\ge2$, skończone elementy w $[0,1]$. Pierwsza sumuje się do 1, każdy wiersz drugiej do 1, z tolerancją `1e-10`. Nie dopuszcza się `NA`, `NaN` ani `Inf`. Warunek zgodności marginesów z obserwacjami to $o_{ji}\le a_{ji}\le o_{ji}+1-u_j$. Poziomy i ich kolejność sprawdza konstruktor; bez nazw nie wolno domyślnie dopasowywać macierzy o różnej interpretacji wierszy.

Niezmienniki: $0\le L\le U\le1$; granice warunkowe dotyczą tego samego zdarzenia co granice wspólne; permutacja poziomów z poprawnym dopasowaniem nazw nie zmienia wyniku. Przy zerowym mianowniku warunkowania zwróć `NA` i status `zerowe_warunkowanie`, a zachowaj granice wspólne. Wynik S3 `granice_przyczynowe`: `przedzialy` z kolumnami `zdarzenie`, `dolna`, `gorna`, `warunkowe`, `status`, `twierdzenie`, oraz `poziomy`, `parametry`. Szerokość granic nie jest błędem standardowym.

Zatrzymanie: „Tablice muszą mieć zgodne poziomy i wymiary”, „Prawdopodobieństwa muszą być skończone i należeć do [0, 1]”, „Rozkład nie sumuje się do jedności”, „Rozkłady naruszają warunek zgodności”, „PNS w tym wariancie wymaga dwóch poziomów zabiegu”. Przekroczenie tolerancji przez $L>U$ jest błędem zgodności lub obliczenia; nie zamieniaj końców przedziału.

## Plan pakietu

Pakiet `CausalBoundsR`, licencja GPL-3. Publiczne funkcje:

- `przygotuj_rozklady(obserwacje, interwencje, tolerancja = 1e-10)` – sprawdzenie i opis poziomów.
- `granice_zdarzenia(dane, rodzaj, wynik, zabieg, wynik_obserwowany = NULL, zabieg_obserwowany = NULL, warunkowe = FALSE)` – twierdzenia 4–7.
- `granice_pns(dane, wynik_po, wynik_bez)` – dwupoziomowy zakres punktu 5.
- `generuj_model(n = 5000, ziarno = 202701)` – dane wraz z rozkładem stanów i prawdą znaną z konstrukcji.

Moduły: `R/rozklady.R`, `R/granice_jawne.R`, `R/pns.R`, `R/generator.R`, `R/metody_s3.R`. Klasa S3 `granice_przyczynowe` ma metody `print()`, `summary()` i `plot()`: skrócony wynik, zestawienie diagnostyki oraz wykres zgodny z rodzajem wyniku. Wartości i parametry pozostają dostępne bez odczytywania tekstu wydruku.

`Imports`: `stats`; opcjonalnie `ggplot2` w Suggests. `Suggests`: `testthat`, `lpSolve`, `ggplot2`, `knitr`, `rmarkdown`, `pkgdown`, `shiny`. Funkcje obliczeniowe nie instalują zależności ani nie korzystają z sieci. Dokumentacja `pkgdown` zawiera przykład od wejścia do interpretacji; aplikacja pod `/app/` korzysta z tego samego interfejsu i jawnie prezentuje parametry. Sprawdzenie: instalacja pakietu, uruchomienie przykładu i metod S3 oraz `R CMD check --as-cran`.

## Dane

**Generator.** `ziarno = 202701`. Dla trzech poziomów $X$ i trzech poziomów $Y$ wylosuj dodatnie masy dla wszystkich $3\cdot3^3=81$ stanów $(X,Y_{x_1},Y_{x_2},Y_{x_3})$: niezależne zmienne Gamma(2,1), następnie podziel je przez sumę. Z rozkładu stanów wyznacz dokładne $o$, $a$ i każde badane prawdopodobieństwo. Wylosuj 5000 obserwacji; wynik obserwowany jest wynikiem potencjalnym dla faktycznego $X$. Osobno wyznacz granice dla dokładnych marginesów i częstości próby. Tylko dla dokładnych marginesów wymagaj deterministycznego zawierania prawdy.

**Obliczenia kontrolne.** Dla dwóch zabiegów i dwóch wyników przyjmij $o=((0{,}3,0{,}2),(0{,}1,0{,}4))$ oraz $a=((0{,}6,0{,}4),(0{,}2,0{,}8))$, z wynikiem korzystnym w drugiej kolumnie. PN w grupie $X=x_2,Y=y_2$ dla braku sukcesu przy $x_1$: granice wspólne $[0{,}2,0{,}3]$, warunkowe $[0{,}5,0{,}75]$. PS w grupie $X=x_1,Y=y_1$ dla sukcesu przy $x_2$: wspólne $[0{,}2,0{,}3]$, warunkowe $[2/3,1]$. PNS wynosi $[0{,}4,0{,}6]$. Przy obu interwencyjnych ryzykach sukcesu równych 0,99 górna granica PNS nie przekroczy 0,01.

**Przypadki brzegowe.** Zerowa masa grupy warunkującej; sprzeczne marginesy; poziomy zamienione miejscami; wartości -0,01 i `Inf`; deterministyczny sukces po zabiegu i porażka bez niego, dające PNS = 1. Nie zakładaj, że niezależność obserwacyjna daje najszersze granice.

**Zbiór empiryczny.** [`datasets::ChickWeight`](https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/ChickWeight.html), dane eksperymentu żywieniowego dystrybuowane z R na licencji [GPL-2 lub GPL-3](https://www.r-project.org/Licenses/). To przykład techniczny, a nie badanie społeczne. Wybierz diety 1 i 2, wynik `weight > 200` w dniu 21. Zapisz liczbę zwierząt bez pomiaru końcowego. Rozkład interwencyjny oszacowany z ramion wymaga założenia losowego przydziału i odpowiedniej obsługi utraty obserwacji; analiza wyłącznie kompletnych wyników dotyczy wybranej podpróby. Porównaj granice przy dwóch jawnych scenariuszach brakującego wyniku, uznając wszystkich brakujących za porażki lub za sukcesy. Tak otrzymane granice z oszacowanych marginesów są ilustracją wrażliwości, bez deklaracji poziomu ufności.

## Mapowanie na pracę

| Materiał | Część pracy |
|---|---|
| Problem zastosowania, pytanie analityczne i zakres wkładu | Wprowadzenie |
| Definicje, wzory, założenia i porównanie dostępnych rozwiązań | Rozdział 1: Podstawy metodyczne |
| Kontrakt, moduły, klasy wyniku, generator i wyniki testów | Rozdział 2: Implementacja i architektura pakietu |
| Charakterystyka danych, analiza, interpretacja i porównanie | Rozdział 3: Studium przypadku |
| Odpowiedź na pytanie, ograniczenia i kierunek rozwoju | Zakończenie |

**Wstępne pytanie analityczne.** Jak dostęp do marginesów interwencyjnych i wybór obserwowanej grupy wpływają na szerokość granic prawdopodobieństwa przyczynowości?

**Proponowany wkład.** Sprawdzony interfejs do jawnych wzorów wielowartościowych z rozróżnieniem granic wspólnych i warunkowych oraz czytelnymi stanami niezdefiniowanymi; sprawdzenie dostępnych implementacji jest częścią ustalenia wkładu.

## Polecenia startowe

1. **Specyfikacja.** Rozpisz oddzielnie cztery rodzaje zdarzeń i ograniczony wariant PNS; przypisz im twierdzenia 4–8. Wynik: `SPEC.md` z sygnaturami, definicjami i obsługą przypadków brzegowych. Sprawdzenie: każdy argument i każda kolumna wyniku mają opis; zakres odpowiada wskazanym częściom artykułu.
2. **Przykłady analityczne.** Zapisz podane PN, PS i PNS oraz przykład zerowego warunkowania. Wynik: testy z liczbowymi wartościami oczekiwanymi. Sprawdzenie: odtwórz rachunki na kartce lub osobnym, prostym skryptem; nie wyznaczaj oczekiwanych wartości testowaną funkcją.
3. **Walidacja.** Zapisz testy wszystkich błędów wymienionych w kontrakcie oraz poprawnych danych prowadzących do `NA`. Wynik: konstruktor wejścia i stabilne komunikaty. Sprawdzenie: błędne dane zatrzymują obliczenia, a niezdefiniowana miara ma opisany status.
4. **Rdzeń.** Implementuj wzory max/min, a dla dwupoziomowego PNS wykorzystaj granice obu rozłącznych grup obserwowanych. Wynik: działające funkcje i obiekt S3. Sprawdzenie: testy analityczne oraz porównanie z niezależną, najprostszą wersją obliczenia.
5. **Eksperyment.** Zestaw granice z prawdą z pełnego rozkładu stanów; opcjonalnie sprawdź dwa małe modele solverem LP. Wynik: skrypt z konfiguracją, ziarnami i tabelą wyników. Sprawdzenie: powtórzenie daje te same dane i odtwarza tabelę; raport obejmuje wszystkie zaplanowane warianty.
6. **Udostępnienie.** Dodaj dokumentację, metodę wykresu, winietę i przykład w aplikacji. Wynik: instalowalny pakiet i działająca strona. Sprawdzenie: przykład działa po instalacji w czystej sesji R; opis odróżnia wynik liczbowy od jego interpretacji.

## Pułapki

Rozkład obserwacyjny i interwencyjny pełnią różne role. PN jest prawdopodobieństwem warunkowym zdarzenia kontrfaktycznego; nie można go odczytać jako zwykłej proporcji sukcesów w grupie. Uogólnione PN w twierdzeniu 7 jest wielkością wspólną, wymagającą osobnego warunkowania. Twierdzenia o ostrości nie obejmują automatycznie całej rekurencji ani danych z błędem próbkowania.

Na obronie należy umieć przejść od obserwacji i wyniku hipotetycznego do konkretnego zdarzenia, obliczyć granice na małej tablicy i wyjaśnić, jakie informacje mogłyby je zawęzić.

## Literatura

Artykuł źródłowy: `liPearl2024probabilities`.

Wprowadzenie: `pearl2009causality`, `tianPearl2000bounds`. Klucze i pełne opisy są w [`zrodla/tematy.bib`](zrodla/tematy.bib).

Środowisko: `rcore2026`. Wymagania formalne: `standardyEPI`. Źródła danych opisano w sekcji „Dane”; w pracy należy podać ich opis bibliograficzny, wersję wykorzystanego zbioru i zakres przekształceń.

Dane: `chickWeightR`.
