# Temat 06. Granice efektu przy brakach nielosowych

## Metryka

| | |
|---|---|
| Artykuł źródłowy | Peña, Jose M. (2024). *Bounds and Sensitivity Analysis of the Causal Effect Under Outcome-Independent MNAR Confounding* |
| Identyfikator | [arXiv:2410.06726](https://arxiv.org/abs/2410.06726) |
| Dostęp | otwarty |
| Dziedzina | badania ankietowe, wnioskowanie przyczynowe przy brakach danych |
| Proponowany tytuł pracy | Pakiet R do analizy wrażliwości przy brakach nielosowych jako przykład zastosowania granic nieparametrycznych w badaniach ankietowych |
| Proponowana nazwa pakietu | `BrakiMNARR` |
| Trudność | ●●● |

## Po co to badaczowi

Każde badanie ankietowe ma braki. Część respondentów nie odpowiada na część pytań,
część wypada z badania podłużnego, część w ogóle nie odbiera telefonu. Standardowa
praktyka polega na założeniu, że braki są **losowe warunkowo** – że po uwzględnieniu
tego, co wiemy o respondencie, brak nie niesie już informacji.

Założenie to jest wygodne i zwykle nieprawdziwe. Ludzie o skrajnych poglądach
częściej odmawiają odpowiedzi. Osoby w gorszej sytuacji częściej wypadają z badania
podłużnego. Brak **sam w sobie** jest wtedy informacją, a analiza, która to ignoruje,
zwraca wynik obciążony w nieznanym kierunku.

Kłopot w tym, że założenia o losowości braków **nie da się sprawdzić na danych**.
Nie ma testu, bo brakujących wartości nie widać. Można natomiast zapytać inaczej:
jak bardzo braki musiałyby być nielosowe, żeby wniosek się odwrócił? Jeśli odpowiedź
brzmi „nieznacznie", wynik jest kruchy. Jeśli „drastycznie", wynik się broni mimo
niepewności.

Artykuł podaje granice efektu przyczynowego przy określonym typie zależności między
brakiem a nieobserwowaną zmienną zakłócającą, wraz z analizą wrażliwości sterowaną
jawnym parametrem. Badacz dostaje przedział zamiast pojedynczej liczby oraz próg,
przy którym wniosek przestaje obowiązywać.

To jest dokładnie to, czego brakuje w raportach z badań społecznych: uczciwego
opisania, ile z wyniku pochodzi z danych, a ile z założeń.

## Algorytm

**Wejście.** Dane obserwacyjne ze zmienną zabiegu, zmienną wyniku, wskaźnikiem
obserwacji oraz zmiennymi towarzyszącymi, wszystkie w postaci dyskretnej. Wartość
lub siatka wartości parametru wrażliwości.

**Wyjście.** Dla każdej wartości parametru wrażliwości: przedział zawierający efekt
przyczynowy. Dodatkowo wartość progowa parametru, przy której przedział zaczyna
zawierać zero.

**Kroki.**

1. Sprawdzenie kodowania zmiennych i wyznaczenie odsetka braków w każdej grupie.
2. Zbudowanie rozkładów warunkowych z części obserwowanej.
3. Dla zadanej wartości parametru wrażliwości wyznaczenie zbioru dopuszczalnych
   rozkładów zmiennej nieobserwowanej.
4. Przeszukanie tego zbioru w poszukiwaniu minimum i maksimum efektu.
5. Powtórzenie dla siatki wartości parametru i wyznaczenie progu.

**Co wynotować z artykułu.** Z sekcji definicyjnej: dokładne sformułowanie warunku
niezależności między wynikiem a wskaźnikiem obserwacji przy zadanym warunkowaniu;
definicję parametru wrażliwości; postać granic wraz z dowodem, że są ostre; warunki,
przy których granice są nieinformatywne, czyli obejmują cały możliwy zakres.
Wynotuj też, jak artykuł traktuje przypadek braków w zmiennych towarzyszących.

## Kontrakt

**Warunki wstępne.** Zmienne dyskretne o zadeklarowanych poziomach; wskaźnik
obserwacji zero-jedynkowy; co najmniej jedna obserwacja w każdej kombinacji poziomów
używanej do warunkowania; parametr wrażliwości nieujemny.

**Niezmienniki.** Dolna granica nie przekracza górnej. Przy parametrze wrażliwości
odpowiadającym brakom losowym przedział degeneruje się do punktu równego oszacowaniu
klasycznemu. Zwiększanie parametru wrażliwości nie zawęża przedziału.

**Wyjście.** Klasa `granice_mnar` ze składnikami: siatka parametru, granice, próg
odwrócenia wniosku, odsetki braków, oszacowanie przy założeniu losowości.

**Błędy zatrzymujące wykonanie.** Pusta warstwa warunkowania; wskaźnik obserwacji
spoza zbioru zero-jedynkowego; ujemny parametr wrażliwości; brak zmienności zabiegu
w części obserwowanej.

## Plan pakietu

| Plik | Odpowiedzialność |
|---|---|
| `R/przygotowanie_danych.R` | walidacja, tablice liczności, odsetki braków |
| `R/granice.R` | wyznaczenie granic dla zadanego parametru |
| `R/wrazliwosc.R` | siatka parametru, próg odwrócenia wniosku |
| `R/klasy_s3.R` | obiekt wyniku, metody `print` i `summary` |
| `R/wizualizacja.R` | wykres granic w funkcji parametru wrażliwości |

Zależności: `stats` i `ggplot2`. Przeszukiwanie po ograniczonym przedziale nie
wymaga solvera; jeżeli sięgasz po optymalizator, uzasadnij to.

## Dane

**Procedura generowania.** Generujesz pełne dane wraz ze zmienną nieobserwowaną,
liczysz **prawdziwy efekt przyczynowy**, a następnie usuwasz część obserwacji według
mechanizmu zależnego od zmiennej nieobserwowanej, o kontrolowanej sile. Sprawdzasz,
czy prawdziwy efekt leży w wyznaczonym przedziale przy parametrze odpowiadającym
rzeczywistej sile mechanizmu. To jest test, który mierzy poprawność, a nie
niezmienność.

Parametry: liczebność, siła zależności braku od zmiennej nieobserwowanej, wielkość
prawdziwego efektu, liczba warstw, ziarno.

**Przypadki o znanym wyniku.** Braki całkowicie losowe: przedział degeneruje się do
punktu. Brak braków: wynik równy oszacowaniu klasycznemu. Parametr wrażliwości
dążący do wartości granicznej: przedział obejmuje cały możliwy zakres.

**Przypadki patologiczne.** Wszystkie obserwacje w jednej grupie brakujące; warstwa
o jednej obserwacji; zabieg bez zmienności.

**Zbiór empiryczny.** Otwarte dane ankietowe z jawnie oznaczonymi brakami, na
przykład z europejskich badań społecznych albo z archiwów danych społecznych.
Wybierz zmienne o wysokim odsetku braków, bo tam metoda ma coś do pokazania.

## Mapowanie na pracę

| Sekcja briefu | Rozdział pracy |
|---|---|
| Po co to badaczowi | Wprowadzenie: tło i luka |
| Algorytm, co wynotować | Rozdział 1: aparat formalny |
| Kontrakt, warunki nieinformatywności | Rozdział 1: granice stosowalności |
| Plan pakietu, dane | Rozdział 2 |
| Zbiór empiryczny, próg odwrócenia | Rozdział 3 |

**Wstępne pytanie badawcze.** Przy jakim odsetku braków i jakiej sile mechanizmu
nielosowego granice przestają nieść informację użyteczną dla wniosku, i jak często
warunki te występują w realnych badaniach ankietowych?

## Polecenia startowe

1. Tablice liczności i odsetki braków w podziale na warstwy, wraz z walidacją.
2. Granice dla zadanej wartości parametru, zgodnie z Twoimi notatkami.
3. Przeszukiwanie po siatce parametru i wyznaczenie progu odwrócenia wniosku.
4. Procedura generowania z mechanizmem braków o kontrolowanej sile.
5. Dane naruszające warunki wstępne wraz z oczekiwanym zachowaniem.
6. Wykres granic w funkcji parametru z zaznaczonym progiem.

## Pułapki

**Imputacja zamiast granic.** Narzędzie zaproponuje uzupełnienie braków, bo tak
wygląda typowe rozwiązanie. Metoda z artykułu robi coś przeciwnego: **nie zgaduje**
brakujących wartości, tylko wyznacza przedział zgodny ze wszystkim, co jest możliwe.

**Warunek niezależności.** Metoda zakłada określony, ograniczony typ zależności
między brakiem a wynikiem. Nie działa dla dowolnego mechanizmu nielosowego. Praca
musi ten warunek podać i pokazać, co się dzieje, gdy jest naruszony.

**Granice nieinformatywne.** Przedział obejmujący cały możliwy zakres nie jest błędem
implementacji. Jest wynikiem mówiącym, że dane nie rozstrzygają. Trzeba to umieć
odróżnić od błędu i tak opisać.

**Interpretacja progu.** Próg mówi, jak silny musiałby być mechanizm, żeby wniosek
upadł. Nie mówi, czy taki mechanizm występuje. Ta różnica jest sednem analizy
wrażliwości i najczęstszym miejscem nadinterpretacji.

**Na obronie** musisz umieć wyjaśnić, dlaczego założenia o losowości braków nie da
się przetestować na danych, i co dokładnie mierzy parametr wrażliwości.

## Literatura

Artykuł źródłowy: `pena2024mnar`.

Wprowadzenie: podręcznikowe omówienie mechanizmów powstawania braków danych;
opracowanie o granicach nieparametrycznych i analizie wrażliwości. Dwie do czterech
pozycji dobierasz sam. Temat pokrewny z tematami 01 i 08.

Środowisko: `rcore2026`. Wymagania formalne: `standardyEPI`.
