# Temat 07. Granica sprawiedliwości i trafności algorytmu

## Metryka

| | |
|---|---|
| Artykuł źródłowy | Liu, Yiqi; Molinari, Francesca (2024). *Inference for an Algorithmic Fairness-Accuracy Frontier* |
| Identyfikator | [arXiv:2402.08879](https://arxiv.org/abs/2402.08879) |
| Dostęp | otwarty |
| Dziedzina | polityka publiczna, automatyczne podejmowanie decyzji |
| Proponowany tytuł pracy | Pakiet R do wyznaczania granicy między sprawiedliwością a trafnością algorytmu jako przykład zastosowania optymalizacji wypukłej w ocenie decyzji automatycznych |
| Proponowana nazwa pakietu | `GranicaFAR` |
| Trudność | ●●●● |

## Po co to badaczowi

Coraz więcej decyzji dotyczących ludzi zapada z udziałem algorytmu: kto dostanie
kredyt, kogo zaprosić na rozmowę, komu przyznać świadczenie, którą sprawę rozpatrzyć
w pierwszej kolejności. Wobec takich systemów stawia się dwa wymagania jednocześnie.
Mają **trafnie** przewidywać. I mają **nie różnicować** osób ze względu na cechy
chronione.

Wymagania te są ze sobą w konflikcie. Nie w sensie moralnym, tylko matematycznym:
zwykle nie da się poprawić jednego, nie psując drugiego. Debata publiczna traktuje
to jako spór o wartości, podczas gdy jest to najpierw kwestia faktu – istnieje
zbiór osiągalnych par trafność–różnicowanie, a decyzja polityczna dotyczy tego,
**który punkt tego zbioru wybrać**.

Artykuł podaje sposób wyznaczenia brzegu tego zbioru wraz z **wnioskowaniem
statystycznym**: nie tylko szacuje granicę, ale mówi, jak niepewne jest to
oszacowanie, i pozwala sprawdzić, czy istniejąca procedura na tej granicy leży.
To ostatnie jest pytaniem o realną doniosłość: jeśli obecny system leży wyraźnie
poniżej granicy, można poprawić sprawiedliwość **bez** utraty trafności, i wtedy
argument o nieuchronnym kompromisie przestaje obowiązywać.

Dla badacza polityki publicznej jest to narzędzie do przejścia od sporu o wartości
do sprawdzalnego pytania: ile trafności faktycznie kosztuje dana poprawa
sprawiedliwości w tym konkretnym systemie.

## Algorytm

**Wejście.** Dane z cechami wejściowymi, zmienną wynikową, cechą chronioną oraz
opcjonalnie decyzjami istniejącej procedury. Wybrana miara różnicowania i miara
błędu.

**Wyjście.** Oszacowanie brzegu zbioru osiągalnych par wraz z pasmem ufności;
położenie istniejącej procedury względem brzegu; wynik testu, czy leży ona na brzegu.

**Kroki.**

1. Sprawdzenie wejścia: cecha chroniona o co najmniej dwóch poziomach, dostateczne
   pokrycie w każdej grupie, brak separacji.
2. Podział próby na części do dopasowania i do oceny.
3. Wyznaczenie funkcji pomocniczych na częściach do dopasowania.
4. Dla siatki kierunków rozwiązanie zadania optymalizacji wypukłej wyznaczającego
   punkt brzegu w danym kierunku.
5. Złożenie punktów w brzeg i wyznaczenie pasma ufności.
6. Test położenia istniejącej procedury względem brzegu.

**Co wynotować z artykułu.** Z sekcji metodycznej: definicję obu miar oraz zbioru
osiągalnego; postać funkcji charakteryzującej brzeg; konstrukcję funkcji wynikowej
odpornej na błąd oszacowania funkcji pomocniczych; sposób podziału próby; postać
statystyki testowej i rozkład, do którego się ją porównuje; założenia dotyczące
pokrycia i ich rolę.

## Kontrakt

**Warunki wstępne.** Cecha chroniona o co najmniej dwóch poziomach z niepustymi
grupami; zmienna wynikowa bez braków; liczba obserwacji wystarczająca do podziału
próby; poziom ufności z przedziału otwartego zero–jeden.

**Niezmienniki.** Brzeg jest nierosnący: poprawa jednej miary nie następuje bez
pogorszenia drugiej. Pasmo ufności zawiera oszacowanie punktowe. Zamiana etykiet
grup cechy chronionej nie zmienia brzegu przy symetrycznej mierze różnicowania.

**Wyjście.** Klasa `granica_far` ze składnikami: punkty brzegu, pasmo ufności,
położenie procedury odniesienia, wynik testu, parametry podziału próby.

**Błędy zatrzymujące wykonanie.** Pusta grupa cechy chronionej; brak zmienności
zmiennej wynikowej w grupie; zbyt mała próba dla zadanego podziału; brak zbieżności
optymalizacji.

## Plan pakietu

| Plik | Odpowiedzialność |
|---|---|
| `R/przygotowanie_danych.R` | walidacja, sprawdzenie pokrycia, podział próby |
| `R/funkcje_pomocnicze.R` | dopasowanie funkcji pomocniczych na częściach próby |
| `R/brzeg.R` | optymalizacja dla siatki kierunków |
| `R/wnioskowanie.R` | pasmo ufności i test położenia |
| `R/klasy_s3.R` | obiekt wyniku, metody `print` i `summary` |
| `R/wizualizacja.R` | brzeg z pasmem i naniesioną procedurą odniesienia |

Zależności: solver optymalizacji wypukłej dostępny na CRAN, `stats`, `ggplot2`.
Wybór solvera uzasadnij: zadania w tej metodzie bywają źle uwarunkowane.

## Dane

**Procedura generowania.** Ustalasz model, w którym **znasz prawdziwy brzeg** – na
przykład model o rozkładach normalnych z zadaną różnicą między grupami, dla którego
brzeg da się wyprowadzić analitycznie. Sprawdzasz, czy oszacowany brzeg zbiega do
prawdziwego i czy pasmo ufności ma deklarowane pokrycie.

Parametry: liczebność, siła zależności wyniku od cechy chronionej, siła zależności
od cech wejściowych, nierównowaga grup, ziarno.

**Przypadki o znanym wyniku.** Brak zależności wyniku od cechy chronionej: brzeg
degeneruje się, bo sprawiedliwość nic nie kosztuje. Zależność deterministyczna:
kompromis maksymalny. Grupy o identycznych rozkładach: różnicowanie zerowe przy
dowolnej trafności.

**Przypadki patologiczne.** Grupa o dziesięciu obserwacjach; separacja doskonała;
cecha chroniona o jednym poziomie.

**Zbiór empiryczny.** Otwarte zbiory używane w badaniach nad sprawiedliwością
algorytmiczną, dotyczące decyzji kredytowych, rekrutacyjnych albo administracyjnych.
**Sprawdź licencję i historię zbioru** – część popularnych zbiorów z tego obszaru
jest krytykowana za sposób pozyskania i za to, jak koduje cechy chronione. Ta
krytyka sama w sobie jest materiałem do rozdziału trzeciego.

## Mapowanie na pracę

| Sekcja briefu | Rozdział pracy |
|---|---|
| Po co to badaczowi | Wprowadzenie: tło i luka |
| Algorytm, co wynotować | Rozdział 1: aparat formalny |
| Kontrakt, założenia o pokryciu | Rozdział 1: granice stosowalności |
| Plan pakietu, dane, badanie pokrycia | Rozdział 2 |
| Zbiór empiryczny, jego krytyka | Rozdział 3 |

**Wstępne pytanie badawcze.** Jak daleko od brzegu leżą procedury decyzyjne
stosowane w praktyce i czy odległość ta jest większa niż niepewność oszacowania
samego brzegu?

## Polecenia startowe

1. Miary trafności i różnicowania jako funkcje wektora decyzji. Sprawdź na ręcznie
   policzonym przykładzie dziesięciu obserwacji.
2. Zadanie optymalizacji dla jednego kierunku, z jawnym wywołaniem solvera.
3. Podział próby i dopasowanie funkcji pomocniczych.
4. Pasmo ufności zgodnie z Twoimi notatkami.
5. Procedura generowania z analitycznie znanym brzegiem.
6. Badanie pokrycia pasma w powtórzeniach.

## Pułapki

**Brak podziału próby.** Narzędzie policzy funkcje pomocnicze i brzeg na tych samych
danych, bo tak jest prościej. Wynik będzie zbyt optymistyczny, a pasmo zbyt wąskie.
Podział próby nie jest ostrożnością, tylko warunkiem poprawności wnioskowania.

**Miara różnicowania.** Istnieje ich kilkanaście i **nie da się spełnić wszystkich
naraz**. Wybór jednej jest decyzją merytoryczną, którą praca musi uzasadnić,
a nie szczegółem implementacyjnym.

**Brzeg nie jest zaleceniem.** Metoda mówi, co jest osiągalne, a nie co wybrać.
Punkt na brzegu wskazuje decydent, nie algorytm. Praca, która wskazuje „optymalny"
punkt, przekracza granice metody.

**Pokrycie.** Przy małej grupie mniejszościowej oszacowania stają się niestabilne.
To najczęstszy realny problem w tym temacie i trzeba go zbadać, a nie przemilczeć.

**Na obronie** musisz umieć wyjaśnić, dlaczego niektóre miary sprawiedliwości są
wzajemnie sprzeczne, i co konkretnie oznacza, że procedura leży na brzegu.

## Literatura

Artykuł źródłowy: `liuMolinari2024frontier`.

Wprowadzenie: przegląd definicji sprawiedliwości algorytmicznej wraz z wynikami
o ich niezgodności; opracowanie o wnioskowaniu w zadaniach z funkcjami pomocniczymi.
Dwie do czterech pozycji dobierasz sam.

Środowisko: `rcore2026`. Wymagania formalne: `standardyEPI`.
