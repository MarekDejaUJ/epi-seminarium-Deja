# Temat 01. Granice prawdopodobieństw przyczynowości

## Metryka

| | |
|---|---|
| Artykuł źródłowy | Li, Ang; Pearl, Judea (2024). *Probabilities of Causation with Nonbinary Treatment and Effect*. Proceedings of the AAAI Conference on Artificial Intelligence 38(18) |
| Identyfikator | [10.1609/aaai.v38i18.30030](https://doi.org/10.1609/aaai.v38i18.30030) |
| Dostęp | materiały AAAI dostępne publicznie |
| Dziedzina | wnioskowanie przyczynowe, ocena polityk publicznych |
| Proponowany tytuł pracy | Pakiet R do wyznaczania granic prawdopodobieństw przyczynowości jako przykład zastosowania programowania liniowego w analizie decyzji |
| Proponowana nazwa pakietu | `CausalBoundsR` |
| Trudność | ●●● |

## Po co to badaczowi

Badacz nauk społecznych stale zadaje pytania kontrfaktyczne, choć rzadko nazywa je
po imieniu. Czy ta osoba porzuciłaby szkołę, **gdyby nie** dostała stypendium? Czy
kampania informacyjna była **konieczna**, żeby ktoś się zaszczepił, czy zrobiłby to
tak czy inaczej? To nie są pytania o średni efekt w grupie. To pytania o pojedynczy
przypadek i o mechanizm.

Klasyczna analiza na takie pytania nie odpowiada. Średni efekt mówi, o ile więcej
osób zaszczepiło się w grupie objętej kampanią. Nie mówi, jaka część z nich zrobiła
to **dzięki** kampanii, a jaka zrobiłaby to i bez niej. Dla decydenta, który
zastanawia się, czy kampanię powtórzyć, różnica jest zasadnicza: pierwsze mówi
o skuteczności wydanych pieniędzy, drugie o ich zmarnowaniu.

Odpowiedzią są **prawdopodobieństwa przyczynowości**: konieczności, dostateczności
oraz konieczności i dostateczności razem. Kłopot polega na tym, że wielkości tych
zwykle **nie da się wyznaczyć dokładnie** z dostępnych danych. Da się natomiast
wyznaczyć przedział, w którym na pewno leżą. Ten przedział bywa wystarczający do
podjęcia decyzji: jeżeli dolna granica prawdopodobieństwa konieczności jest wysoka,
wiadomo, że interwencja była potrzebna, nawet jeśli nie wiadomo dokładnie w ilu
przypadkach.

Artykuł rozszerza znane wyniki z przypadku dwuwartościowego, czyli zabieg jest albo
go nie ma, na przypadek **wielowartościowy**: kilka poziomów interwencji i kilka
możliwych wyników. To krok, który dopiero czyni metodę użyteczną w naukach
społecznych, gdzie interwencje rzadko są zerojedynkowe, a wyniki rzadko są binarne.
Intensywność kampanii, wysokość stypendium, liczba godzin szkolenia – wszystko to
ma poziomy.

Narzędzia, które to liczy, badacz nauk społecznych dziś nie ma pod ręką.

## Algorytm

**Wejście.** Rozkład obserwacyjny oraz rozkład interwencyjny, oba w postaci tablic
prawdopodobieństw dla zmiennej zabiegu o wartościach dyskretnych, zmiennej wyniku
o wartościach dyskretnych i opcjonalnych warstw zmiennych towarzyszących.

**Wyjście.** Dla każdej pary poziomów zabiegu i pary poziomów wyniku: przedział
domknięty zawierający wartość prawdopodobieństwa konieczności, dostateczności oraz
konieczności i dostateczności.

**Kroki.**

1. Sprawdzenie spójności danych wejściowych: rozkłady sumują się do jedności,
   rozkład interwencyjny i obserwacyjny nie są ze sobą sprzeczne.
2. Zbudowanie macierzy ograniczeń wiążącej nieobserwowalne stany świata
   z obserwowalnymi rozkładami.
3. Rozwiązanie zadania programowania liniowego osobno dla minimum i maksimum każdej
   wielkości.
4. Zwrócenie przedziałów wraz z informacją, które ograniczenie okazało się wiążące.

**Wzory.** Trzy podstawowe wielkości definiuje się w języku kontrfaktycznym. Dla
zmiennych zerojedynkowych, gdzie $x$ oznacza podanie leczenia, a $y$ wystąpienie skutku:

$$PN = P(Y_{x'} = \text{fałsz} \mid X = x,\; Y = y)$$

$$PS = P(Y_{x} = y \mid X = x',\; Y = y')$$

$$PNS = P(Y_{x} = y,\; Y_{x'} = y')$$

Prawdopodobieństwo konieczności odpowiada na pytanie, czy skutek by nie wystąpił bez
leczenia, u osoby leczonej, u której wystąpił. Prawdopodobieństwo dostateczności pyta
odwrotnie: czy skutek by wystąpił po leczeniu, u osoby nieleczonej, u której nie wystąpił.
Trzecia wielkość łączy oba warunki.

Wielkości te są **nieidentyfikowalne**: z samych danych nie da się wyznaczyć ich wartości,
a jedynie przedział, w którym leżą. Artykuł rozszerza definicje na zmienne wielowartościowe,
gdzie $X$ przyjmuje wartości $x_1,\ldots,x_m$, a $Y$ wartości $y_1,\ldots,y_n$, i podaje
granice **dokładne** w tym sensie, że dla każdego punktu wewnątrz przedziału istnieje model
przyczynowy dający dokładnie tę wartość.

Granice wyznacza się jako rozwiązanie zadania programowania liniowego: zmiennymi są
prawdopodobieństwa stanów nieobserwowalnych, ograniczeniami zgodność z rozkładem
obserwacyjnym i eksperymentalnym oraz warunek unormowania, a funkcją celu wielkość, której
granic szukasz. Dolna granica to minimum, górna maksimum tego samego zadania.

**Co wynotować z artykułu.** Wzory pobierasz z sekcji definicyjnej i z części
opisującej konstrukcję zadania programowania liniowego. Potrzebujesz:

- definicji trzech prawdopodobieństw w wersji wielowartościowej, wraz z zapisem
  kontrfaktycznym;
- pełnej postaci funkcji celu oraz macierzy i wektora ograniczeń;
- założeń, przy których granice są **ostre**, czyli nie da się ich zawęzić;
- warunku, przy którym przedział degeneruje się do punktu.

Sprawdź szczególnie, jak artykuł traktuje przypadek braku rozkładu interwencyjnego:
granice są wtedy szersze, a część ograniczeń znika.

## Kontrakt

**Warunki wstępne.** Tablice prawdopodobieństw o zgodnych wymiarach; wartości
z przedziału jednostkowego; sumowanie do jedności w obrębie każdego warunkowania;
co najmniej dwa poziomy zabiegu i dwa poziomy wyniku.

**Niezmienniki.** Dolna granica nie przekracza górnej. Obie mieszczą się w przedziale
jednostkowym. Przedział wyznaczony przy dostępie do obu rozkładów zawiera się
w przedziale wyznaczonym tylko z rozkładu obserwacyjnego.

**Wyjście.** Klasa `granice_przyczynowe` ze składnikami: przedziały dla każdej
wielkości i pary poziomów, informacja o wiążących ograniczeniach, status solvera.

**Błędy zatrzymujące wykonanie.** Rozkład niesumujący się do jedności; ujemne
prawdopodobieństwo; sprzeczność między rozkładem obserwacyjnym a interwencyjnym;
brak zbieżności solvera.

## Plan pakietu

| Plik | Odpowiedzialność |
|---|---|
| `R/przygotowanie_danych.R` | walidacja tablic, przekształcenie do postaci roboczej |
| `R/ograniczenia.R` | budowa macierzy ograniczeń i wektora prawych stron |
| `R/granice.R` | wywołanie solvera, wyznaczenie przedziałów |
| `R/klasy_s3.R` | obiekt wyniku, metody `print` i `summary` |
| `R/wizualizacja.R` | wykres przedziałów dla par poziomów |

Zależności: solver programowania liniowego dostępny na CRAN oraz `ggplot2`.
Wybór solvera uzasadnij w pracy: różnią się obsługą zadań zdegenerowanych.

## Dane

**Procedura generowania.** Losujesz rozkład stanów nieobserwowalnych, z niego
wyprowadzasz rozkłady obserwacyjny i interwencyjny. Wtedy **znasz prawdziwe
wartości** wszystkich trzech prawdopodobieństw, więc możesz sprawdzić, czy leżą
w wyznaczonych przedziałach. To najmocniejszy test poprawności, jaki masz w tym
temacie.

Parametry: liczba poziomów zabiegu, liczba poziomów wyniku, liczba warstw, ziarno.

**Przypadki o znanym wyniku.** Przypadek dwuwartościowy bez zmiennych towarzyszących,
dla którego granice są znane z literatury klasycznej i policzalne ręcznie.
Przypadek deterministyczny, w którym przedział degeneruje się do punktu. Przypadek
niezależności zabiegu i wyniku, w którym granice są najszersze.

**Przypadki patologiczne.** Rozkład z zerowym prawdopodobieństwem w komórce; zadanie
niedopuszczalne; sprzeczność między rozkładami.

**Zbiór empiryczny.** Tablice kontyngencji z otwartych badań ankietowych, na przykład
Europejskiego Sondażu Społecznego, przekształcone do postaci dyskretnej. Sprawdź
licencję i sposób cytowania przed rozpoczęciem analizy.

## Mapowanie na pracę

| Sekcja briefu | Rozdział pracy |
|---|---|
| Po co to badaczowi | Wprowadzenie: tło i luka |
| Algorytm, co wynotować | Rozdział 1: aparat formalny |
| Kontrakt, założenia z artykułu | Rozdział 1: założenia i granice stosowalności |
| Plan pakietu, dane | Rozdział 2 |
| Zbiór empiryczny | Rozdział 3 |

**Wstępne pytanie badawcze.** Jak szerokość wyznaczonych granic zależy od tego, ile
poziomów ma zmienna zabiegu, i przy jakiej liczbie poziomów przestają one nieść
informację użyteczną dla decydenta?

## Polecenia startowe

1. Wyznaczenie definicji: poproś o zestawienie trzech prawdopodobieństw w wersji
   dwuwartościowej i wielowartościowej obok siebie, na podstawie Twoich notatek
   z artykułu. Sprawdź, czy zapis kontrfaktyczny się zgadza.
2. Budowa macierzy ograniczeń dla zadanych wymiarów, jako funkcja zwracająca macierz
   i wektor. Sprawdź wymiary ręcznie dla przypadku dwa na dwa.
3. Wywołanie solvera dla minimum i maksimum, z obsługą statusu zwracanego przez
   solver. Sprawdź na zadaniu o znanym rozwiązaniu.
4. Dane naruszające warunki wstępne, wraz z oczekiwanym zachowaniem.
5. Procedura generowania: rozkład stanów nieobserwowalnych i wyprowadzenie z niego
   obu rozkładów obserwowalnych.
6. Dokumentacja funkcji eksportowanych na podstawie specyfikacji.

## Pułapki

**Narzędzie pomyli granice ostre z granicami przybliżonymi.** Artykuł dowodzi, że
granice są najwęższe z możliwych przy danych założeniach. Implementacja, która daje
szerszy przedział, nie jest błędna liczbowo, ale nie realizuje metody.

**Kierunek nierówności w ograniczeniach.** Najczęstszy błąd w tego typu zadaniach.
Objawia się przedziałem, w którym dolna granica przekracza górną, albo przedziałem
zbyt szerokim. Test na przypadku dwuwartościowym wychwyci to od razu.

**Przypadek bez rozkładu interwencyjnego.** Metoda działa też wtedy, ale z mniejszą
liczbą ograniczeń. Sprawdź, czy funkcja nie wymaga rozkładu interwencyjnego jako
obowiązkowego.

**Interpretacja.** Prawdopodobieństwo konieczności nie jest prawdopodobieństwem
warunkowym i nie da się go odczytać z tablicy kontyngencji. Praca musi to
rozróżnienie wyłożyć, bo bez niego cały rozdział trzeci jest nadinterpretacją.

**Na obronie** musisz umieć wyjaśnić, dlaczego wielkości te w ogóle nie dają się
wyznaczyć dokładnie, i co takiego dokłada rozkład interwencyjny, że przedział się
zawęża.

## Literatura

Artykuł źródłowy: `liPearl2024probabilities`.

Wprowadzenie: podręcznikowe omówienie prawdopodobieństw przyczynowości w pracach
Pearla; opracowanie o granicach nieparametrycznych w modelach przyczynowych.
Dwie do czterech pozycji dobierasz sam i uzgadniasz z promotorem.

Środowisko: `rcore2026`. Wymagania formalne: `standardyEPI`.
