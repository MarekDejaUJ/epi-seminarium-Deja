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

> **Uwaga o istniejącym kodzie.** Autorzy udostępniają skrypty liczące wskaźniki
> przełomowości na swoim zbiorze. Nie jest to pakiet R i nie obejmuje rozkładu na
> składowe ani porównania między bazami, ale **musisz go przejrzeć i opisać w pracy**,
> czym Twoja implementacja się różni. Pominięcie istniejącego kodu jest w tym
> seminarium usterką poważną.

## Po co to badaczowi

Wskaźniki przełomowości publikacji liczy się z sieci cytowań. Sieć tę bierze się
z bazy danych bibliograficznych – a baz jest kilka i **każda widzi trochę co innego**.
Jedna indeksuje więcej czasopism, druga lepiej pokrywa nauki humanistyczne, trzecia
inaczej dopasowuje odwołania do rekordów.

Konsekwencja jest taka, że ta sama publikacja może dostać różny wskaźnik w zależności
od tego, skąd wzięto dane. Przy publikacjach, o których toczy się spór, różnica bywa
rozstrzygająca. Problem ten jest w naukometrii znany i rzadko badany wprost, bo mało
kto ma dostęp do kilku baz naraz i możliwość policzenia tego samego wskaźnika
równolegle.

Artykuł ten dostęp udostępnia: podaje zbiór zbudowany przez skrzyżowanie **trzech
baz** i przeznaczony do liczenia wskaźników przełomowości. Otwiera to pytanie, na
które wcześniej nie było materiału – jak bardzo wnioski zależą od wyboru źródła
danych.

Drugi wątek dotyczy samego wskaźnika. Klasyczna postać ściska w jedną liczbę dwie
różne rzeczy: to, na ile praca **wypiera** dotychczasowe ustalenia, i to, na ile je
**utrwala**. Praca może robić jedno i drugie naraz, a wskaźnik pokaże wtedy wartość
pośrednią, nieodróżnialną od pracy, która nie robi ani jednego, ani drugiego.
Rozłożenie wskaźnika na dwie składowe rozróżnia te przypadki.

Dla badacza polityki naukowej narzędzie liczące obie składowe i porównujące je
między bazami pozwala sprawdzić, na ile jego wnioski są artefaktem doboru danych.

## Algorytm

**Wejście.** Listy krawędzi cytowań z co najmniej jednej bazy; przyporządkowanie
identyfikatorów między bazami; lata publikacji; opcjonalnie dziedziny.

**Wyjście.** Dla każdej publikacji i każdej bazy: składowa destabilizująca, składowa
konsolidująca, wskaźnik klasyczny, wartości znormalizowane w obrębie dziedziny
i rocznika; miary zgodności między bazami.

**Kroki.**

1. Sprawdzenie danych: spójność przyporządkowania identyfikatorów, brak cykli,
   kompletność lat.
2. Wyznaczenie dla każdej publikacji zbiorów prac cytujących: cytujących tylko ją,
   cytujących ją i jej źródła, cytujących tylko źródła.
3. Złożenie obu składowych z liczności tych zbiorów.
4. Normalizacja w obrębie dziedziny i rocznika.
5. Powtórzenie dla każdej bazy i zestawienie wyników.
6. Miary zgodności między bazami: korelacja rangowa, odsetek zgodnych klasyfikacji.

**Wzory.** Podstawą jest ten sam podział prac cytujących co w temacie 04: $N_i$ to prace
cytujące wyłącznie publikację, $N_j$ prace cytujące ją razem ze źródłami, $N_k$ prace
cytujące wyłącznie źródła. Wskaźnik klasyczny to

$$DI = \frac{N_i - N_j}{N_i + N_j + N_k}$$

Rozkład na dwie składowe polega na tym, żeby nie odejmować liczników, lecz podać je osobno:

$$DI_{\text{destab}} = \frac{N_i}{N_i + N_j + N_k}, \qquad DI_{\text{konsol}} = \frac{N_j}{N_i + N_j + N_k}$$

Pierwsza składowa mierzy **wypieranie** źródeł, druga ich **utrwalanie**. Wskaźnik klasyczny
jest ich różnicą, więc publikacja o obu składowych wysokich i publikacja o obu niskich mogą
dać tę samą wartość, mimo że opisują zupełnie różne zjawiska. Rozdzielenie składowych
przywraca tę informację.

Zachodzi przy tym

$$DI_{\text{destab}} + DI_{\text{konsol}} + \frac{N_k}{N_i + N_j + N_k} = 1$$

więc trzy frakcje sumują się do jedności i stanowią pełny rozkład prac cytujących. Jest to
niezmiennik nadający się wprost na test.

Dokładne warianty wskaźnika liczone przez autorów, przyjęte okno czasowe oraz sposób
traktowania autocytowań przepisz z opisu zbioru.

**Co wynotować z artykułu.** Z opisu zbioru i metody: dokładne definicje obu
składowych; sposób przyporządkowania rekordów między bazami wraz z odsetkiem
dopasowań; przyjęte okno czasowe; traktowanie autocytowań; postać normalizacji
dziedzinowej; znane ograniczenia zbioru wskazane przez autorów. Ostatnie jest
gotowym materiałem do sekcji o granicach stosowalności.

## Kontrakt

**Warunki wstępne.** Listy krawędzi bez powtórzeń i bez krawędzi do samego siebie;
przyporządkowanie identyfikatorów wzajemnie jednoznaczne w obrębie dopasowanych
rekordów; lata publikacji obecne przy zadanej normalizacji.

