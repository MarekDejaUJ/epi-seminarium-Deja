# Temat 12. Wyjaśnienia decyzji sieci grafowej

## Metryka

| | |
|---|---|
| Artykuł źródłowy | Cai, Ruichu; Zhu, Yuxuan; Chen, Xuexin; Fang, Yuan; Wu, Min; Qiao, Jie; Hao, Zhifeng (2025). *On the probability of necessity and sufficiency of explaining Graph Neural Networks: A lower bound optimization approach*. Neural Networks |
| Identyfikator | [10.1016/j.neunet.2024.107065](https://doi.org/10.1016/j.neunet.2024.107065) |
| Dostęp | przez bibliotekę UJ |
| Dziedzina | sieci informacyjne, wyjaśnialność decyzji |
| Proponowany tytuł pracy | Pakiet R do wyjaśniania decyzji modeli grafowych jako przykład zastosowania kryteriów przyczynowych w analizie sieci społecznych |
| Proponowana nazwa pakietu | `WyjasnieniaGR` |
| Trudność | ●●●● |

## Po co to badaczowi

Sieci są naturalnym opisem wielu zjawisk społecznych: znajomości, współautorstwa,
cytowań, udostępnień, przepływów informacji. Modele uczące się na grafach potrafią
w takich sieciach przewidywać – kto się zradykalizuje, który wpis się rozejdzie,
która praca zyska cytowania. Coraz częściej z nich korzystamy.

I coraz częściej stajemy przed pytaniem, na które model nie odpowiada: **dlaczego**.
Które połączenia zdecydowały o tej prognozie? Bez odpowiedzi model jest nieużyteczny
badawczo, bo badacza nie interesuje sama prognoza, tylko mechanizm.

Metody wyjaśniania modeli grafowych istnieją, ale większość szuka fragmentu sieci,
który **wystarczy** do uzyskania tej samej prognozy. To za mało. Fragment może
wystarczać i jednocześnie być zbędny, bo prognoza wyszłaby taka sama i bez niego.
Wyjaśnienie warte swojej nazwy musi spełniać oba warunki naraz: bez tego fragmentu
prognoza by się zmieniła (**konieczność**) i sam ten fragment do niej wystarcza
(**dostateczność**).

Sformułowanie to pochodzi z teorii przyczynowości i ma znany kłopot: odpowiedniej
wielkości zwykle nie da się policzyć. Artykuł proponuje wyjście – optymalizować
**dolne ograniczenie** tej wielkości, które policzyć się da, a które gwarantuje,
że znaleziony fragment jest co najmniej tak dobry.

Dla badacza sieci społecznych oznacza to wyjaśnienia, o których da się powiedzieć
coś mocniejszego niż „model zwrócił uwagę na te krawędzie".

## Algorytm

**Wejście.** Graf w postaci macierzy sąsiedztwa, atrybuty wierzchołków, wytrenowany
model zwracający prognozę dla grafu, wskazanie wierzchołka lub grafu do wyjaśnienia,
parametr kary za rozmiar wyjaśnienia.

**Wyjście.** Maska krawędzi lub wierzchołków wskazująca fragment wyjaśniający;
wartości składowe konieczności i dostateczności; rozmiar wyjaśnienia.

**Kroki.**

1. Sprawdzenie wejścia: zgodność wymiarów macierzy sąsiedztwa i atrybutów, poprawność
   wyjścia modelu, obecność wskazanego wierzchołka.
2. Zastąpienie wyboru zero-jedynkowego **maską ciągłą** z przedziału jednostkowego.
3. Wyznaczenie prognozy dla grafu z zastosowaną maską oraz dla grafu z maską
   dopełniającą.
4. Złożenie funkcji celu z obu prognoz i kary za rozmiar maski.
5. Optymalizacja maski metodą gradientową.
6. Wyostrzenie maski do postaci zero-jedynkowej i sprawdzenie wartości składowych.

**Co wynotować z artykułu.** Z sekcji metodycznej: definicję prawdopodobieństwa
konieczności i dostateczności w tym zastosowaniu; **postać dolnego ograniczenia
wraz z dowodem, że jest ograniczeniem** – to jest sedno artykułu; pełną funkcję celu
z karą; sposób relaksacji wyboru do maski ciągłej; regułę wyostrzania maski;
założenia dotyczące modelu, do którego metoda się stosuje.

## Kontrakt

**Warunki wstępne.** Macierz sąsiedztwa kwadratowa, o wymiarze zgodnym z liczbą
wierszy atrybutów; model zwracający wartość liczbową dla podanego grafu; parametr
kary nieujemny; wskazany wierzchołek istniejący w grafie.

**Niezmienniki.** Maska należy do przedziału jednostkowego przed wyostrzeniem.
Funkcja celu nie rośnie między iteracjami. Zwiększenie kary nie zwiększa rozmiaru
wyjaśnienia. Przy karze zerowej maska dąży do pełnego grafu.

**Wyjście.** Klasa `wyjasnienie_grafu` ze składnikami: maska, wartości składowe,
rozmiar wyjaśnienia, przebieg funkcji celu, liczba iteracji.

**Błędy zatrzymujące wykonanie.** Macierz niekwadratowa; niezgodność wymiarów;
model zwracający wartość nieliczbową; ujemny parametr kary; brak zbieżności.

## Plan pakietu

| Plik | Odpowiedzialność |
|---|---|
| `R/przygotowanie_danych.R` | walidacja grafu i atrybutów, sprawdzenie modelu |
| `R/maska.R` | relaksacja ciągła, zastosowanie maski do grafu |
| `R/cel.R` | funkcja celu wraz z karą |
| `R/optymalizacja.R` | spadek gradientu, warunek zatrzymania |
| `R/klasy_s3.R` | obiekt wyniku, metody `print` i `summary` |
| `R/wizualizacja.R` | graf z wyróżnionym wyjaśnieniem |

Zależności: pakiet do grafów, `stats`, `ggplot2`. **Model przyjmujesz jako funkcję
podaną przez użytkownika**, a nie trenujesz w pakiecie: uczenie sieci grafowej
wprowadziłoby zależności, których nie da się utrzymać w pakiecie przechodzącym
sprawdzenie zgodności. Do testów wystarczy prosty model o znanym zachowaniu.

## Dane

**Procedura generowania.** Budujesz grafy, w których **wiesz, który fragment
decyduje** o prognozie: wszczepiasz w losowy graf określony motyw i definiujesz
model zwracający wartość zależną wyłącznie od obecności tego motywu. Metoda powinna
wskazać dokładnie ten fragment. Odsetek poprawnie wskazanych krawędzi jest miarą
skuteczności.

Parametry: liczba wierzchołków, gęstość grafu tła, rodzaj i liczba motywów, poziom
szumu w modelu, ziarno.

**Przypadki o znanym wyniku.** Motyw jedyną przyczyną prognozy: maska wskazuje
wyłącznie jego krawędzie. Prognoza niezależna od grafu: maska pusta przy niezerowej
karze. Graf o jednej krawędzi: wynik policzalny ręcznie.

**Przypadki patologiczne.** Graf pusty; graf pełny; wierzchołek izolowany; model
zwracający stałą.

**Zbiór empiryczny.** Otwarte sieci społeczne albo cytowań udostępniane do badań,
wraz z prostym modelem wytrenowanym poza pakietem. Sprawdź licencję i wymagania
dotyczące danych o osobach.

## Mapowanie na pracę

| Sekcja briefu | Rozdział pracy |
|---|---|
| Po co to badaczowi, konieczność i dostateczność | Wprowadzenie: tło i luka |
| Algorytm, dolne ograniczenie | Rozdział 1: aparat formalny |
| Kontrakt, założenia o modelu | Rozdział 1: granice stosowalności |
| Plan pakietu, dane, badanie skuteczności | Rozdział 2 |
| Zbiór empiryczny | Rozdział 3 |

**Wstępne pytanie badawcze.** Jak wielkość kary za rozmiar wyjaśnienia wpływa na
równowagę między koniecznością a dostatecznością i przy jakich wartościach
wyjaśnienie przestaje być czytelne dla badacza?

## Polecenia startowe

1. Zastosowanie maski ciągłej do macierzy sąsiedztwa, z zachowaniem różniczkowalności.
2. Funkcja celu wraz z karą, zgodnie z Twoimi notatkami o dolnym ograniczeniu.
3. Pętla optymalizacji z jawnym warunkiem zatrzymania i śledzeniem funkcji celu.
4. Procedura generowania grafów z wszczepionym motywem oraz model o znanym zachowaniu.
5. Dane naruszające warunki wstępne wraz z oczekiwanym zachowaniem.
6. Badanie skuteczności w funkcji gęstości grafu tła.

## Pułapki

**Sama dostateczność.** Narzędzie zaproponuje metodę szukającą fragmentu
wystarczającego, bo takich implementacji jest najwięcej. Artykuł wymaga obu
składowych naraz, a różnica jest tym, co czyni temat wartym pracy.

**Dolne ograniczenie a wielkość docelowa.** Optymalizujesz ograniczenie, nie samą
wielkość. Wynik jest gwarancją, a nie dokładną wartością. Praca musi to rozróżnienie
utrzymać, bo inaczej rozdział trzeci przypisuje metodzie własność, której nie ma.

**Wyostrzanie maski.** Maska ciągła po optymalizacji nie jest wyjaśnieniem. Reguła
zamiany na zero-jedynkową jest częścią metody i zmienia wynik. Progowanie dobrane
arbitralnie trzeba opisać jako decyzję.

**Model jako zależność.** Trenowanie sieci grafowej wewnątrz pakietu zamknie drogę
do sprawdzenia zgodności. Model jest wejściem.

**Na obronie** musisz umieć podać przykład fragmentu grafu, który jest dostateczny,
ale nie konieczny, i wyjaśnić, dlaczego byłby złym wyjaśnieniem.

## Literatura

Artykuł źródłowy: `cai2025pns`.

Wprowadzenie: opracowanie o wyjaśnialności modeli grafowych; podręcznikowe omówienie
prawdopodobieństw konieczności i dostateczności. Dwie do czterech pozycji dobierasz
sam. Temat pokrewny z tematem 01 w części pojęciowej.

Środowisko: `rcore2026`. Wymagania formalne: `standardyEPI`.
