# Temat 05. Ramy interpretacyjne w dyskursie spolaryzowanym

## Metryka

| | |
|---|---|
| Artykuł źródłowy | Sarmiento, Hernan; Córdova, Ricardo; Ortiz, Jorge; Bravo-Marquez, Felipe; Santos, Marcelo; Valenzuela, Sebastián (2025). *Unsupervised Framing Analysis for Social Media Discourse in Polarizing Events*. ACM Transactions on the Web |
| Identyfikator | [10.1145/3711912](https://doi.org/10.1145/3711912) |
| Dostęp | przez bibliotekę UJ |
| Dziedzina | komunikacja społeczna, analiza dyskursu |
| Proponowany tytuł pracy | Pakiet R do wykrywania ram interpretacyjnych w dyskursie sieciowym jako przykład zastosowania analizy skupień w badaniach nad komunikacją |
| Proponowana nazwa pakietu | `RamyR` |
| Trudność | ●● |

## Po co to badaczowi

Kiedy toczy się spór publiczny – o aborcję, o klimat, o wybory – strony nie tylko
mówią różne rzeczy. Mówią o **różnych aspektach tej samej sprawy**. Jedni mówią
o wolności, drudzy o bezpieczeństwie, jedni o kosztach, drudzy o sprawiedliwości.
Badania nad komunikacją nazywają to ramami interpretacyjnymi i od dekad pokazują,
że rama decyduje o odbiorze mocniej niż same fakty.

Tradycyjnie ramy wykrywa się ręcznie: badacz układa listę ram na podstawie
literatury, a koderzy przypisują do nich wypowiedzi. Podejście działa, ale ma dwie
wady, które przy dyskursie sieciowym stają się rozstrzygające. Skalowanie: nikt nie
zakoduje ręcznie miliona wpisów. I zamknięcie na nowe: lista ram powstaje przed
badaniem, więc rama, której badacz nie przewidział, nie zostanie znaleziona – 
a w zdarzeniach nagłych to właśnie nowe ramy są najciekawsze.

Artykuł proponuje podejście **nienadzorowane**: nie zakładać ram z góry, tylko
wyłonić je ze struktury samego dyskursu, grupując wypowiedzi po podobieństwie
znaczeniowym. Do tego dokłada miary pozwalające ocenić, czy wyłoniona grupa jest
spójna, czy dotyczy sprawy będącej przedmiotem sporu, i **jak bardzo dzieli strony**.

Dla badacza komunikacji społecznej jest to narzędzie do stawiania pytań, których
ręczne kodowanie nie obsługuje: które ramy są wspólne obu stronom, a które
wyłącznie jednej, i jak to się zmienia w czasie trwania zdarzenia.

## Algorytm

**Wejście.** Zbiór wypowiedzi wraz z ich reprezentacjami wektorowymi; opcjonalnie
przynależność autora do jednej ze stron sporu; opcjonalnie miara zasięgu wypowiedzi
i znacznik czasu.

**Wyjście.** Przypisanie wypowiedzi do wyłonionych ram; dla każdej ramy miary
spójności, związku ze sprawą i różnicy między stronami; opcjonalnie przebieg w czasie.

**Kroki.**

1. Sprawdzenie wejścia: zgodność liczby wypowiedzi i wektorów, brak wymiarów
   o zerowej wariancji, brak wektorów zerowych.
2. Wyznaczenie macierzy podobieństwa między wypowiedziami.
3. Wyłonienie skupień odpowiadających ramom.
4. Dla każdego skupienia: miara spójności wewnętrznej oraz miara związku ze sprawą,
   liczona względem środka całego dyskursu.
5. Przy znanej przynależności stron: miara różnicy postaw między stronami w obrębie
   ramy.
6. Uporządkowanie ram według wybranej miary.

**Co wynotować z artykułu.** Z sekcji metodycznej: dokładne definicje wszystkich
miar wraz z ich zakresami; przyjętą metodę grupowania i sposób doboru jej parametrów;
sposób wyznaczenia środka dyskursu; definicję miary różnicy między stronami oraz to,
czym w artykule jest postawa. Wynotuj też, jak autorzy oceniają jakość wyłonionych
ram – to jest podstawa Twojego rozdziału trzeciego.

## Kontrakt

**Warunki wstępne.** Macierz reprezentacji o liczbie wierszy równej liczbie
wypowiedzi; brak wektorów zerowych; co najmniej tyle wypowiedzi, ile wymaga metoda
grupowania; przy podanej przynależności stron co najmniej dwie wypowiedzi na stronę.

**Niezmienniki.** Miara spójności należy do przedziału jednostkowego. Miara różnicy
między stronami jest nieujemna. Wynik nie zależy od kolejności wypowiedzi na wejściu.
Przeskalowanie wszystkich wektorów przez dodatnią stałą nie zmienia przypisania.

**Wyjście.** Klasa `ramy_dyskursu` ze składnikami: przypisanie, miary dla każdej
ramy, parametry grupowania, liczba wypowiedzi nieprzypisanych.

**Błędy zatrzymujące wykonanie.** Wektor zerowy; wymiar o zerowej wariancji;
niezgodność liczby wypowiedzi i wektorów; zbyt mała liczba wypowiedzi dla przyjętej
metody grupowania.

## Plan pakietu

| Plik | Odpowiedzialność |
|---|---|
| `R/przygotowanie_danych.R` | walidacja reprezentacji, normalizacja, obsługa zasięgu |
| `R/podobienstwo.R` | macierz podobieństwa |
| `R/ramy.R` | grupowanie i wyłanianie ram |
| `R/miary.R` | spójność, związek ze sprawą, różnica między stronami |
| `R/klasy_s3.R` | obiekt wyniku, metody `print` i `summary` |
| `R/wizualizacja.R` | mapa ram, przebieg w czasie |

Zależności: pakiet do grupowania gęstościowego oraz `ggplot2`. **Reprezentacje
wektorowe przyjmujesz jako wejście**, a nie generujesz w pakiecie: model językowy
jest zależnością, której nie da się utrzymać w pakiecie przechodzącym sprawdzenie
zgodności.

## Dane

**Procedura generowania.** Losujesz zadaną liczbę środków ram w przestrzeni
wektorowej, wokół nich generujesz wypowiedzi z kontrolowanym rozrzutem, a stronom
sporu przypisujesz różne rozkłady postaw w obrębie ram. Znasz wtedy prawdziwe
przypisanie i prawdziwe różnice między stronami, więc możesz zmierzyć skuteczność
wyłaniania ram.

Parametry: liczba ram, wypowiedzi na ramę, wymiar przestrzeni, rozrzut wewnątrz ramy,
odległość między ramami, siła polaryzacji, ziarno.

**Przypadki o znanym wyniku.** Ramy dobrze rozdzielone: metoda odtwarza przypisanie
niemal bezbłędnie. Jedna rama: miara spójności maksymalna, różnica między stronami
policzalna ręcznie. Ramy nakładające się całkowicie: metoda nie powinna ich rozdzielić.

**Przypadki patologiczne.** Wszystkie wypowiedzi identyczne; jedna wypowiedź na
stronę; wymiar o zerowej wariancji.

**Zbiór empiryczny.** Otwarte zbiory wypowiedzi z serwisów społecznościowych
udostępniane do badań, wraz z gotowymi reprezentacjami wektorowymi. **Sprawdź
licencję i wymagania dotyczące danych osobowych** – to jest w tym temacie warunek
konieczny, nie formalność. Rozważ zbiór zanonimizowany albo pochodzący z archiwum
badawczego.

## Mapowanie na pracę

| Sekcja briefu | Rozdział pracy |
|---|---|
| Po co to badaczowi | Wprowadzenie: tło i luka |
| Algorytm, co wynotować | Rozdział 1: aparat formalny |
| Kontrakt, ograniczenia metody | Rozdział 1: założenia |
| Plan pakietu, dane | Rozdział 2 |
| Zbiór empiryczny, kwestie etyczne | Rozdział 3 |

**Wstępne pytanie badawcze.** Przy jakim stopniu nakładania się ram metoda przestaje
je rozróżniać i jak wpływa to na wnioski o polaryzacji wyciągane z takiej analizy?

## Polecenia startowe

1. Macierz podobieństwa z macierzy reprezentacji, na operacjach macierzowych.
2. Miary spójności i związku ze sprawą zgodnie z Twoimi notatkami.
3. Miara różnicy między stronami przy zadanej przynależności.
4. Procedura generowania z kontrolowanym nakładaniem się ram.
5. Dane naruszające warunki wstępne wraz z oczekiwanym zachowaniem.
6. Badanie skuteczności odtwarzania przypisania w funkcji odległości między ramami.

## Pułapki

**Generowanie reprezentacji wewnątrz pakietu.** Narzędzie zaproponuje wywołanie
modelu językowego. Pakiet przestanie się wtedy instalować, a wyniki przestaną być
odtwarzalne. Reprezentacje są wejściem.

**Skupienie to nie rama.** Metoda wyłania grupy podobnych wypowiedzi. Nazwanie takiej
grupy ramą interpretacyjną jest **interpretacją badacza**, wymagającą uzasadnienia.
Praca musi to rozróżnienie utrzymać w całym rozdziale trzecim.

**Liczba ram.** Metody gęstościowe nie wymagają jej podania, ale wynik zależy od
parametrów. Sprawdź stabilność przy różnych ustawieniach i opisz to jako ograniczenie.

**Wypowiedzi nieprzypisane.** Nie są błędem, tylko informacją. Wysoki odsetek
oznacza dyskurs bez wyraźnych ram i tak trzeba go opisać.

**Dane osobowe.** Wypowiedzi z serwisów społecznościowych dotyczą realnych osób.
Anonimizacja, podstawa przetwarzania i sposób publikowania przykładów wymagają
rozstrzygnięcia **przed** rozpoczęciem analizy i opisania w pracy.

**Na obronie** musisz umieć wyjaśnić, dlaczego bliskość w przestrzeni wektorowej
ma cokolwiek wspólnego z podobieństwem znaczeniowym, i gdzie ta odpowiedniość zawodzi.

## Literatura

Artykuł źródłowy: `sarmiento2025framing`.

Wprowadzenie: klasyczne opracowanie o ramach interpretacyjnych w naukach
o komunikacji; przegląd metod automatycznego wykrywania ram. Dwie do czterech
pozycji dobierasz sam. Temat jest pokrewny z tematem 02 w części dotyczącej
reprezentacji tekstu.

Środowisko: `rcore2026`. Wymagania formalne: `standardyEPI`.
