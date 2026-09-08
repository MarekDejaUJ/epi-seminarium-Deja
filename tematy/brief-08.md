# Temat 08. Podobieństwo dwóch rankingów, gdy nie znamy ich końca

## Metryka

| | |
|---|---|
| Artykuł źródłowy | Corsi, Matteo; Urbano, Julián (2024). *The Treatment of Ties in Rank-Biased Overlap*. SIGIR '24 |
| Identyfikator | [arXiv:2406.07121](https://arxiv.org/abs/2406.07121) |
| Podstawa metody | Webber, Moffat, Zobel (2010). *A Similarity Measure for Indefinite Rankings*, [10.1145/1852102.1852106](https://doi.org/10.1145/1852102.1852106) |
| Dostęp | otwarty |
| Dziedzina | wyszukiwanie informacji, bibliometria, porównywanie list |
| Proponowany tytuł pracy | Pakiet R do porównywania rankingów nieokreślonej długości jako przykład zastosowania miar ważonych pozycją w analizie danych bibliograficznych |
| Proponowana nazwa pakietu | `RankingiR` |
| Trudność | ●● |

## Po co to badaczowi

Porównywanie dwóch uporządkowań to jedna z najczęstszych czynności w naukach
o informacji. Dwa systemy wyszukiwawcze zwracają dwie listy wyników. Dwie bazy
bibliograficzne dają dwa rankingi czasopism. Dwóch ekspertów porządkuje te same
dokumenty od najważniejszego. Za każdym razem pada pytanie: **jak bardzo te dwa
porządki się zgadzają**.

Klasyczne współczynniki korelacji rangowej odpowiadają na to pytanie źle, z dwóch
powodów. Po pierwsze wymagają, żeby obie listy zawierały **te same elementy** –
a listy wyszukiwania zawierają różne dokumenty. Po drugie traktują wszystkie pozycje
tak samo, więc zamiana miejscami pozycji tysięcznej i tysiąc pierwszej waży tyle samo,
co zamiana pierwszej z drugą. Dla użytkownika, który ogląda pierwszą dziesiątkę, jest
to nonsens.

Miara opisana w artykule podstawowym rozwiązuje oba problemy naraz: dopuszcza listy
o różnej zawartości i różnej, nawet nieznanej długości, a wagę pozycji ustala malejąco.

Artykuł źródłowy dokłada rzecz, którą wersja pierwotna zostawiła otwartą: **remisy**.
W realnych danych remisy są wszędzie – dokumenty o identycznej ocenie systemu, czasopisma
o tej samej liczbie cytowań, oceny ekspertów na skali pięciostopniowej. Wersja pierwotna
zakłada porządek ścisły, więc badacz musi remisy jakoś rozstrzygnąć, i robi to zwykle
przypadkowo, przez kolejność w pliku. Artykuł pokazuje, że wynik od tego zależy, i podaje
postać uogólnioną wraz z wariantami.

## Algorytm

**Wejście.** Dwa rankingi tych samych albo różnych elementów, ewentualnie z grupami
remisowymi; parametr wytrwałości $p$; głębokość oceny.

**Wyjście.** Wartość podobieństwa, granice przy niepełnej znajomości list, wkład
kolejnych głębokości, wariant obsługi remisów.

**Wzory.** Niech $S_{:d}$ i $T_{:d}$ oznaczają zbiory elementów zajmujących pierwsze $d$
pozycji obu rankingów. Pokrycie na głębokości $d$ to liczność części wspólnej

$$X_d = |S_{:d} \cap T_{:d}|$$

a zgodność na tej głębokości to pokrycie odniesione do głębokości

$$A_d = \frac{X_d}{d}$$

Miara jest średnią ważoną zgodności po wszystkich głębokościach, z wagami malejącymi
geometrycznie:

$$\mathrm{RBO} = (1-p)\sum_{d=1}^{\infty} p^{\,d-1} A_d$$

Wartość należy do przedziału od zera do jedności: rankingi rozłączne dają zero, bo
zgodność jest zerowa na każdej głębokości, rankingi identyczne dają jedność, bo zgodność
jest wszędzie równa jeden.

Parametr $p$ działa tak samo jak w temacie 07: małe $p$ oznacza, że liczy się prawie
wyłącznie początek listy, duże $p$ rozkłada uwagę głębiej.

**Remisy.** Gdy elementy stoją w grupie remisowej, pojęcie pierwszych $d$ pozycji
przestaje być jednoznaczne. Artykuł źródłowy podaje uogólnienie i kilka wariantów
różniących się tym, co zakłada się o elementach wewnątrz grupy. Wybór wariantu jest
decyzją badacza i **zmienia wynik**, więc musi być w pracy nazwany i uzasadniony.

**Kroki.**

1. Sprawdzenie danych: brak powtórzeń w obrębie rankingu, zgodność przestrzeni
   identyfikatorów, poprawność zapisu grup remisowych.
2. Wyznaczenie pokrycia na kolejnych głębokościach metodą przyrostową: przy przejściu
   z $d$ na $d+1$ pokrycie zmienia się co najwyżej o dwa.
3. Złożenie sumy ważonej zgodności.
4. Wyznaczenie granic wartości przy rankingach obciętych.
5. Powtórzenie dla wybranego wariantu obsługi remisów.
6. Zestawienie z klasycznymi współczynnikami korelacji rangowej.

**Co wynotować z artykułu.** Postać uogólnioną dla remisów wraz z definicją każdego
symbolu; różnice między wariantami i to, co każdy z nich zakłada; sposób wyznaczania
granic przy prefiksach; przykład przewodni z artykułu wraz z policzonymi wartościami
– posłuży za przypadek analityczny w testach.

## Kontrakt

**Warunki wstępne.** Parametr ściśle między zerem a jednością; brak powtórzeń elementu
w obrębie jednego rankingu; obie listy niepuste; grupy remisowe rozłączne.

**Niezmienniki.** Wynik należy do przedziału od zera do jedności. Miara jest symetryczna:
zamiana rankingów miejscami nie zmienia wyniku. Rankingi identyczne dają jedność,
rozłączne zero. Pokrycie jest niemalejące wraz z głębokością. Zgodność na głębokości $d$
nie przekracza jedności.

**Wyjście.** Klasa `podobienstwo_rankingow` ze składnikami: wartość, granice, wkład
kolejnych głębokości, wariant obsługi remisów, wartość parametru.

**Błędy zatrzymujące wykonanie.** Parametr poza przedziałem otwartym; powtórzony element
w rankingu; pusty ranking; niespójny zapis grup remisowych.

## Plan pakietu

| Plik | Odpowiedzialność |
|---|---|
| `R/przygotowanie_danych.R` | walidacja rankingów, rozpoznanie grup remisowych |
| `R/pokrycie.R` | pokrycie i zgodność na kolejnych głębokościach, przyrostowo |
| `R/rbo.R` | miara podstawowa i granice |
| `R/remisy.R` | warianty obsługi grup remisowych |
| `R/klasy_s3.R` | obiekt wyniku, metody `print` i `summary` |
| `R/wizualizacja.R` | zgodność w funkcji głębokości, wpływ parametru |

Zależności: `stats` i `ggplot2`. Pokrycie licz **przyrostowo**: przechodząc na głębokość
$d+1$ sprawdzasz tylko dwa nowe elementy, zamiast wyznaczać część wspólną od nowa.
Różnica między złożonością kwadratową a liniową jest sednem części inżynierskiej.

## Dane

**Procedura generowania.** Budujesz parę rankingów o **zadanym stopniu zgodności**:
zaczynasz od rankingu wzorcowego i przestawiasz w nim losowo określony odsetek pozycji
albo podmieniasz określony odsetek elementów. Znasz wtedy kierunek, w którym miara ma
się zmieniać, i możesz sprawdzić monotoniczność. Następnie wprowadzasz remisy o zadanej
wielkości grup i porównujesz warianty.

Parametry: długość rankingu, odsetek wspólnych elementów, siła przestawienia, wielkość
grup remisowych, parametr wytrwałości, ziarno.

**Przypadki o znanym wyniku.** Rankingi identyczne: jedność. Rankingi całkowicie
rozłączne: zero. Rankingi różniące się zamianą dwóch pierwszych pozycji: wartość
policzalna ręcznie z kilku pierwszych wyrazów sumy – wpisz rachunek do komentarza testu.

**Przypadki patologiczne.** Rankingi o skrajnie różnej długości; ranking złożony z jednej
grupy remisowej; parametr bardzo bliski jedności przy krótkich listach.

**Zbiór empiryczny.** Dwa rankingi tych samych obiektów z różnych źródeł: listy czasopism
według liczby cytowań z dwóch baz bibliograficznych, rankingi uczelni z dwóch zestawień
albo wyniki dwóch wyszukiwarek dla tego samego zapytania. Sprawdź warunki licencyjne.

## Mapowanie na pracę

| Sekcja briefu | Rozdział pracy |
|---|---|
| Po co to badaczowi, ograniczenia korelacji rangowej | Wprowadzenie: tło i luka |
| Wzory, wagi pozycji, uogólnienie na remisy | Rozdział 1: aparat formalny |
| Kontrakt, symetria i zachowanie graniczne | Rozdział 1: granice stosowalności |
| Plan pakietu, liczenie przyrostowe, procedura generowania | Rozdział 2 |
| Zbiór empiryczny, porównanie wariantów | Rozdział 3 |

**Wstępne pytanie badawcze.** O ile wynik porównania dwóch rankingów zależy od sposobu
rozstrzygnięcia remisów i przy jakiej wielkości grup remisowych różnica między wariantami
przewyższa różnicę między porównywanymi rankingami?

## Polecenia startowe

1. Walidacja pary rankingów wraz z rozpoznaniem grup remisowych.
2. Pokrycie i zgodność na kolejnych głębokościach, liczone przyrostowo.
3. Miara podstawowa i granice przy rankingach obciętych.
4. Wariant obsługi remisów zgodnie z Twoimi notatkami z artykułu.
5. Procedura generowania pary rankingów o zadanym stopniu zgodności.
6. Badanie wpływu wielkości grup remisowych na rozstęp między wariantami.

## Pułapki

**Wyznaczanie części wspólnej od nowa na każdej głębokości.** Kod działa i jest o rząd
wielkości wolniejszy, niż powinien. Przy rankingach długości tysiąca widać to od razu.

**Remisy rozstrzygane kolejnością w pliku.** Najczęstszy błąd w tym temacie i jednocześnie
jego temat. Wynik zależy wtedy od tego, jak dane były posortowane przed wczytaniem, czego
nikt nie odnotowuje.

**Mylenie z korelacją rangową.** Miara nie jest współczynnikiem korelacji: nie przyjmuje
wartości ujemnych i nie ma interpretacji probabilistycznej znanej z korelacji rangowej.
Praca musi to rozróżnienie postawić wprost, bo recenzent o nie zapyta.

**Rankingi o różnej długości.** Zgodność liczona do głębokości krótszej listy zaniża
wynik, do dłuższej zawyża. Sposób postępowania jest w artykule i trzeba go zastosować,
a nie wymyślić.

**Na obronie** musisz umieć wyjaśnić, dlaczego zwykła korelacja rangowa nie nadaje się
do porównywania wyników dwóch wyszukiwarek, i pokazać na przykładzie dwóch krótkich list,
jak zmienia się wynik przy dwóch różnych rozstrzygnięciach remisu.

## Literatura

Artykuł źródłowy: `corsiUrbano2024remisy`. Podstawa metody: `webber2010similarity` –
przeczytaj oba, w tej kolejności.

Wprowadzenie: podręcznikowe omówienie współczynników korelacji rangowej; opracowanie
o porównywaniu rankingów w bibliometrii. Dwie do czterech pozycji dobierasz sam.
Temat pokrewny: 07 – ten sam mechanizm wag malejących geometrycznie, inne zastosowanie.

Środowisko: `rcore2026`. Wymagania formalne: `standardyEPI`.
