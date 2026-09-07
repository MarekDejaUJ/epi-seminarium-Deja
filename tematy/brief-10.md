# Temat 10. Metaanaliza parametrów teorii perspektywy

## Metryka

| | |
|---|---|
| Artykuł źródłowy | Imai, Taisuke; Nunnari, Salvatore; Wu, Jilong; Vieider, Ferdinand M. (2025). *Meta-Analysis of Prospect Theory Parameters*. CESifo Working Paper 12334 |
| Dostęp | dokument roboczy dostępny publicznie |
| Dziedzina | ekonomia behawioralna, percepcja ryzyka |
| Proponowany tytuł pracy | Pakiet R do metaanalizy parametrów modeli decyzji jako przykład zastosowania ważenia odwrotnością wariancji w syntezie wyników badań |
| Proponowana nazwa pakietu | `MetaPTR` |
| Trudność | ●● |

## Po co to badaczowi

Teoria perspektywy opisuje, jak ludzie podejmują decyzje w warunkach ryzyka: że
inaczej traktują zyski niż straty, że przeceniają zdarzenia mało prawdopodobne,
że strata boli mocniej, niż cieszy zysk tej samej wielkości. Model ten ma kilka
parametrów, a **setki badań** oszacowały je na własnych próbach.

I tu zaczyna się problem, który dotyczy nie tylko tej teorii. Oszacowania te bardzo
się między sobą różnią. Badacz, który chce przyjąć wartość parametru do własnego
modelu – albo po prostu chce wiedzieć, ile wynosi awersja do strat – nie ma czego
zacytować poza pojedynczym badaniem sprzed lat. Metaanaliza miałaby dać odpowiedź,
ale w tym przypadku napotyka trzy przeszkody naraz.

Po pierwsze, parametry są **wzajemnie skorelowane**: pochodzą z jednego dopasowania,
więc traktowanie ich jak niezależnych oszacowań zaniża niepewność. Po drugie, wiele
prac **nie podaje błędów standardowych**, więc klasyczne ważenie odwrotnością
wariancji nie ma czym ważyć. Po trzecie, różnice między badaniami mogą wynikać nie
z różnic między ludźmi, tylko z **procedury pomiaru** – a to pytanie samo w sobie
jest ciekawsze niż średnia.

Artykuł zbiera 812 oszacowań z 166 prac i podaje procedurę radzącą sobie z tymi
trzema przeszkodami. Wynik: wzorce średnie potwierdzają teorię, ale rozrzut między
badaniami jest ogromny, a najsilniejszymi jego predyktorami są cechy **procedury
badawczej**, nie cechy badanych. To ustalenie o naruszeniu niezmienniczości
procedury dotyczy każdego, kto mierzy postawy kwestionariuszem.

Narzędzie robiące to samo dla dowolnego zestawu skorelowanych parametrów przydaje
się daleko poza teorią perspektywy.

## Algorytm

**Wejście.** Ramka oszacowań: identyfikator badania, nazwa parametru, wartość,
błąd standardowy jeżeli podany, liczebność próby, cechy badania i procedury pomiaru.

**Wyjście.** Oszacowania zbiorcze dla każdego parametru wraz z przedziałami; miary
rozrzutu między badaniami; wynik metaregresji na cechach badania; diagnostyka wpływu
imputacji.

**Kroki.**

1. Sprawdzenie wejścia: rozpoznane nazwy parametrów, kompletność identyfikatorów,
   obecność liczebności tam, gdzie brakuje błędu standardowego.
2. Imputacja brakujących błędów standardowych na podstawie liczebności i oszacowań
   dostępnych w badaniach kompletnych.
3. Zbudowanie macierzy kowariancji uwzględniającej korelacje między parametrami
   pochodzącymi z tego samego badania.
4. Ważenie odwrotnością wariancji z tą macierzą i wyznaczenie oszacowań zbiorczych.
5. Wyznaczenie miar rozrzutu między badaniami.
6. Metaregresja oszacowań na cechach badania i procedury.
7. Analiza wrażliwości: wynik przy pominięciu badań z imputowanym błędem.

**Co wynotować z artykułu.** Z sekcji metodycznej: dokładną postać estymatora
ważonego z uwzględnieniem korelacji; sposób imputacji brakujących błędów
standardowych wraz z założeniami; przyjętą strukturę korelacji między parametrami;
specyfikację metaregresji; sposób raportowania rozrzutu. Wynotuj też definicje
samych parametrów teorii, bo są potrzebne do rozdziału pierwszego.

## Kontrakt

**Warunki wstępne.** Co najmniej dwa badania na parametr; nieujemne błędy
standardowe; liczebności dodatnie; nazwy parametrów ze zbioru zadeklarowanego;
cechy badania bez braków albo z jawnie zadeklarowaną obsługą.

**Niezmienniki.** Oszacowanie zbiorcze mieści się w zakresie oszacowań składowych.
Błąd standardowy oszacowania zbiorczego nie przekracza najmniejszego z błędów
składowych. Przy jednym badaniu wynik równa się temu badaniu. Uwzględnienie korelacji
nie zawęża przedziału względem wariantu zakładającego niezależność.

**Wyjście.** Klasa `metaanaliza_pt` ze składnikami: oszacowania zbiorcze, przedziały,
miary rozrzutu, wynik metaregresji, liczba imputacji, wynik analizy wrażliwości.

