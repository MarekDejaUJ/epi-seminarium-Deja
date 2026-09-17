# Temat 04. Indeks przełomowości jako miara wyparcia

## Metryka

| | |
|---|---|
| Artykuł źródłowy | Lin, Yiling; Li, Linzhuo; Wu, Lingfei (2026). *The Disruption Index Measures Displacement Between a Paper and Its Most Cited Reference*. Quantitative Science Studies 7, s. 229–239 |
| Identyfikator | [10.1162/QSS.a.409](https://doi.org/10.1162/QSS.a.409), preprint [arXiv:2504.04677](https://arxiv.org/abs/2504.04677) |
| Dostęp | otwarty (preprint) |
| Dziedzina | bibliometria, polityka naukowa |
| Proponowany tytuł pracy | Pakiet R do analizy przełomowości publikacji jako przykład zastosowania operacji na macierzach rzadkich w badaniach nad nauką |
| Proponowana nazwa pakietu | `WyparcieR` |
| Trudność | ●● |

## Po co to badaczowi

Klasyczny indeks przełomowości opisuje, czy późniejsze prace cytują publikację bez jej źródeł, czy razem z nimi. W interpretacji bibliometrycznej pomijanie źródeł bywa łączone z wyparciem wcześniejszej linii badań. Jedna liczba może jednak mieszać bilans bezpośrednich cytowań z popularnością całego otoczenia źródeł.

Lin, Li i Wu analizują tę konstrukcję i wskazują związek indeksu z najczęściej cytowanym źródłem. Do sprawdzenia tej interpretacji potrzebne są osobne liczności kategorii, bilans bezpośrednio cytujących i relacja popularności źródła do popularności publikacji. Dokładną tożsamość wynikającą z definicji należy oddzielić od przybliżeń stwierdzonych empirycznie.

Własny pakiet ma udostępniać te składowe i umożliwiać porównanie okien cytowań oraz kompletności sieci. Badacz może dzięki temu rozpoznać, dlaczego zmienił się indeks. Wynik dotyczy wzorca cytowania, a ocena nowości treści wymaga dodatkowych dowodów.

## Algorytm

**Wejście.** Skierowana sieć cytowań, lista publikacji analizowanych i wspólne okno przyszłych cytowań. Krawędź `cytujacy -> cytowany` oznacza odwołanie. Dla publikacji $p$ niech $F$ oznacza zbiór prac cytujących $p$, a $B$ zbiór prac cytujących co najmniej jedno źródło $p$. Oba zbiory dotyczą tego samego okna. Policz $N_i=|F\setminus B|$, $N_j=|F\cap B|$, $N_k=|B\setminus F|$.

$$D_p=\frac{N_i-N_j}{N_i+N_j+N_k},\qquad d_p=\frac{N_i-N_j}{N_i+N_j},\qquad R_k=\frac{N_k}{N_i+N_j}.$$

$D_p$ jest klasycznym indeksem, $d_p$ wyraża bilans pomijania i współcytowania źródeł wśród bezpośrednio cytujących, a $R_k$ stosunek cytujących tylko źródła do cytujących publikację. Przy dodatnich mianownikach zachodzi dokładna tożsamość $D_p=d_p/(1+R_k)$.

Niech $C_p=|F|$, a $C_{\max}$ będzie największą liczbą cytowań pojedynczego źródła $p$ w tym samym oknie.

$$b_p=C_{\max}/C_p.$$

Wielkość $b_p$ jest czynnikiem związanym z najczęściej cytowanym źródłem. Przybliżenia łączące $R_k$ z $b_p$ w artykule mają charakter empiryczny; współczynnik około 2,5 nie jest stałą wynikającą z definicji. $d_p$ odnosi się do całego zbioru źródeł, a nie tylko do najczęściej cytowanego.

Kroki: sprawdź kierunek i identyfikatory relacji, usuń duplikaty krawędzi, ustal źródła i przyszłych cytujących, wykonaj operacje na zbiorach, policz indeksy i diagnostykę mianowników. Porównanie kilku okien stanowi analizę wrażliwości. Nie usuwaj cytowań autorów własnych bez jawnej, osobnej reguły; nie myl ich z krawędzią publikacji do samej siebie.

Dla pojedynczej publikacji koszt zależy od liczby jej źródeł i odczytanych krawędzi ich cytowania. Macierze rzadkie są opcją implementacji, ale ich iloczyny mogą zwiększyć zużycie pamięci. Przetwarzanie blokami i pomiar czasu oraz pamięci są ważniejsze od zakazu pętli. Miara nie dowodzi przełomu intelektualnego ani wyparcia przyczynowego.

## Kontrakt

Tabela `krawedzie` ma niepuste identyfikatory `cytujacy`, `cytowany`, tabela `publikacje` unikatowe `id`, `rok`; bez `NA` w identyfikatorach i latach potrzebnych do okna. Brak rekordu źródła lub niekompletną listę odwołań należy zgłosić. Duplikaty krawędzi usuwa konstruktor z podaniem liczby. Krawędź do samej publikacji zatrzymuje wykonanie. `okno` jest dodatnią liczbą całkowitą; podstawowy wariant to lata od `rok + 1` do `rok + okno`, z wyłączeniem cytowań w roku publikacji.

Niezmienniki: zbiory kategorii są rozłączne, liczności nieujemne, $D,d\in[-1,1]$, $R_k,b_p\ge0$ tam, gdzie są określone. $N_i+N_j+N_k=0$ daje `D=NA`. Przy $C_p=0$ i $N_k>0$ zachowaj `D=0`, a `d`, `Rk`, `bp=NA`. Brak źródeł daje `bp=NA`; wzór D przy $C_p>0$ daje 1, lecz taki przypadek oznacz `brak_zrodel`, aby nie interpretować go jak dowodu przełomu. Błąd kompletności sieci jest odrębnym statusem.

S3 `wyparcie_cytowan`: tabela `id`, `Ni`, `Nj`, `Nk`, `Cp`, `Cmax`, `D`, `d`, `Rk`, `bp`, `status`; `parametry` i `diagnostyka`. Błędy: „Identyfikatory publikacji muszą być jednoznaczne”, „Krawędź nie może wskazywać tej samej publikacji”, „Brak metadanych potrzebnych do okna cytowań”, „Okno musi być dodatnią liczbą całkowitą”.

## Plan pakietu

Pakiet `WyparcieR`, licencja GPL-3. Publiczne funkcje:

- `przygotuj_siec(krawedzie, publikacje)` – sprawdzenie kierunku i metadanych.
- `oblicz_wyparcie(siec, cele, okno = 5)` – liczności, D, d, Rk i bp.
- `porownaj_okna(siec, cele, okna = c(3, 5, 10))` – wspólna tabela wariantów.
- `generuj_siec(n = 1000, ziarno = 202704)` – sieć z kontrolowanymi otoczeniami.

Moduły: `R/siec.R`, `R/zbiory_cytowan.R`, `R/wyparcie.R`, `R/generator.R`, `R/metody_s3.R`. Klasa S3 `wyparcie_cytowan` ma metody `print()`, `summary()` i `plot()`: skrócony wynik, zestawienie diagnostyki oraz wykres zgodny z rodzajem wyniku. Wartości i parametry pozostają dostępne bez odczytywania tekstu wydruku.

`Imports`: `stats`; `Matrix` tylko przy wyborze implementacji macierzowej. `Suggests`: `testthat`, `knitr`, `rmarkdown`, `pkgdown`, `shiny`. Funkcje obliczeniowe nie instalują zależności ani nie korzystają z sieci. Dokumentacja `pkgdown` zawiera przykład od wejścia do interpretacji; aplikacja pod `/app/` korzysta z tego samego interfejsu i jawnie prezentuje parametry. Sprawdzenie: instalacja pakietu, uruchomienie przykładu i metod S3 oraz `R CMD check --as-cran`.

## Dane

**Generator.** `ziarno = 202704`. Utwórz 1000 publikacji z rokiem równym $2000+\lfloor(i-1)/50\rfloor$. Każda od 2001 r. wybiera bez zwracania do pięciu wcześniejszych publikacji, z prawdopodobieństwem proporcjonalnym do $1+$ aktualna liczba cytowań. Następnie dołącz 20 odrębnych składowych, każdą z nowym celem, jego dwoma własnymi źródłami i przyszłymi cytującymi o dokładnie znanych $N_i,N_j,N_k$, np. $(10,0,10)$, $(0,10,10)$ i $(5,5,90)$; Składowe nie łączą się z bazową siecią, a identyfikatory nowych prac nie mogą się pokrywać. Zadaj lata źródeł wcześniejsze od celu, a przyszłych cytujących od roku celu + 1 do + 5. To prawda konstrukcyjna dotycząca liczności i indeksów, bez twierdzenia o rzeczywistej nowości prac. Osobno usuń losowo 5% i 20% krawędzi oraz odetnij cytowania po trzecim roku, zachowując pełną sieć jako wzorzec.

**Obliczenia kontrolne.** $(N_i,N_j,N_k)=(1,0,1)$ daje $D=0{,}5$, $d=1$, $R_k=1$. $(0,0,1)$ daje $D=0$, pozostałe dwa wskaźniki `NA`. $(2,1,3)$ daje $D=1/6$, $d=1/3$, $R_k=1$; jeśli $C_{\max}=5$, to $b_p=5/3$. $(0,0,0)$ daje `D=NA`.

**Przypadki brzegowe.** Brak źródeł; brak przyszłych cytowań; powtórzone krawędzie; brakujący rok; jedna praca cytująca wiele źródeł, liczona do B tylko raz; bardzo popularne źródło powodujące duży zbiór B.

**Zbiór empiryczny.** [OpenAlex](https://openalex.org/), metadane w zwykłym formacie OpenAlex na licencji [CC0](https://github.com/ourresearch/openalex-docs/blob/main/license.md). Wybierz 20 publikacji z jednego podobszaru nauk społecznych, opublikowanych w 2015 r., i pięcioletnie okno cytowań. Zachowaj listę identyfikatorów oraz datę i parametry pobrania. Zgromadź źródła każdej publikacji oraz prace z lat 2016–2020 cytujące publikację lub choć jedno z jej źródeł. Tego otoczenia nie ograniczaj do wybranego podobszaru. Nieobecny rekord lub niedostępna lista źródeł oznacza brak informacji, a nie brak cytowania.

Pobranie jest osobnym etapem, poza funkcjami obliczeniowymi i testami pakietu. Zachowaj surowe odpowiedzi i odtwarzalny skrypt budowy tabeli krawędzi. Porównuj publikacje przy tym samym oknie i tej samej regule wyłączeń; liczności dotyczą zarejestrowanych relacji, a nie wszystkich cytowań istniejących poza bazą.

## Mapowanie na pracę

| Materiał | Część pracy |
|---|---|
| Problem zastosowania, pytanie analityczne i zakres wkładu | Wprowadzenie |
| Definicje, wzory, założenia i porównanie dostępnych rozwiązań | Rozdział 1: Podstawy metodyczne |
| Kontrakt, moduły, klasy wyniku, generator i wyniki testów | Rozdział 2: Implementacja i architektura pakietu |
| Charakterystyka danych, analiza, interpretacja i porównanie | Rozdział 3: Studium przypadku |
| Odpowiedź na pytanie, ograniczenia i kierunek rozwoju | Zakończenie |

**Wstępne pytanie analityczne.** Jak cytowania źródeł i długość okna zmieniają klasyczny indeks D, bilans d oraz czynnik bp przy stałych cytowaniach publikacji?

**Proponowany wkład.** Wspólny rachunek wszystkich składowych, jawna diagnostyka zerowych mianowników oraz eksperyment oddzielający tożsamość matematyczną od empirycznej zależności z bp.

## Polecenia startowe

1. **Specyfikacja.** Zdefiniuj kierunek krawędzi, zbiory F i B oraz pięć wskaźników i okno. Wynik: `SPEC.md` z sygnaturami, definicjami i obsługą przypadków brzegowych. Sprawdzenie: każdy argument i każda kolumna wyniku mają opis; zakres odpowiada wskazanym częściom artykułu.
2. **Przykłady analityczne.** Dodaj cztery przypadki liczności, test deduplikacji i cytowania wielu źródeł przez tę samą pracę. Wynik: testy z liczbowymi wartościami oczekiwanymi. Sprawdzenie: odtwórz rachunki na kartce lub osobnym, prostym skryptem; nie wyznaczaj oczekiwanych wartości testowaną funkcją.
3. **Walidacja.** Zapisz testy wszystkich błędów wymienionych w kontrakcie oraz poprawnych danych prowadzących do `NA`. Wynik: konstruktor wejścia i stabilne komunikaty. Sprawdzenie: błędne dane zatrzymują obliczenia, a niezdefiniowana miara ma opisany status.
4. **Rdzeń.** Najpierw wykonaj operacje na zbiorach dla jednego celu; wersję blokową sprawdź względem tej referencji. Wynik: działające funkcje i obiekt S3. Sprawdzenie: testy analityczne oraz porównanie z niezależną, najprostszą wersją obliczenia.
5. **Eksperyment.** Zestaw pełną i przerzedzoną sieć oraz różne okna; zmierz również zużycie pamięci. Wynik: skrypt z konfiguracją, ziarnami i tabelą wyników. Sprawdzenie: powtórzenie daje te same dane i odtwarza tabelę; raport obejmuje wszystkie zaplanowane warianty.
6. **Udostępnienie.** Dodaj dokumentację, metodę wykresu, winietę i przykład w aplikacji. Wynik: instalowalny pakiet i działająca strona. Sprawdzenie: przykład działa po instalacji w czystej sesji R; opis odróżnia wynik liczbowy od jego interpretacji.

## Pułapki

Jedna praca cytująca kilka źródeł nie jest kilkoma przyszłymi pracami. Brak bezpośrednich cytowań nie zawsze oznacza niezdefiniowany D. Wartości bp i Rk nie są identyczne; empiryczne przybliżenie nie może być niezmiennikiem testowym. Przestawienie roli publikacji i jej źródła nie gwarantuje zmiany znaku miary.

Na obronie należy omówić, jakie wzorce cytowań stoją za tą samą wartością D, dlaczego trzeba odczytywać składowe i jak niekompletność sieci ogranicza interpretację.

## Literatura

Artykuł źródłowy: `lin2026disruption`.

Wprowadzenie: `funk2017dynamic`, `leydesdorff2019i3`. Klucze i pełne opisy są w [`zrodla/tematy.bib`](zrodla/tematy.bib).

Środowisko: `rcore2026`. Wymagania formalne: `standardyEPI`. Źródła danych opisano w sekcji „Dane”; w pracy należy podać ich opis bibliograficzny, wersję wykorzystanego zbioru i zakres przekształceń.

Dane: `openalexData`.
