# Temat 08. Wrażliwość na zmienne pominięte

## Metryka

| | |
|---|---|
| Artykuł źródłowy | Freidling, Tobias; Zhao, Qingyuan (2026). *Optimization-Based Sensitivity Analysis for Unmeasured Confounding Using Partial Correlations*. Journal of Computational and Graphical Statistics |
| Identyfikator | [10.1080/10618600.2025.2573156](https://doi.org/10.1080/10618600.2025.2573156) |
| Dostęp | przez bibliotekę UJ |
| Dziedzina | badania obserwacyjne, polityka edukacyjna i społeczna |
| Proponowany tytuł pracy | Pakiet R do analizy wrażliwości na zmienne pominięte jako przykład zastosowania optymalizacji z ograniczeniami w badaniach obserwacyjnych |
| Proponowana nazwa pakietu | `WrazliwoscR` |
| Trudność | ●●● |

## Po co to badaczowi

Ogromna część wiedzy o społeczeństwie pochodzi z badań, w których nikt niczego nie
losował. Porównujemy absolwentów różnych szkół, uczestników i nieuczestników
programu, czytelników i nieczytelników. I za każdym razem pada to samo pytanie:
a może różnica bierze się z czegoś, czego nie zmierzyliśmy?

Zarzut ten jest nie do odparcia w sposób ostateczny, bo dotyczy zmiennej, której
z definicji nie mamy. Można jednak odwrócić pytanie: **jak silna musiałaby być taka
zmienna**, żeby wynik przestał obowiązywać? Jeśli wystarczyłaby zmienna słabsza niż
zmierzony wiek respondenta, wynik jest kruchy. Jeśli musiałaby być silniejsza niż
wszystko, co znamy w tej dziedzinie, wynik się broni.

Istniejące metody odpowiadają na to pytanie, ale zwykle przy założeniach
o rozkładach albo tylko dla najprostszych modeli. Artykuł proponuje podejście
oparte na **korelacjach cząstkowych** i sformułowaniu zadania optymalizacyjnego,
dzięki czemu obywa się bez założeń o postaci rozkładu i obejmuje także modele ze
zmiennymi instrumentalnymi.

Dla badacza oznacza to możliwość dopisania do każdego wyniku zdania, którego dziś
zwykle brakuje: „wniosek upada dopiero wtedy, gdy istnieje zmienna pominięta
wyjaśniająca tyle a tyle zmienności obu stron". To jest uczciwsze niż zastrzeżenie
o „możliwych zmiennych zakłócających" postawione w akapicie o ograniczeniach.

## Algorytm

**Wejście.** Dane z wynikiem, zmienną objaśniającą będącą przedmiotem zainteresowania,
zmiennymi kontrolnymi i opcjonalnie instrumentem. Granice na siłę związku
hipotetycznej zmiennej pominiętej z wynikiem i ze zmienną objaśniającą.

**Wyjście.** Przedział, w którym leży współczynnik przy uwzględnieniu zmiennej
pominiętej o sile mieszczącej się w zadanych granicach; wartość graniczna siły,
przy której wniosek się odwraca; skorygowany przedział ufności.

**Kroki.**

1. Sprawdzenie wejścia: brak współliniowości doskonałej, dodatnia określoność
   macierzy kowariancji, przy instrumencie sprawdzenie jego siły.
2. Wyrugowanie zmiennych kontrolnych z wyniku i ze zmiennej objaśniającej.
3. Wyrażenie obciążenia współczynnika przez korelacje cząstkowe z hipotetyczną
   zmienną pominiętą.
4. Rozwiązanie zadania optymalizacji po zbiorze dopuszczalnych korelacji.
5. Wyznaczenie wartości granicznej i skorygowanego przedziału ufności.
6. Powtórzenie po siatce granic dla wykresu konturowego.

**Co wynotować z artykułu.** Z sekcji metodycznej: postać obciążenia wyrażoną przez
korelacje cząstkowe; dokładne sformułowanie zadania optymalizacji wraz ze zbiorem
dopuszczalnym; definicję wartości granicznej; metodę wyznaczenia przedziału ufności
i założenia, przy których zachowuje on pokrycie; różnice między wariantem
z instrumentem a bez.

## Kontrakt

**Warunki wstępne.** Macierz kowariancji dodatnio określona; brak współliniowości
doskonałej; granice na siłę związku z przedziału jednostkowego; przy wariancie
z instrumentem instrument o niezerowym związku ze zmienną objaśniającą.

**Niezmienniki.** Przy zerowych granicach przedział degeneruje się do oszacowania
klasycznego. Rozszerzenie granic nie zawęża przedziału. Wartość graniczna jest
nieujemna. Przeskalowanie zmiennych nie zmienia wartości granicznej wyrażonej
w korelacjach cząstkowych.

**Wyjście.** Klasa `wrazliwosc_r2` ze składnikami: przedział współczynnika, wartość
graniczna, skorygowany przedział ufności, siatka do wykresu konturowego, diagnostyka
instrumentu.

**Błędy zatrzymujące wykonanie.** Macierz osobliwa; współliniowość doskonała;
granice poza przedziałem jednostkowym; instrument bez związku ze zmienną objaśniającą.

## Plan pakietu

| Plik | Odpowiedzialność |
|---|---|
| `R/przygotowanie_danych.R` | walidacja, wyrugowanie zmiennych kontrolnych |
| `R/obciazenie.R` | obciążenie przez korelacje cząstkowe |
| `R/optymalizacja.R` | zadanie optymalizacji i wartość graniczna |
| `R/przedzialy.R` | skorygowany przedział ufności |
| `R/klasy_s3.R` | obiekt wyniku, metody `print` i `summary` |
| `R/wizualizacja.R` | wykres konturowy wartości granicznej |

Zależności: `stats`, `ggplot2` oraz opcjonalnie solver optymalizacji. Sprawdź, czy
zadanie da się rozwiązać w postaci zamkniętej – jeśli tak, solver jest zbędny i to
warto opisać.

## Dane

**Procedura generowania.** Generujesz dane **ze znaną zmienną pominiętą** o zadanej
sile związku z wynikiem i ze zmienną objaśniającą, liczysz prawdziwy współczynnik,
a następnie usuwasz tę zmienną z danych przekazywanych metodzie. Sprawdzasz, czy
prawdziwa wartość leży w wyznaczonym przedziale przy granicach odpowiadających
rzeczywistej sile. To bezpośredni test poprawności.

Parametry: liczebność, siła związku zmiennej pominiętej z każdą ze stron, liczba
zmiennych kontrolnych, siła instrumentu, ziarno.

**Przypadki o znanym wyniku.** Brak zmiennej pominiętej: przedział degeneruje się do
punktu. Zmienna pominięta związana tylko z wynikiem: brak obciążenia. Model z jedną
zmienną kontrolną: obciążenie policzalne ręcznie ze wzoru.

**Przypadki patologiczne.** Współliniowość doskonała; słaby instrument; jedna
obserwacja więcej niż zmiennych.

**Zbiór empiryczny.** Otwarte dane z badań edukacyjnych albo społecznych,
w których publikowano oszacowanie efektu wraz z dyskusją o zmiennych zakłócających.
Odtworzenie takiego oszacowania i dopisanie do niego analizy wrażliwości jest
mocnym rozdziałem trzecim.

## Mapowanie na pracę

| Sekcja briefu | Rozdział pracy |
|---|---|
| Po co to badaczowi | Wprowadzenie: tło i luka |
| Algorytm, co wynotować | Rozdział 1: aparat formalny |
| Kontrakt, założenia przedziału ufności | Rozdział 1: granice stosowalności |
| Plan pakietu, dane | Rozdział 2 |
| Odtworzenie opublikowanego wyniku | Rozdział 3 |

**Wstępne pytanie badawcze.** Jak silna musiałaby być zmienna pominięta, żeby
odwrócić wnioski z wybranych opublikowanych badań społecznych, i czy siła ta jest
porównywalna ze zmiennymi faktycznie mierzonymi w tych badaniach?

## Polecenia startowe

1. Wyrugowanie zmiennych kontrolnych i wyznaczenie korelacji cząstkowych.
2. Obciążenie wyrażone przez korelacje cząstkowe, zgodnie z Twoimi notatkami.
3. Zadanie optymalizacji i wartość graniczna.
4. Skorygowany przedział ufności.
5. Procedura generowania ze znaną zmienną pominiętą.
6. Wykres konturowy wartości granicznej po siatce granic.

## Pułapki

**Korelacja cząstkowa a zwykła.** Metoda mówi o związku **po uwzględnieniu zmiennych
kontrolnych**. Pomylenie tych dwóch wielkości daje wynik pozornie sensowny i całkowicie
błędny. Test na modelu z jedną zmienną kontrolną to wychwyci.

**Interpretacja wartości granicznej.** Mówi, jak silna musiałaby być zmienna
pominięta. Nie mówi, że taka istnieje. Zdanie „wynik jest odporny" wymaga
porównania z siłą zmiennych rzeczywiście mierzonych – bez tego jest puste.

**Wariant z instrumentem.** Ma inne założenia i inną postać obciążenia. Nie jest
uogólnieniem wariantu podstawowego przez dopisanie jednej zmiennej.

**Słaby instrument.** Psuje wszystko i objawia się nieprawdopodobnie szerokim
przedziałem. Diagnostyka siły instrumentu musi być częścią funkcji, a nie zaleceniem
w dokumentacji.

**Na obronie** musisz umieć wyjaśnić, dlaczego założenia o braku zmiennych
pominiętych nie da się przetestować, i co dokładnie mierzą oba parametry graniczne.

## Literatura

Artykuł źródłowy: `freidlingZhao2026sensitivity`.

Wprowadzenie: klasyczne opracowanie o obciążeniu przez zmienne pominięte;
podręcznikowe omówienie zmiennych instrumentalnych. Dwie do czterech pozycji
dobierasz sam. Temat pokrewny z tematami 01 i 06.

Środowisko: `rcore2026`. Wymagania formalne: `standardyEPI`.
