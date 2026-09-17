# Temat 06. Granice efektu przy brakach nielosowych

## Metryka

| | |
|---|---|
| Artykuł źródłowy | Peña, Jose M. (2024). *Bounds and Sensitivity Analysis of the Causal Effect Under Outcome-Independent MNAR Confounding* |
| Identyfikator | [arXiv:2410.06726v2](https://arxiv.org/abs/2410.06726v2) |
| Dostęp | otwarty |
| Dziedzina | badania ankietowe, wnioskowanie przyczynowe przy brakach danych |
| Proponowany tytuł pracy | Pakiet R do analizy wrażliwości przy brakach nielosowych jako przykład zastosowania granic nieparametrycznych w badaniach ankietowych |
| Proponowana nazwa pakietu | `BrakiMNARR` |
| Trudność | ●●● |

## Po co to badaczowi

Każde badanie ankietowe ma braki. Część respondentów nie odpowiada na część pytań,
część wypada z badania podłużnego, część w ogóle nie odbiera telefonu. Standardowa
praktyka polega na założeniu, że braki są **losowe warunkowo** – że po uwzględnieniu
tego, co wiemy o respondencie, brak nie niesie już informacji.

Założenie to jest wygodne i zwykle nieprawdziwe. Ludzie o skrajnych poglądach
częściej odmawiają odpowiedzi. Osoby w gorszej sytuacji częściej wypadają z badania
podłużnego. Brak **sam w sobie** jest wtedy informacją, a analiza, która to ignoruje,
zwraca wynik obciążony w nieznanym kierunku.

Kłopot w tym, że założenia o losowości braków **nie da się sprawdzić na danych**.
Nie ma testu, bo brakujących wartości nie widać. Można natomiast zapytać inaczej:
jak bardzo braki musiałyby być nielosowe, żeby wniosek się odwrócił? Jeśli odpowiedź
brzmi „nieznacznie", wynik jest kruchy. Jeśli „drastycznie", wynik się broni mimo
niepewności.

Artykuł podaje granice efektu przyczynowego przy określonym typie zależności między
brakiem a nieobserwowaną zmienną zakłócającą, wraz z analizą wrażliwości sterowaną
jawnym parametrem. Badacz dostaje przedział zamiast pojedynczej liczby oraz próg,
przy którym wniosek przestaje obowiązywać.

To jest dokładnie to, czego brakuje w raportach z badań społecznych: uczciwego
opisania, ile z wyniku pochodzi z danych, a ile z założeń.

## Algorytm

**Zakres.** Granice podstawowe z równania 4 i analiza wrażliwości z równania 6 preprintu w wersji v2. Zabieg $E$ i wynik $D$ są binarne i w pełni obserwowane. Dyskretny czynnik zakłócający $U$ może być nieobserwowany; $R=0$ oznacza obserwowany U, a $R=1$ brak. Założenia przyczynowe ze źródła obejmują kontrolę zakłócenia przez U i niezależność wyniku od mechanizmu braków warunkowo względem E,U: $R\perp D\mid E,U$. Nie jest to dowolny problem braków w tabeli.

Zdefiniuj $r_{eu}=P(D=1\mid E=e,U=u,R=0)$, $m_e=\min_u r_{eu}$, $M_e=\max_u r_{eu}$ oraz

$$c_e=\sum_u r_{eu}P(U=u\mid E=1-e,R=0).$$

Wielkość $c_e$ przenosi obserwowane ryzyka na rozkład U z przeciwnego ramienia. Oznacz $a_e=P(D=1,E=e)$, $b_e=P(R=0,E=1-e)$, $h_e=P(R=1,E=1-e)$.

$$L_e=a_e+c_eb_e+m_eh_e,\qquad U_e=a_e+c_eb_e+M_eh_e.$$

Granice obejmują $P(D_e=1)$, czyli ryzyko po interwencji E=e. Nie zastępuj ich ogólnym przedziałem [0,1]. Dolne i górne granice kontrastów:

$$RD\in[L_1-U_0,U_1-L_0],\qquad RR\in[L_1/U_0,U_1/L_0].$$

RD jest różnicą ryzyk z wartością neutralną 0, RR ilorazem z wartością neutralną 1. Dzielenie wymaga osobnej reguły dla zera.

**Wrażliwość.** Użytkownik określa cztery parametry: $\alpha_e\le P(U=u\mid E=e,R=1)\le\beta_e$ dla wszystkich u i obu e. Interpretacja ze źródła wiąże je z minimum i maksimum nieobserwowanego rozkładu. W interfejsie są zadanymi ograniczeniami tego rozkładu. Dla K poziomów konieczne jest $0\le\alpha_e\le1/K\le\beta_e\le1$.

$$L_e^{s}=a_e+c_eb_e+\alpha_{1-e}h_e\sum_u r_{eu},\qquad
U_e^{s}=a_e+c_eb_e+\beta_{1-e}h_e\sum_u r_{eu}.$$

Równanie 6 wykorzystuje dodatkową informację o rozkładzie U w brakach. Wynik zawęź przez przecięcie z granicami podstawowymi i zakresem [0,1], zapisując wszystkie końce przed przecięciem. Niepuste przecięcie nie dowodzi, że założenia użytkownika są prawdziwe. Wymagaj ograniczenia górnego dla każdego prawdopodobieństwa, a nie tylko dla jego minimum.

Kroki: utwórz tablice prawdopodobieństw, sprawdź obserwowane wsparcie U w obu ramionach, wyznacz ryzyka, oblicz dwa ryzyka interwencyjne i kontrasty, powtórz rachunek na jawnej siatce czterech parametrów. Koszt podstawowy $O(n+K)$, siatki G kombinacji $O(n+GK)$. Granice nie są ogólnie ostre; źródło wskazuje to w aneksie. Zanik braków identyfikuje ryzyko przy założeniach przyczynowych; samo MCAR nie wymusza punktowego wyniku tej procedury bez dodania informacji o rozkładzie w brakach.

## Kontrakt

Tabela `dane`: `zabieg` i `wynik` wyłącznie 0/1 bez braków; `zaklocenie` ma zdefiniowane K poziomów i `NA` wyłącznie tam, gdzie `brak = 1`. `brak` ma wartości 0/1 zgodne z U. Każda obserwowana komórka E,U potrzebna do ryzyka musi mieć dodatnią liczność; brak wsparcia zatrzymuje wykonanie. Estymacja z próby nie dodaje automatycznie przedziałów ufności. Wektor `alfa`, `beta` ma po dwa elementy z nazwami `0`, `1`; sprawdź wykonalność sumy rozkładu, nie tylko osobne [0,1].

Niezmienniki: granice ryzyk w [0,1], RD w [-1,1]; przecięcie wrażliwości jest podprzedziałem podstawowym; zmniejszenie zbioru dopuszczalnych rozkładów nie poszerza obliczonych granic. Dla RR dolną granicę wyznaczaj tylko przy dodatnim $U_0$; górna przy $L_0=0,U_1>0$ wynosi `Inf`. Przy obu ryzykach zerowych RR jest niezdefiniowane, z `NA` i statusem. Nie wymuszaj „braku efektu” przez obecność zera w RR.

S3 `granice_mnar`: `ryzyka`, `kontrasty`, `wrazliwosc`, `liczebnosci`, `parametry`, `status`. Błędy: „Zabieg i wynik muszą być binarne i kompletne”, „Wskaźnik braku musi być zgodny z zakłóceniem”, „Brak obserwowanego wsparcia w komórce zabieg–zakłócenie”, „Parametry wrażliwości nie dopuszczają rozkładu o sumie 1”, „Przecięcie granic jest puste”.

## Plan pakietu

Pakiet `BrakiMNARR`, licencja GPL-3. Publiczne funkcje:

- `przygotuj_mnar(dane, poziomy)` – tablice i obserwowane wsparcie.
- `granice_mnar(dane, kontrast = "roznica")` – ryzyka i RD albo RR.
- `wrazliwosc_mnar(dane, alfa, beta, kontrast = "roznica")` – cztery ograniczenia.
- `siatka_wrazliwosci(dane, siatka, kontrast = "roznica")` – nazwane kombinacje.
- `generuj_mnar(n = 5000, ziarno = 202706)` – dane pełne, maskowane i dokładny target.

Moduły: `R/tablice.R`, `R/granice.R`, `R/wrazliwosc.R`, `R/generator.R`, `R/metody_s3.R`. Klasa S3 `granice_mnar` ma metody `print()`, `summary()` i `plot()`: skrócony wynik, zestawienie diagnostyki oraz wykres zgodny z rodzajem wyniku. Wartości i parametry pozostają dostępne bez odczytywania tekstu wydruku.

`Imports`: `stats`. `Suggests`: `testthat`, `knitr`, `rmarkdown`, `pkgdown`, `shiny`. Funkcje obliczeniowe nie instalują zależności ani nie korzystają z sieci. Dokumentacja `pkgdown` zawiera przykład od wejścia do interpretacji; aplikacja pod `/app/` korzysta z tego samego interfejsu i jawnie prezentuje parametry. Sprawdzenie: instalacja pakietu, uruchomienie przykładu i metod S3 oraz `R CMD check --as-cran`.

## Dane

**Generator.** `ziarno = 202706`. $U\sim\operatorname{Bernoulli}(0{,}4)$; $P(E=1\mid U)=\operatorname{logit}^{-1}(-0{,}5+U)$; $P(D=1\mid E,U)=\operatorname{logit}^{-1}(-1+0{,}7E+0{,}8U)$; $P(R=1\mid E,U)=\operatorname{logit}^{-1}(-1+0{,}5E+1{,}2U)$. Losuj D i R niezależnie warunkowo względem E,U. Zachowaj U przed maskowaniem. Dokładny target to suma ryzyk D po rozkładzie populacyjnym U; policz go z parametrów, a nie z kompletnej podpróby. Najpierw testuj granice na dokładnej tablicy prawdopodobieństw, potem ich zachowanie dla n = 500, 2000, 5000 w 500 powtórzeniach. Dla każdego ramienia użyj siatki alfa = 0, 0,1, 0,2 i beta = 0,8, 0,9, 1, odrzucając niewykonalne kombinacje. Jako naruszenie założenia dodaj do modelu R składnik D; oznacz ten eksperyment osobno.

**Obliczenia kontrolne.** Dla każdego e przyjmij masę $P(E=e,R=0)=0{,}3$, $P(E=e,R=1)=0{,}2$ i równy rozkład U w obu częściach. Ryzyka dla U=0,1: przy e=0 $(0{,}1,0{,}3)$, przy e=1 $(0{,}4,0{,}6)$. Wówczas $a_0=0{,}1$, $a_1=0{,}25$, $c_0=0{,}2$, $c_1=0{,}5$; podstawowe granice ryzyk to $[0{,}18,0{,}22]$ i $[0{,}48,0{,}52]$. RD jest w $[0{,}26,0{,}34]$, RR w $[24/11,26/9]$. Przy alfa = beta = 0,5 dla obu ramion ryzyka wynoszą dokładnie 0,2 i 0,5, RD = 0,3, RR = 2,5.

**Przypadki brzegowe.** Brak obserwacji U w jednym ramieniu; całe U nieobserwowane; zero ryzyka w ramieniu odniesienia; alfa = 0,6 dla dwóch poziomów U; kompletny U; R zależny od D mimo kontroli E,U.

**Zbiór empiryczny.** [Adult w UCI](https://archive.ics.uci.edu/dataset/2/adult), DOI [10.24432/C5XW20](https://doi.org/10.24432/C5XW20), CC BY 4.0. Wynik: dochód ponad 50 tys.; umowny zabieg: wykształcenie co najmniej na poziomie bachelor; U: kategoria `workclass`, z oryginalnym `?` jako brakiem. Ustal łączenie rzadkich kategorii na podstawie liczności przed analizą i sprawdź wsparcie w obu ramionach. Jest to ilustracja warunkowej analizy, a nie dowód przyczynowego wpływu edukacji: U nie stanowi pewnego, kompletnego zbioru czynników zakłócających, a niezależność R od D nie jest potwierdzona. Dodatkowo na kompletnych rekordach ukryj U według jawnego mechanizmu E,U i porównaj z wynikiem przed maskowaniem, zachowując ten eksperyment jako osobny.

## Mapowanie na pracę

| Materiał | Część pracy |
|---|---|
| Problem zastosowania, pytanie analityczne i zakres wkładu | Wprowadzenie |
| Definicje, wzory, założenia i porównanie dostępnych rozwiązań | Rozdział 1: Podstawy metodyczne |
| Kontrakt, moduły, klasy wyniku, generator i wyniki testów | Rozdział 2: Implementacja i architektura pakietu |
| Charakterystyka danych, analiza, interpretacja i porównanie | Rozdział 3: Studium przypadku |
| Odpowiedź na pytanie, ograniczenia i kierunek rozwoju | Zakończenie |

**Wstępne pytanie analityczne.** Jak wiedza o rozkładzie czynnika zakłócającego w brakujących obserwacjach zmienia granice RD i RR oraz interpretację wyniku przy MNAR?

**Proponowany wkład.** Sprawdzony interfejs wzorów podstawowych i czteroparametrowej wrażliwości, z kontrolą wsparcia i wykonalności oraz porównaniem z prawdą generatora.

## Polecenia startowe

1. **Specyfikacja.** Zapisz znaczenie R, założenie niezależności wyniku i cztery parametry alfa/beta. Wynik: `SPEC.md` z sygnaturami, definicjami i obsługą przypadków brzegowych. Sprawdzenie: każdy argument i każda kolumna wyniku mają opis; zakres odpowiada wskazanym częściom artykułu.
2. **Przykłady analityczne.** Sprawdź dwa przedziały ryzyka, RD, RR oraz punkt przy alfa = beta = 0,5. Wynik: testy z liczbowymi wartościami oczekiwanymi. Sprawdzenie: odtwórz rachunki na kartce lub osobnym, prostym skryptem; nie wyznaczaj oczekiwanych wartości testowaną funkcją.
3. **Walidacja.** Zapisz testy wszystkich błędów wymienionych w kontrakcie oraz poprawnych danych prowadzących do `NA`. Wynik: konstruktor wejścia i stabilne komunikaty. Sprawdzenie: błędne dane zatrzymują obliczenia, a niezdefiniowana miara ma opisany status.
4. **Rdzeń.** Implementuj bezpośrednie wzory; pokaż granice przed przecięciem i po nim, zamiast zastępować metodę dowolną optymalizacją. Wynik: działające funkcje i obiekt S3. Sprawdzenie: testy analityczne oraz porównanie z niezależną, najprostszą wersją obliczenia.
5. **Eksperyment.** Oddziel dokładne tablice, próby losowe i naruszenia niezależności R; przedstaw powierzchnię wrażliwości przy jawnie ustalonych pozostałych parametrach. Wynik: skrypt z konfiguracją, ziarnami i tabelą wyników. Sprawdzenie: powtórzenie daje te same dane i odtwarza tabelę; raport obejmuje wszystkie zaplanowane warianty.
6. **Udostępnienie.** Dodaj dokumentację, metodę wykresu, winietę i przykład w aplikacji. Wynik: instalowalny pakiet i działająca strona. Sprawdzenie: przykład działa po instalacji w czystej sesji R; opis odróżnia wynik liczbowy od jego interpretacji.

## Pułapki

MNAR dotyczy tu U, a nie dowolnego wyniku D. Kodowanie R odwrotnie niż w artykule odwraca składniki wzorów. Siatka jednego parametru może być wyłącznie jawną ścieżką w czterowymiarowej przestrzeni. Parametrów dla braków nie da się zidentyfikować z samych obserwowanych danych. Wąskie granice nie potwierdzają założeń przyczynowych.

Na obronie należy omówić źródło nieidentyfikowalności, przejście od ryzyk do RD i RR oraz rozróżnienie informacji z danych od założeń wrażliwości.

## Literatura

Artykuł źródłowy: `pena2024mnar`.

Wprowadzenie: `pearl2009causality`, `little2019missing`. Klucze i pełne opisy są w [`zrodla/tematy.bib`](zrodla/tematy.bib).

Środowisko: `rcore2026`. Wymagania formalne: `standardyEPI`. Źródła danych opisano w sekcji „Dane”; w pracy należy podać ich opis bibliograficzny, wersję wykorzystanego zbioru i zakres przekształceń.

Dane: `adultUCI`.
