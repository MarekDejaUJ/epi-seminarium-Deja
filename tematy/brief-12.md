# Temat 12. Ranking nagradzający nowość zamiast powtórzeń

## Metryka

| | |
|---|---|
| Artykuł źródłowy | Clarke, Charles L. A.; Kolla, Maheedhar; Cormack, Gordon V.; Vechtomova, Olga; Ashkan, Azin; Büttcher, Stefan; MacKinnon, Ian (2008). *Novelty and Diversity in Information Retrieval Evaluation*. SIGIR '08, s. 659-666 |
| Identyfikator | [10.1145/1390334.1390446](https://doi.org/10.1145/1390334.1390446) |
| Dostęp | przez bibliotekę UJ |
| Dziedzina | wyszukiwanie informacji, wieloznaczność zapytań |
| Proponowany tytuł pracy | Pakiet R do oceny różnorodności wyników wyszukiwania jako przykład zastosowania miar nowości w analizie systemów informacyjnych |
| Proponowana nazwa pakietu | `RoznorodnoscR` |
| Trudność | ●●● |

## Po co to badaczowi

Klasyczne miary skuteczności sumują trafność dokumentów niezależnie od siebie. Dziesięć
dokumentów mówiących dokładnie to samo dostaje taką samą ocenę jak dziesięć dokumentów
pokrywających dziesięć różnych aspektów sprawy. Dla użytkownika są to sytuacje zupełnie
różne, a miara ich nie odróżnia.

Problem ma dwa źródła. Pierwsze to **wieloznaczność zapytania**: słowo wpisane
w wyszukiwarkę zwykle ma kilka znaczeń, a system nie wie, o które chodzi. Rozsądne
zachowanie polega wtedy na pokryciu kilku znaczeń w pierwszej dziesiątce, a nie na
postawieniu wszystkiego na jedno. Klasyczna miara karze za takie zachowanie, bo dokumenty
z pozostałych znaczeń liczy jako nietrafne.

Drugie źródło to **powtarzalność**. Nawet przy zapytaniu jednoznacznym użytkownik, który
przeczytał pierwszy dokument, nie potrzebuje piątego, mówiącego to samo innymi słowami.
Wartość dokumentu zależy od tego, co użytkownik już widział, a więc od pozycji w rankingu
i od zawartości pozycji wcześniejszych.

Artykuł podaje ramę, w której trafność przestaje być własnością dokumentu, a staje się
własnością **dokumentu w kontekście rankingu**. Potrzeba informacyjna rozkłada się na
elementy składowe, a dokument dostaje tym mniejszy zysk za dany element, im więcej
wcześniejszych dokumentów ten element już pokryło.

Dla badacza zachowań informacyjnych jest to miara odpowiadająca na pytanie, czy system
rozumie, że użytkownik czyta ranking po kolei i się uczy.

## Algorytm

**Wejście.** Ranking dokumentów; rozkład potrzeby informacyjnej na elementy składowe;
macierz przynależności mówiąca, który dokument pokrywa który element; parametr $\alpha$
sterujący karą za powtórzenie; głębokość oceny.

**Wyjście.** Zysk na każdej pozycji, skumulowany zysk zdyskontowany, wartość
znormalizowana, ranking wzorcowy użyty do normalizacji.

**Wzory.** Niech $J(d_k, i)$ przyjmuje wartość jeden, gdy dokument na pozycji $k$ pokrywa
element $i$ potrzeby informacyjnej, a zero w przeciwnym razie. Niech

$$r_{i,k-1} = \sum_{j=1}^{k-1} J(d_j, i)$$

oznacza liczbę dokumentów stojących **przed** pozycją $k$, które element $i$ już pokryły.
Zysk pozycji $k$ wynosi

$$G[k] = \sum_{i=1}^{m} J(d_k, i)\,(1-\alpha)^{\,r_{i,k-1}}$$

gdzie $m$ to liczba elementów potrzeby, a $\alpha$ należy do przedziału od zera do
jedności. Kluczowy jest wykładnik: pierwszy dokument pokrywający dany element dostaje
za niego pełny zysk, drugi $(1-\alpha)$, trzeci $(1-\alpha)^2$ i tak dalej.

Zysk sumuje się z dyskontem pozycyjnym:

$$DCG[k] = \sum_{j=1}^{k} \frac{G[j]}{\log_2(1+j)}$$

a wartość znormalizowana to iloraz przez tę samą wielkość policzoną dla rankingu
wzorcowego:

$$\alpha\text{-}nDCG[k] = \frac{DCG[k]}{DCG'[k]}$$

**Ranking wzorcowy.** Tu jest sedno trudności tego tematu. Ranking maksymalizujący zysk
skumulowany nie daje się wyznaczyć przeglądem wszystkich możliwości, bo problem należy
do klasy zadań trudnych obliczeniowo. Stosuje się przybliżenie **zachłanne**: na każdą
kolejną pozycję wybiera się dokument dający największy zysk przy już wybranym początku
rankingu. Jest to decyzja, którą trzeba w pracy nazwać, bo wynik znormalizowany od niej
zależy.

Przy $\alpha = 0$ kara za powtórzenie znika i miara sprowadza się do zwykłego zysku
skumulowanego z dyskontem. Przy $\alpha = 1$ drugi i każdy kolejny dokument pokrywający
ten sam element nie wnosi nic.

**Kroki.**

1. Sprawdzenie danych: zgodność wymiarów macierzy przynależności z rankingiem, zakres
   parametru, niepusty zbiór elementów potrzeby.
2. Przejście po rankingu z pamięcią, ile razy każdy element był już pokryty.
3. Złożenie zysku na każdej pozycji.
4. Skumulowanie zysku z dyskontem pozycyjnym.
5. Zbudowanie rankingu wzorcowego metodą zachłanną i policzenie dla niego tej samej
   wielkości.
6. Podzielenie i zestawienie z miarą klasyczną liczoną bez kary za powtórzenie.

**Co wynotować z artykułu.** Uzasadnienie postaci wykładniczej kary; interpretację
parametru $\alpha$ jako prawdopodobieństwa, że ocena przynależności jest błędna; sposób
budowy rankingu wzorcowego i jego uzasadnienie; własności, które autorzy wykazują dla
miary, oraz przyjęte założenia o niezależności elementów potrzeby.

## Kontrakt

**Warunki wstępne.** Parametr $\alpha$ w przedziale od zera do jedności; macierz
przynależności zerojedynkowa o wymiarach dokumenty na elementy; ranking bez powtórzeń;
co najmniej jeden element potrzeby.

**Niezmienniki.** Zysk na pozycji jest nieujemny i nie przekracza liczby elementów
potrzeby. Zysk skumulowany jest niemalejący. Wartość znormalizowana należy do przedziału
od zera do jedności. Przy $\alpha = 0$ wynik równa się miarze bez kary za powtórzenie.
Przy $\alpha = 1$ powtórne pokrycie elementu daje zysk zerowy.

**Wyjście.** Klasa `roznorodnosc_rankingu` ze składnikami: zysk na pozycjach, zysk
skumulowany, wartość znormalizowana, ranking wzorcowy, pokrycie elementów potrzeby.

**Błędy zatrzymujące wykonanie.** Parametr poza przedziałem; niezgodność wymiarów;
macierz przynależności spoza zbioru zerojedynkowego; ranking z powtórzeniami.

## Plan pakietu

| Plik | Odpowiedzialność |
|---|---|
| `R/przygotowanie_danych.R` | walidacja rankingu, macierzy przynależności i parametru |
| `R/zysk.R` | zysk na pozycji z uwzględnieniem wcześniejszych pokryć |
| `R/dyskonto.R` | skumulowanie z dyskontem pozycyjnym |
| `R/wzorzec.R` | ranking wzorcowy metodą zachłanną |
| `R/klasy_s3.R` | obiekt wyniku, metody `print` i `summary` |
| `R/wizualizacja.R` | pokrycie elementów wzdłuż rankingu, wpływ parametru |

Zależności: `stats` i `ggplot2`. Licznik wcześniejszych pokryć prowadź jako **wektor
aktualizowany w trakcie przejścia**, a nie licz od nowa dla każdej pozycji: różnica
między złożonością liniową a kwadratową względem długości rankingu.

## Dane

**Procedura generowania.** Budujesz zbiór dokumentów o **zadanym pokryciu elementów
potrzeby**: część dokumentów pokrywa jeden element, część kilka, część żadnego. Znasz
wtedy ranking optymalny w przypadkach prostych i możesz sprawdzić, czy przybliżenie
zachłanne go odtwarza. Następnie generujesz rankingi o kontrolowanej powtarzalności
i badasz, jak miara je odróżnia.

Parametry: liczba dokumentów, liczba elementów potrzeby, rozkład pokrycia, stopień
powtarzalności rankingu, wartość parametru kary, ziarno.

**Przypadki o znanym wyniku.** Każdy dokument pokrywa dokładnie jeden, inny element:
kara nie działa, wynik równy miarze klasycznej. Wszystkie dokumenty pokrywają ten sam
element: zysk maleje geometrycznie, wartości policzalne ręcznie. Ranking o długości dwa:
cały rachunek mieści się w trzech linijkach – wpisz go do komentarza testu.

**Przypadki patologiczne.** Żaden dokument nie pokrywa żadnego elementu; jeden element
potrzeby; parametr równy jedności przy dokumentach pokrywających wyłącznie ten sam
element.

**Zbiór empiryczny.** Zapytania wieloznaczne wraz z podziałem na znaczenia. Materiał
tego rodzaju udostępniają kolekcje testowe do zadań różnorodności; można go też zbudować
samodzielnie dla kilkunastu zapytań, opisując znaczenia ręcznie. **Opis procedury
opisywania jest wtedy częścią metodologii**, nie szczegółem technicznym.

## Mapowanie na pracę

| Sekcja briefu | Rozdział pracy |
|---|---|
| Po co to badaczowi, wieloznaczność i powtarzalność | Wprowadzenie: tło i luka |
| Wzory, kara wykładnicza, ranking wzorcowy | Rozdział 1: aparat formalny |
| Kontrakt, zachowanie graniczne parametru | Rozdział 1: granice stosowalności |
| Plan pakietu, przybliżenie zachłanne, procedura generowania | Rozdział 2 |
| Zbiór empiryczny, porównanie z miarą klasyczną | Rozdział 3 |

**Wstępne pytanie badawcze.** Jak dobór parametru kary za powtórzenie wpływa na
uporządkowanie systemów i przy jakiej wartości ranking pokrywający wiele znaczeń zaczyna
wygrywać z rankingiem skupionym na jednym?

## Polecenia startowe

1. Walidacja rankingu, macierzy przynależności i parametru.
2. Zysk na pozycji z licznikiem wcześniejszych pokryć, aktualizowanym w przejściu.
3. Skumulowanie z dyskontem pozycyjnym.
4. Ranking wzorcowy metodą zachłanną, zgodnie z Twoimi notatkami.
5. Procedura generowania dokumentów o zadanym pokryciu elementów potrzeby.
6. Badanie wpływu parametru na uporządkowanie dwóch rankingów o różnej powtarzalności.

## Pułapki

**Zysk liczony niezależnie od pozycji.** Agent napisze sumę trafności, bo tak wygląda
typowy kod miary rankingowej. Cała treść tej metody leży w tym, że zysk zależy od tego,
co stoi wyżej. Test z dokumentami pokrywającymi ten sam element wychwyci to od razu.

**Licznik pokryć liczony od nowa.** Poprawnie, ale wolno. Przy rankingu tysiąca pozycji
i kilkudziesięciu elementach potrzeby różnica jest wyraźna.

**Ranking wzorcowy wyznaczany przeglądem zupełnym.** Nie skończy się. Metoda zachłanna
jest w artykule i jest przybliżeniem, o czym praca musi powiedzieć wprost, bo wynik
znormalizowany zależy wtedy od jakości przybliżenia.

**Elementy potrzeby traktowane jak niezależne.** Metoda to zakłada, a w realnych danych
znaczenia zapytania bywają zagnieżdżone. Jest to ograniczenie do opisania w granicach
stosowalności, a nie usterka implementacji.

**Na obronie** musisz umieć podać dwa rankingi o tej samej wartości miary klasycznej
i różnej wartości miary z karą, oraz wyjaśnić, co dokładnie oznacza parametr $\alpha$.

## Literatura

Artykuł źródłowy: `clarke2008novelty`.

Wprowadzenie: podręcznikowe omówienie zysku skumulowanego z dyskontem; opracowanie
o wieloznaczności zapytań i różnorodności wyników. Dwie do czterech pozycji dobierasz
sam. Tematy pokrewne: 07 i 13 – wszystkie trzy wyprowadzają miarę z założeń o zachowaniu
użytkownika.

Środowisko: `rcore2026`. Wymagania formalne: `standardyEPI`.
