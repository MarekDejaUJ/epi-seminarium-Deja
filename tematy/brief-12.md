# Temat 12. Ranking nagradzający nowość zamiast powtórzeń

## Metryka

| | |
|---|---|
| Artykuł źródłowy | Clarke, Charles L. A.; Kolla, Maheedhar; Cormack, Gordon V.; Vechtomova, Olga; Ashkan, Azin; Büttcher, Stefan; MacKinnon, Ian (2008). *Novelty and Diversity in Information Retrieval Evaluation*. SIGIR '08, s. 659-666 |
| Identyfikator | [10.1145/1390334.1390446](https://doi.org/10.1145/1390334.1390446) |
| Dostęp | przez bibliotekę UJ |
| Dziedzina | wyszukiwanie informacji, wieloznaczność zapytań |
| Proponowany tytuł pracy | Pakiet R do oceny różnorodności wyników wyszukiwania jako przykład zastosowania miar nowości w analizie systemów informacyjnych |
| Proponowana nazwa pakietu | `RoznorodnoscR` |
| Trudność | ●●● |

## Po co to badaczowi

Ranking może zawierać wiele trafnych dokumentów powtarzających tę samą informację. Użytkownik poszukujący obrazu zagadnienia potrzebuje także odmiennych aspektów. Miara sumująca niezależne oceny dokumentów może słabo odzwierciedlać wartość kolejnej wiadomości powielającej już przeczytaną treść.

W metodzie Clarke'a i współautorów potrzeba informacyjna jest rozłożona na aspekty. Wkład dokumentu zależy od tego, ile razy wcześniejsze pozycje pokryły dany aspekt. Parametr reguluje zmniejszanie zysku z powtórzeń, a dyskontowanie uwzględnia kolejność czytania.

Projekt pozwala porównać rankingi przy stałym zestawie aspektów i wspólnej puli kandydatów. Ważną częścią jest sprawdzenie przybliżonego wzorca normalizacji. Badacz otrzyma ocenę nowości w ramach określonej reprezentacji potrzeb, bez utożsamiania kategorii aspektów z pełnym rozumieniem użytkownika.

## Algorytm

**Wejście.** Macierz $J(d,t)\in\{0,1\}$ opisująca pokrycie aspektu t przez dokument d, pełna pula kandydatów, ranking, głębokość k i $\alpha\in[0,1]$. Aspekt jest odrębną jednostką informacji (*nugget*), którą dokument może pokrywać. Dla pozycji i niech $c_{it}=\sum_{j<i}J(d_j,t)$ oznacza wcześniejszą liczbę pokryć.

$$G_i=\sum_t J(d_i,t)(1-\alpha)^{c_{it}},\qquad
\alpha\mathrm{DCG}@k=\sum_{i=1}^{k}\frac{G_i}{\log_2(i+1)}.$$

Pierwszy wzór zmniejsza wkład aspektu po wcześniejszych pokryciach; drugi dyskontuje zysk pozycją. W interpretacji artykułu alpha jest prawdopodobieństwem faktycznego pokrycia przy pozytywnej ocenie, a $1-\alpha$ prawdopodobieństwem błędu lub braku zaspokojenia potrzeby. Dla alpha = 1 tylko pierwsze pokrycie daje zysk; przyjmij $0^0=1$ w tym konkretnym przypadku. Dla alpha = 0 zysk jest sumą pokryć aspektów, co nie jest automatycznie klasycznym DCG z wykładniczą skalą ocen.

**Normalizacja.** Zbuduj ranking zachłanny z całej wspólnej puli: na każdej pozycji wybierz pozostały dokument z największym aktualnym zyskiem, a remis rozstrzygnij identyfikatorem. Po jego wyborze zaktualizuj liczniki pokryć. Nie buduj innego wzorca z listy odnalezionej przez każdy system.

$$x=\frac{\alpha\mathrm{DCG}@k}{\alpha\mathrm{DCG}_{\rm zachlanny}@k},\qquad
\alpha\mathrm{nDCG}@k=\min(1,x).$$

Zachłanny wzorzec jest przybliżony, więc x może przekroczyć 1. Artykuł zalicza taki ranking jak wzorzec idealny. Zachowaj x i flagę przekroczenia w wyniku, aby ograniczenie nie ukrywało jakości przybliżenia. Jeśli mianownik jest zerowy, iloraz jest niezdefiniowany i wynosi `NA` z opisem. Do kontroli małych pul dodaj wzorzec dokładny przez enumerację permutacji, bez nazywania zachłannego wyniku dokładnym optimum.

Koszt oceny $O(kT)$, wzorca zachłannego $O(kMT)$ dla M dokumentów i T aspektów; dokładny wzorzec rośnie jak liczba permutacji M po k. Wynik zależy od zdefiniowanych aspektów, jakości ich ocen i wspólnej puli. Wybrany ranking może pokryć inne potrzeby niż zapisane w macierzy J.

## Kontrakt

`pokrycie`: macierz dokument × aspekt, wyłącznie 0/1, bez braków, unikatowe nazwy obu osi. `ranking`: unikatowe identyfikatory należące do puli. `k` dodatnie całkowite, nie większe od liczby dokumentów w puli; krótszy ranking uzupełnia się zerowym zyskiem. `alpha` skończone w [0,1]. Wszystkie porównywane systemy mają tę samą pulę, aspekty, k i alpha. `NA` nie oznacza nieobecności aspektu, więc podstawowy wariant go odrzuca.

Niezmienniki: zyski nieujemne; ponowne pokrycie nie zwiększa jego własnego marginalnego wkładu przy alpha > 0; wynik ograniczony w [0,1], surowy iloraz może być większy od 1; wzorzec dokładny nie gorszy niż zachłanny. Macierz zerowa jest poprawnym wejściem, daje DCG = 0 i nDCG = `NA`, `zerowy_wzorzec`, a nie błąd.

S3 `ocena_roznorodnosci`: `dcg`, `wzorzec_dcg`, `iloraz`, `ndcg`, `ranking_wzorcowy`, `zyski`, `parametry`, `diagnostyka`, `status`. Błędy: „Pokrycie musi zawierać wyłącznie 0 i 1”, „Dokument rankingu nie występuje w puli”, „Ranking zawiera powtórzony dokument”, „Parametr alpha musi należeć do [0, 1]”.

## Plan pakietu

Pakiet `RoznorodnoscR`, licencja GPL-3. Publiczne funkcje:

- `przygotuj_aspekty(pokrycie, ranking)` – wspólna pula i walidacja.
- `oblicz_alfa_dcg(dane, alpha = 0.5, k = 10)` – zyski i suma.
- `ranking_zachlanny(pokrycie, alpha = 0.5, k = 10)` – przybliżony wzorzec.
- `oblicz_alfa_ndcg(dane, alpha = 0.5, k = 10)` – iloraz, ograniczenie i diagnostyka.
- `wzorzec_dokladny(pokrycie, alpha, k)` – tylko pule do ośmiu dokumentów.
- `generuj_aspekty(ziarno = 202712)` – kontrolowane pokrycia.

Moduły: `R/aspekty.R`, `R/zyski.R`, `R/wzorce.R`, `R/normalizacja.R`, `R/generator.R`, `R/metody_s3.R`. Klasa S3 `ocena_roznorodnosci` ma metody `print()`, `summary()` i `plot()`: skrócony wynik, zestawienie diagnostyki oraz wykres zgodny z rodzajem wyniku. Wartości i parametry pozostają dostępne bez odczytywania tekstu wydruku.

`Imports`: `stats`. `Suggests`: `testthat`, `knitr`, `rmarkdown`, `pkgdown`, `shiny`. Funkcje obliczeniowe nie instalują zależności ani nie korzystają z sieci. Dokumentacja `pkgdown` zawiera przykład od wejścia do interpretacji; aplikacja pod `/app/` korzysta z tego samego interfejsu i jawnie prezentuje parametry. Sprawdzenie: instalacja pakietu, uruchomienie przykładu i metod S3 oraz `R CMD check --as-cran`.

## Dane

**Generator.** `ziarno = 202712`. Dla 50 zapytań utwórz 100 dokumentów i 6 aspektów. Przydziel dokumentowi dominujący aspekt równomiernie; pokrywa go z prawdopodobieństwem 0,9, każdy inny z 0,05. Zbuduj ranking preferujący jeden aspekt i ranking przeplatający sześć aspektów, bez zmiany macierzy. Zadaj alpha = 0, 0,5, 1 i k = 5, 10, 20. Prawdą konstrukcyjną są pokrycia, zyski i dokładny wzorzec w osobnych pulach 4–8 dokumentów. Nie zakładaj, że przeplatanie zawsze wygrywa przy każdym losowym pokryciu. Dodaj 10% całkowicie niepokrywających dokumentów i powielone wektory pokrycia z różnymi identyfikatorami; braków nie imputuj.

**Obliczenia kontrolne.** Dwa aspekty, dokumenty a=(1,0), b=(1,0), c=(0,1), alpha = 1, k = 2: DCG(a,b)=1, DCG(a,c)=$1+1/\log_2 3=1{,}63092975$, nDCG(a,b)=0,61314719. Przy alpha = 0,5 DCG(a,b)=$1+0{,}5/\log_2 3=1{,}31546488$.

Kontrprzykład dla zachłanności: a={1,2,3,4}, b={1,2,5}, c={3,4,6}, alpha = 1, k = 2. Wzorzec zachłanny (a,b) ma DCG = 4,63092975, ranking (b,c) 4,89278926. Surowy iloraz wynosi 1,05654577, wynik ograniczony 1. Enumeracja wszystkich sześciu uporządkowanych par potwierdza dokładne optimum.

**Przypadki brzegowe.** Macierz zerowa; pojedynczy aspekt; alpha = 1 i pierwsze pokrycie; krótszy ranking; dokument spoza puli; wiele identycznych wektorów pokrycia.

**Zbiór empiryczny.** [Reuters-21578, Distribution 1.0](https://archive.ics.uci.edu/dataset/137/reuters+21578+text+categorization+collection), DOI [10.24432/C52G6M](https://doi.org/10.24432/C52G6M), licencja CC BY 4.0 wskazana przez UCI. Dokumenty prasowe mają kategorie przypisane przez osoby indeksujące. W studium przypadku kategoria jest umownym zapytaniem, a przynależność do niej binarną oceną trafności. Jest to adaptacja zbioru klasyfikacyjnego, więc wynik dotyczy odnajdywania kategorii, a nie pełnej oceny potrzeb informacyjnych użytkownika.

Wybierz dokumenty z niepustym tekstem i oznaczeniem `TOPICS="YES"` ze zbioru testowego podziału ModApte. Zapisz identyfikatory dokumentów, wybór kategorii i liczności. Zbuduj co najmniej trzy rankingi na tej samej puli: podobieństwo tekstu do nazwy i opisu kategorii, jego wariant oparty tylko na tytule oraz ranking losowy. Ustal preprocessing i rozstrzyganie remisów identyfikatorem przed porównaniem wyników. Pełne etykiety kategorii są punktem odniesienia dla kontrolowanego ukrywania ocen. Pobranie i przekształcenie wykonaj osobnym skryptem; zachowaj opis źródła, a w testach pakietu używaj małych przykładów bez pobierania danych z sieci.

W tym temacie wybierz dokumenty z kategorii `earn`, `acq`, `money-fx` i `trade`. Kategorie są aspektami umownego zapytania o informacje gospodarcze; dokument może pokrywać więcej niż jedną. Ustal wspólną pulę do 500 dokumentów przed budową rankingów. Wnioski dotyczą różnorodności tych kategorii, a nie automatycznie potrzeb konkretnego użytkownika.

## Mapowanie na pracę

| Materiał | Część pracy |
|---|---|
| Problem zastosowania, pytanie analityczne i zakres wkładu | Wprowadzenie |
| Definicje, wzory, założenia i porównanie dostępnych rozwiązań | Rozdział 1: Podstawy metodyczne |
| Kontrakt, moduły, klasy wyniku, generator i wyniki testów | Rozdział 2: Implementacja i architektura pakietu |
| Charakterystyka danych, analiza, interpretacja i porównanie | Rozdział 3: Studium przypadku |
| Odpowiedź na pytanie, ograniczenia i kierunek rozwoju | Zakończenie |

**Wstępne pytanie analityczne.** Jak siła kary za powtórzenia i przybliżony wzorzec normalizacji zmieniają ocenę rankingów o odmiennej strukturze pokrycia aspektów?

**Proponowany wkład.** Sprawdzony rachunek nowości z jawną pulą, diagnostyką ilorazu ponad 1 i dokładną kontrolą przybliżenia na małych danych.

## Polecenia startowe

1. **Specyfikacja.** Rozpisz liczniki poprzednich pokryć, interpretację alpha i regułę ograniczenia ilorazu. Wynik: `SPEC.md` z sygnaturami, definicjami i obsługą przypadków brzegowych. Sprawdzenie: każdy argument i każda kolumna wyniku mają opis; zakres odpowiada wskazanym częściom artykułu.
2. **Przykłady analityczne.** Sprawdź trzy DCG i kontrprzykład zachłanności, enumerując uporządkowane pary. Wynik: testy z liczbowymi wartościami oczekiwanymi. Sprawdzenie: odtwórz rachunki na kartce lub osobnym, prostym skryptem; nie wyznaczaj oczekiwanych wartości testowaną funkcją.
3. **Walidacja.** Zapisz testy wszystkich błędów wymienionych w kontrakcie oraz poprawnych danych prowadzących do `NA`. Wynik: konstruktor wejścia i stabilne komunikaty. Sprawdzenie: błędne dane zatrzymują obliczenia, a niezdefiniowana miara ma opisany status.
4. **Rdzeń.** Najpierw oblicz zyski dla zadanego rankingu, potem niezależny wzorzec i diagnostykę normalizacji. Wynik: działające funkcje i obiekt S3. Sprawdzenie: testy analityczne oraz porównanie z niezależną, najprostszą wersją obliczenia.
5. **Eksperyment.** Porównaj alpha i k na stałej puli; w małych pulach zmierz lukę między wzorcem dokładnym a zachłannym. Wynik: skrypt z konfiguracją, ziarnami i tabelą wyników. Sprawdzenie: powtórzenie daje te same dane i odtwarza tabelę; raport obejmuje wszystkie zaplanowane warianty.
6. **Udostępnienie.** Dodaj dokumentację, metodę wykresu, winietę i przykład w aplikacji. Wynik: instalowalny pakiet i działająca strona. Sprawdzenie: przykład działa po instalacji w czystej sesji R; opis odróżnia wynik liczbowy od jego interpretacji.

## Pułapki

Odwrócenie interpretacji alpha prowadzi do odwrócenia modelu nowości. Algorytm zachłanny nie gwarantuje optimum. Przycięcie ilorazu bez zachowania jego wartości ukrywa informację. Zmiana puli wzorca między systemami unieważnia wspólne odniesienie. Przy wielu kategoriach szczegółowość aspektów staje się decyzją analityczną.

Na obronie należy omówić kompromis trafności i nowości, przejść przez aktualizację zysku i wyjaśnić ograniczenia normalizacji przybliżonej.

## Literatura

Artykuł źródłowy: `clarke2008novelty`.

Wprowadzenie: `manning2008ir`, `chapelle2009err`. Klucze i pełne opisy są w [`zrodla/tematy.bib`](zrodla/tematy.bib).

Środowisko: `rcore2026`. Wymagania formalne: `standardyEPI`. Źródła danych opisano w sekcji „Dane”; w pracy należy podać ich opis bibliograficzny, wersję wykorzystanego zbioru i zakres przekształceń.

Dane: `reuters21578`.
