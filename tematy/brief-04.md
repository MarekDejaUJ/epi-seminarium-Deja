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

Od kilkunastu lat naukometria posługuje się wskaźnikiem, który ma odróżniać prace
**przełomowe** od **rozwijających** to, co już jest. Idea jest prosta: jeśli kolejne
prace cytują Twój artykuł, a przestają cytować to, na czym się oparłeś, znaczy że
wyparłeś poprzedników. Jeśli cytują Ciebie **razem** z Twoimi źródłami, znaczy że
dołożyłeś cegiełkę do istniejącego gmachu.

Wskaźnik ten trafił do polityki naukowej. Używa się go w raportach o kondycji nauki,
w dyskusjach o tym, czy nauka przestała być przełomowa, a bywa, że w ocenie
jednostek. Konsekwencje takich zastosowań są realne.

Artykuł stawia tezę, która to zastosowanie podważa. Pokazuje, że wskaźnik **nie
mierzy przełomowości bezwzględnej**, jak się powszechnie zakłada, tylko relację
między artykułem a jego **najczęściej cytowanym źródłem**. Innymi słowy: mierzy
lokalne wyparcie jednego poprzednika, a nie zmianę w całej dziedzinie. To zupełnie
inna wielkość i zupełnie inne wnioski.

Dla badacza nauk społecznych zainteresowanego naukometrią oznacza to, że
interpretacja setek opublikowanych analiz wymaga rewizji. Narzędzie, które liczy
wskaźnik **i pokazuje, względem czego** został policzony, pozwala tę rewizję
przeprowadzić na własnych danych.

Autorzy udostępnili wartości wskaźnika dla **49 milionów artykułów** z otwartej bazy
danych bibliograficznych, więc materiał do studium przypadku jest gotowy.

## Algorytm

**Wejście.** Lista krawędzi cytowań: pary identyfikatorów artykuł cytujący –
artykuł cytowany. Opcjonalnie lata publikacji, dziedziny i identyfikatory autorów.

**Wyjście.** Dla każdego artykułu: wartość wskaźnika przełomowości, wskazanie
najczęściej cytowanego źródła oraz miara wyparcia względem tego źródła.

**Kroki.**

1. Sprawdzenie grafu: brak cykli, brak krawędzi do samego siebie, kompletność
   identyfikatorów.
2. Wyznaczenie dla każdego artykułu zbioru jego źródeł oraz zbioru prac cytujących.
3. Podział prac cytujących na te, które cytują tylko artykuł, te, które cytują
   artykuł i jego źródła, oraz te, które cytują tylko źródła.
4. Złożenie wskaźnika z liczności tych zbiorów.
5. Wyznaczenie najczęściej cytowanego źródła i miary wyparcia względem niego.
6. Opcjonalne przycięcie okna czasowego i normalizacja w obrębie dziedziny i rocznika.

**Wzory.** Dla publikacji $p$ dzieli się prace cytujące na trzy rozłączne grupy:
$N_i$ to prace cytujące wyłącznie $p$, $N_j$ prace cytujące zarówno $p$, jak i jej źródła,
$N_k$ prace cytujące wyłącznie źródła $p$. Wskaźnik przełomowości to

$$D = \frac{N_i - N_j}{N_i + N_j + N_k}$$

Wartość dodatnia oznacza, że publikacja jest cytowana zamiast swoich źródeł, ujemna, że
razem z nimi. Zakres to przedział od minus jednego do jednego.

Artykuł rozkłada wskaźnik na dwa czynniki:

$$D = \frac{d_p}{1 + R_k}, \qquad d_p = \frac{N_i - N_j}{N_i + N_j}, \qquad R_k = \frac{N_k}{N_i + N_j}$$

Pierwszy czynnik $d_p$ to **lokalne wyparcie**: na ile publikacja zastępuje swoje źródła
w bezpośredniej konkurencji o uwagę. Drugi czynnik opisuje przewagę źródeł nad publikacją
i jest przybliżeniem ilorazu liczby cytowań źródeł do liczby cytowań publikacji.

Rozkład ten jest sednem artykułu, bo pokazuje, że o wartości wskaźnika decyduje przede
wszystkim **najczęściej cytowane źródło**, a nie liczba źródeł. Rozkład cytowań wśród
źródeł jest silnie skośny i autorzy modelują go prawem potęgowym, z czego wyprowadzają
udział najczęściej cytowanego źródła w cytowaniach wszystkich źródeł.

**Co wynotować z artykułu.** Z sekcji metodycznej: dokładną definicję wskaźnika
w postaci użytej przez autorów, definicję miary wyparcia względem najczęściej
cytowanego źródła oraz **wykazanie związku między nimi** – to jest sedno pracy
i to musisz umieć odtworzyć. Wynotuj też przyjęte okno czasowe i sposób traktowania
autocytowań.

## Kontrakt

**Warunki wstępne.** Lista krawędzi bez powtórzeń; brak krawędzi z artykułu do
samego siebie; identyfikatory niepuste; przy podanym oknie czasowym obecne lata
publikacji.

**Niezmienniki.** Wskaźnik należy do przedziału od minus jeden do jeden. Artykuł bez
źródeł nie ma wskaźnika. Odwrócenie ról artykułu i źródła zmienia znak miary
wyparcia. Wynik nie zależy od kolejności krawędzi na wejściu.

