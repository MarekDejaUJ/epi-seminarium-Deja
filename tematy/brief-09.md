# Temat 09. Sekwencyjny syntetyczny DiD

## Metryka

| | |
|---|---|
| Artykuł źródłowy | Arkhangelsky, Dmitry; Samkov, Aleksei (2024). *Sequential Synthetic Difference in Differences* |
| Identyfikator | [arXiv:2404.00164](https://arxiv.org/abs/2404.00164) |
| Dostęp | otwarty |
| Dziedzina | ewaluacja programów publicznych, dane panelowe |
| Proponowany tytuł pracy | Pakiet R do oceny programów wdrażanych etapami jako przykład zastosowania metod syntetycznej kontroli w ewaluacji polityk publicznych |
| Proponowana nazwa pakietu | `SekwSDIDR` |
| Trudność | ●●●● |

## Po co to badaczowi

Programy publiczne rzadko wchodzą w życie wszędzie naraz. Bibliotekę cyfrową wdraża
się województwo po województwie, program czytelniczy szkoła po szkole, reformę
gmina po gminie. Powstaje wtedy dane panelowe z **rozłożonym w czasie** momentem
wejścia – i to jest sytuacja, w której klasyczne metody porównywania grup zawodzą
w sposób nieoczywisty.

Zawodzą, bo jednostki, które weszły do programu wcześniej, stają się grupą
porównawczą dla tych, które weszły później – mimo że są już objęte działaniem
programu. Wynik potrafi wyjść z odwrotnym znakiem niż prawda, i to nie z powodu
błędu w danych, tylko z powodu konstrukcji estymatora. Literatura ostatnich lat
opisała to zjawisko szczegółowo i wywołało ono rewizję sporej części wyników
w ekonomii i naukach o polityce.

Odpowiedzią jest rodzina metod syntetycznej kontroli: zamiast porównywać z dowolną
grupą, buduje się dla każdej jednostki objętej programem **sztuczny odpowiednik**
złożony z jednostek nieobjętych, dobrany tak, żeby przed wejściem programu zachowywał
się tak samo. Artykuł rozszerza to podejście na wdrożenia etapowe, wprowadzając
sekwencyjne wyznaczanie wag jednostek i okresów.

Dla badacza oceniającego program wdrażany etapami jest to narzędzie dające wynik,
którego nie trzeba opatrywać zastrzeżeniem o możliwym odwróceniu znaku.

## Algorytm

**Wejście.** Panel z identyfikatorem jednostki, okresem, wynikiem i momentem wejścia
do programu; opcjonalnie zmienne towarzyszące i wagi jednostek.

**Wyjście.** Efekt programu dla każdej grupy wejścia i każdego okresu po wejściu;
efekt zagregowany; wagi jednostek i okresów; diagnostyka dopasowania przed wejściem;
błędy standardowe.

**Kroki.**

1. Sprawdzenie panelu: kompletność, brak powrotów do stanu sprzed programu,
   istnienie jednostek nigdy nieobjętych albo objętych najpóźniej.
2. Wyśrodkowanie efektów jednostkowych i okresowych.
3. Dla każdej grupy wejścia wyznaczenie wag jednostek przez regresję z ograniczeniami
   i karą regularyzacyjną, dopasowującą przebieg sprzed wejścia.
4. Wyznaczenie wag okresów sprzed wejścia.
5. Złożenie efektu dla grupy jako różnicy podwójnej z zastosowanymi wagami.
6. Sekwencyjne przejście po grupach wejścia i agregacja.
7. Błędy standardowe metodą powtórzeń albo testem placebo.

**Co wynotować z artykułu.** Z sekcji metodycznej: postać zadania wyznaczania wag
jednostek wraz z ograniczeniami i karą; sposób doboru parametru kary; postać wag
okresów; regułę sekwencyjnego przechodzenia po grupach wejścia; wzór agregacji;
metodę wyznaczania błędów standardowych i jej założenia; warunek istnienia
dopuszczalnej grupy porównawczej.

## Kontrakt

**Warunki wstępne.** Panel zrównoważony albo z jawnie zadeklarowaną obsługą braków;
program pochłaniający, czyli bez powrotów; co najmniej jedna jednostka nieobjęta
w każdym momencie porównania; co najmniej dwa okresy przed wejściem dla każdej grupy.

**Niezmienniki.** Wagi jednostek są nieujemne i sumują się do jedności. Wagi okresów
są nieujemne i sumują się do jedności. Przy jednym momencie wejścia metoda sprowadza
się do wariantu klasycznego. Wynik nie zależy od kolejności jednostek w danych.

**Wyjście.** Klasa `sekw_sdid` ze składnikami: efekty w podziale na grupy i okresy,
efekt zagregowany, wagi, diagnostyka dopasowania, błędy standardowe.

**Błędy zatrzymujące wykonanie.** Powrót do stanu sprzed programu; brak jednostek
nieobjętych; mniej niż dwa okresy przed wejściem; panel z powtórzonymi parami
jednostka–okres.

## Plan pakietu

| Plik | Odpowiedzialność |
|---|---|
| `R/przygotowanie_danych.R` | walidacja panelu, wykrycie schematu wdrożenia |
| `R/wagi_jednostek.R` | regresja z ograniczeniami i karą |
| `R/wagi_okresow.R` | wagi okresów sprzed wejścia |
| `R/efekty.R` | sekwencyjne wyznaczanie i agregacja |
| `R/bledy.R` | błędy standardowe i testy placebo |
| `R/klasy_s3.R` | obiekt wyniku, metody `print` i `summary` |
| `R/wizualizacja.R` | przebiegi obserwowany i syntetyczny, wykres efektów |

Zależności: `stats`, `ggplot2` oraz solver dla regresji z ograniczeniami.
Rozważ implementację własną metodą rzutowanego spadku gradientu i uzasadnij wybór.

## Dane

**Procedura generowania.** Generujesz panel z **zadanym efektem programu**,
rozłożonym w czasie momentem wejścia i strukturą czynnikową odpowiadającą założeniom
metody. Znasz prawdziwy efekt, więc mierzysz obciążenie i pokrycie przedziałów.
Warto dołożyć wariant, w którym założenia są **naruszone**, żeby pokazać, kiedy
metoda zawodzi.

Parametry: liczba jednostek, okresów, grup wejścia, wielkość efektu, siła czynników,
odsetek jednostek nigdy nieobjętych, ziarno.

**Przypadki o znanym wyniku.** Zerowy efekt: oszacowanie bliskie zeru. Jeden moment
wejścia: zgodność z wariantem klasycznym. Jednostka porównawcza idealnie dopasowana:
waga równa jeden dla niej i zero dla pozostałych.

**Przypadki patologiczne.** Wszystkie jednostki objęte w tym samym okresie; brak
jednostek nieobjętych; jeden okres przed wejściem; jednostka z brakami w środku panelu.

**Zbiór empiryczny.** Otwarte dane o wdrożeniach etapowych: statystyki bibliotek
publicznych, dane oświatowe, wskaźniki gminne. Dobierz program, którego moment
wejścia jest udokumentowany, bo od tego zależy cała analiza.

## Mapowanie na pracę

| Sekcja briefu | Rozdział pracy |
|---|---|
| Po co to badaczowi, problem wdrożeń etapowych | Wprowadzenie: tło i luka |
| Algorytm, co wynotować | Rozdział 1: aparat formalny |
| Kontrakt, warunek pochłaniania | Rozdział 1: założenia |
| Plan pakietu, dane, badanie obciążenia | Rozdział 2 |
| Zbiór empiryczny | Rozdział 3 |

**Wstępne pytanie badawcze.** Jak liczba jednostek nigdy nieobjętych programem
wpływa na jakość dopasowania sztucznej grupy porównawczej i przy jakiej ich liczbie
metoda przestaje dawać wiarygodne oszacowanie?

## Polecenia startowe

1. Walidacja panelu i wykrycie schematu wdrożenia, w tym powrotów.
2. Wagi jednostek przez regresję z ograniczeniami, zgodnie z Twoimi notatkami.
3. Wagi okresów sprzed wejścia.
4. Sekwencyjne wyznaczanie efektów i agregacja.
5. Procedura generowania panelu o zadanym efekcie i etapowym wdrożeniu.
6. Badanie obciążenia i pokrycia w powtórzeniach.

## Pułapki

**Estymator dwukierunkowy jako punkt wyjścia.** Narzędzie zaproponuje regresję
z efektami stałymi, bo tak wygląda typowy kod dla danych panelowych. To jest
dokładnie ten estymator, który metoda ma zastąpić, i który przy wdrożeniach
etapowych bywa obciążony.

**Ograniczenia na wagi.** Nieujemność i sumowanie do jedności to nie są detale
techniczne, tylko sedno metody. Implementacja bez tych ograniczeń liczy zwykłą
regresję i daje inny wynik.

**Parametr kary.** Sposób jego doboru jest w metodzie jawny. Wybór arbitralny
zmienia wynik i musi być opisany w pracy jako decyzja.

**Diagnostyka dopasowania.** Jeżeli sztuczna grupa porównawcza źle odtwarza przebieg
sprzed wejścia, wynik nie znaczy nic – niezależnie od tego, jak wygląda błąd
standardowy. Wykres przebiegów przed wejściem musi być w rozdziale trzecim.

**Na obronie** musisz umieć wyjaśnić, dlaczego przy wdrożeniach etapowych klasyczny
estymator potrafi dać zły znak, i jak wagi to naprawiają.

## Literatura

Artykuł źródłowy: `arkhangelsky2024sequential`.

Wprowadzenie: praca wprowadzająca syntetyczny estymator różnicy podwójnej; opracowanie
o problemach estymatora dwukierunkowego przy wdrożeniach etapowych. Dwie do czterech
pozycji dobierasz sam.

Środowisko: `rcore2026`. Wymagania formalne: `standardyEPI`.
