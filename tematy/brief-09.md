# Temat 09. Wskaźnik łączący liczbę publikacji z ich oddziaływaniem

## Metryka

| | |
|---|---|
| Artykuł źródłowy | Leydesdorff, Loet; Bornmann, Lutz; Adams, Jonathan (2019). *The Integrated Impact Indicator Revisited (I3\*): A Non-Parametric Alternative to the Journal Impact Factor*. Scientometrics 119, 1669–1694 |
| Identyfikator | [10.1007/s11192-019-03099-8](https://doi.org/10.1007/s11192-019-03099-8); [preprint](https://arxiv.org/abs/1812.03448) |
| Dostęp | otwarty |
| Dziedzina | bibliometria, polityka naukowa |
| Proponowany tytuł pracy | Pakiet R do nieparametrycznej oceny oddziaływania publikacji jako przykład zastosowania klas percentylowych w naukometrii |
| Proponowana nazwa pakietu | `WskaznikI3R` |
| Trudność | ●● |

## Po co to badaczowi

Liczba cytowań ma zwykle rozkład skośny: niewielka część publikacji uzyskuje bardzo wiele odwołań. Średnia liczba cytowań jest poprawnie obliczoną miarą przeciętnego wyniku, ale nie wystarcza do opisu takiego rozkładu. Dwa zbiory o tej samej średniej mogą mieć inny udział publikacji wysoko cytowanych i zupełnie inną wielkość.

I3* sumuje wkłady publikacji zależne od ich klasy percentylowej w ustalonym zbiorze odniesienia. Dzięki temu można osobno przedstawić łączny wynik dorobku i wynik na jedną publikację. Wybór między nimi wynika z pytania analitycznego: wielkość dorobku i jego przeciętna pozycja to różne własności.

Badacz polityki naukowej potrzebuje przede wszystkim jawnej definicji odniesienia: dziedziny, rocznika, typu publikacji i okna cytowań. Projekt obejmuje klasy, remisy i schematy wag oraz sprawdzenie wrażliwości porównań. Żaden wybór wag nie usuwa wszystkich decyzji ocennych ani nie sprawia, że wskaźnik mierzy jakość badań bez dodatkowej interpretacji.

## Algorytm

**Wejście.** Cytowania nieujemne, identyfikatory publikacji, ich grupy oraz osobny zbiór odniesienia. Podstawowy I3* stosuje rozłączne klasy: dolne 50%, kolejne 40%, kolejne 9% i górny 1%, z wagami odpowiednio 1, 2, 10, 100. Przed liczeniem ustal definicję percentyla i remisów.

$$I3^*=\sum_{j=1}^{J}w_jn_j,\qquad I3^*/N=\sum_{j=1}^{J}w_j(n_j/N).$$

$n_j$ jest liczbą albo ułamkową licznością publikacji w klasie j, $w_j$ jej wagą, a $N=\sum_jn_j$. Pierwszy wynik uwzględnia wielkość dorobku, drugi opisuje średni wkład publikacji. Schemat z wagą 1 dla top-10% i 0 dla pozostałych daje liczbę publikacji top-10%; dopiero podzielenie przez N daje ich udział.

**Remisy i odniesienie.** Obowiązkowy wariant ułamkowy: w posortowanym zbiorze odniesienia o M pracach blok g prac z jednakowymi cytowaniami zajmuje przedział percentylowy $[100b/M,100(b+g)/M]$, gdzie b jest liczbą prac o niższych cytowaniach. Długość przecięcia bloku z klasą, podzielona przez długość bloku, daje udział każdej remisowej publikacji w tej klasie. To reguła omówiona przez Waltmana i Schreibera i użyta w znormalizowanym wariancie źródłowym. Suma udziałów publikacji wynosi 1. Dodaj wariant dyskretny jako analizę wrażliwości, jawnie definiując przypisanie remisów, zamiast dowolnej domyślnej funkcji kwantyli.

Dla celu z cytowaniami niewystępującymi w odniesieniu użyj pozycji empirycznej $100\cdot\#\{c_{ref}<c_{cel}\}/M$, z przedziałami klas domkniętymi od dołu. Dla równości zastosuj udziały całego bloku. Zachowaj dopasowany rocznik, typ dokumentu i dziedzinę; nie przeliczaj odniesienia osobno dla każdej ocenianej jednostki. Przypadek wszystkich cytowań zerowych jest blokiem remisowym, a nie automatycznie dolną klasą.

Kroki: przygotuj odniesienie, zbuduj bloki i udziały klas, przypisz każdy cel, zsumuj wkłady według jednostek, oblicz wynik surowy i na publikację. Koszt sortowania odniesienia $O(M\log M)$, dopasowania celów $O(N\log M)$ i agregacji $O(NJ)$. Addytywność dotyczy surowego I3 przy tym samym odniesieniu, wagach i regule remisów. Porównanie między dziedzinami wymaga odrębnie zdefiniowanego odniesienia dla każdego celu.

## Kontrakt

Cytowania są skończone, całkowite, nieujemne, bez `NA`; identyfikatory unikatowe. Macierz udziałów ma wiersze publikacji i kolumny rozłącznych klas, elementy w [0,1] i sumę wiersza 1. Granice `progi` zaczynają się od 0, kończą na 100 i rosną ściśle; liczba wag jest o 1 mniejsza od liczby granic. Wagi skończone, nieujemne, przynajmniej jedna dodatnia. Dla top-10% poprawny schemat to `progi = c(0, 90, 100)`, `wagi = c(0, 1)`.

Niezmienniki: suma liczności klas równa N; $N\min(w)\le I3\le N\max(w)$; surowy wynik addytywny dla rozłącznych grup przy stałym odniesieniu; wynik nie zależy od kolejności publikacji. N = 0 daje surowy I3 = 0, wynik na publikację `NA`. Nie wymagaj całkowitych liczności w wariancie ułamkowym.

S3 `wynik_i3`: `wyniki` z jednostką, `N`, `I3`, `I3_na_publikacje`, `status`, `licznosci_klas`, `udzialy`, `odniesienie`, `parametry`. Błędy: „Cytowania muszą być nieujemnymi liczbami całkowitymi”, „Progi muszą rosnąć od 0 do 100”, „Liczba wag nie odpowiada liczbie klas”, „Brak zbioru odniesienia dla publikacji”.

Zbiór odniesienia musi zawierać co najmniej jedną publikację w każdym używanym przekroju. Pusty przekrój daje zatrzymanie z komunikatem „Zbiór odniesienia nie może być pusty”.

## Plan pakietu

Pakiet `WskaznikI3R`, licencja GPL-3. Publiczne funkcje:

- `przygotuj_odniesienie(publikacje, progi = c(0, 50, 90, 99, 100))` – bloki remisowe.
- `przypisz_klasy(publikacje, odniesienie, remisy = "ulamkowe")` – udziały i ślad dopasowania.
- `oblicz_i3(udzialy, grupy, wagi = c(1, 2, 10, 100))` – surowy wynik i wynik na pracę.
- `generuj_cytowania(n = 1000, ziarno = 202709)` – skośne rozkłady i ustalone grupy.

Moduły: `R/odniesienie.R`, `R/percentyle.R`, `R/i3.R`, `R/generator.R`, `R/metody_s3.R`. Klasa S3 `wynik_i3` ma metody `print()`, `summary()` i `plot()`: skrócony wynik, zestawienie diagnostyki oraz wykres zgodny z rodzajem wyniku. Wartości i parametry pozostają dostępne bez odczytywania tekstu wydruku.

`Imports`: `stats`. `Suggests`: `testthat`, `knitr`, `rmarkdown`, `pkgdown`, `shiny`. Funkcje obliczeniowe nie instalują zależności ani nie korzystają z sieci. Dokumentacja `pkgdown` zawiera przykład od wejścia do interpretacji; aplikacja pod `/app/` korzysta z tego samego interfejsu i jawnie prezentuje parametry. Sprawdzenie: instalacja pakietu, uruchomienie przykładu i metod S3 oraz `R CMD check --as-cran`.

## Dane

**Generator.** `ziarno = 202709`. Odniesienie: 5000 prac, cytowania z mieszaniny 30% zer i 70% Poissona z intensywnością lognormalną, $\log\lambda\sim N(1,1{,}5^2)$. Jednostki A i B: 100 i 1000 prac z tego samego rozkładu; jednostka C: 100 prac, z 5% intensywności pomnożonych przez 50. Przy stałym odniesieniu porównuj wielkość surowego wyniku, wynik na pracę, średnią i medianę cytowań. Prawdą testową są udziały i suma zadanych wag, a nie uniwersalne „poprawne” uporządkowanie jednostek. Dodatkowy wariant zaokrągla cytowania do wielokrotności 5, zwiększając remisy. Braków nie imputuj; testuj odrzucenie i osobny raport wyłączeń w przygotowaniu studium.

**Obliczenia kontrolne.** Po jednej publikacji w każdej klasie daje I3 = 1 + 2 + 10 + 100 = 113, N = 4, wynik na pracę 28,25. Przy klasach top-10% i reszta, z 3 i 7 pracami, I3 = 3, udział = 0,3. Dziesięć remisowych publikacji zajmujących percentyle 80–100: każda ma udziały 0,5 w klasie 50–90, 0,45 w 90–99 i 0,05 w 99–100; jej wkład wynosi 10,5, cały blok 105.

**Przypadki brzegowe.** Pusta jednostka; wszystkie zera; wszystkie prace na progu klasy; odmienne wielkości jednostek; brak odniesienia dla rocznika; negatywne wagi.

**Zbiór empiryczny.** [OpenAlex](https://openalex.org/), zwykłe metadane na [CC0](https://github.com/ourresearch/openalex-docs/blob/main/license.md). Wybierz jeden podobszar i rocznik 2018, wyznacz cały dostępny zbiór odniesienia przed wyborem pięciu czasopism do porównania. Dla każdej publikacji policz cytowania do końca 2023 r. na podstawie tego samego zamrożonego pobrania; nie używaj dzisiejszej liczby wszystkich cytowań jako liczby pięcioletniej. Zapisz kompletność pobrania i nie przypisuj brakujących wartości jako zera. Porównaj wariant ułamkowy i dyskretny oraz wynik surowy i na publikację.

## Mapowanie na pracę

| Materiał | Część pracy |
|---|---|
| Problem zastosowania, pytanie analityczne i zakres wkładu | Wprowadzenie |
| Definicje, wzory, założenia i porównanie dostępnych rozwiązań | Rozdział 1: Podstawy metodyczne |
| Kontrakt, moduły, klasy wyniku, generator i wyniki testów | Rozdział 2: Implementacja i architektura pakietu |
| Charakterystyka danych, analiza, interpretacja i porównanie | Rozdział 3: Studium przypadku |
| Odpowiedź na pytanie, ograniczenia i kierunek rozwoju | Zakończenie |

**Wstępne pytanie analityczne.** Jak wielkość dorobku, reguła remisów i dobór odniesienia zmieniają porównanie czasopism według I3* oraz I3* na publikację?

**Proponowany wkład.** Odtwarzalne klasyfikowanie do klas, w tym ułamkowe remisy, i porównanie wrażliwości ocen przy jawnych wagach i wspólnym odniesieniu.

## Polecenia startowe

1. **Specyfikacja.** Ustal granice klas, wagi, odniesienie i ułamkową obsługę remisów. Wynik: `SPEC.md` z sygnaturami, definicjami i obsługą przypadków brzegowych. Sprawdzenie: każdy argument i każda kolumna wyniku mają opis; zakres odpowiada wskazanym częściom artykułu.
2. **Przykłady analityczne.** Sprawdź 113, 28,25, liczbę 3 wobec udziału 0,3 oraz blok remisowy o wyniku 105. Wynik: testy z liczbowymi wartościami oczekiwanymi. Sprawdzenie: odtwórz rachunki na kartce lub osobnym, prostym skryptem; nie wyznaczaj oczekiwanych wartości testowaną funkcją.
3. **Walidacja.** Zapisz testy wszystkich błędów wymienionych w kontrakcie oraz poprawnych danych prowadzących do `NA`. Wynik: konstruktor wejścia i stabilne komunikaty. Sprawdzenie: błędne dane zatrzymują obliczenia, a niezdefiniowana miara ma opisany status.
4. **Rdzeń.** Zbuduj macierz udziałów i agregację; porównaj ją z ręcznym przypisaniem małego zbioru. Wynik: działające funkcje i obiekt S3. Sprawdzenie: testy analityczne oraz porównanie z niezależną, najprostszą wersją obliczenia.
5. **Eksperyment.** Porównaj wielkość i rozkład jednostek, dwa warianty remisów oraz wspólne i celowo zmienione odniesienie. Wynik: skrypt z konfiguracją, ziarnami i tabelą wyników. Sprawdzenie: powtórzenie daje te same dane i odtwarza tabelę; raport obejmuje wszystkie zaplanowane warianty.
6. **Udostępnienie.** Dodaj dokumentację, metodę wykresu, winietę i przykład w aplikacji. Wynik: instalowalny pakiet i działająca strona. Sprawdzenie: przykład działa po instalacji w czystej sesji R; opis odróżnia wynik liczbowy od jego interpretacji.

## Pułapki

Średnia przy skośnym rozkładzie nie jest źle policzona; opisuje inną wielkość niż I3. I3 nie usuwa arbitralności wag. Wariant dyskretny i ułamkowy mają inne liczności graniczne. Addytywność znika jako ogólna własność, jeśli przy łączeniu jednostek zmienia się odniesienie. Wynik surowy i udział to różne skale.

Na obronie należy połączyć pytanie o dorobek z wyborem skali wskaźnika i pokazać, jak decyzje o odniesieniu oraz remisach wpływają na wnioski.

## Literatura

Artykuł źródłowy: `leydesdorff2019i3`.

Wprowadzenie: `waltman2013percentiles`, `funk2017dynamic`. Klucze i pełne opisy są w [`zrodla/tematy.bib`](zrodla/tematy.bib).

Środowisko: `rcore2026`. Wymagania formalne: `standardyEPI`. Źródła danych opisano w sekcji „Dane”; w pracy należy podać ich opis bibliograficzny, wersję wykorzystanego zbioru i zakres przekształceń.

Dane: `openalexData`.
