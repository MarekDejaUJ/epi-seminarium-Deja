# Temat 09. Wskaźnik łączący liczbę publikacji z ich oddziaływaniem

## Metryka

| | |
|---|---|
| Artykuł źródłowy | Leydesdorff, Loet; Bornmann, Lutz; Adams, Jonathan (2019). *The Integrated Impact Indicator Revisited (I3\*): A Non-Parametric Alternative to the Journal Impact Factor* |
| Identyfikator | [arXiv:1812.03448](https://arxiv.org/abs/1812.03448) |
| Dostęp | otwarty |
| Dziedzina | bibliometria, polityka naukowa |
| Proponowany tytuł pracy | Pakiet R do nieparametrycznej oceny oddziaływania publikacji jako przykład zastosowania klas percentylowych w naukometrii |
| Proponowana nazwa pakietu | `WskaznikI3R` |
| Trudność | ●● |

## Po co to badaczowi

Wskaźnik oddziaływania czasopisma to średnia liczba cytowań przypadająca na artykuł.
Jest to jedna z najczęściej używanych liczb w polityce naukowej i jednocześnie liczba
źle policzona, z powodu, który zna każdy, kto raz spojrzał na rozkład cytowań.

Rozkład ten jest skrajnie skośny. W typowym czasopiśmie kilka procent artykułów zbiera
większość cytowań, a połowa nie zbiera prawie nic. Średnia arytmetyczna z takiego
rozkładu nie opisuje ani typowego artykułu, ani żadnego innego: jest zdominowana przez
ogon. Dwa czasopisma o identycznej średniej mogą mieć zupełnie inny rozkład, a decyzje
podejmuje się na podstawie średniej.

Drugi kłopot jest taki, że średnia **gubi wielkość**. Czasopismo publikujące trzydzieści
artykułów rocznie i czasopismo publikujące trzy tysiące mogą mieć tę samą wartość
wskaźnika, choć ich wkład w obieg wiedzy jest nieporównywalny.

Artykuł proponuje wskaźnik zbudowany inaczej. Zamiast uśredniać cytowania, przypisuje
każdą publikację do **klasy percentylowej** wyznaczonej w zbiorze odniesienia i sumuje
publikacje z wagami zależnymi od klasy. Znika założenie o rozkładzie, bo liczy się tylko
pozycja publikacji wśród innych, a nie sama liczba cytowań. Wielkość dorobku zostaje
w wyniku, bo to jest suma, nie średnia. Wynik da się też podzielić przez liczbę publikacji
i wtedy otrzymuje się wartość oczekiwaną przypadającą na jedną pracę.

Dla badacza polityki naukowej jest to narzędzie pozwalające porównywać jednostki różnej
wielkości bez udawania, że rozkład cytowań jest symetryczny.

## Algorytm

**Wejście.** Zbiór publikacji z liczbą cytowań, zbiór odniesienia wyznaczający percentyle
(dziedzina, rocznik, typ dokumentu) oraz schemat klas i wag.

**Wyjście.** Wartość wskaźnika, wartość znormalizowana przez liczbę publikacji, liczności
klas rozłącznych, udział każdej klasy w wyniku.

**Wzory.** Wskaźnik jest sumą ważonych liczb publikacji w klasach percentylowych:

$$I3 = \sum_{i} x_i \cdot W_i$$

gdzie $x_i$ to liczba publikacji w klasie $i$, a $W_i$ waga tej klasy.

Schemat zapisuje się w notacji

$$I3(PR_1\text{-}W_1,\; PR_2\text{-}W_2,\; \ldots,\; PR_n\text{-}W_n)$$

w której $PR$ jest **dolnym progiem** klasy percentylowej, a $W$ jej wagą. Wariant
zaproponowany w artykule to

$$I3^{*} = I3(99\text{-}100,\; 90\text{-}10,\; 50\text{-}2,\; 0\text{-}1)$$

czyli: publikacje w górnym jednym procencie z wagą sto, w górnych dziesięciu procentach
z wagą dziesięć, w górnej połowie z wagą dwa, pozostałe z wagą jeden.

Wcześniejszy schemat sześcioklasowy zapisuje się jako
$I3(99\text{-}6,\, 95\text{-}5,\, 90\text{-}4,\, 75\text{-}3,\, 50\text{-}2,\, 0\text{-}1)$,
a popularny wskaźnik udziału publikacji w górnych dziesięciu procentach jest przypadkiem
szczególnym $I3(90\text{-}1)$. Ten sam wzór obsługuje więc całą rodzinę wskaźników,
co jest głównym powodem, dla którego warto go zaimplementować raz.

**Klasy rozłączne.** Progi są zagnieżdżone: publikacja z górnego procenta należy też do
górnych dziesięciu procent i do górnej połowy. Liczności trzeba więc **skorygować przez
odejmowanie**, żeby nie policzyć jej wielokrotnie. Jest to krok, który najłatwiej
pominąć, i jednocześnie ten, który przesądza o poprawności wyniku.

**Wersja niezależna od wielkości.** Podzielenie wyniku przez liczbę publikacji

$$\frac{I3^{*}}{N}$$

daje wartość oczekiwaną przypadającą na jedną pracę, którą można traktować jako wartość
odniesienia przy sprawdzaniu, czy konkretna publikacja wypada powyżej czy poniżej
oczekiwania.

**Kroki.**

1. Sprawdzenie danych: kompletność liczby cytowań, obecność zbioru odniesienia,
   poprawność schematu klas i wag.
2. Wyznaczenie rangi percentylowej każdej publikacji w zbiorze odniesienia.
3. Przypisanie publikacji do klas według progów.
4. Korekta liczności do klas rozłącznych przez odejmowanie.
5. Przemnożenie przez wagi i zsumowanie.
6. Wyznaczenie wersji znormalizowanej i udziału klas w wyniku.

**Co wynotować z artykułu.** Sposób wyznaczania rangi percentylowej wraz z obsługą
remisów, bo przy dużej liczbie publikacji o zerowej liczbie cytowań remisy są masowe
i sposób ich potraktowania zmienia wynik; procedurę normalizacji dziedzinowej; przykład
liczbowy z tabeli, w której autorzy pokazują rachunek krok po kroku – posłuży za przypadek
analityczny.

## Kontrakt

**Warunki wstępne.** Liczby cytowań nieujemne i całkowite; zbiór odniesienia niepusty;
progi klas rosnące i zawarte w przedziale od zera do stu; wagi dodatnie; liczba progów
równa liczbie wag.

**Niezmienniki.** Suma liczności klas rozłącznych równa się liczbie publikacji. Wynik
jest nieujemny. Dodanie publikacji nie zmniejsza wyniku. Wartość znormalizowana mieści
się między najmniejszą a największą wagą schematu. Przy schemacie jednoklasowym z wagą
jeden wynik równa się liczbie publikacji.

**Wyjście.** Klasa `wskaznik_i3` ze składnikami: wartość, wartość znormalizowana,
liczności klas rozłącznych, udziały klas, użyty schemat.

**Błędy zatrzymujące wykonanie.** Progi nierosnące; liczba wag różna od liczby progów;
ujemna liczba cytowań; pusty zbiór odniesienia.

## Plan pakietu

| Plik | Odpowiedzialność |
|---|---|
| `R/przygotowanie_danych.R` | walidacja publikacji, zbioru odniesienia i schematu |
| `R/percentyle.R` | rangi percentylowe wraz z obsługą remisów |
| `R/klasy.R` | przypisanie do klas i korekta do klas rozłącznych |
| `R/wskaznik.R` | suma ważona, wersja znormalizowana, udziały klas |
| `R/klasy_s3.R` | obiekt wyniku, metody `print` i `summary` |
| `R/wizualizacja.R` | udział klas w wyniku, porównanie jednostek |

Zależności: `stats` i `ggplot2`. Schemat klas przyjmuj jako **jeden argument o jawnej
strukturze**, nie jako kilka osobnych wektorów – dzięki temu ta sama funkcja obsłuży
wszystkie warianty z artykułu bez zmiany kodu.

## Dane

**Procedura generowania.** Generujesz rozkład cytowań o **kontrolowanej skośności**,
na przykład z rozkładu potęgowego o zadanym wykładniku, dla kilku jednostek różnej
wielkości. Znasz wtedy prawdziwe uporządkowanie jednostek i możesz sprawdzić, kiedy
wskaźnik oparty na średniej daje inne uporządkowanie niż wskaźnik percentylowy. To jest
wprost odpowiedź na pytanie badawcze.

Parametry: liczba jednostek, liczba publikacji w jednostce, wykładnik rozkładu, odsetek
publikacji niecytowanych, ziarno.

**Przypadki o znanym wyniku.** Wszystkie publikacje poniżej mediany: wynik równy liczbie
publikacji. Jedna publikacja w każdej z czterech klas przy schemacie z artykułu: wynik
równy sumie wag, czyli sto trzynaście. Schemat jednoklasowy z wagą jeden: wynik równy
liczbie publikacji.

**Przypadki patologiczne.** Wszystkie publikacje o zerowej liczbie cytowań, czyli jeden
wielki remis; zbiór odniesienia mniejszy od ocenianego zbioru; jedna publikacja w zbiorze
odniesienia.

**Zbiór empiryczny.** Otwarte dane bibliometryczne z liczbą cytowań: rejestry publikacji
otwartego dostępu, dane z otwartych baz cytowań albo zestawienia udostępniane przez
wydawców. Wystarczy kilka czasopism albo kilka jednostek z jednej dziedziny i jednego
rocznika. Sprawdź licencję i warunki wtórnego wykorzystania.

## Mapowanie na pracę

| Sekcja briefu | Rozdział pracy |
|---|---|
| Po co to badaczowi, skośność rozkładu cytowań | Wprowadzenie: tło i luka |
| Wzory, notacja schematu, klasy rozłączne | Rozdział 1: aparat formalny |
| Kontrakt, niezmienniki, obsługa remisów | Rozdział 1: granice stosowalności |
| Plan pakietu, procedura generowania | Rozdział 2 |
| Zbiór empiryczny, porównanie ze wskaźnikiem opartym na średniej | Rozdział 3 |

**Wstępne pytanie badawcze.** Przy jakim stopniu skośności rozkładu cytowań
uporządkowanie jednostek według wskaźnika opartego na średniej rozchodzi się
z uporządkowaniem według wskaźnika percentylowego, i które jednostki tracą, a które
zyskują na zmianie miary?

## Polecenia startowe

1. Walidacja publikacji, zbioru odniesienia i schematu klas z wagami.
2. Rangi percentylowe z jawną obsługą remisów, zgodnie z Twoimi notatkami.
3. Przypisanie do klas i korekta do klas rozłącznych przez odejmowanie.
4. Suma ważona, wersja znormalizowana i udziały klas w wyniku.
5. Procedura generowania rozkładów cytowań o kontrolowanej skośności.
6. Porównanie uporządkowań jednostek przy obu rodzajach wskaźnika.

## Pułapki

**Podwójne liczenie publikacji.** Klasy percentylowe są zagnieżdżone. Zsumowanie
liczności bez korekty daje wynik zawyżony i zawsze w tę samą stronę, więc błąd nie
rzuca się w oczy. Test na jednej publikacji w każdej klasie wychwyci go natychmiast.

**Remisy przy zerowych cytowaniach.** W realnych danych połowa publikacji potrafi mieć
zero cytowań. Sposób przypisania im rangi percentylowej przesądza o tym, ile z nich
wpadnie do górnej połowy, a to jest znacząca część wyniku. Decyzję trzeba opisać.

**Zbiór odniesienia.** Percentyl liczy się względem czegoś. Wzięcie za zbiór odniesienia
ocenianego zbioru zamiast dziedziny i rocznika daje wskaźnik mierzący coś innego, niż
się deklaruje.

**Porównywanie wartości nieznormalizowanych między jednostkami różnej wielkości.**
Wskaźnik jest sumą, więc rośnie z wielkością. To jest cecha, nie wada, ale w porównaniach
trzeba wiedzieć, którą wersję się podaje.

**Na obronie** musisz umieć wyjaśnić, dlaczego średnia jest złą miarą dla rozkładu
skośnego, i pokazać dwa zbiory publikacji o tej samej średniej liczbie cytowań i różnym
wskaźniku percentylowym.

## Literatura

Artykuł źródłowy: `leydesdorff2019i3`.

Wprowadzenie: opracowanie o rozkładach cytowań i ich skośności; krytyczne omówienie
wskaźnika oddziaływania czasopisma. Dwie do czterech pozycji dobierasz sam. Tematy
pokrewne: 04 i 14 – wszystkie trzy operują na danych cytowań i mogą korzystać z tego
samego zbioru.

Środowisko: `rcore2026`. Wymagania formalne: `standardyEPI`.
