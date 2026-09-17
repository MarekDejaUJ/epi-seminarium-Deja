# Temat 11. Wyniki porównywalne między różnymi zestawami zapytań

## Metryka

| | |
|---|---|
| Artykuł źródłowy | Webber, William; Moffat, Alistair; Zobel, Justin (2008). *Score Standardization for Inter-Collection Comparison of Retrieval Systems*. SIGIR '08, s. 51-58 |
| Identyfikator | [10.1145/1390334.1390346](https://doi.org/10.1145/1390334.1390346); [kopia autorska](https://www.codalism.com/research/papers/wmz08_sigir_pp.pdf) |
| Dostęp | wolny |
| Dziedzina | wyszukiwanie informacji, metodologia eksperymentu |
| Proponowany tytuł pracy | Pakiet R do standaryzacji wyników oceny systemów wyszukiwawczych jako przykład zastosowania normalizacji rozkładowej w badaniach porównawczych |
| Proponowana nazwa pakietu | `StandaryzacjaR` |
| Trudność | ●● |

## Po co to badaczowi

Średnia skuteczność wyszukiwarki zależy od wybranego zestawu zapytań. Zbiory mogą różnić się trudnością, a wyniki poszczególnych zapytań skalą i rozrzutem. Porównanie liczb z dwóch doświadczeń wymaga więc określenia, względem czego wynik ma być wysoki lub niski.

Standaryzacja ze źródła odnosi wynik systemu do rozkładu wyników systemów kalibracyjnych na tym samym zapytaniu. Położenie w tym rozkładzie jest następnie przekształcane i uśredniane. Badacz otrzymuje skalę odniesienia, ale jej znaczenie zależy od składu kalibracji.

W projekcie trzeba oddzielić zmianę skali zadania od rzeczywistej specjalizacji systemów i zbadać wpływ kalibratorów. Samo centrowanie nie zapewnia porównywalności dowolnych kolekcji. Pakiet ma zachować parametry oraz identyfikatory kalibracji, aby nowe wyniki można było interpretować względem tego samego odniesienia.

## Algorytm

**Wejście.** Macierz wyniku miary z systemami w wierszach i zapytaniami w kolumnach. Dla każdego zapytania t istnieje stały zbiór systemów kalibracyjnych. Niech $\mu_t$ i $\sigma_t$ oznaczają średnią i odchylenie standardowe ich wyników, z mianownikiem $K-1$ dla K systemów.

$$z_{st}=(m_{st}-\mu_t)/\sigma_t,\qquad u_{st}=\Phi(z_{st}).$$

Wynik $z_{st}$ wyraża położenie systemu s względem kalibracji zapytania t. $\Phi$ jest dystrybuantą standardowego rozkładu normalnego; $u_{st}$ to przekształcony wynik w [0,1], a nie wartość p testu statystycznego ani pewne empiryczne prawdopodobieństwo przewagi. Wynik systemu jest średnią jego $u_{st}$ po określonym zbiorze zapytań.

Kroki: wybierz i zapisz systemy kalibracyjne, wyznacz parametry osobno dla kolumn, zastosuj do systemów ocenianych, przekształć przez Phi i uśrednij. W R centrowanie i skalowanie wykonaj po kolumnach, np. dwoma wywołaniami `sweep(..., MARGIN = 2)`, bez niejawnego recyklingu wektorów. Przechowuj nazwy zapytań w obiekcie kalibracji.

Parametry dla nowych kolekcji wyznacza się na odpowiadających im zapytaniach przy porównywalnym, ustalonym zbiorze systemów odniesienia. Oceniany nowy system nie zmienia automatycznie kalibracji pozostałych. Rekalibracja jest dopuszczalnym, osobno oznaczonym wariantem z nowym identyfikatorem. Koszt $O(KT+ST)$ i pamięć $O(ST)$ dla T zapytań i S systemów ocenianych.

Metoda usuwa część różnic skali i trudności zapytań. Nie gwarantuje porównywalności całkowicie odmiennych zadań, reprezentatywności kalibracji ani normalności rozkładu wyników. Dodanie identycznej stałej trudności do wyników wszystkich systemów w zapytaniu nie zmienia ich różnic; symulacja musi uwzględniać interakcje lub zmienną skalę, aby badać zmianę uporządkowań.

## Kontrakt

`wyniki`: macierz liczb skończonych, z unikatowymi nazwami systemów i zapytań. Co najmniej dwa systemy kalibracyjne, bez `NA` w podstawowym wariancie. `kalibracja` przechowuje identyfikatory, średnie, odchylenia i definicję miary. Dane oceniane mają dokładnie dopasowane identyfikatory zapytań; kolejność dopasowuje się nazwami. Zmiana definicji miary wymaga nowej kalibracji.

Kolumna o zerowym odchyleniu daje `NA` dla wszystkich systemów i status `zerowa_skala`. Średnia wyłącza takie kolumny tylko po podaniu ich liczby i wspólnej listy dla porównywanych systemów; brak jakiejkolwiek określonej kolumny daje `NA`. Niezmienniki: monotoniczność transformacji wewnątrz zapytania; niezmienność po wspólnym dodatnim skalowaniu i przesunięciu kolumny wraz z jej kalibracją; nowy oceniany system nie zmienia wyników innych przy stałej kalibracji.

S3 `wynik_standaryzacji`: `z`, `u`, `srednie`, `kalibracja`, `zapytania_wylaczone`, `parametry`, `status`. Błędy: „Macierz musi mieć jednoznaczne nazwy systemów i zapytań”, „Potrzeba co najmniej dwóch systemów kalibracyjnych”, „Zapytania nie odpowiadają zapisanej kalibracji”, „Wyniki muszą być skończone i kompletne”.

## Plan pakietu

Pakiet `StandaryzacjaR`, licencja GPL-3. Publiczne funkcje:

- `kalibruj_wyniki(wyniki, systemy_kalibracyjne, miara)` – parametry po zapytaniach.
- `standaryzuj_wyniki(wyniki, kalibracja)` – z, Phi i średnie.
- `porownaj_kolekcje(wyniki_a, wyniki_b, systemy_kalibracyjne, miara)` – oddzielne kalibracje o wspólnej definicji.
- `generuj_wyniki(n_systemow = 20, n_zapytan = 100, ziarno = 202711)` – interakcje i skala.

Moduły: `R/kalibracja.R`, `R/standaryzacja.R`, `R/porownanie.R`, `R/generator.R`, `R/metody_s3.R`. Klasa S3 `wynik_standaryzacji` ma metody `print()`, `summary()` i `plot()`: skrócony wynik, zestawienie diagnostyki oraz wykres zgodny z rodzajem wyniku. Wartości i parametry pozostają dostępne bez odczytywania tekstu wydruku.

`Imports`: `stats`. `Suggests`: `testthat`, `knitr`, `rmarkdown`, `pkgdown`, `shiny`. Funkcje obliczeniowe nie instalują zależności ani nie korzystają z sieci. Dokumentacja `pkgdown` zawiera przykład od wejścia do interpretacji; aplikacja pod `/app/` korzysta z tego samego interfejsu i jawnie prezentuje parametry. Sprawdzenie: instalacja pakietu, uruchomienie przykładu i metod S3 oraz `R CMD check --as-cran`.

## Dane

**Generator.** `ziarno = 202711`. Ustal zdolności 20 systemów $a_s$ równomiernie od -1 do 1. Dla 100 zapytań losuj trudność $b_t\sim N(0,1)$, skalę $c_t\sim\operatorname{Lognormal}(0,0{,}5^2)$ i preferencję zadania $h_t\in\{-1,1\}$ z równymi szansami. System ma specjalizację $g_s=(-1)^s\cdot0{,}3$, a surowy wynik $m_{st}=b_t+c_t(a_s+g_sh_t+\varepsilon_{st})$, $\varepsilon\sim N(0,0{,}2^2)$. Zbiory A i B różnią się udziałem h=1: 0,2 i 0,8. Kalibrację buduj z ustalonych 12 systemów, oceniaj pozostałe 8. Target porównawczy to średnia standaryzowana na niezależnym, zbalansowanym zestawie 10000 zapytań, a nie z góry założona kolejność po samym a. Dodatkowo dodaj stałą 100 do jednego zapytania albo zwiększ jego skalę dziesięciokrotnie; testuj niezmienność po wspólnej zmianie kalibracji. Braki są odrzucane; kolumnę stałą badaj jako osobny przypadek.

**Obliczenia kontrolne.** Jedno zapytanie z wynikami kalibracji $(0{,}1,0{,}2,0{,}3)$: średnia 0,2, odchylenie 0,1, z = (-1,0,1), u = (0,1586553; 0,5; 0,8413447). Nowy system z wynikiem 0,4 ma z = 2 i u = 0,9772499 przy tej samej kalibracji. Po dodaniu go wyłącznie do oceny poprzednie u nie zmieniają się.

**Przypadki brzegowe.** Dwa systemy kalibracyjne; stała kolumna; kolumny zamienione miejscami; nowe zapytanie bez parametrów; macierz niesymetryczna wymiarowo, aby wykryć skalowanie po złej osi.

**Zbiór empiryczny.** [Reuters-21578, Distribution 1.0](https://archive.ics.uci.edu/dataset/137/reuters+21578+text+categorization+collection), DOI [10.24432/C52G6M](https://doi.org/10.24432/C52G6M), licencja CC BY 4.0 wskazana przez UCI. Dokumenty prasowe mają kategorie przypisane przez osoby indeksujące. W studium przypadku kategoria jest umownym zapytaniem, a przynależność do niej binarną oceną trafności. Jest to adaptacja zbioru klasyfikacyjnego, więc wynik dotyczy odnajdywania kategorii, a nie pełnej oceny potrzeb informacyjnych użytkownika.

Wybierz dokumenty z niepustym tekstem i oznaczeniem `TOPICS="YES"` ze zbioru testowego podziału ModApte. Zapisz identyfikatory dokumentów, wybór kategorii i liczności. Zbuduj co najmniej trzy rankingi na tej samej puli: podobieństwo tekstu do nazwy i opisu kategorii, jego wariant oparty tylko na tytule oraz ranking losowy. Ustal preprocessing i rozstrzyganie remisów identyfikatorem przed porównaniem wyników. Pełne etykiety kategorii są punktem odniesienia dla kontrolowanego ukrywania ocen. Pobranie i przekształcenie wykonaj osobnym skryptem; zachowaj opis źródła, a w testach pakietu używaj małych przykładów bez pobierania danych z sieci.

Zbuduj dwie kolekcje z rozłącznych kategorii. Dla każdej przygotuj co najmniej sześć wariantów wyszukiwania, cztery kalibracyjne i dwa oceniane, z tą samą miarą P@10 i regułą etykiet. Przy tak małej liczbie kalibratorów traktuj analizę jako sprawdzenie działania, a wpływ składu kalibracji jako główny wariant wrażliwości.

## Mapowanie na pracę

| Materiał | Część pracy |
|---|---|
| Problem zastosowania, pytanie analityczne i zakres wkładu | Wprowadzenie |
| Definicje, wzory, założenia i porównanie dostępnych rozwiązań | Rozdział 1: Podstawy metodyczne |
| Kontrakt, moduły, klasy wyniku, generator i wyniki testów | Rozdział 2: Implementacja i architektura pakietu |
| Charakterystyka danych, analiza, interpretacja i porównanie | Rozdział 3: Studium przypadku |
| Odpowiedź na pytanie, ograniczenia i kierunek rozwoju | Zakończenie |

**Wstępne pytanie analityczne.** W jakim stopniu standaryzacja ogranicza zależność oceny systemu od skali wyników i składu kolekcji przy stałym oraz zmienionym zestawie kalibratorów?

**Proponowany wkład.** Jawny, przenośny obiekt kalibracji z diagnostyką zerowych skal i eksperymentem rozdzielającym zmianę trudności od interakcji system–zadanie.

## Polecenia startowe

1. **Specyfikacja.** Ustal orientację macierzy, mianownik odchylenia i niezmienność kalibracji podczas oceniania nowego systemu. Wynik: `SPEC.md` z sygnaturami, definicjami i obsługą przypadków brzegowych. Sprawdzenie: każdy argument i każda kolumna wyniku mają opis; zakres odpowiada wskazanym częściom artykułu.
2. **Przykłady analityczne.** Sprawdź trzy u oraz nowy wynik 0,9772499 i kolumnę stałą. Wynik: testy z liczbowymi wartościami oczekiwanymi. Sprawdzenie: odtwórz rachunki na kartce lub osobnym, prostym skryptem; nie wyznaczaj oczekiwanych wartości testowaną funkcją.
3. **Walidacja.** Zapisz testy wszystkich błędów wymienionych w kontrakcie oraz poprawnych danych prowadzących do `NA`. Wynik: konstruktor wejścia i stabilne komunikaty. Sprawdzenie: błędne dane zatrzymują obliczenia, a niezdefiniowana miara ma opisany status.
4. **Rdzeń.** Wykonaj dopasowanie nazw i skalowanie po kolumnach; porównaj każdą kolumnę z osobnym rachunkiem. Wynik: działające funkcje i obiekt S3. Sprawdzenie: testy analityczne oraz porównanie z niezależną, najprostszą wersją obliczenia.
5. **Eksperyment.** Porównaj trudność, skalę i interakcje osobno; zapisz identyfikatory wszystkich kalibracji. Wynik: skrypt z konfiguracją, ziarnami i tabelą wyników. Sprawdzenie: powtórzenie daje te same dane i odtwarza tabelę; raport obejmuje wszystkie zaplanowane warianty.
6. **Udostępnienie.** Dodaj dokumentację, metodę wykresu, winietę i przykład w aplikacji. Wynik: instalowalny pakiet i działająca strona. Sprawdzenie: przykład działa po instalacji w czystej sesji R; opis odróżnia wynik liczbowy od jego interpretacji.

## Pułapki

Prawidłowy wzór może być źle wykonany przez recykling lub skalowanie po wierszach. Phi nie jest empirycznym percentylem małego zestawu kalibracji. Dodanie stałej do wszystkich systemów nie jest wiarygodnym generatorem zmiany ich kolejności. Zmiana kalibratorów może zmienić u nawet przy tych samych surowych wynikach.

Na obronie należy wyjaśnić, jak odniesienie nadaje wynikowi skalę, i ocenić, które różnice między kolekcjami standaryzacja może ograniczyć.

## Literatura

Artykuł źródłowy: `webber2008standaryzacja`.

Wprowadzenie: `manning2008ir`, `buckleyVoorhees2004incomplete`. Klucze i pełne opisy są w [`zrodla/tematy.bib`](zrodla/tematy.bib).

Środowisko: `rcore2026`. Wymagania formalne: `standardyEPI`. Źródła danych opisano w sekcji „Dane”; w pracy należy podać ich opis bibliograficzny, wersję wykorzystanego zbioru i zakres przekształceń.

Dane: `reuters21578`.