**Wyjście.** Klasa `przelomowosc` ze składnikami: ramka wyników, liczności
składowych, wskazane źródło odniesienia, przyjęte okno czasowe.

**Błędy zatrzymujące wykonanie.** Cykl w grafie cytowań; krawędź do samego siebie;
brak lat publikacji przy zadanym oknie; pusta lista krawędzi.

## Plan pakietu

| Plik | Odpowiedzialność |
|---|---|
| `R/przygotowanie_danych.R` | walidacja grafu, budowa macierzy rzadkiej |
| `R/wskaznik.R` | liczności składowych i wskaźnik |
| `R/wyparcie.R` | najczęściej cytowane źródło i miara wyparcia |
| `R/normalizacja.R` | okno czasowe, normalizacja dziedzinowa |
| `R/klasy_s3.R` | obiekt wyniku, metody `print` i `summary` |
| `R/wizualizacja.R` | rozrzut wskaźnika względem miary wyparcia |

Zależności: pakiet do macierzy rzadkich oraz `ggplot2`. **Nie używaj pętli po
artykułach** – przy realnych danych to jedyna decyzja projektowa, która przesądza
o wykonalności.

## Dane

**Procedura generowania.** Budujesz sztuczny graf cytowań o **zadanej strukturze**:
część artykułów wypiera swoje źródła, część je konsoliduje, w kontrolowanych
proporcjach. Znasz wtedy oczekiwany znak wskaźnika dla każdego artykułu, więc możesz
sprawdzić, czy implementacja go odtwarza.

Parametry: liczba artykułów, rozkład liczby źródeł, rozkład liczby cytowań, odsetek
artykułów wypierających, ziarno.

**Przypadki o znanym wyniku.** Artykuł, którego wszyscy cytujący pomijają źródła:
wskaźnik równy jeden. Artykuł, którego wszyscy cytujący cytują też źródła: wskaźnik
ujemny o znanej wartości. Artykuł bez cytowań: brak wskaźnika albo wartość
zdefiniowana wprost w artykule – sprawdź, którą przyjmują autorzy.

**Przypadki patologiczne.** Graf z jednym artykułem; artykuł cytujący sam siebie;
identyfikatory zduplikowane; okno czasowe wykluczające wszystkie cytowania.

**Zbiór empiryczny.** Zbiór wartości wskaźnika udostępniony przez autorów oraz
otwarta baza danych bibliograficznych, z której powstał. Sprawdź licencję i sposób
cytowania. **Porównanie własnych wyników z wartościami autorów jest tu najmocniejszą
weryfikacją empiryczną** i powinno trafić do rozdziału trzeciego.

## Mapowanie na pracę

| Sekcja briefu | Rozdział pracy |
|---|---|
| Po co to badaczowi | Wprowadzenie: tło i luka |
| Algorytm, co wynotować | Rozdział 1: aparat formalny |
| Kontrakt, okno czasowe, autocytowania | Rozdział 1: założenia |
| Plan pakietu, dane, wydajność | Rozdział 2 |
| Porównanie z wartościami autorów | Rozdział 3 |

**Wstępne pytanie badawcze.** W jakim stopniu wartość wskaźnika przełomowości daje
się wyjaśnić samą relacją do najczęściej cytowanego źródła i co z tego wynika dla
interpretacji analiz opartych na tym wskaźniku?

## Polecenia startowe

1. Budowa macierzy rzadkiej z listy krawędzi wraz z walidacją grafu.
2. Liczności trzech składowych bez pętli po artykułach, na operacjach macierzowych.
3. Wskaźnik i miara wyparcia zgodnie z Twoimi notatkami.
4. Procedura generowania grafu o zadanej strukturze.
5. Dane naruszające warunki wstępne wraz z oczekiwanym zachowaniem.
6. Pomiar czasu i pamięci dla grafu o rosnącej liczbie krawędzi.

## Pułapki

**Pętla po artykułach.** Narzędzie zaproponuje ją jako pierwsze rozwiązanie, bo tak
się to czyta w definicji. Przy milionie artykułów kod się nie skończy. Przełożenie
liczności na operacje na macierzach rzadkich jest sednem części inżynierskiej pracy.

**Autocytowania.** Zmieniają wynik i różne prace traktują je różnie. Sprawdź, co
robią autorzy, i zapisz to w specyfikacji jako decyzję.

**Okno czasowe.** Wskaźnik liczony po dwóch latach i po dziesięciu to dwie różne
wielkości. Porównywanie wyników policzonych w różnych oknach jest błędem, który
często trafia do publikacji.

**Teza artykułu.** Praca nie ma być kolejnym zastosowaniem wskaźnika, tylko
narzędziem pokazującym, **względem czego** został policzony. Jeśli rozdział trzeci
sprowadza się do rankingu najbardziej przełomowych artykułów, temat został
zmarnowany.

**Na obronie** musisz umieć wyjaśnić, dlaczego wskaźnik mierzy relację lokalną,
a nie zmianę w dziedzinie, i podać przykład, w którym prowadzi to do mylnego wniosku.

## Literatura

Artykuł źródłowy: `lin2026disruption`.

Wprowadzenie: pierwotna praca wprowadzająca wskaźnik przełomowości; przegląd krytyk
tego wskaźnika. Dwie do czterech pozycji dobierasz sam. Temat jest pokrewny
z tematem 14 – warto uzgodnić wspólną część literatury.

Środowisko: `rcore2026`. Wymagania formalne: `standardyEPI`.
