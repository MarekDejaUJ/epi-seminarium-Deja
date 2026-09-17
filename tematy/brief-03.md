# Temat 03. Ocena wyszukiwarki, gdy nie wszystko oceniono

## Metryka

| | |
|---|---|
| Artykuł źródłowy | Buckley, Chris; Voorhees, Ellen M. (2004). *Retrieval Evaluation with Incomplete Information*. SIGIR '04, s. 25-32 |
| Identyfikator | [kopia w repozytorium NIST](https://tsapps.nist.gov/publication/get_pdf.cfm?pub_id=150469) |
| Dostęp | wolny |
| Dziedzina | wyszukiwanie informacji, ocena systemów |
| Proponowany tytuł pracy | Pakiet R do oceny skuteczności wyszukiwania przy niepełnych sądach o trafności jako przykład zastosowania miar preferencyjnych w badaniach nad systemami informacyjnymi |
| Proponowana nazwa pakietu | `NiepelnaOcenaR` |
| Trudność | ● |

Temat o najniższym progu matematycznym w całym zestawie. Cały aparat to liczenie par
dokumentów i jedna suma. Trudność projektu leży w danych i w rzetelnym eksperymencie,
nie we wzorze.

## Po co to badaczowi

Porównanie wyszukiwarek zwykle opiera się na sądach o trafności dokumentów. Ocenia się tylko część dużej kolekcji. Dokument bez oceny nie musi być nietrafny, a przypisanie mu zerowej trafności może obniżać wynik systemu, który odnajduje materiały pominięte w budowie puli ocen.

Bpref ocenia kolejność par dokumentów trafnych i nietrafnych, dla których dostępne są sądy. Dokumenty nieocenione nie zwiększają liczby nietrafnych wyprzedzających trafny dokument. W artykule opisane są historyczne warianty tej miary; ich wartości trzeba odróżnić od późniejszej normalizacji używanej w programach ewaluacyjnych.

Projekt pozwala zbadać, jak wynik i uporządkowanie systemów zależą od liczby oraz sposobu ukrywania ocen. Badacz otrzyma porównanie bpref z klasycznymi miarami na tej samej kolekcji. Odporność na część braków jest własnością do oceny w konkretnych warunkach, a nie gwarancją prawidłowego porównania przy każdym mechanizmie oceniania.

## Algorytm

**Zakres.** Historyczne bpref i bpref-10 z sekcji 3 artykułu; późniejszy wariant `trec_eval` jest osobno nazwanym porównaniem. Wejście to ranking unikatowych dokumentów oraz pełna tabela dostępnych sądów dla jednego zapytania: trafny, nietrafny lub nieoceniony. Dokumenty z sądami mogą znajdować się poza rankingiem.

Niech $R$ będzie liczbą wszystkich ocenionych trafnych dokumentów w sądach, a $n_r$ liczbą ocenionych nietrafnych dokumentów przed trafnym dokumentem $r$ w rankingu. Dla $c=0$ lub $c=10$:

$$\operatorname{bpref}_{c}=\frac1R\sum_{r\in\mathcal R\cap\mathrm{ranking}}\left(1-\frac{\min(n_r,R+c)}{R+c}\right).$$

$\mathcal R$ jest zbiorem trafnych dokumentów z sądów; dokument nieodnaleziony wnosi zero, lecz nadal wchodzi do mianownika $R$. Wariant $c=0$ to historyczny bpref, a $c=10$ to bpref-10. Liczy się tylko pierwszych $R+c$ nietrafnych; dokumenty nieocenione nie zmieniają $n_r$.

Kroki: dopasuj sądy identyfikatorem, oblicz $R$ z całych sądów, wykonaj sumę skumulowaną liczby nietrafnych w rankingu, odczytaj ją na pozycjach trafnych i zsumuj wkłady. Wynik uśredniaj dopiero po obliczeniu osobno dla każdego zapytania. Koszt po dopasowaniu identyfikatorów: $O(d+J)$ czasu i $O(d+J)$ pamięci dla głębokości $d$ i $J$ sądów.

Współczesny wariant z mianownikiem $\min(R,N)$, gdzie $N$ to całkowita liczba ocenionych nietrafnych, oznacz `trec`; zdefiniuj oddzielnie przypadek $N=0$ i sprawdź wybraną wersję programu wzorcowego. Nie porównuj go z historycznym wzorem jak identycznej implementacji.

AP i P@k jako miary odniesienia liczą się na pierwotnych pozycjach, z nieocenionymi traktowanymi jako nietrafne w tym zadeklarowanym wariancie. Kompresowanie pozycji po usunięciu nieocenionych zmieniłoby także definicję tych miar. Bpref ogranicza wpływ braków, ale nie gwarantuje poprawnego uporządkowania systemów przy każdym mechanizmie oceniania.

## Kontrakt

`ranking`: wektor unikatowych, niepustych identyfikatorów, bez `NA`. `sady`: tabela `dokument`, `trafnosc` z unikatowym dokumentem i wartościami 0, 1 lub `NA`. Brak dokumentu w sądach oznacza nieocenienie. Sądy poza rankingiem są poprawne. `k` jest dodatnią liczbą całkowitą; dla P@k brakujące pozycje krótszej listy wnoszą zero.

Niezmienniki: $0\le\mathrm{bpref}\le1$; wstawienie nieocenionych do rankingu nie zmienia bpref; nieodnaleziony trafny wnosi zero; przy stałych sądach i odnalezionych trafnych przesunięcie nietrafnego za trafny nie obniża bpref. Ranking odwrotny daje zero dla bpref-2004 dopiero przy wystarczającej liczbie nietrafnych; bpref-10 ma inne warunki. $R=0$ daje `NA`, `brak_trafnych`, bez udawania wyniku zerowego.

Wynik `ocena_niepelna`: `wyniki` z kolumnami `zapytanie`, `wariant`, `wartosc`, `R`, `N`, `status`, `parametry`, `diagnostyka`. Średnia pomija niezdefiniowane zapytania tylko po jawnym wskazaniu liczby wyłączeń.

Błędy: „Ranking zawiera powtórzone dokumenty”, „Sądy muszą być jednoznaczne dla dokumentu”, „Trafność musi mieć wartość 0, 1 albo NA”, „Głębokość k musi być dodatnią liczbą całkowitą”.

## Plan pakietu

Pakiet `NiepelnaOcenaR`, licencja GPL-3. Publiczne funkcje:

- `przygotuj_ranking(ranking, sady)` – dopasowanie bez usuwania sądów spoza listy.
- `oblicz_bpref(ranking, sady, wariant = "2004")` – warianty `2004`, `2004_10`, opcjonalnie `trec`.
- `oblicz_ap(ranking, sady)` i `oblicz_precyzje(ranking, sady, k = 10)` – miary odniesienia.
- `ukryj_sady(sady, odsetek, mechanizm = "losowy", ziarno = 202703)` – maskowanie ocen.
- `porownaj_systemy(rankingi, sady, wariant = "2004")` – wyniki po zapytaniach.

Moduły: `R/ranking.R`, `R/bpref.R`, `R/miary_odniesienia.R`, `R/braki.R`, `R/metody_s3.R`. Klasa S3 `ocena_niepelna` ma metody `print()`, `summary()` i `plot()`: skrócony wynik, zestawienie diagnostyki oraz wykres zgodny z rodzajem wyniku. Wartości i parametry pozostają dostępne bez odczytywania tekstu wydruku.

`Imports`: `stats`. `Suggests`: `testthat`, `knitr`, `rmarkdown`, `pkgdown`, `shiny`. Funkcje obliczeniowe nie instalują zależności ani nie korzystają z sieci. Dokumentacja `pkgdown` zawiera przykład od wejścia do interpretacji; aplikacja pod `/app/` korzysta z tego samego interfejsu i jawnie prezentuje parametry. Sprawdzenie: instalacja pakietu, uruchomienie przykładu i metod S3 oraz `R CMD check --as-cran`.

## Dane

**Generator.** `ziarno = 202703`. Dla 100 zapytań utwórz 200 dokumentów z $r\sim\operatorname{Bernoulli}(0{,}1)$. Wynik systemu $s_{qd}=a_s r_{qd}+\varepsilon_{qd}$, $\varepsilon\sim N(0,1)$, dla $a_s=0,0{,}5,1,2$. Sortuj malejąco, remisy po identyfikatorze. Zachowaj pełne sądy jako punkt odniesienia. Ukrywaj 10%, 30%, 50%, 70%, 90% sądów losowo, a osobno częściej dla nietrafnych lub poniżej pozycji 20; w wariancie zależnym od pozycji zapisz jeden system użyty do budowy puli. Wykonaj 200 powtórzeń maskowania. Mierz korelację Kendalla uporządkowań i odsetek zapytań bez trafnych sądów. Nie wymuszaj przewagi bpref nad AP.

**Obliczenia kontrolne.** `t n t n`, przy $R=2$: bpref-2004 = $(1+1/2)/2=0{,}75$, bpref-10 = $(1+11/12)/2=23/24$. `n t t` przy $R=2,N=1$: odpowiednio 0,5 i $11/12$. Ranking `t` przy dwóch trafnych w pełnych sądach daje obu wariantom 0,5. `t ? n t` daje te same bpref co `t n t`, lecz P@2 przy konwencji nieoceniony = nietrafny wynosi 0,5.

**Przypadki brzegowe.** Pusta lista wyników przy $R>0$ daje 0; $R=0$ daje `NA`; wszystkie dokumenty nieocenione; trafne poza rankingiem; powtórzone identyfikatory; $N<R$.

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

**Wstępne pytanie analityczne.** Jak losowe i zależne od pozycji usuwanie ocen zmienia zgodność uporządkowań systemów według historycznych wariantów bpref, AP i P@k?

**Proponowany wkład.** Jednoznaczne rozdzielenie definicji bpref i eksperyment z kontrolowanym mechanizmem braków, zamiast założenia, że każda miara preferencyjna jest odporna na każdy brak ocen.

## Polecenia startowe

1. **Specyfikacja.** Zapisz rolę R z całych sądów, warianty mianownika i reguły dla miar odniesienia. Wynik: `SPEC.md` z sygnaturami, definicjami i obsługą przypadków brzegowych. Sprawdzenie: każdy argument i każda kolumna wyniku mają opis; zakres odpowiada wskazanym częściom artykułu.
2. **Przykłady analityczne.** Dodaj cztery ręczne rankingi z podanymi wynikami i trafny dokument nieodnaleziony. Wynik: testy z liczbowymi wartościami oczekiwanymi. Sprawdzenie: odtwórz rachunki na kartce lub osobnym, prostym skryptem; nie wyznaczaj oczekiwanych wartości testowaną funkcją.
3. **Walidacja.** Zapisz testy wszystkich błędów wymienionych w kontrakcie oraz poprawnych danych prowadzących do `NA`. Wynik: konstruktor wejścia i stabilne komunikaty. Sprawdzenie: błędne dane zatrzymują obliczenia, a niezdefiniowana miara ma opisany status.
4. **Rdzeń.** Użyj dopasowania identyfikatorów i sum skumulowanych; zachowaj prostą wersję liczącą pary jako kontrolę. Wynik: działające funkcje i obiekt S3. Sprawdzenie: testy analityczne oraz porównanie z niezależną, najprostszą wersją obliczenia.
5. **Eksperyment.** Porównaj trzy mechanizmy maskowania na tych samych systemach i raportuj zapytania wyłączone z powodu R=0. Wynik: skrypt z konfiguracją, ziarnami i tabelą wyników. Sprawdzenie: powtórzenie daje te same dane i odtwarza tabelę; raport obejmuje wszystkie zaplanowane warianty.
6. **Udostępnienie.** Dodaj dokumentację, metodę wykresu, winietę i przykład w aplikacji. Wynik: instalowalny pakiet i działająca strona. Sprawdzenie: przykład działa po instalacji w czystej sesji R; opis odróżnia wynik liczbowy od jego interpretacji.

## Pułapki

Usunięcie sądów spoza rankingu zawyża wynik przez zmniejszenie R. Nieoceniony dokument nie jest nietrafnym w bpref, ale ma zerowy wkład w wybranej klasycznej ocenie na pierwotnych pozycjach. Historyczny i współczesny mianownik dają różne wartości, zwłaszcza przy małym N. Bpref-10 nie jest korektą pozwalającą zawsze otrzymać zero dla odwrotnego rankingu.

Na obronie należy wyjaśnić ocenianie par preferencji, wpływ mechanizmu braków i związek między kompletnością sądów a stabilnością porównania systemów.

## Literatura

Artykuł źródłowy: `buckleyVoorhees2004incomplete`.

Wprowadzenie: `manning2008ir`, `moffatZobel2008rbp`. Klucze i pełne opisy są w [`zrodla/tematy.bib`](zrodla/tematy.bib).

Środowisko: `rcore2026`. Wymagania formalne: `standardyEPI`. Źródła danych opisano w sekcji „Dane”; w pracy należy podać ich opis bibliograficzny, wersję wykorzystanego zbioru i zakres przekształceń.

Dane: `reuters21578`.
