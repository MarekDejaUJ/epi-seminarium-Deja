# Temat 08. Podobieństwo dwóch rankingów, gdy nie znamy ich końca

## Metryka

| | |
|---|---|
| Artykuł źródłowy | Corsi, Matteo; Urbano, Julián (2024). *The Treatment of Ties in Rank-Biased Overlap*. Proceedings of the 47th ACM SIGIR, 251–260 |
| Identyfikator | [10.1145/3626772.3657700](https://doi.org/10.1145/3626772.3657700); [preprint](https://arxiv.org/abs/2406.07121) |
| Podstawa metody | Webber, Moffat, Zobel (2010). *A Similarity Measure for Indefinite Rankings*, [10.1145/1852102.1852106](https://doi.org/10.1145/1852102.1852106) |
| Dostęp | otwarty |
| Dziedzina | wyszukiwanie informacji, bibliometria, porównywanie list |
| Proponowany tytuł pracy | Pakiet R do porównywania rankingów nieokreślonej długości jako przykład zastosowania miar ważonych pozycją w analizie danych bibliograficznych |
| Proponowana nazwa pakietu | `RankingiR` |
| Trudność | ●● |

## Po co to badaczowi

Dwie wyszukiwarki lub dwa zestawienia bibliometryczne mogą zwracać listy o innych długościach i częściowo innych elementach. Badacz często zna tylko początek listy. Klasyczne korelacje rang wymagają uzgodnienia wspólnego zbioru i nie dają same przez się opisu niewiedzy o dalszych pozycjach.

RBO porównuje zgodność kolejnych prefiksów, nadając większe znaczenie początkowi listy. Corsi i Urbano rozróżniają interpretacje remisów: cała grupa może być widoczna na danej głębokości albo elementy mogą wnosić ułamkowy wkład wynikający z możliwej kolejności. Te interpretacje dają odmienne wyniki także dla tych samych list.

Projekt obejmuje własny interfejs porównania, granice wynikające z nieznanego ogona oraz punkt ekstrapolowany przy jawnym założeniu. Istnieją pełne implementacje autorów, dlatego wkład obejmuje sprawdzony pakiet, diagnostykę i analizę wpływu remisów. Badacz ma otrzymać wynik, którego znaczenie odpowiada zastosowaniu rankingu.

## Algorytm

**Zakres.** RBO bez remisów oraz trzy warianty remisów $w,a,b$ z Corsi i Urbano. Obowiązkowe granice i ekstrapolacja dotyczą wspólnej ocenianej głębokości k z całkowicie widocznymi grupami remisowymi. Dla nierównych list wybierz k nieprzecinające grupy w żadnej liście, zachowaj niewykorzystane elementy w diagnostyce. Dokładniejsze wzory nierównych prefiksów są rozszerzeniem ze źródła, a nie domyślnym zastąpieniem wspólnego zakresu.

**Wejście.** Dwa rankingi unikatowych identyfikatorów i wyniki liczbowe opisujące remisy, $0<p<1$. Bez remisów $A_d=|S_{1:d}\cap T_{1:d}|/d$, a suma ważona ma postać:

$$\operatorname{RBO}=(1-p)\sum_{d=1}^{\infty}p^{d-1}A_d.$$

$A_d$ jest zgodnością do głębokości d; p reguluje wagę dalszej części listy. Dla znanych poziomów 1..k:

$$B_k=(1-p)\sum_{d=1}^{k}p^{d-1}A_d,\qquad [B_k,B_k+p^k].$$

To podstawowy, konserwatywny zakres przy nieznanej dalszej zgodności w [0,1]. Nie jest przedziałem ufności. Jego górny koniec nie musi być osiągalny dla każdego konkretnego prefiksu. Ekstrapolacja zakłada stały poziom dalszej zgodności:

$$\operatorname{RBO}_{\rm ext}=B_k+p^kA_k.$$

Punkt ekstrapolowany wynika z założenia o ogonie i nie zastępuje całego przedziału.

**Remisy.** Dla elementu e w grupie zajmującej pozycje l..u zdefiniuj wkład widoczności $c_{e,d}$ równy 0 dla $d<l$, $(d-l+1)/(u-l+1)$ dla $l\le d<u$ i 1 dla $d\ge u$. Pełna grupa musi być znana nawet wtedy, gdy aktualna głębokość przecina ją. Wariant $a$:

$$A_d^a=\frac1d\sum_e c^S_{e,d}c^T_{e,d}.$$

Jest to oczekiwana zgodność niezależnych porządków wewnątrz remisów. Wariant $b$ normalizuje ten iloczyn przez normy obu wektorów wkładów:

$$A_d^b=\frac{\sum_e c^S_{e,d}c^T_{e,d}}{\sqrt{\sum_e(c^S_{e,d})^2\sum_e(c^T_{e,d})^2}}.$$

Pozwala to osiągnąć 1 dla identycznych grup remisowych. Wariant $w$ włącza całą grupę przecinającą d; dla zbiorów widocznych $S_d^w,T_d^w$ stosuje $A_d^w=2|S_d^w\cap T_d^w|/(|S_d^w|+|T_d^w|)$. Realizuje inną interpretację głębokości niż niezależne losowanie kolejności. Użyj odpowiedniego $A_d$ w B, granicach i ekstrapolacji.

Koszt budowy grup i sum przy wykorzystaniu indeksu identyfikatorów powinien być co najwyżej $O(k^2)$ w prostej wersji i niższy po aktualizacji przyrostowej; sortowanie to $O(k\log k)$. Zmierz wersje na identycznych danych. Nie przestawiaj arbitralnie elementów remisowych, aby pozornie otrzymać metodę bez remisów.

## Kontrakt

Każda lista: tabela `element`, `wynik`, unikatowy i niepusty element, skończony wynik, uporządkowanie malejące. Równość wyników definiuje remis dokładny; ewentualne zaokrąglenie jest jawnym przygotowaniem danych. `p` w (0,1), wariant `bez_remisow`, `w`, `a` albo `b`. Wariant bez remisów odrzuca powtarzające się wyniki. Brak etykiet elementów lub wyników nie jest dozwolony. Dla braku dodatniej wspólnej głębokości wyniki punktowe są `NA`, granice [0,1].

Niezmienniki: symetria S,T; $A_d,B,\mathrm{ext}\in[0,1]$; punkt ekstrapolowany w zwróconych granicach; przestawienie wierszy w tej samej grupie nie zmienia wyniku. Identyczne listy z remisami nie muszą mieć wartości 1 w wariancie a. Rozłączne prefiksy nie dowodzą zerowej zgodności nieznanych ogonów. Losowa zamiana dwóch elementów nie gwarantuje monotonicznego spadku RBO.

Wynik `podobienstwo_rankingow`: `wariant`, `dolna`, `gorna`, `reszta`, `ekstrapolacja`, `profil`, `k`, `p`, `diagnostyka`, `status`. Błędy: „Elementy rankingu muszą być unikatowe”, „Wyniki muszą być skończone”, „Wariant bez remisów nie dopuszcza grup remisowych”, „Głębokość końcowa nie może przecinać grupy remisowej”.

## Plan pakietu

Pakiet `RankingiR`, licencja GPL-3. Publiczne funkcje:

- `przygotuj_listy(lista_s, lista_t)` – identyfikatory, grupy i kierunek.
- `profil_zgodnosci(dane, wariant = "a", k = NULL)` – wartości A po głębokościach.
- `oblicz_rbo(dane, p = 0.9, wariant = "a", k = NULL)` – granice i ekstrapolacja.
- `generuj_listy(n = 100, ziarno = 202708)` – kontrolowane listy i remisy.

Moduły: `R/listy.R`, `R/remisy.R`, `R/rbo.R`, `R/generator.R`, `R/metody_s3.R`. Klasa S3 `podobienstwo_rankingow` ma metody `print()`, `summary()` i `plot()`: skrócony wynik, zestawienie diagnostyki oraz wykres zgodny z rodzajem wyniku. Wartości i parametry pozostają dostępne bez odczytywania tekstu wydruku.

`Imports`: `stats`. `Suggests`: `testthat`, `knitr`, `rmarkdown`, `pkgdown`, `shiny`. Funkcje obliczeniowe nie instalują zależności ani nie korzystają z sieci. Dokumentacja `pkgdown` zawiera przykład od wejścia do interpretacji; aplikacja pod `/app/` korzysta z tego samego interfejsu i jawnie prezentuje parametry. Sprawdzenie: instalacja pakietu, uruchomienie przykładu i metod S3 oraz `R CMD check --as-cran`.

## Dane

**Generator.** `ziarno = 202708`. Dla 200 identyfikatorów losuj bazowe wyniki $z_e\sim N(0,1)$. Drugi ranking ma wynik $z_e+\varepsilon_e$, $\varepsilon\sim N(0,\sigma^2)$, dla $\sigma=0,0{,}5,2$. Remisy wprowadź zaokrągleniem do 1 lub 0 miejsc; wariant bez remisów pozostaw niezaokrąglony. Ukryj koniec list po 10, 30 i 100 pozycjach, zachowując kompletne graniczne grupy. Pełne wygenerowane listy są wzorcem skończonej ekstrapolacji, a niezależnie zadane przedłużenia testują zakresy ogona. Dodatkowe 10% elementów obecnych wyłącznie w jednej liście testuje niezgodność zbiorów. Zwiększenie szumu oceniaj statystycznie w 500 powtórzeniach, bez deterministycznego testu monotoniczności każdej zamiany.

**Obliczenia kontrolne.** Bez remisów identyczny prefiks długości 2 przy p = 0,9: B = 0,19, reszta 0,81, granice [0,19; 1], ekstrapolacja 1. Rozłączne prefiksy tej długości: B = 0, granice [0; 0,81], ekstrapolacja 0. Dwie identyczne listy, z remisem pierwszych dwóch elementów: $A_1^a=1/2$, $A_2^a=1$, więc ekstrapolacja przy k = 2 wynosi 0,95; warianty w i b dają 1. Dla wariantu a B = 0,14, górna granica 0,95.

**Przypadki brzegowe.** Grupa remisowa obejmująca całą listę; nierówne listy z grupą przecinającą krótszy koniec; p bliskie 1; powtórzony element; identyczne elementy z innymi remisami.

**Zbiór empiryczny i kod odniesienia.** Autorzy udostępniają [pełne implementacje wszystkich wariantów w R i Pythonie](https://github.com/julian-urbano/sigir2024-rbo), z kodem MIT oraz plikami danych CC BY-SA 4.0. Surowe przebiegi TREC w ich procedurze wymagają osobnego dostępu do TREC; nie są przez to automatycznie plikami zawartymi w archiwum. Porównanie własnych funkcji z implementacją autorów jest obowiązkowe, po uzgodnieniu wariantu i wzoru ekstrapolacji. Granice konserwatywne w tym projekcie mogą być szersze od dokładniejszych granic programu wzorcowego.

**Zbiór empiryczny.** [Reuters-21578, Distribution 1.0](https://archive.ics.uci.edu/dataset/137/reuters+21578+text+categorization+collection), DOI [10.24432/C52G6M](https://doi.org/10.24432/C52G6M), licencja CC BY 4.0 wskazana przez UCI. Dokumenty prasowe mają kategorie przypisane przez osoby indeksujące. W studium przypadku kategoria jest umownym zapytaniem, a przynależność do niej binarną oceną trafności. Jest to adaptacja zbioru klasyfikacyjnego, więc wynik dotyczy odnajdywania kategorii, a nie pełnej oceny potrzeb informacyjnych użytkownika.

Wybierz dokumenty z niepustym tekstem i oznaczeniem `TOPICS="YES"` ze zbioru testowego podziału ModApte. Zapisz identyfikatory dokumentów, wybór kategorii i liczności. Zbuduj co najmniej trzy rankingi na tej samej puli: podobieństwo tekstu do nazwy i opisu kategorii, jego wariant oparty tylko na tytule oraz ranking losowy. Ustal preprocessing i rozstrzyganie remisów identyfikatorem przed porównaniem wyników. Pełne etykiety kategorii są punktem odniesienia dla kontrolowanego ukrywania ocen. Pobranie i przekształcenie wykonaj osobnym skryptem; zachowaj opis źródła, a w testach pakietu używaj małych przykładów bez pobierania danych z sieci.

Dla empirycznych rankingów zachowaj wyniki podobieństwa, a remisy utwórz przez jawne zaokrąglenie. Oddziel wpływ remisów od wpływu odcięcia list.

## Mapowanie na pracę

| Materiał | Część pracy |
|---|---|
| Problem zastosowania, pytanie analityczne i zakres wkładu | Wprowadzenie |
| Definicje, wzory, założenia i porównanie dostępnych rozwiązań | Rozdział 1: Podstawy metodyczne |
| Kontrakt, moduły, klasy wyniku, generator i wyniki testów | Rozdział 2: Implementacja i architektura pakietu |
| Charakterystyka danych, analiza, interpretacja i porównanie | Rozdział 3: Studium przypadku |
| Odpowiedź na pytanie, ograniczenia i kierunek rozwoju | Zakończenie |

**Wstępne pytanie analityczne.** Jak interpretacja remisów i długość widocznego prefiksu zmieniają ocenę podobieństwa tych samych rankingów?

**Proponowany wkład.** Własna implementacja z walidacją, klasami wyniku, porównaniem wariantów i dokumentacją dla badacza. Istniejący kod autorów jest punktem odniesienia; nie można uzasadniać projektu nieistnieniem implementacji w R.

## Polecenia startowe

1. **Specyfikacja.** Zdefiniuj trzy interpretacje remisów, widoczność elementu i konserwatywne granice wspólnego prefiksu. Wynik: `SPEC.md` z sygnaturami, definicjami i obsługą przypadków brzegowych. Sprawdzenie: każdy argument i każda kolumna wyniku mają opis; zakres odpowiada wskazanym częściom artykułu.
2. **Przykłady analityczne.** Sprawdź 0,19, 0,81 oraz różnicę 0,95 wobec 1 dla identycznego remisu. Wynik: testy z liczbowymi wartościami oczekiwanymi. Sprawdzenie: odtwórz rachunki na kartce lub osobnym, prostym skryptem; nie wyznaczaj oczekiwanych wartości testowaną funkcją.
3. **Walidacja.** Zapisz testy wszystkich błędów wymienionych w kontrakcie oraz poprawnych danych prowadzących do `NA`. Wynik: konstruktor wejścia i stabilne komunikaty. Sprawdzenie: błędne dane zatrzymują obliczenia, a niezdefiniowana miara ma opisany status.
4. **Rdzeń.** Najpierw zbuduj profile widoczności, potem zgodność i sumę geometryczną; porównaj profile i ekstrapolację z kodem autorów. Wynik: działające funkcje i obiekt S3. Sprawdzenie: testy analityczne oraz porównanie z niezależną, najprostszą wersją obliczenia.
5. **Eksperyment.** Zmień wyłącznie zaokrąglenie i głębokość na tych samych listach; raportuj niewykorzystaną część dłuższej listy. Wynik: skrypt z konfiguracją, ziarnami i tabelą wyników. Sprawdzenie: powtórzenie daje te same dane i odtwarza tabelę; raport obejmuje wszystkie zaplanowane warianty.
6. **Udostępnienie.** Dodaj dokumentację, metodę wykresu, winietę i przykład w aplikacji. Wynik: instalowalny pakiet i działająca strona. Sprawdzenie: przykład działa po instalacji w czystej sesji R; opis odróżnia wynik liczbowy od jego interpretacji.

## Pułapki

Wariant a opisuje niezależne porządki w remisach i ma inną własność identyczności niż b. Nieznany ogon nie jest pustym zbiorem. Punkt ekstrapolowany i dolna granica są innymi wynikami. Porównanie z gotowym kodem wymaga ustalenia interpretacji i zakresu, a zgodność punktu nie oznacza identycznych granic.

Na obronie należy omówić znaczenie remisu dla użytkownika rankingu, skutek ukrycia dalszych pozycji i wkład własnego pakietu przy istniejącym kodzie odniesienia.

## Literatura

Artykuł źródłowy: `corsiUrbano2024remisy`.

Wprowadzenie: `webber2010similarity`, `manning2008ir`. Klucze i pełne opisy są w [`zrodla/tematy.bib`](zrodla/tematy.bib).

Środowisko: `rcore2026`. Wymagania formalne: `standardyEPI`. Źródła danych opisano w sekcji „Dane”; w pracy należy podać ich opis bibliograficzny, wersję wykorzystanego zbioru i zakres przekształceń.

Dane: `reuters21578`.