**Błędy zatrzymujące wykonanie.** Ujemny błąd standardowy; brak liczebności przy
braku błędu standardowego; nierozpoznana nazwa parametru; jedno badanie przy żądaniu
metaregresji.

## Plan pakietu

| Plik | Odpowiedzialność |
|---|---|
| `R/przygotowanie_danych.R` | walidacja ramki oszacowań, kontrola nazw parametrów |
| `R/imputacja.R` | uzupełnianie brakujących błędów standardowych |
| `R/kowariancja.R` | macierz kowariancji z korelacjami wewnątrz badania |
| `R/laczenie.R` | ważenie odwrotnością wariancji, oszacowania zbiorcze |
| `R/metaregresja.R` | wyjaśnianie rozrzutu cechami badania |
| `R/klasy_s3.R` | obiekt wyniku, metody `print` i `summary` |
| `R/wizualizacja.R` | wykres leśny, wykres lejkowy |

Zależności: `stats` i `ggplot2`. Jeżeli sięgasz po istniejący pakiet do metaanalizy,
uzasadnij to i pokaż, czego on nie robi – to jest wprost Twoja luka technologiczna.

## Dane

**Procedura generowania.** Ustalasz **prawdziwe wartości zbiorcze** parametrów,
losujesz z nich oszacowania badań z zadanym rozrzutem między badaniami i zadaną
strukturą korelacji wewnątrz badania, a następnie **usuwasz część błędów
standardowych** według kontrolowanego mechanizmu. Sprawdzasz, czy oszacowanie
zbiorcze odtwarza prawdę i czy przedział ma deklarowane pokrycie – osobno przy
imputacji i bez niej.

Parametry: liczba badań, oszacowań na badanie, rozrzut między badaniami, siła
korelacji wewnątrz badania, odsetek brakujących błędów, ziarno.

**Przypadki o znanym wyniku.** Wszystkie badania o identycznym błędzie standardowym:
oszacowanie zbiorcze równe średniej arytmetycznej. Jedno badanie: wynik równy temu
badaniu. Zerowa korelacja wewnątrz badania: zgodność z wariantem klasycznym,
policzalnym ręcznie dla trzech badań.

**Przypadki patologiczne.** Zerowy błąd standardowy; wszystkie błędy brakujące;
jedno badanie z dziesięcioma parametrami.

**Zbiór empiryczny.** Dane towarzyszące artykułowi, czyli zebrane oszacowania.
Sprawdź warunki udostępnienia. Alternatywnie zbuduj własny, mniejszy zestaw z prac
w wybranym obszarze – samo zbieranie danych jest wtedy częścią rozdziału trzeciego
i warto opisać jego procedurę.

## Mapowanie na pracę

| Sekcja briefu | Rozdział pracy |
|---|---|
| Po co to badaczowi | Wprowadzenie: tło i luka |
| Definicje parametrów, algorytm | Rozdział 1: aparat formalny |
| Kontrakt, założenia imputacji | Rozdział 1: granice stosowalności |
| Plan pakietu, dane, badanie pokrycia | Rozdział 2 |
| Zbiór empiryczny, metaregresja | Rozdział 3 |

**Wstępne pytanie badawcze.** Ile rozrzutu oszacowań parametrów da się wyjaśnić
cechami procedury pomiaru, a ile pozostaje niewyjaśnione, i co z tego wynika dla
badacza chcącego przyjąć wartość parametru do własnego modelu?

## Polecenia startowe

1. Walidacja ramki oszacowań wraz z kontrolą nazw parametrów.
2. Imputacja brakujących błędów standardowych zgodnie z Twoimi notatkami.
3. Macierz kowariancji z korelacjami wewnątrz badania.
4. Estymator ważony i przedziały.
5. Procedura generowania z kontrolowanym brakiem błędów standardowych.
6. Badanie pokrycia osobno dla wariantu z imputacją i bez.

## Pułapki

**Traktowanie oszacowań jako niezależnych.** Narzędzie zaproponuje klasyczną
metaanalizę, bo tak wygląda typowy kod. Kilka parametrów z jednego dopasowania nie
jest kilkoma niezależnymi obserwacjami. Skutkiem jest przedział zbyt wąski.

**Imputacja bez analizy wrażliwości.** Uzupełnienie brakujących błędów standardowych
jest założeniem, nie faktem. Wynik przy pominięciu badań imputowanych musi być
pokazany obok wyniku głównego.

**Metaregresja a przyczynowość.** Związek cechy procedury z wartością parametru nie
oznacza, że procedura ten parametr powoduje. Badania różnią się wieloma rzeczami
naraz. Rozdział trzeci musi to zastrzec.

**Wykres lejkowy.** Bywa czytany jako dowód stronniczości publikacyjnej. Przy
skorelowanych oszacowaniach jego interpretacja jest ostrożniejsza, niż podaje
większość podręczników.

**Na obronie** musisz umieć wyjaśnić, dlaczego ważenie odwrotnością wariancji jest
optymalne, i co się psuje, gdy wariancje trzeba oszacować zamiast odczytać.

## Literatura

Artykuł źródłowy: `imai2025meta`.

Wprowadzenie: klasyczne opracowanie teorii perspektywy; podręcznikowe omówienie
metaanalizy i miar rozrzutu między badaniami. Dwie do czterech pozycji dobierasz sam.
Temat pokrewny z tematem 13.

Środowisko: `rcore2026`. Wymagania formalne: `standardyEPI`.
