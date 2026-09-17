# Temat 14. Rozkład przełomowości na destabilizację i konsolidację

## Metryka

| | |
|---|---|
| Artykuł źródłowy | Xu, Shuo; Wang, Congcong; An, Xin; Liu, Jianhua (2025). *CrossDI: A comprehensive dataset crossing three databases for calculating disruption indexes*. Scientific Data |
| Identyfikator | [10.1038/s41597-025-06232-w](https://doi.org/10.1038/s41597-025-06232-w) |
| Dostęp | otwarty |
| Dziedzina | bibliometria, polityka naukowa i technologiczna |
| Proponowany tytuł pracy | Pakiet R do porównawczego liczenia wskaźników przełomowości jako przykład zastosowania złączeń dwudzielnych w analizie danych bibliograficznych |
| Proponowana nazwa pakietu | `PrzelomoweR` |
| Trudność | ●● |

## Po co to badaczowi

Sieć cytowań zależy od pokrycia bazy i sposobu dopasowania odwołań. Ta sama publikacja może mieć inne otoczenie w Web of Science, Dimensions i OpenCitations. Przed interpretacją wskaźnika trzeba więc rozpoznać, czy różnica wynika z konstrukcji miary, z okna czasowego czy z dostępnych relacji.

CrossDI zawiera otoczenia publikacji w trzech bazach i kod obliczający wskaźniki. Artykuł rozróżnia klasyczny indeks liczony względem unii źródeł oraz miary D i C uśredniane po pojedynczych źródłach. Pierwsza składowa opisuje cytujących publikację bez danego źródła, druga współcytujących. Średnie po źródłach mają inną konstrukcję niż proste rozłożenie globalnego indeksu na dwa ułamki.

Projekt służy do poprawnego odtworzenia tych definicji i zbadania wrażliwości na dane. Badacz otrzymuje liczności, wyniki cząstkowe i informację o kompletności. Nie ma podstaw, aby wynik automatycznie utożsamiać z przełomowością treści; mierzone są wzorce odwołań zarejestrowane w określonym źródle danych.

## Algorytm

**Wejście.** Sieć z oznaczeniem bazy, publikacje analizowane, ich źródła oraz wspólne okno przyszłych cytowań. Krawędź jest skierowana od cytującego do cytowanego. Dla publikacji p niech F będzie zbiorem jej przyszłych cytujących, a $B_i$ zbiorem przyszłych cytujących pojedyncze źródło i, dla i=1..n. Zbiory muszą obejmować także prace spoza dziedziny publikacji p.

**Indeks globalny.** Dla $B=\bigcup_i B_i$ policz $N_i=|F\setminus B|$, $N_j=|F\cap B|$, $N_k=|B\setminus F|$.

$$DI=(N_i-N_j)/(N_i+N_j+N_k).$$

To klasyczny indeks liczony względem wszystkich źródeł razem. Globalne ułamki $N_i/(N_i+N_j+N_k)$ i $N_j/(N_i+N_j+N_k)$ różnią się o DI, lecz nie są D i C z CrossDI.

**Miary po źródłach.** Dla każdego i oblicz $NF_i=|F\setminus B_i|$, $NB_i=|F\cap B_i|$, $NR_i=|B_i\setminus F|$ i $T_i=NF_i+NB_i+NR_i$.

$$D=\frac1n\sum_{i=1}^n\frac{NF_i}{T_i},\qquad
C=\frac1n\sum_{i=1}^n\frac{NB_i}{T_i}.$$

D jest średnią udziałów cytujących publikację bez określonego źródła; C średnią udziałów współcytujących. Każde źródło ma równą wagę, niezależnie od jego liczby cytowań. Różnica D-C nie jest ogólnie równa globalnemu DI.

Kroki: dopasuj identyfikatory wewnątrz i między bazami przy zachowaniu pochodzenia, sprawdź kompletność list źródeł, policz zbiory globalne i per źródło, zachowaj wyniki cząstkowe, zagreguj D,C i porównaj bazy na wspólnym zbiorze celów oraz wspólnym oknie. Źródło nieodnalezione w bazie jest brakiem danych, a nie źródłem z zerowymi cytowaniami. Nie używaj liczby dostępnych źródeł z jednej bazy jako liczby pełnych źródeł we wszystkich bazach.

Koszt dla jednego celu zależy od sumy rozmiarów F i odczytanych $B_i$; prosta wersja zbiorowa wymaga powtarzania przecięć dla n źródeł. Nie materializuj pełnej gęstej macierzy sieci. Zmierz czas i pamięć wersji blokowej oraz zgodność z prostym rachunkiem. Nie dodawaj normalizacji dziedzinowej bez odrębnej definicji, odniesienia i celu analizy.

## Kontrakt

Tabela `krawedzie`: `baza`, `cytujacy`, `cytowany`; `publikacje`: `baza`, `id`, `rok`; identyfikatory kompletne i jednoznaczne wewnątrz bazy. Odtwarzalna tabela dopasowania celów między bazami. Podstawowe okno: od roku publikacji + 1 do roku + `okno`, jednakowe dla F i wszystkich $B_i$. Duplikaty krawędzi usuwa konstruktor z raportem. Nieznana kompletność bibliografii oznacza status wymagający wyjaśnienia i wyłączenie z porównania wymagającego pełnych źródeł.

Niezmienniki: DI w [-1,1], D,C w [0,1], D+C <= 1 tam, gdzie określone; zgodność sum z wynikami cząstkowymi; przestawienie kolejności źródeł nie zmienia średnich. Dla n = 0 D,C = `NA`, `brak_zrodel`. Przy $T_i=0$ zachowaj cząstkowe `NA`; podstawowe D,C także `NA`, zamiast cichego usunięcia źródła i zmiany mianownika n. Ewentualna średnia po określonych źródłach jest osobnym wynikiem z liczbą wyłączeń. Globalny mianownik zerowy daje DI = `NA`.

S3 `przelomowosc`: `globalne`, `po_zrodlach`, `skladowe`, `porownanie_baz`, `kompletnosc`, `parametry`, `status`. Błędy: „Brak jednoznacznego dopasowania publikacji między bazami”, „Brak metadanych potrzebnych do wspólnego okna”, „Krawędź nie może wskazywać tej samej publikacji”, „Okno musi być dodatnią liczbą całkowitą”. Nie wymagaj tożsamości D-C = DI.

## Plan pakietu

Pakiet `PrzelomoweR`, licencja GPL-3. Publiczne funkcje:

- `przygotuj_cytowania(krawedzie, publikacje, dopasowanie)` – pochodzenie i identyfikatory.
- `oblicz_di(siec, cele, okno = 5)` – globalne liczności i DI.
- `oblicz_skladowe(siec, cele, okno = 5)` – NF,NB,NR per źródło oraz D,C.
- `porownaj_bazy(wyniki, wspolne_cele = TRUE)` – zestawienie z informacją o brakach.
- `generuj_bazy(ziarno = 202714)` – pełna sieć i kontrolowane obserwacje.

Moduły: `R/dopasowanie.R`, `R/siec.R`, `R/di.R`, `R/skladowe.R`, `R/porownanie.R`, `R/generator.R`, `R/metody_s3.R`. Klasa S3 `przelomowosc` ma metody `print()`, `summary()` i `plot()`: skrócony wynik, zestawienie diagnostyki oraz wykres zgodny z rodzajem wyniku. Wartości i parametry pozostają dostępne bez odczytywania tekstu wydruku.

`Imports`: `stats`; `Matrix` wyłącznie dla wybranego wariantu macierzowego. `Suggests`: `testthat`, `knitr`, `rmarkdown`, `pkgdown`, `shiny`. Funkcje obliczeniowe nie instalują zależności ani nie korzystają z sieci. Dokumentacja `pkgdown` zawiera przykład od wejścia do interpretacji; aplikacja pod `/app/` korzysta z tego samego interfejsu i jawnie prezentuje parametry. Sprawdzenie: instalacja pakietu, uruchomienie przykładu i metod S3 oraz `R CMD check --as-cran`.

## Dane

**Generator.** `ziarno = 202714`. Dla 30 celów utwórz po trzy źródła i po 100 przyszłych publikacji w latach 1–5 po celu. Każda przyszła praca cytuje cel z prawdopodobieństwem 0,2. Warunkowo po cytowaniu celu cytuje każde źródło z prawdopodobieństwem 0,5, w przeciwnym razie 0,1. Pełna sieć stanowi prawdę konstrukcyjną dla DI,D,C. Utwórz trzy umowne bazy: pełną, z 10% i z 30% usuniętych krawędzi; osobno wariant usuwający częściej relacje do źródeł. Porównanie takich baz jest eksperymentem z pokryciem, nie modelem rzeczywistych różnic trzech dostawców. Powtarzaj 200 razy; zachowaj wyniki cząstkowe i listę usuniętych krawędzi. Brak rekordu źródła testuj oddzielnie od braku relacji.

**Obliczenie kontrolne.** F={a,b}, $B_1$={a,c}, $B_2$={d}. Globalnie $N_i=1,N_j=1,N_k=2$, więc DI=0. Dla źródła 1: $(NF,NB,NR)=(1,1,1)$; dla źródła 2: (2,0,1). D=$\tfrac12(1/3+2/3)=1/2$, C=$\tfrac12(1/3+0)=1/6$, więc D-C=1/3. Globalne ułamki wynoszą 1/4 i 1/4. Ten przykład musi wystąpić w testach i dokumentacji, ponieważ odróżnia definicje.

**Przypadki brzegowe.** Brak źródeł; F pusty przy niepustych $B_i$; jedno źródło bez przyszłych cytujących i pusty F; współcytowanie kilku źródeł przez jedną pracę; brak rekordu w jednej bazie; niejednoznaczne dopasowanie DOI.

**Zbiór empiryczny.** [OpenAlex](https://openalex.org/), metadane w zwykłym formacie OpenAlex na licencji [CC0](https://github.com/ourresearch/openalex-docs/blob/main/license.md). Wybierz 20 publikacji z jednego podobszaru nauk społecznych, opublikowanych w 2015 r., i pięcioletnie okno cytowań. Zachowaj listę identyfikatorów oraz datę i parametry pobrania. Zgromadź źródła każdej publikacji oraz prace z lat 2016–2020 cytujące publikację lub choć jedno z jej źródeł. Tego otoczenia nie ograniczaj do wybranego podobszaru. Nieobecny rekord lub niedostępna lista źródeł oznacza brak informacji, a nie brak cytowania.

Pobranie jest osobnym etapem, poza funkcjami obliczeniowymi i testami pakietu. Zachowaj surowe odpowiedzi i odtwarzalny skrypt budowy tabeli krawędzi. Porównuj publikacje przy tym samym oknie i tej samej regule wyłączeń; liczności dotyczą zarejestrowanych relacji, a nie wszystkich cytowań istniejących poza bazą.

Z otwartego pobrania utwórz pełną sieć i dwie kontrolowane wersje z ograniczonym pokryciem. Jest to podstawowe studium wrażliwości na danych empirycznych. Do porównania rzeczywistych baz służy [CrossDI, wersja 1](https://doi.org/10.6084/m9.figshare.30356599.v1), na licencji CC BY 4.0 wskazanej w rekordzie Figshare. Wybierz 10 celów obecnych we wszystkich trzech bazach, z pełnymi dostępnymi otoczeniami. Uzgodnij nazwy pól, kierunek cytowań i okno z opisem zbioru; opublikowany wynik indeksu nie zastępuje potrzebnej listy relacji. Nie jest potrzebny własny dostęp do zamkniętych baz, jeśli odpowiednie otoczenia są już w zbiorze. Wykonaj najpierw reprodukcję na tym samym oknie co autorzy, potem osobne porównanie jednolitego okna. Gdy wybrane pliki nie zawierają pełnych danych do własnego okna, zachowaj okno źródłowe i wskaż ograniczenie, zamiast rekonstruować relacje z samych indeksów.

**Kod odniesienia.** [Repozytorium autorów CrossDI](https://github.com/pzczxs/CrossDI-Dataset-and-Source-Code) obejmuje wskaźniki oraz składowe D,C i pracę z trzema bazami. Przejrzyj jego definicje, politykę okna i zerowych mianowników. Własna implementacja w R ma być porównana na uzgodnionym przykładzie; nie uzasadniaj jej rzekomym brakiem składowych w istniejącym kodzie.

## Mapowanie na pracę

| Materiał | Część pracy |
|---|---|
| Problem zastosowania, pytanie analityczne i zakres wkładu | Wprowadzenie |
| Definicje, wzory, założenia i porównanie dostępnych rozwiązań | Rozdział 1: Podstawy metodyczne |
| Kontrakt, moduły, klasy wyniku, generator i wyniki testów | Rozdział 2: Implementacja i architektura pakietu |
| Charakterystyka danych, analiza, interpretacja i porównanie | Rozdział 3: Studium przypadku |
| Odpowiedź na pytanie, ograniczenia i kierunek rozwoju | Zakończenie |

**Wstępne pytanie analityczne.** Jak uśrednianie po źródłach i niekompletność sieci zmieniają relację między globalnym DI a składowymi D i C?

**Proponowany wkład.** Sprawdzony pakiet R z wynikami per źródło i diagnostyką kompletności oraz kontrolowany eksperyment z pokryciem. Wkład wynika z formy narzędzia i analizy wrażliwości, a nie z twierdzenia o braku kodu autorów.

## Polecenia startowe

1. **Specyfikacja.** Oddziel unię źródeł od średniej po pojedynczych źródłach, a brak rekordu od pustego zbioru cytujących. Wynik: `SPEC.md` z sygnaturami, definicjami i obsługą przypadków brzegowych. Sprawdzenie: każdy argument i każda kolumna wyniku mają opis; zakres odpowiada wskazanym częściom artykułu.
2. **Przykłady analityczne.** Sprawdź DI=0, D=1/2, C=1/6 oraz zerowe mianowniki. Wynik: testy z liczbowymi wartościami oczekiwanymi. Sprawdzenie: odtwórz rachunki na kartce lub osobnym, prostym skryptem; nie wyznaczaj oczekiwanych wartości testowaną funkcją.
3. **Walidacja.** Zapisz testy wszystkich błędów wymienionych w kontrakcie oraz poprawnych danych prowadzących do `NA`. Wynik: konstruktor wejścia i stabilne komunikaty. Sprawdzenie: błędne dane zatrzymują obliczenia, a niezdefiniowana miara ma opisany status.
4. **Rdzeń.** Zachowaj wszystkie wyniki cząstkowe przed średnią i porównaj prostą wersję z kodem autorów na wspólnych definicjach. Wynik: działające funkcje i obiekt S3. Sprawdzenie: testy analityczne oraz porównanie z niezależną, najprostszą wersją obliczenia.
5. **Eksperyment.** Porównaj pełną i dwie przerzedzone wersje tego samego pobrania; pokaż, które relacje odpowiadają za zmianę wskaźnika. Wynik: skrypt z konfiguracją, ziarnami i tabelą wyników. Sprawdzenie: powtórzenie daje te same dane i odtwarza tabelę; raport obejmuje wszystkie zaplanowane warianty.
6. **Udostępnienie.** Dodaj dokumentację, metodę wykresu, winietę i przykład w aplikacji. Wynik: instalowalny pakiet i działająca strona. Sprawdzenie: przykład działa po instalacji w czystej sesji R; opis odróżnia wynik liczbowy od jego interpretacji.

## Pułapki

Podział globalnego DI na dwa ułamki nie odtwarza D,C z artykułu. Liczenie po pojedynczych źródłach zmienia wagi otoczeń. Brakujące źródło nie może być traktowane jak źródło z zerową liczbą cytowań. Dostępność kodu nie usuwa potrzeby sprawdzenia jego konwencji i własnej implementacji.

Na obronie należy wyjaśnić różnicę między globalną agregacją a średnią po źródłach oraz ocenić, jakie porównanie jest uprawnione przy nierównym pokryciu danych.

## Literatura

Artykuł źródłowy: `xu2025crossdi`.

Wprowadzenie: `funk2017dynamic`, `lin2026disruption`. Klucze i pełne opisy są w [`zrodla/tematy.bib`](zrodla/tematy.bib).

Środowisko: `rcore2026`. Wymagania formalne: `standardyEPI`. Źródła danych opisano w sekcji „Dane”; w pracy należy podać ich opis bibliograficzny, wersję wykorzystanego zbioru i zakres przekształceń.

Dane: `openalexData`, `crossdiData`.
