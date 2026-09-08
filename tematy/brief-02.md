# Temat 02. Wiarygodność ocen trafności generowanych maszynowo

## Metryka

| | |
|---|---|
| Artykuł źródłowy | Oosterhuis, Harrie; Jagerman, Rolf; Qin, Zhen; Wang, Xuanhui; Bendersky, Michael (2024). *Reliable Confidence Intervals for Information Retrieval Evaluation Using Generative A.I.* KDD '24 |
| Identyfikator | [10.1145/3637528.3671883](https://doi.org/10.1145/3637528.3671883), preprint [arXiv:2407.02464](https://arxiv.org/abs/2407.02464) |
| Dostęp | otwarty (preprint) |
| Dziedzina | wyszukiwanie informacji, metodologia oceny systemów |
| Proponowany tytuł pracy | Pakiet R do szacowania niepewności oceny systemów wyszukiwawczych jako przykład zastosowania ocen generowanych maszynowo w badaniach informatologicznych |
| Proponowana nazwa pakietu | `OcenaIRR` |
| Trudność | ●● |

## Po co to badaczowi

Żeby ocenić system wyszukiwawczy, trzeba wiedzieć, które dokumenty są trafne dla
których zapytań. Oceny takie wystawiają ludzie, a to jest kosztowne: kilkaset
zapytań po kilkadziesiąt dokumentów to tygodnie pracy. Dlatego badacze coraz częściej
zlecają ocenianie modelom językowym, które robią to w kilka minut.

Powstaje pytanie, którego nie da się obejść: **ile taka ocena jest warta**. Model nie
myli się losowo. Myli się systematycznie – przecenia dokumenty dłuższe, faworyzuje
sformułowania podobne do zapytania, inaczej traktuje pewne tematy. Zwykły przedział
ufności policzony metodą bootstrapu na maszynowych ocenach mierzy tylko rozrzut
i **przemilcza obciążenie**, przez co wychodzi za wąski. Badacz dostaje fałszywe
poczucie precyzji i ogłasza różnicę między systemami, której nie ma.

Artykuł proponuje wyjście: oceń maszynowo wszystko, a **ludzko tylko niewielką
próbkę**, i użyj tej próbki do oszacowania systematycznego błędu maszyny. Przedział
ufności uwzględnia wtedy obie składowe niepewności. Jedna z proponowanych metod jest
dostosowana do miar rankingowych i pozwala różnicować przedział dla poszczególnych
zapytań i dokumentów.

Dla kierunku informatologicznego temat ma dodatkową wartość: to ten sam problem,
który stawia sobie seminarium wobec własnych narzędzi. Kiedy wolno zaufać wynikowi,
którego nie wytworzył człowiek, i co trzeba zmierzyć, żeby to rozstrzygnąć.

## Algorytm

**Wejście.** Macierz ocen maszynowych dla par zapytanie–dokument; oceny ludzkie dla
podzbioru tych par; przypisanie dokumentów do systemów wraz z pozycjami w rankingu;
wybrana miara oceny.

**Wyjście.** Punktowa wartość miary dla każdego systemu wraz z przedziałem ufności
uwzględniającym obciążenie ocen maszynowych; opcjonalnie przedziały różnicowane na
poziomie zapytania.

**Kroki.**

1. Sprawdzenie zgodności: każda para z próbki ludzkiej ma odpowiednik w ocenach
   maszynowych, rankingi są kompletne.
2. Oszacowanie systematycznego błędu ocen maszynowych na podstawie próbki ludzkiej.
3. Korekta wartości miary o oszacowane obciążenie.
4. Wyznaczenie przedziału ufności łączącego niepewność z próbkowania i niepewność
   oszacowania obciążenia.
5. Wariant rankingowy: powtórzenie kroków z uwzględnieniem wag pozycji w rankingu.

**Wzory.** Punktem wyjścia jest miara skuteczności policzona na ocenach maszynowych,
obciążona o nieznaną wielkość. Poprawkę szacuje się na **podpróbie ocenionej przez
człowieka**: dla dokumentów należących do podpróby znane są obie oceny, więc znana jest
różnica między nimi.

Niech $\hat{\theta}_{M}$ oznacza wartość miary policzoną na ocenach maszynowych dla całego
zbioru, a $\hat{\Delta}$ średnią różnicę między wartością na ocenach ludzkich i maszynowych,
policzoną na podpróbie. Estymator skorygowany ma postać

$$\hat{\theta} = \hat{\theta}_{M} + \hat{\Delta}$$

Przedział ufności buduje się wokół tej wartości, a jego szerokość zależy od zmienności
poprawki, a nie od zmienności samej miary. Stąd bierze się zysk metody: przy dobrych ocenach
maszynowych poprawka jest mała i mało zmienna, więc przedział jest wąski mimo niewielkiej
podpróby ludzkiej.

Drugie podejście opisane w artykule nie szacuje poprawki, lecz wyznacza **granice** wokół
trafności każdego dokumentu tak, żeby prawdziwa wartość mieściła się między nimi z zadanym
prawdopodobieństwem. Wynikiem jest wtedy przedział z gwarancją pokrycia, a nie oszacowanie
punktowe z błędem standardowym. Oba warianty trzeba w pracy rozróżnić.

**Co wynotować z artykułu.** Z sekcji metodycznej potrzebujesz: definicji obu
proponowanych estymatorów, postaci składnika korygującego obciążenie, sposobu
wyznaczenia przedziału dla każdej z metod oraz warunków, przy których przedział ma
deklarowane pokrycie. Wynotuj też, jak artykuł dobiera rozmiar próbki ludzkiej
i co się dzieje, gdy jest ona za mała.

## Kontrakt

**Warunki wstępne.** Oceny w znanej skali; próbka ludzka niepusta i będąca
podzbiorem par ocenionych maszynowo; rankingi bez powtórzeń dokumentów w obrębie
zapytania; poziom ufności z przedziału otwartego zero–jeden.

**Niezmienniki.** Przedział zawiera oszacowanie punktowe. Przy próbce ludzkiej
obejmującej wszystkie pary metoda sprowadza się do zwykłego przedziału na ocenach
ludzkich. Zwiększenie próbki ludzkiej nie poszerza przedziału.

**Wyjście.** Klasa `ocena_ir` ze składnikami: wartości miary, przedziały, oszacowane
obciążenie, rozmiar próbki, wybrana metoda.

**Błędy zatrzymujące wykonanie.** Pusta próbka ludzka; oceny poza skalą; para
w próbce ludzkiej nieobecna w ocenach maszynowych; poziom ufności poza przedziałem.

## Plan pakietu

| Plik | Odpowiedzialność |
|---|---|
| `R/przygotowanie_danych.R` | walidacja, złączenie ocen maszynowych z ludzkimi |
| `R/miary.R` | miary oceny rankingu liczone na wektorze ocen |
| `R/przedzialy.R` | estymacja obciążenia i wyznaczenie przedziałów |
| `R/klasy_s3.R` | obiekt wyniku, metody `print` i `summary` |
| `R/wizualizacja.R` | wykres przedziałów dla porównywanych systemów |

Zależności: `stats` i `ggplot2`. Metoda nie wymaga solvera.

## Dane

**Procedura generowania.** Losujesz prawdziwe trafności dokumentów, z nich generujesz
oceny maszynowe z **zadanym obciążeniem** (na przykład zawyżanie dla dokumentów
o określonej cesze) oraz oceny ludzkie z niewielkim szumem. Ponieważ prawdziwa
wartość miary jest znana, możesz sprawdzić **pokrycie przedziału**: jaki odsetek
z tysiąca powtórzeń zawiera prawdziwą wartość. To najmocniejszy test w tym temacie
i wprost odpowiada na pytanie, czy metoda działa.

Parametry: liczba zapytań, dokumentów na zapytanie, wielkość obciążenia, rozmiar
próbki ludzkiej, ziarno.

**Przypadki o znanym wyniku.** Oceny maszynowe równe ludzkim: obciążenie zero,
przedział jak w metodzie klasycznej. Obciążenie stałe: korekta równa temu
obciążeniu. Próbka ludzka obejmująca całość: metoda sprowadza się do przypadku
referencyjnego.

**Przypadki patologiczne.** Próbka ludzka o rozmiarze jeden; wszystkie oceny
identyczne; jedno zapytanie.

**Zbiór empiryczny.** Otwarte kolekcje testowe z ocenami trafności, na przykład
zbiory udostępniane przez konferencje ewaluacyjne. Sprawdź licencję. Oceny maszynowe
możesz zasymulować albo wygenerować, dokumentując procedurę.

## Mapowanie na pracę

| Sekcja briefu | Rozdział pracy |
|---|---|
| Po co to badaczowi | Wprowadzenie: tło i luka |
| Algorytm, co wynotować | Rozdział 1: aparat formalny |
| Kontrakt | Rozdział 1: założenia |
| Plan pakietu, dane, badanie pokrycia | Rozdział 2 |
| Zbiór empiryczny | Rozdział 3 |

**Wstępne pytanie badawcze.** Jak mała może być próbka ocen ludzkich, żeby przedział
ufności zachował deklarowane pokrycie przy realistycznej wielkości obciążenia ocen
maszynowych?

## Polecenia startowe

1. Miary oceny rankingu jako funkcje przyjmujące wektor ocen i zwracające liczbę.
   Sprawdź na ręcznie policzonym rankingu pięciu dokumentów.
2. Estymator obciążenia na podstawie próbki ludzkiej, zgodnie z Twoimi notatkami.
3. Wyznaczenie przedziału dla obu wariantów metody.
4. Procedura generowania z zadanym obciążeniem.
5. Badanie pokrycia: tysiąc powtórzeń, odsetek przedziałów zawierających prawdę.
6. Dokumentacja funkcji eksportowanych.

## Pułapki

**Bootstrap na ocenach maszynowych.** Narzędzie zaproponuje go jako rozwiązanie
domyślne, bo tak wygląda typowy kod. To jest dokładnie ta metoda, którą artykuł
krytykuje: mierzy rozrzut i pomija obciążenie.

**Próbka ludzka jako zbiór testowy.** Próbka służy do oszacowania błędu maszyny,
a nie do niezależnej oceny systemów. Użycie jej dwa razy zaniża niepewność.

**Miary rankingowe nie są średnimi.** Wagi pozycji sprawiają, że błąd oceny
dokumentu wysoko w rankingu waży więcej niż nisko. Wariant rankingowy metody
właśnie to uwzględnia; implementacja traktująca miarę jak zwykłą średnią gubi sedno.

**Interpretacja.** Szerszy przedział nie znaczy gorsza metoda. Znaczy uczciwszą
ocenę niepewności. W rozdziale trzecim trzeba to powiedzieć wprost, bo czytelnik
przyzwyczajony do wąskich przedziałów odczyta wynik odwrotnie.

**Na obronie** musisz umieć wyjaśnić, czym różni się obciążenie od wariancji i
dlaczego zwiększanie liczby ocen maszynowych nie usuwa pierwszego.

## Literatura

Artykuł źródłowy: `oosterhuis2024reliable`.

Wprowadzenie: podręcznikowe omówienie oceny systemów wyszukiwawczych i miar
rankingowych; opracowanie o wnioskowaniu wspieranym predykcją, czyli o rodzinie
metod, do której należy podejście z artykułu. Dwie do czterech pozycji dobierasz sam.

Środowisko: `rcore2026`. Wymagania formalne: `standardyEPI`.