**Niezmienniki.** Obie składowe są nieujemne i sumują się do wartości nie większej
niż jeden. Publikacja bez źródeł nie ma wskaźnika. Wynik nie zależy od kolejności
krawędzi. Suma składowych i trzeciej frakcji równa się jedności.

**Wyjście.** Klasa `przelomowosc_por` ze składnikami: ramka wyników w podziale na
bazy, wartości znormalizowane, miary zgodności, odsetek dopasowanych rekordów.

**Błędy zatrzymujące wykonanie.** Cykl w grafie cytowań; krawędź do samego siebie;
niejednoznaczne przyporządkowanie identyfikatorów; brak lat przy żądanej normalizacji.

## Plan pakietu

| Plik | Odpowiedzialność |
|---|---|
| `R/przygotowanie_danych.R` | walidacja, budowa macierzy rzadkich, przyporządkowanie baz |
| `R/skladowe.R` | destabilizacja i konsolidacja z liczności zbiorów |
| `R/normalizacja.R` | normalizacja dziedzinowa i rocznikowa |
| `R/zgodnosc.R` | miary zgodności między bazami |
| `R/klasy_s3.R` | obiekt wyniku, metody `print` i `summary` |
| `R/wizualizacja.R` | rozrzut obu składowych, porównanie baz |

Zależności: pakiet do macierzy rzadkich oraz `ggplot2`. **Liczności wyznaczaj
operacjami na macierzach**, nie pętlami po publikacjach.

## Dane

**Procedura generowania.** Budujesz graf cytowań o **zadanych proporcjach**:
część publikacji wypiera źródła, część je utrwala, część robi jedno i drugie.
Znasz oczekiwane wartości obu składowych. Następnie **symulujesz niepełne pokrycie
bazy**, usuwając losowo część krawędzi, i sprawdzasz, jak zmieniają się wskaźniki.
To bezpośrednio odpowiada na pytanie badawcze.

Parametry: liczba publikacji, rozkład liczby źródeł i cytowań, proporcje trzech
typów publikacji, odsetek usuniętych krawędzi, ziarno.

**Przypadki o znanym wyniku.** Wszyscy cytujący pomijają źródła: destabilizacja
maksymalna, konsolidacja zerowa. Wszyscy cytujący cytują też źródła: odwrotnie.
Publikacja bez cytowań: obie składowe niezdefiniowane albo zerowe zgodnie z decyzją
zapisaną w specyfikacji.

**Przypadki patologiczne.** Graf pusty; publikacja bez źródeł; identyfikatory
niedopasowane między bazami; okno czasowe wykluczające wszystkie cytowania.

**Zbiór empiryczny.** Zbiór udostępniony przez autorów artykułu. Sprawdź licencję
i sposób cytowania. Jeżeli pełny zbiór jest za duży na komputer osobisty, pracuj na
podzbiorze dziedzinowym i **opisz sposób jego wyboru** – to jest część metodologii,
nie szczegół techniczny.

## Mapowanie na pracę

| Sekcja briefu | Rozdział pracy |
|---|---|
| Po co to badaczowi, zależność od bazy | Wprowadzenie: tło i luka |
| Algorytm, definicje składowych | Rozdział 1: aparat formalny |
| Kontrakt, ograniczenia zbioru | Rozdział 1: granice stosowalności |
| Plan pakietu, dane, wydajność | Rozdział 2 |
| Porównanie baz | Rozdział 3 |

**Wstępne pytanie badawcze.** Jak bardzo klasyfikacja publikacji na przełomowe
i utrwalające zależy od wyboru bazy danych bibliograficznych, i przy jakim poziomie
niepełności pokrycia wnioski przestają być stabilne?

## Polecenia startowe

1. Budowa macierzy rzadkich z list krawędzi wraz z walidacją i przyporządkowaniem baz.
2. Liczności trzech zbiorów na operacjach macierzowych, bez pętli.
3. Obie składowe i wskaźnik klasyczny zgodnie z Twoimi notatkami.
4. Normalizacja dziedzinowa i rocznikowa.
5. Procedura generowania z kontrolowanym usuwaniem krawędzi.
6. Miary zgodności między bazami i wykres porównawczy.

## Pułapki

**Pętla po publikacjach.** Przy realnym zbiorze kod się nie skończy. Przeniesienie
liczności na operacje macierzowe jest sednem części inżynierskiej pracy.

**Wskaźnik klasyczny jako suma składowych.** Sprawdź w artykule, jaka dokładnie jest
zależność między nimi. Założenie oparte na intuicji da wyniki niezgodne z literaturą
i trudne do wykrycia.

**Publikacje niedopasowane między bazami.** Nie są błędem, tylko wynikiem: mówią
o pokryciu baz. Odrzucenie ich bez odnotowania odsetka zafałszuje porównanie, bo
zostaną tylko publikacje dobrze indeksowane wszędzie.

**Normalizacja dziedzinowa.** Dziedziny różnią się kulturą cytowania na tyle, że
porównywanie wartości surowych między nimi nie ma sensu. Sposób przypisania dziedziny
jest decyzją, którą trzeba opisać.

**Na obronie** musisz umieć wyjaśnić, dlaczego jedna liczba nie wystarcza do opisania
przełomowości, i podać przykład dwóch publikacji o tym samym wskaźniku klasycznym
i różnym charakterze.

## Literatura

Artykuł źródłowy: `xu2025crossdi`.

Wprowadzenie: praca wprowadzająca wskaźnik przełomowości; opracowanie o porównywalności
baz danych bibliograficznych. Dwie do czterech pozycji dobierasz sam. Temat pokrewny
z tematem 04 – warto uzgodnić wspólną część literatury i porównać wyniki.

Środowisko: `rcore2026`. Wymagania formalne: `standardyEPI`.
