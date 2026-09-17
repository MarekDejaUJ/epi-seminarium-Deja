# Temat 10. Metaanaliza parametrów teorii perspektywy

## Metryka

| | |
|---|---|
| Artykuł źródłowy | Imai, Taisuke; Nunnari, Salvatore; Wu, Jilong; Vieider, Ferdinand M. (2025). *Meta-Analysis of Prospect Theory Parameters*. CESifo Working Paper 12334 |
| Dostęp | dokument roboczy dostępny publicznie |
| Dziedzina | ekonomia behawioralna, percepcja ryzyka |
| Proponowany tytuł pracy | Pakiet R do wspólnej metaanalizy parametrów jako przykład zastosowania bayesowskich modeli hierarchicznych w syntezie wyników badań |
| Proponowana nazwa pakietu | `MetaPTR` |
| Trudność | ●●● |
| Identyfikator | [CESifo Working Paper 12334](https://www.ifo.de/DocDL/cesifo1_wp12334.pdf) |

## Po co to badaczowi

Oszacowania parametrów teorii perspektywy różnią się między badaniami. W artykule analizowane są krzywizna użyteczności, wrażliwość na prawdopodobieństwo i podniesienie funkcji wag prawdopodobieństwa. Parametry wspólnie opisują zachowanie wobec ryzyka. Awersja do strat należy do szerszej teorii, ale jest wyłączona z tej metaanalizy.

Synteza napotyka kilka problemów: różne postacie funkcji, różne procedury badawcze, zależności między prawdziwymi wartościami parametrów i brakujące błędy standardowe. Zastąpienie brakującego błędu jedną przewidywaną liczbą pomija niepewność tej liczby. Autorzy rozwiązują to wspólnym bayesowskim modelem hierarchicznym, w którym brakujące błędy są zmiennymi, a nie stałymi.

Projekt obejmuje ograniczony model dla dwóch lub trzech parametrów, z jawnym modelem błędów, rozkładami a priori i diagnostyką próbkowania. Nie wymaga odtworzenia wszystkich metaregresji autorów. Pakiet ma służyć do wspólnej syntezy porównywalnych parametrów; studium empiryczne może ilustrować tę strukturę na publicznych danych wielowymiarowej metaanalizy, bez obietnicy replikacji całej bazy teorii perspektywy.

## Algorytm

**Zakres obowiązkowy.** Model pomiarowy i hierarchiczny z sekcji 4.1–4.2, ze wspólną estymacją nieznanych błędów standardowych. Obowiązkowe są stałe średnie oraz najwyżej jeden ustalony predyktor w X i jeden w Z. Harmonizacja parametrów i wybór jednej estymacji z każdej niezależnej próby poprzedzają dopasowanie. Pełna baza 812 estymacji, wszystkie postacie funkcji i wszystkie metaregresje są poza zakresem obowiązkowym.

Niech $\theta_i=(\rho_i,\gamma_i,\delta_i)$ będzie wektorem raportowanych parametrów, $\eta_i$ ich prawdziwym, nieobserwowanym odpowiednikiem, a $s_i$ wektorem błędów standardowych. W ogólnym interfejsie liczba wymiarów może wynosić dwa lub trzy.

$$\theta_i\mid\eta_i,s_i\sim N(\eta_i,\operatorname{diag}(s_i^2)),\qquad
\eta_i\sim N(X_iB,\Sigma).$$

Pierwszy poziom opisuje błąd pomiaru raportowanych estymacji, drugi zróżnicowanie prawdziwych parametrów i ich współzmienność między próbami. X jest macierzą cech z wyrazem wolnym, B macierzą współczynników, a $\Sigma$ kowariancją między prawdziwymi parametrami. Kowariancja ta nie jest kowariancją błędów pomiaru: artykuł w pierwszym poziomie używa macierzy diagonalnej.

$$\log(s_i)\sim N(Z_i\Xi,\Omega).$$

Z i $\Xi$ określają model błędów, a $\Omega$ zależności między ich logarytmami. Obserwowane s są danymi, brakujące s dla raportowanych parametrów zmiennymi dodatnimi przez transformację wykładniczą. Nie wstawiaj jednej regresyjnej imputacji przed dopasowaniem. Dla nieobserwowanego parametru pomijaj jego składnik funkcji wiarygodności, czyli modelu rozkładu obserwowanych estymacji i używaj właściwego podwektora oraz podmacierzy modelu błędów. Brak parametru nie oznacza wartości neutralnej 0 lub 1.

**Specyfikacja projektu.** Standaryzuj jawnie skale wejściowe przy ustalonych centrach i skalach, zapisując transformację odwrotną. Użyj $B_{jk}\sim N(0,2^2)$, wyrazu wolnego $\Xi\sim N(-2,1)$, pozostałych współczynników $\Xi\sim N(0,1)$, dodatnich skal obu kowariancji z półnormalnym N(0,1) i macierzy korelacji z LKJ(2). Są to jawne wybory a priori w projekcie, a nie deklaracja identyczności z nieuszczegółowionymi w tekście rozproszonymi rozkładami a priori hiperparametrów autorów. Wrażliwość obejmuje podwojenie skal rozkładów a priori. Stałe neutralne dla teorii perspektywy: rho = 0, gamma = 1, delta = 1; postacie funkcji harmonizuje się według sekcji 2, a skali power i exponential nie miesza bez dodatkowego modelowania.

Kroki: walidacja i maski obserwacji, budowa X,Z, model Stan z parametryzacją Cholesky'ego, cztery łańcuchy po 1000 rozgrzewki i 1000 zachowanych losowań, diagnostyka, transformacja odwrotna i podsumowanie rozkładu a posteriori. Wyniki: średnie lub mediany, kwantyle 2,5% i 97,5%, kowariancje, przewidywania i rozkłady imputowanych błędów. To przedziały wiarygodności bayesowskiej, nie klasyczne przedziały ufności.

Koszt jednej oceny modelu przy J wymiarach jest rzędu $O(nJ^2+J^3)$ przy ponownym użyciu rozkładów macierzy; całkowity koszt zależy od liczby kroków próbkowania. Założenia: porównywalne parametry, niezależne próby i brakujące błędy MAR względem informacji ujętej w modelu. Wiele estymacji tej samej próby wymaga dodatkowego poziomu zależności, więc nie traktuj ich jak niezależnych w zakresie podstawowym.

## Kontrakt

Macierze `estymaty`, `bledy` mają te same nazwy i wymiary n × J, J = 2 albo 3. Estymaty skończone lub `NA`; błędy ściśle dodatnie albo `NA`. Jeśli parametr nie został oszacowany, jego błąd też jest `NA`. X,Z mają n wierszy, skończone wartości, wyraz wolny i pełną rangę. Dla każdego wymiaru musi istnieć co najmniej pięć niezależnych raportowanych estymacji i co najmniej trzy dodatnie błędy; to minimalny warunek obliczeniowy projektu, nie gwarancja wiarygodnej identyfikacji korelacji. Żaden wiersz nie może mieć samych braków. `id_proby` jednoznaczne; wiele wierszy tej samej próby w tym wariancie jest błędem.

Niezmienniki: macierze kowariancji dodatnio określone, losowane błędy dodatnie, maski nie zmieniają danych obserwowanych. Nie wymagaj, aby niepewność syntezy była mniejsza od najmniejszego błędu pojedynczego badania, ani aby każdy wynik mieścił się między skrajnymi estymatami. S3 `meta_parametrow`: `losowania`, `podsumowanie`, `imputacje`, `kowariancje`, `diagnostyka`, `transformacje`, `parametry`, `status`.

Brak zbieżności to zachowany wynik diagnostyczny `niezbieznosc`, z ostrzeżeniem i bez automatycznego zatwierdzenia wniosku. Próg kontroli: R-hat > 1,01, efektywna liczebność bulk/tail < 400 albo rozbieżne kroki próbkowania. Błędy: „Błędy standardowe muszą być dodatnie albo NA”, „Macierze parametrów i błędów muszą być zgodne”, „Próby muszą być niezależne w tym wariancie”, „Macierz predyktorów musi mieć pełną rangę”, „Za mało obserwowanych danych dla wymiaru”.

## Plan pakietu

Pakiet `MetaPTR`, licencja GPL-3. Publiczne funkcje:

- `przygotuj_meta(estymaty, bledy, id_proby, X = NULL, Z = NULL, centra, skale)` – dane i maski.
- `dopasuj_meta(dane, priory, lancuchy = 4, rozgrzewka = 1000, iteracje = 1000, ziarno = 202710)` – model i diagnostyka.
- `podsumuj_meta(wynik, poziom = 0.95)` – wynik w skali wejściowej.
- `przewiduj_meta(wynik, X_nowe, Z_nowe)` – rozkłady predykcyjne.
- `generuj_meta(n = 100, ziarno = 202710)` – prawdziwe parametry, błędy i maski.

Moduły: `R/dane.R`, `R/model.R`, `R/podsumowanie.R`, `R/generator.R`, `R/metody_s3.R` oraz model w `inst/stan/`. Klasa S3 `meta_parametrow` ma metody `print()`, `summary()` i `plot()`: skrócony wynik, zestawienie diagnostyki oraz wykres zgodny z rodzajem wyniku. Wartości i parametry pozostają dostępne bez odczytywania tekstu wydruku.

`Imports`: `stats`, `rstan`, `posterior`. `Suggests`: `testthat`, `metadat`, `ggplot2`, `knitr`, `rmarkdown`, `pkgdown`, `shiny`. Funkcje obliczeniowe nie instalują zależności ani nie korzystają z sieci. Dokumentacja `pkgdown` zawiera przykład od wejścia do interpretacji; aplikacja pod `/app/` korzysta z tego samego interfejsu i jawnie prezentuje parametry. Sprawdzenie: instalacja pakietu, uruchomienie przykładu i metod S3 oraz `R CMD check --as-cran`.

Stan wymaga lokalnego środowiska kompilacji i nie jest backendem obliczeniowym aplikacji Shinylive. Aplikacja prezentuje wcześniej obliczone, podpisane scenariusze oraz ich diagnostykę; interaktywne filtry nie udają ponownego dopasowania modelu. Winieta zawiera polecenie odtwarzające te scenariusze lokalnie. Testy szybkie sprawdzają przygotowanie danych i rachunki analityczne, a pełną walidację próbkowania uruchamia się osobnym skryptem z zapisanymi ziarnami.

## Dane

**Generator.** `ziarno = 202710`, 100 niezależnych prób, trzy parametry. $\mu=(0{,}2,0{,}7,1)$; odchylenia prawdziwych parametrów $(0{,}15,0{,}1,0{,}2)$ i macierz korelacji z każdą korelacją poza przekątną 0,4. Losuj $\eta_i$ z tego rozkładu normalnego. Liczebność próby równa 50 albo 200 z równymi szansami; $\log s_i$ ma średnią -2, zależność -0,05 od $\sqrt{n_i}$, odchylenie 0,3 i korelacje 0,5. Następnie losuj estymaty z diagonalnym błędem pomiaru. Usuń 30% s niezależnie i 10% parametrów, zachowując co najmniej jedną estymatę w wierszu. Zachowaj pełne s i eta. Osobno usuń s zależnie od ich wielkości jako naruszenie MAR; do 5% estymat dodaj 4 odchylenia jako wariant odstający. Oceniaj odzyskiwanie mu, kowariancji i niepewność imputacji w 100 powtórzeniach, z błędem Monte Carlo i odsetkiem niezbieżnych dopasowań.

**Obliczenie kontrolne.** Jednowymiarowy, warunkowy fragment modelu: dwie estymaty 0 i 1, s = 0,1 i 1, ustalone $\tau^2=4$, płaski rozkład a priori średniej. Wagi wynoszą $1/4{,}01$ i $1/5$, średnia $401/901=0{,}445061$, a odchylenie a posteriori $\sqrt{2005/901}=1{,}491746$. Sprawdź ten fragment przy ustalonych hiperparametrach; nie oczekuj identycznych liczb w pełnym modelu z estymowaną tau i właściwym rozkładem a priori.

**Przypadki brzegowe.** s = 0; całkowicie brakujący wymiar; powtórzone id próby; współliniowe predyktory; bardzo mały zbiór i korelacja bliska 1; dopasowanie z diagnostyką rozbieżnych kroków.

**Zbiór empiryczny.** [`metadat::dat.berkey1998`](https://wviechtb.github.io/metadat/reference/dat.berkey1998.html), pięć prób klinicznych z dwoma parametrami efektu i ich wariancjami; pakiet [`metadat`](https://cran.r-project.org/package=metadat) na GPL (>= 2), z możliwością użycia GPL-3. Użyj PD i AL jako dwóch wymiarów. Z wariancji wyznacz s przez pierwiastek; pomiarowe kowariancje dostępne w danych zachowaj do diagnostyki, ponieważ model z artykułu używa diagonalnego poziomu pomiarowego i je pomija. Podaj to ograniczenie przy interpretacji. Pokaż pełne dane oraz kontrolowane ukrycie trzech błędów, nie tworząc dodatkowych pozornie niezależnych prób. Tak mały zbiór służy do demonstracji interfejsu i wrażliwości na rozkład a priori; nie uzasadnia precyzyjnych wniosków o korelacjach. To zastosowanie ogólnej struktury modelu, a nie replikacja wyników teorii perspektywy. Dostępność i licencję surowej bazy autorów trzeba ustalić osobno przed ewentualnym rozszerzeniem studium.

## Mapowanie na pracę

| Materiał | Część pracy |
|---|---|
| Problem zastosowania, pytanie analityczne i zakres wkładu | Wprowadzenie |
| Definicje, wzory, założenia i porównanie dostępnych rozwiązań | Rozdział 1: Podstawy metodyczne |
| Kontrakt, moduły, klasy wyniku, generator i wyniki testów | Rozdział 2: Implementacja i architektura pakietu |
| Charakterystyka danych, analiza, interpretacja i porównanie | Rozdział 3: Studium przypadku |
| Odpowiedź na pytanie, ograniczenia i kierunek rozwoju | Zakończenie |

**Wstępne pytanie analityczne.** Jak wspólne modelowanie parametrów i nieznanych błędów standardowych wpływa na niepewność syntezy oraz wrażliwość na założenia modelu?

**Proponowany wkład.** Sprawdzony pakiet ograniczonego modelu hierarchicznego, z rozkładami imputacji i diagnostyką. Wkład obejmuje implementację modelu i ocenę jego działania; nie polega na zastąpieniu go ważoną średnią.

## Polecenia startowe

1. **Specyfikacja.** Rozdziel trzy poziomy modelu, brak parametru od braku błędu i rozkłady a priori projektu. Wynik: `SPEC.md` z sygnaturami, definicjami i obsługą przypadków brzegowych. Sprawdzenie: każdy argument i każda kolumna wyniku mają opis; zakres odpowiada wskazanym częściom artykułu.
2. **Przykłady analityczne.** Sprawdź fragment normalny o średniej 401/901 i odchyleniu sqrt(2005/901), przy ustalonych hiperparametrach. Wynik: testy z liczbowymi wartościami oczekiwanymi. Sprawdzenie: odtwórz rachunki na kartce lub osobnym, prostym skryptem; nie wyznaczaj oczekiwanych wartości testowaną funkcją.
3. **Walidacja.** Zapisz testy wszystkich błędów wymienionych w kontrakcie oraz poprawnych danych prowadzących do `NA`. Wynik: konstruktor wejścia i stabilne komunikaty. Sprawdzenie: błędne dane zatrzymują obliczenia, a niezdefiniowana miara ma opisany status.
4. **Rdzeń.** Zapisz pełny model Stan z losowanymi log-błędami i podmacierzami; sprawdź każdą składową funkcji wiarygodności względem prostego rachunku. Wynik: działające funkcje i obiekt S3. Sprawdzenie: testy analityczne oraz porównanie z niezależną, najprostszą wersją obliczenia.
5. **Eksperyment.** Porównaj pełne i maskowane dane, dwa warianty rozkładów a priori i naruszenie MAR; zawsze raportuj diagnostykę przed interpretacją. Wynik: skrypt z konfiguracją, ziarnami i tabelą wyników. Sprawdzenie: powtórzenie daje te same dane i odtwarza tabelę; raport obejmuje wszystkie zaplanowane warianty.
6. **Udostępnienie.** Dodaj dokumentację, metodę wykresu, winietę i przykład w aplikacji. Wynik: instalowalny pakiet i działająca strona. Sprawdzenie: przykład działa po instalacji w czystej sesji R; opis odróżnia wynik liczbowy od jego interpretacji.

## Pułapki

Współzmienność prawdziwych parametrów i zależność ich błędów są odrębnymi macierzami. Jedna imputacja s nie przenosi jej niepewności. Parametr awersji do strat nie należy do estymowanych wymiarów artykułu. Macierz diagonalna w poziomie pomiarowym jest założeniem, a nie wynikiem estymacji. Dodatkowe losowania nie naprawiają źle określonego modelu ani zależności próbek.

Na obronie należy przejść przez trzy poziomy modelu, objaśnić sens rozkładu a posteriori i pokazać, co diagnostyka pozwala powiedzieć o wiarygodności własnego wyniku.

## Literatura

Artykuł źródłowy: `imai2025meta`.

Wprowadzenie: `tversky1992prospect`, `carpenter2017stan`, `gelman2013bayesian`. Klucze i pełne opisy są w [`zrodla/tematy.bib`](zrodla/tematy.bib).

Środowisko: `rcore2026`. Wymagania formalne: `standardyEPI`. Źródła danych opisano w sekcji „Dane”; w pracy należy podać ich opis bibliograficzny, wersję wykorzystanego zbioru i zakres przekształceń.

Dane: `berkeyData`.
