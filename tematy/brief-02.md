# Temat 02. Wiarygodność ocen trafności generowanych maszynowo

## Metryka

| | |
|---|---|
| Artykuł źródłowy | Oosterhuis, Harrie; Jagerman, Rolf; Qin, Zhen; Wang, Xuanhui; Bendersky, Michael (2024). *Reliable Confidence Intervals for Information Retrieval Evaluation Using Generative A.I.* KDD '24 |
| Identyfikator | [10.1145/3637528.3671883](https://doi.org/10.1145/3637528.3671883), preprint [arXiv:2407.02464](https://arxiv.org/abs/2407.02464) |
| Dostęp | otwarty (preprint) |
| Dziedzina | wyszukiwanie informacji, metodologia oceny systemów |
| Proponowany tytuł pracy | Pakiet R do szacowania niepewności oceny systemów wyszukiwawczych jako przykład zastosowania ocen generowanych maszynowo w badaniach informatologicznych |
| Proponowana nazwa pakietu | `OcenaIRR` |
| Trudność | ●● |

## Po co to badaczowi

Ocena wyszukiwarki wymaga ustalenia trafności dokumentów dla zapytań. Oceny referencyjne są kosztowne, więc badacz może korzystać z przewidywań modelu. Duża liczba takich przewidywań nie usuwa jednak ich obciążenia: system może systematycznie przypisywać zbyt wysoką ocenę albo mylić podobieństwo słów z przydatnością dokumentu.

Artykuł proponuje dwie procedury łączące predykcje z mniejszą próbą pełnych ocen referencyjnych. PPI koryguje przeciętne obciążenie i uwzględnia zmienność dwóch składników estymacji. CRC przesuwa przewidywane rozkłady ocen i kalibruje dolną oraz górną granicę na odpowiednio dobranych jednostkach.

W projekcie trzeba sprawdzić, czy deklarowana niepewność odpowiada rzeczywistemu pokryciu w zaplanowanym eksperymencie. Badacz uzyska narzędzie do oceny, kiedy predykcje pozwalają ograniczyć koszt oceniania i kiedy zmiana rozkładu zapytań podważa interpretację przedziału. Zakres obejmuje miary liniowe, kompletnie ocenione zapytania oraz jawną jednostkę kalibracji.

## Algorytm

**Zakres.** Estymacja wspomagana predykcją (*prediction-powered inference*, PPI) oraz kalibracja ryzyka konformalnego (*conformal risk control*, CRC) z sekcji 5–6 artykułu. Pierwsza koryguje średnią ocen maszynowych; druga kalibruje dwie granice na podstawie całych zapytań lub zbiorów zapytań.

**Wejście.** Dla zapytania $q$ wynik $U_q=\sum_{i=1}^k w_i r_{qi}$ jest liniową sumą trafności $r_{qi}$ z nieujemnymi wagami $w_i$. Obowiązkowe miary: P@k z $w_i=1/k$ i DCG@k z $w_i=1/\log_2(i+1)$. Wybraną transformację stopnia trafności wykonuje się przed obliczeniem i stosuje identycznie dla referencji i predykcji. AP, ERR i nDCG z nieznanym idealnym mianownikiem pozostają poza tym kontraktem. $N$ zapytań ma predykcje, a niezależna próba $n$ zapytań także pełne oceny referencyjne potrzebne do $U_q$. Dowolna próbka pojedynczych par dokument–zapytanie nie spełnia tego wymagania.

**PPI.** Oblicz $\widehat U_q$ z predykcji, a w próbie referencyjnej poprawkę $e_q=U_q-\widehat U_q$.

$$\widehat\theta=\frac1N\sum_{q=1}^{N}\widehat U_q+\frac1n\sum_{q=1}^{n}e_q,\qquad \widehat{SE}=\sqrt{\frac{s_{\widehat U}^2}{N}+\frac{s_e^2}{n}}.$$

Średnia poprawka usuwa przeciętne obciążenie predykcji. $s^2$ oznacza wariancję próbkową z mianownikiem liczebność minus 1. Asymptotyczny przedział ma postać $\widehat\theta\pm z_{1-\alpha/2}\widehat{SE}$, gdzie $z$ jest kwantylem rozkładu normalnego, a $\alpha$ docelowym prawdopodobieństwem niepokrycia. W wersji obowiązkowej próbki predykcyjną i referencyjną pobiera się niezależnie; nakładanie próbek wymaga osobnego uwzględnienia kowariancji. Surowych końców nie przycinaj w podstawowym wyniku bez opisania zmiany procedury.

**CRC.** Potrzebny jest cały przewidywany rozkład $p(r)$ ocen każdego dokumentu, a nie tylko etykieta. Dla dodatniego $\lambda<1$ usuń masę $\lambda$ kolejno od najmniejszych ocen, dla ujemnego usuń $|\lambda|$ od największych. Usuwana masa z danej kategorii nie może przekroczyć jej prawdopodobieństwa. Pozostały rozkład podziel przez jego sumę i oblicz wartość oczekiwaną trafności. To realizuje równania 16–19; graniczne $\lambda=\pm1$ wymagają osobnej konwencji i nie są argumentem zwykłej normalizacji.

$$C(Q)=[\widehat U_{\rm CRC}(Q,\lambda_{\rm low}),\widehat U_{\rm CRC}(Q,\lambda_{\rm high})].$$

Wynik jest średnią po docelowym zbiorze zapytań $Q$ dla dwóch przesunięć rozkładów. Zbiór Q ma ustaloną wielkość B; każda jednostka kalibracyjna także zawiera B zapytań pobranych w ten sam sposób. Dla $M$ niezależnych zbiorów kalibracyjnych sprawdź osobno straty: $L_{\rm low}=\mathbf1(\widehat U_{\rm low}>U)$ i $L_{\rm high}=\mathbf1(\widehat U_{\rm high}<U)$.

$$\frac1M\sum_{b=1}^{M} L_{{\rm low},b}<\frac12\left(\alpha-\frac{1-\alpha}{M}\right),\qquad
\frac1M\sum_{b=1}^{M} L_{{\rm high},b}<\frac12\left(\alpha-\frac{1-\alpha}{M}\right).$$

Warunek z równania 24 rozdziela dopuszczalne ryzyko między obie granice. Znajdź największe dopuszczalne przesunięcie dolnej granicy i najmniejsze górnej, z tolerancją `1e-6`, wykorzystując monotoniczność. Jeśli próg jest niedodatni lub brak rozwiązania, zwróć opisany status. Losowanie wielu nakładających się zbiorów bootstrapowych z małej próby jest wariantem empirycznym ze źródła; nie tworzy nowych niezależnych obserwacji i nie uzasadnia automatycznie ścisłej gwarancji dla dowolnej populacji.

PPI kosztuje $O((N+n)k)$. Jedna ocena CRC kosztuje $O(MBkL)$ dla zbiorów po B zapytań i $L$ stopni trafności; wyszukiwanie dodaje czynnik logarytmiczny zależny od tolerancji. Predykcje muszą być ustalone przed użyciem ocen kalibracyjnych. Zmiana rozkładu zapytań lub zależne próbkowanie ogranicza gwarancje.

Dla PPI wielkością docelową jest średnia populacyjna wyniku referencyjnego. CRC kalibrowane na zbiorach Q obejmuje referencyjną średnią nowego zbioru tej samej wielkości B. W eksperymencie zapisz osobno obie wielkości docelowe; gwarancji dla skończonego zbioru nie przenoś automatycznie na dokładną średnią całej populacji.

## Kontrakt

Tabela ocen ma unikatowe pary `zapytanie`, `dokument`, pozycje `1..k`, zgodne identyfikatory i ustaloną skalę ocen. Każde zapytanie referencyjne ma kompletny zestaw ocen top-k. PPI wymaga $N,n\ge2$; CRC dodatkowo macierzy rozkładów o nieujemnych, skończonych elementach i sumie każdego wiersza 1. `alpha` należy do $(0,1)$, wagi są nieujemne, z dodatnią sumą. `NA` wolno wyłącznie w ocenach referencyjnych zapytań poza próbą referencyjną; nie w rozkładach predykcyjnych.

Wynik `ocena_przedzialowa`: `metoda`, `estymata` (dla CRC `NA`, jeśli nie zdefiniowano osobnego punktu), `dolna`, `gorna`, `alpha`, `liczebnosci`, `parametry`, `diagnostyka`, `status`, `cel_estymacji` i `wielkosc_zbioru` dla CRC. CRC musi mieć uporządkowane granice i zakres zgodny z miarą. Nie wymaga się zawierania punktu PPI przez CRC ani zwężania przedziału po każdym zwiększeniu próby. Zbyt mała poprawna próba CRC daje `NA` i `za_malo_kalibracji`.

Błędy: „Oceny referencyjne muszą obejmować całe zapytania”, „Próby PPI muszą być niezależne w tym wariancie”, „Rozkłady ocen muszą sumować się do jedności”, „Miara musi być liniową sumą z nieujemnymi wagami”, „Poziom alpha musi należeć do (0, 1)”.

Każda jednostka kalibracyjna CRC i zbiór docelowy muszą mieć B zapytań. Zatrzymanie przy naruszeniu: „Wielkość i jednostka zbioru docelowego muszą odpowiadać kalibracji”. Przy braku rozwiązania w dopuszczalnym zakresie lambda zwróć końce NA i status `brak_kalibracji`; nie zastępuj ich arbitralnym, wąskim przedziałem.

## Plan pakietu

Pakiet `OcenaIRR`, licencja GPL-3. Publiczne funkcje:

- `przygotuj_oceny(rankingi, oceny, predykcje, skala, k)` – dopasowanie i walidacja.
- `ocena_ppi(dane_predykcyjne, dane_referencyjne, miara = "precyzja", alpha = 0.05)` – niezależne próby.
- `przesun_rozklad(prawdopodobienstwa, skala, lambda)` – usunięcie masy i renormalizacja.
- `ocena_crc(kalibracja, cel, miara = "precyzja", alpha = 0.05, tolerancja = 1e-6)` – dwie granice.
- `generuj_oceny(N = 1000, n = 100, M = 100, B = 100, k = 10, ziarno = 202702)` – oddzielne próby i prawda.

Moduły: `R/oceny.R`, `R/ppi.R`, `R/crc.R`, `R/generator.R`, `R/metody_s3.R`. Klasa S3 `ocena_przedzialowa` ma metody `print()`, `summary()` i `plot()`: skrócony wynik, zestawienie diagnostyki oraz wykres zgodny z rodzajem wyniku. Wartości i parametry pozostają dostępne bez odczytywania tekstu wydruku.

`Imports`: `stats`. `Suggests`: `testthat`, `knitr`, `rmarkdown`, `pkgdown`, `shiny`. Funkcje obliczeniowe nie instalują zależności ani nie korzystają z sieci. Dokumentacja `pkgdown` zawiera przykład od wejścia do interpretacji; aplikacja pod `/app/` korzysta z tego samego interfejsu i jawnie prezentuje parametry. Sprawdzenie: instalacja pakietu, uruchomienie przykładu i metod S3 oraz `R CMD check --as-cran`.

## Dane

**Generator.** `ziarno = 202702`. Wylosuj niezależnie $N=1000$ zapytań predykcyjnych, $n=100$ referencyjnych i M = 100 niezależnych zbiorów kalibracyjnych po B = 100 zapytań i nowy zbiór docelowy CRC o tej samej wielkości; każde zapytanie ma $k=10$ pozycji. Dla każdego zapytania $h_q\sim N(0,0{,}5^2)$, a $r_{qi}\sim\operatorname{Bernoulli}(\operatorname{logit}^{-1}(-0{,}2-0{,}1i+h_q))$. Rozkład maszyny ma prawdopodobieństwo sukcesu $\operatorname{logit}^{-1}(-0{,}2-0{,}1i+h_q+b)$, z $b=0,0{,}5,1$. Oceny referencyjne są realizacjami $r$, a celem PPI oczekiwana wartość referencyjnej miary, nie odrębna trafność latentna. Średnią populacyjną dla PPI oblicz przez niezależną kwadraturę po $h$, a dla CRC zachowaj rzeczywistą średnią referencyjną nowego zbioru B zapytań; porównanie wykonaj w 1000 powtórzeniach dla $n=50,100,200$. Braki oznaczają wyłącznie nieudostępnione oceny całych zapytań. Wariant przesunięcia: do 10% zapytań docelowych dodaj $h=3$; oceniaj utratę zgodności rozkładów, a nie wymuszaj pokrycia.

**Obliczenia kontrolne.** Predykcyjne wyniki zapytań $(0{,}2,0{,}4,0{,}6,0{,}8)$ mają średnią 0,5 i wariancję $1/15$. Referencyjne poprawki $(0{,}1,-0{,}1)$ mają średnią 0 i wariancję 0,02. PPI daje 0,5, $SE=\sqrt{2/75}=0{,}1632993$ i przy $z=1{,}96$ przedział około $[0{,}1799333,0{,}8200667]$. Dla binarnego rozkładu $(0{,}7,0{,}3)$ przesunięcia 0,2 i -0,2 dają oczekiwaną trafność odpowiednio 0,375 i 0,125. Przy $\alpha=0{,}05$, $M=10$ próg kalibracyjny jest ujemny i nie ma wyniku CRC.

**Przypadki brzegowe.** Niekompletne zapytanie referencyjne; rozkład o sumie 0,9; jedna obserwacja PPI; wyłącznie zgodne predykcje z nadal zmiennym wynikiem zapytań; duże obciążenie w tym samym kierunku dla obu końców CRC. Przedział PPI może wyjść poza teoretyczny zakres miary.

**Zbiór empiryczny.** [Reuters-21578, Distribution 1.0](https://archive.ics.uci.edu/dataset/137/reuters+21578+text+categorization+collection), DOI [10.24432/C52G6M](https://doi.org/10.24432/C52G6M), licencja CC BY 4.0 wskazana przez UCI. Dokumenty prasowe mają kategorie przypisane przez osoby indeksujące. W studium przypadku kategoria jest umownym zapytaniem, a przynależność do niej binarną oceną trafności. Jest to adaptacja zbioru klasyfikacyjnego, więc wynik dotyczy odnajdywania kategorii, a nie pełnej oceny potrzeb informacyjnych użytkownika.

Wybierz dokumenty z niepustym tekstem i oznaczeniem `TOPICS="YES"` ze zbioru testowego podziału ModApte. Zapisz identyfikatory dokumentów, wybór kategorii i liczności. Zbuduj co najmniej trzy rankingi na tej samej puli: podobieństwo tekstu do nazwy i opisu kategorii, jego wariant oparty tylko na tytule oraz ranking losowy. Ustal preprocessing i rozstrzyganie remisów identyfikatorem przed porównaniem wyników. Pełne etykiety kategorii są punktem odniesienia dla kontrolowanego ukrywania ocen. Pobranie i przekształcenie wykonaj osobnym skryptem; zachowaj opis źródła, a w testach pakietu używaj małych przykładów bez pobierania danych z sieci.

Dla PPI z empirycznej puli kategorii losuj niezależnie zapytania z powtórzeniami do próby predykcyjnej i referencyjnej. Wielkość docelowa to średnia po tej jawnie zdefiniowanej puli. Predykcje przygotuj modelem kategorii uczonym na części treningowej; traktuj je jako ustalone. Jest to kontrolowana ocena błędu predykcyjnego względem indeksowania kategorii, bez deklaracji badania rzeczywistych ocen generatywnych.

W empirycznym CRC losuj M oddzielnych zbiorów po B zapytań z tej samej puli z powtórzeniami. Oceny kategorii pozwalają obliczyć ich pełne wyniki referencyjne. Wielkość nowego zbioru i sposób jego losowania są identyczne z kalibracją; pokrycie sprawdzaj względem jego średniej, bez porównywania dwóch różnych wielkości docelowych.

## Mapowanie na pracę

| Materiał | Część pracy |
|---|---|
| Problem zastosowania, pytanie analityczne i zakres wkładu | Wprowadzenie |
| Definicje, wzory, założenia i porównanie dostępnych rozwiązań | Rozdział 1: Podstawy metodyczne |
| Kontrakt, moduły, klasy wyniku, generator i wyniki testów | Rozdział 2: Implementacja i architektura pakietu |
| Charakterystyka danych, analiza, interpretacja i porównanie | Rozdział 3: Studium przypadku |
| Odpowiedź na pytanie, ograniczenia i kierunek rozwoju | Zakończenie |

**Wstępne pytanie analityczne.** Jak obciążenie predykcji i liczba kompletnie ocenionych zapytań wpływają na pokrycie i szerokość przedziałów PPI oraz CRC?

**Proponowany wkład.** Wspólny, walidowany interfejs dwóch procedur, z jawną jednostką kalibracji i osobnym pomiarem pokrycia przy zgodności oraz zmianie rozkładu zapytań.

## Polecenia startowe

1. **Specyfikacja.** Rozdziel wejścia PPI i CRC, liniowe miary i jednostkę próbkowania. Wynik: `SPEC.md` z sygnaturami, definicjami i obsługą przypadków brzegowych. Sprawdzenie: każdy argument i każda kolumna wyniku mają opis; zakres odpowiada wskazanym częściom artykułu.
2. **Przykłady analityczne.** Sprawdź PPI = 0,5 oraz dwa przesunięcia binarnego rozkładu i ujemny próg CRC. Wynik: testy z liczbowymi wartościami oczekiwanymi. Sprawdzenie: odtwórz rachunki na kartce lub osobnym, prostym skryptem; nie wyznaczaj oczekiwanych wartości testowaną funkcją.
3. **Walidacja.** Zapisz testy wszystkich błędów wymienionych w kontrakcie oraz poprawnych danych prowadzących do `NA`. Wynik: konstruktor wejścia i stabilne komunikaty. Sprawdzenie: błędne dane zatrzymują obliczenia, a niezdefiniowana miara ma opisany status.
4. **Rdzeń.** Najpierw implementuj PPI, potem przesuwanie rozkładu i monotoniczną kalibrację dwóch końców. Wynik: działające funkcje i obiekt S3. Sprawdzenie: testy analityczne oraz porównanie z niezależną, najprostszą wersją obliczenia.
5. **Eksperyment.** Zmierz pokrycie i średnią szerokość; podaj błąd Monte Carlo dla odsetka pokryć i oznacz wariant bootstrapowy. Wynik: skrypt z konfiguracją, ziarnami i tabelą wyników. Sprawdzenie: powtórzenie daje te same dane i odtwarza tabelę; raport obejmuje wszystkie zaplanowane warianty.
6. **Udostępnienie.** Dodaj dokumentację, metodę wykresu, winietę i przykład w aplikacji. Wynik: instalowalny pakiet i działająca strona. Sprawdzenie: przykład działa po instalacji w czystej sesji R; opis odróżnia wynik liczbowy od jego interpretacji.

## Pułapki

Korekta średniej nie naprawia dowolnej nieliniowej miary. Liczba ocenionych par nie zastępuje liczby kompletnych zapytań. CRC potrzebuje rozkładów ocen, a PPI obu składników wariancji. Szerokość przedziału w pojedynczej realizacji próby nie musi maleć po dodaniu obserwacji. Gwarancje dotyczą rozkładu i procedury próbkowania, nie każdej możliwej kolekcji.

Na obronie należy omówić różnicę między błędem predykcyjnym a niepewnością średniej, przedstawić kalibrację na poziomie zapytania i zinterpretować empiryczne pokrycie.

## Literatura

Artykuł źródłowy: `oosterhuis2024reliable`.

Wprowadzenie: `manning2008ir`, `buckleyVoorhees2004incomplete`. Klucze i pełne opisy są w [`zrodla/tematy.bib`](zrodla/tematy.bib).

Środowisko: `rcore2026`. Wymagania formalne: `standardyEPI`. Źródła danych opisano w sekcji „Dane”; w pracy należy podać ich opis bibliograficzny, wersję wykorzystanego zbioru i zakres przekształceń.

Dane: `reuters21578`.
