# Temat 05. Ramy interpretacyjne w dyskursie spolaryzowanym

## Metryka

| | |
|---|---|
| Artykuł źródłowy | Sarmiento, Hernan; Córdova, Ricardo; Ortiz, Jorge; Bravo-Marquez, Felipe; Santos, Marcelo; Valenzuela, Sebastián (2025). *Unsupervised Framing Analysis for Social Media Discourse in Polarizing Events*. ACM Transactions on the Web 19(4), 1–42 |
| Identyfikator | [10.1145/3711912](https://doi.org/10.1145/3711912) |
| Dostęp | przez bibliotekę UJ |
| Dziedzina | komunikacja społeczna, analiza dyskursu |
| Proponowany tytuł pracy | Pakiet R do wyboru kandydatów na ramy interpretacyjne jako przykład zastosowania modeli tematów w badaniach nad komunikacją |
| Proponowana nazwa pakietu | `RamyR` |
| Trudność | ●● |

## Po co to badaczowi

W sporze publicznym strony eksponują wybrane aspekty zdarzenia: koszty, bezpieczeństwo, prawa lub odpowiedzialność. Rama interpretacyjna wiąże takie aspekty w sposób rozumienia problemu. Badacz komunikacji potrzebuje procedury wyłaniającej wyrażenia, od których można rozpocząć interpretację dyskursu, bez ograniczania analizy do listy kategorii ustalonej przed badaniem.

W artykule modele tematów dopasowuje się osobno do społeczności uczestników, a kandydatów na ramy wybiera spośród wyrażeń wielowyrazowych. Wyrażenie musi być istotne w przynajmniej jednym temacie każdej społeczności. Dwa warianty selekcji korzystają odpowiednio z prawdopodobieństw słów i ich pozycji w tematach. Wyłonione wyrażenie jest kandydatem do interpretacji, a nie automatycznie rozpoznaną ramą.

Projekt obejmuje etap selekcji z gotowych modeli oraz dwie miary oceny kandydatów. Nie wymaga budowy całej infrastruktury zbierania wpisów, wykrywania społeczności i uczenia reprezentacji tekstu. Tak ograniczony pakiet pozwala porównać warianty selekcji oraz sprawdzić, czy kandydaci są semantycznie zróżnicowani i zgodni z ręczną oceną związku ze sprawą.

## Algorytm

**Zakres obowiązkowy.** Podejście probabilistyczne i rangowe z sekcji 3.2 oraz jednorodność i trafność kandydatów z sekcji 3.3. Społeczności, wyrażenia wielowyrazowe i modele tematów przygotowuje się przed wywołaniem rdzenia. Grupowanie wektorów wypowiedzi nie zastępuje metody z artykułu.

**Wejście.** Dla każdej społeczności $c=1,\ldots,C$ macierz $P_c(t,w)$ prawdopodobieństw wyrażeń $w$ w tematach $t$. Każdy wiersz jest rozkładem po pełnym słowniku modelu. Wyrażenia kandydujące stanowią wskazany podzbiór słownika. Potrzebne są też wektory znaczeniowe tych wyrażeń oraz, do oceny trafności, niezależne ręczne etykiety związku z dyskusją.

**Wariant probabilistyczny.**

$$s_c(w)=\max_t P_c(t,w),\qquad s(w)=\min_c s_c(w).$$

Pierwszy krok wybiera największą istotność wyrażenia w społeczności, drugi ocenia jego najsłabszą społeczność. Wybierz `liczba` wyrażeń o najwyższym $s(w)$; jest to parametr $\gamma$ z równania 2. Wyrażenie obecne tylko po jednej stronie może otrzymać zero.

**Wariant rangowy.** Dla każdego tematu posortuj wyrażenia według malejącego prawdopodobieństwa. $R_c(t,w)$ jest pozycją wyrażenia; nieobecny termin otrzymuje rangę o 1 większą od liczby wyrażeń obecnych w temacie.

$$r_c(w)=\min_t R_c(t,w),\qquad r(w)=\max_c r_c(w).$$

To najlepsza pozycja w tematach społeczności i najgorsza spośród tych pozycji między społecznościami. Wybierz wyrażenia z $r(w)\le\lambda$, gdzie $\lambda$ jest progiem rangi z równania 4. Wariant nie polega na wyborze wyrażeń z $\lambda\le r(w)$. Remisy rozstrzygaj identyfikatorem wyrażenia i zapisz tę regułę; źródłowy wybór losowy przy remisie może dać inny zestaw.

**Ocena.** Dla wybranego zbioru $FC$ o $f$ elementach i niezerowych wektorach $v_i$:

$$\operatorname{sim}(i,j)=\frac{v_i^\top v_j}{\|v_i\|\|v_j\|},\qquad
H_\alpha=\frac{\sum_{i<j}\mathbf1(\operatorname{sim}(i,j)\ge\alpha)}{\binom f2}.$$

Podobieństwo kosinusowe opisuje kierunki wektorów. Jednorodność $H_\alpha$ jest udziałem podobnych par przy progu $\alpha$; niższa wartość oznacza większe zróżnicowanie kandydatów. Nie jest średnim podobieństwem wypowiedzi w skupieniu. Dla top-$\beta$ kandydatów $FC_\beta$ i ręcznie oznaczonego zbioru trafnych wyrażeń $G$:

$$\operatorname{relevancy}_\beta=|FC_\beta\cap G|/|FC_\beta|.$$

To udział wyrażeń związanych ze sprawą. $\beta$ określa liczbę ocenianych kandydatów; przy mniejszym dostępnym zbiorze zapisz rzeczywistą liczebność mianownika. Brak etykiety nie jest etykietą nietrafną.

Koszt selekcji: $O(\sum_c T_cV)$ w wariancie probabilistycznym i $O(\sum_c T_cV\log V)$ przy pełnym sortowaniu rangowym; $T_c$ to liczba tematów, $V$ rozmiar słownika. Jednorodność kosztuje $O(f^2h)$ dla wektorów długości $h$. Modele różnych społeczności muszą używać porównywalnego słownika i przygotowania tekstu. Selekcja wspólnych wyrażeń nie mierzy samodzielnie stopnia polaryzacji.

## Kontrakt

`modele`: nazwana lista co najmniej dwóch macierzy temat × wyrażenie, z nieujemnymi, skończonymi elementami. Suma wiersza pełnego modelu wynosi 1 z tolerancją `1e-8`; nie normalizuj ponownie wyłącznie podzbioru kandydatów. Unia słowników jest jawna; nieobecność wyrażenia daje 0 w wariancie probabilistycznym i rangę końcową w rangowym. `wektory`: macierz wyrażenie × wymiar, z nazwami i bez zerowej normy. Stała wartość pojedynczego wymiaru nie unieważnia wektora. `etykiety`: jednoznaczne 0/1 dla ocenianych wyrażeń. `alpha` w [0,1], `liczba`, `prog_rangi`, `beta` dodatnie całkowite.

Niezmienniki: wybór nie zależy od kolejności społeczności; $s(w)\in[0,1]$; $H$ i trafność w [0,1], gdy są określone. Dla mniej niż dwóch kandydatów H = `NA`; dla pustego zbioru trafność = `NA`. Brak kompletnych etykiet daje `NA` i `niepelne_etykiety`, zamiast sztucznie obniżonego udziału.

Wynik `ramy_dyskursu`: `kandydaci` z wyrażeniem, wynikiem i pozycją, `wyniki_spolecznosci`, `ocena`, `parametry`, `diagnostyka`. Błędy: „Model musi zawierać pełne rozkłady tematów”, „Wektor wyrażenia ma zerową normę”, „Identyfikatory wyrażeń muszą być jednoznaczne”, „Próg rangi musi być dodatnią liczbą całkowitą”.

## Plan pakietu

Pakiet `RamyR`, licencja GPL-3. Publiczne funkcje:

- `przygotuj_modele(modele, kandydaci, wektory = NULL)` – słowniki i rozkłady.
- `wybierz_ramy(dane, metoda = "probabilistyczna", liczba = 10, prog_rangi = 10)` – dwa warianty.
- `oblicz_jednorodnosc(wynik, wektory, alpha = 0.8)` – udział par.
- `oblicz_trafnosc(wynik, etykiety, beta = 10)` – ocena ręczna.
- `generuj_modele(ziarno = 202705)` – kontrolowane modele i wektory.

Moduły: `R/modele.R`, `R/selekcja.R`, `R/ocena.R`, `R/generator.R`, `R/metody_s3.R`. Klasa S3 `ramy_dyskursu` ma metody `print()`, `summary()` i `plot()`: skrócony wynik, zestawienie diagnostyki oraz wykres zgodny z rodzajem wyniku. Wartości i parametry pozostają dostępne bez odczytywania tekstu wydruku.

`Imports`: `stats`; do rdzenia nie potrzeba biblioteki grupowania. `Suggests`: `testthat`, `topicmodels`, `text2vec`, `ggplot2`, `knitr`, `rmarkdown`, `pkgdown`, `shiny`. Funkcje obliczeniowe nie instalują zależności ani nie korzystają z sieci. Dokumentacja `pkgdown` zawiera przykład od wejścia do interpretacji; aplikacja pod `/app/` korzysta z tego samego interfejsu i jawnie prezentuje parametry. Sprawdzenie: instalacja pakietu, uruchomienie przykładu i metod S3 oraz `R CMD check --as-cran`.

## Dane

**Generator.** `ziarno = 202705`. Dwie społeczności, po trzy tematy, słownik 60 terminów, w tym 20 wyrażeń wielowyrazowych. Dla każdego tematu losuj rozkład Dirichleta przez niezależne Gamma z parametrem kształtu 0,2, a dla czterech wspólnych wyrażeń użyj 10 w przynajmniej jednym temacie każdej społeczności. Dla czterech wyrażeń jednostronnych zwiększ parametr tylko w pierwszej społeczności. Po normalizacji zachowaj wszystkie prawdopodobieństwa i oblicz wynik min/max osobnym skryptem. Dla wektorów utwórz dwa bliskie kierunki w trzech wymiarach z szumem $N(0,0{,}02^2)$ i dwa odrębne kierunki. Braki i zerową normę dodaj wyłącznie do wariantów walidacyjnych. Konstrukcja wskazuje zadane terminy, ale nie gwarantuje ich selekcji w każdej losowej realizacji.

**Obliczenia kontrolne.** Dwie jedno-tematowe społeczności, terminy `a_b`, `c_d`, `e_f`, rozkłady $(0{,}5,0{,}3,0{,}2)$ i $(0{,}2,0{,}5,0{,}3)$: wyniki probabilistyczne $(0{,}2,0{,}3,0{,}2)$, a rangi maksymalne $(3,2,3)$. Top-1 i próg rangi 2 wybierają `c_d`. Wektory $(1,0),(1,0),(0,1)$ przy $\alpha=0{,}8$ dają H = 1/3. Dwie trafne etykiety w top-3 dają trafność 2/3.

**Przypadki brzegowe.** Termin nieobecny w jednej społeczności; identyczne wyniki selekcji; jeden lub zero kandydatów; zerowy wektor; inne słowniki; brak ręcznej oceny jednego wybranego wyrażenia.

**Zbiór empiryczny.** [Twenty Newsgroups w UCI](https://archive.ics.uci.edu/dataset/113/twenty+newsgroups), DOI [10.24432/C5C323](https://doi.org/10.24432/C5C323), CC BY 4.0. Wybierz po 300 wiadomości z `talk.politics.guns` i `talk.politics.misc`, ustalając identyfikatory. Grupy dyskusyjne są zastępczym podziałem społeczności; nie utożsamiaj ich automatycznie ze stronami konkretnego zdarzenia politycznego. Usuń nagłówki, cytaty poprzednich wiadomości i podpisy według zapisanej reguły. Wyznacz kolokacje dwuwyrazowe, wspólny słownik i LDA z pięcioma tematami osobno dla grup (`ziarno = 202705`). Modele oraz wektory wyrażeń przygotuj poza pakietem, np. jako reprezentacje współwystępowania terminów w wiadomościach. Dwóch koderów ocenia top-30 wyrażeń według jawnej definicji związku z wybranym zagadnieniem; zachowaj oceny przed uzgodnieniem. Wykonaj porównanie selekcji i ocen, bez deklaracji pełnej replikacji zbierania danych z artykułu.

## Mapowanie na pracę

| Materiał | Część pracy |
|---|---|
| Problem zastosowania, pytanie analityczne i zakres wkładu | Wprowadzenie |
| Definicje, wzory, założenia i porównanie dostępnych rozwiązań | Rozdział 1: Podstawy metodyczne |
| Kontrakt, moduły, klasy wyniku, generator i wyniki testów | Rozdział 2: Implementacja i architektura pakietu |
| Charakterystyka danych, analiza, interpretacja i porównanie | Rozdział 3: Studium przypadku |
| Odpowiedź na pytanie, ograniczenia i kierunek rozwoju | Zakończenie |

**Wstępne pytanie analityczne.** Jak wariant probabilistyczny i rangowy zmieniają wybór wspólnych kandydatów oraz ich zróżnicowanie semantyczne i zgodność z oceną ręczną?

**Proponowany wkład.** Samodzielny, sprawdzony moduł selekcji i oceny z gotowych modeli; wkład obejmuje jawne postępowanie ze słownikami, remisami i brakami etykiet.

## Polecenia startowe

1. **Specyfikacja.** Oddziel przygotowanie społeczności i modeli od selekcji wyrażeń; rozpisz cztery miary. Wynik: `SPEC.md` z sygnaturami, definicjami i obsługą przypadków brzegowych. Sprawdzenie: każdy argument i każda kolumna wyniku mają opis; zakres odpowiada wskazanym częściom artykułu.
2. **Przykłady analityczne.** Sprawdź wybór c_d, jednorodność 1/3 i trafność 2/3. Wynik: testy z liczbowymi wartościami oczekiwanymi. Sprawdzenie: odtwórz rachunki na kartce lub osobnym, prostym skryptem; nie wyznaczaj oczekiwanych wartości testowaną funkcją.
3. **Walidacja.** Zapisz testy wszystkich błędów wymienionych w kontrakcie oraz poprawnych danych prowadzących do `NA`. Wynik: konstruktor wejścia i stabilne komunikaty. Sprawdzenie: błędne dane zatrzymują obliczenia, a niezdefiniowana miara ma opisany status.
4. **Rdzeń.** Oblicz najpierw max po tematach i min po społecznościach, następnie analogiczny wariant rangowy i ocenę par. Wynik: działające funkcje i obiekt S3. Sprawdzenie: testy analityczne oraz porównanie z niezależną, najprostszą wersją obliczenia.
5. **Eksperyment.** Porównaj top-10, top-20 i top-30, progi jednorodności 0,5 i 0,8 oraz niezależne oceny koderów. Wynik: skrypt z konfiguracją, ziarnami i tabelą wyników. Sprawdzenie: powtórzenie daje te same dane i odtwarza tabelę; raport obejmuje wszystkie zaplanowane warianty.
6. **Udostępnienie.** Dodaj dokumentację, metodę wykresu, winietę i przykład w aplikacji. Wynik: instalowalny pakiet i działająca strona. Sprawdzenie: przykład działa po instalacji w czystej sesji R; opis odróżnia wynik liczbowy od jego interpretacji.

## Pułapki

Wektor wiadomości i wektor wyrażenia są innymi wejściami. Wysoka jednorodność oznacza podobieństwo kandydatów, nie ich poprawność. Trafność wymaga etykiet, a nie centroidu. Wyrażenia wspólne społecznościom mogą mieć odmienne użycie w kontekście; selekcja nie zastępuje interpretacji. Odwrócenie min i max zmienia znaczenie obu metod.

Na obronie należy wyjaśnić przejście od tematów do kandydatów, różnicę między wyrażeniem a ramą i sposób niezależnej oceny wyników tekstowych.

## Literatura

Artykuł źródłowy: `sarmiento2025framing`.

Wprowadzenie: `entman1993framing`, `blei2003lda`. Klucze i pełne opisy są w [`zrodla/tematy.bib`](zrodla/tematy.bib).

Środowisko: `rcore2026`. Wymagania formalne: `standardyEPI`. Źródła danych opisano w sekcji „Dane”; w pracy należy podać ich opis bibliograficzny, wersję wykorzystanego zbioru i zakres przekształceń.

Dane: `twentyNewsgroups`.
