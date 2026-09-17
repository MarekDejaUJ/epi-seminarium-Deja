# Tematy prac

Czternaście tematów, po jednym na osobę. Każdy opiera się na artykule metodycznym
opisującym algorytm, który zaimplementujesz jako pakiet języka R.

Zanim wybierzesz, przeczytaj [notę o doborze tematów](dobor-tematow.md) oraz brief
tematu, który Cię interesuje. Brief jest samowystarczalny: żeby zacząć, nie
potrzebujesz niczego poza nim i artykułem źródłowym.

## Zestawienie

| Nr | Temat | Dziedzina | Rdzeń obliczeniowy | Trudność |
|---|---|---|---|---|
| [01](brief-01.md) | Granice prawdopodobieństw przyczynowości | wnioskowanie przyczynowe | jawne nierówności probabilistyczne | ●●● |
| [02](brief-02.md) | Wiarygodność ocen trafności generowanych maszynowo | wyszukiwanie informacji | estymacja obciążenia, przedziały ufności | ●● |
| [03](brief-03.md) | Ocena wyszukiwarki przy niepełnych sądach o trafności | wyszukiwanie informacji | zliczanie par, jedna suma | ● |
| [04](brief-04.md) | Indeks przełomowości jako miara wyparcia | bibliometria | operacje na macierzach rzadkich | ●● |
| [05](brief-05.md) | Ramy interpretacyjne w dyskursie spolaryzowanym | komunikacja społeczna | selekcja wyrażeń z modeli tematów | ●● |
| [06](brief-06.md) | Granice efektu przy brakach nielosowych | badania ankietowe | wzory granic, siatka ograniczeń rozkładu | ●●● |
| [07](brief-07.md) | Miara skuteczności wyprowadzona z modelu użytkownika | wyszukiwanie informacji | wagi geometryczne, wartość resztowa | ●● |
| [08](brief-08.md) | Podobieństwo rankingów nieokreślonej długości | porównywanie list | pokrycie przyrostowe, wagi geometryczne | ●● |
| [09](brief-09.md) | Wskaźnik oddziaływania oparty na percentylach | bibliometria, polityka naukowa | klasy percentylowe, suma ważona | ●● |
| [10](brief-10.md) | Metaanaliza parametrów teorii perspektywy | ekonomia behawioralna | bayesowski model hierarchiczny, wspólna imputacja | ●●● |
| [11](brief-11.md) | Standaryzacja wyników między zestawami zapytań | metodologia eksperymentu | standaryzacja rozkładowa | ●● |
| [12](brief-12.md) | Nowość i różnorodność w ocenie rankingu | wyszukiwanie informacji | zysk zależny od pozycji, przybliżenie zachłanne | ●●● |
| [13](brief-13.md) | Model kaskadowy zatrzymania użytkownika | zachowania informacyjne | iloczyny częściowe, wartość oczekiwana | ●● |
| [14](brief-14.md) | Rozkład przełomowości na destabilizację i konsolidację | bibliometria | operacje na zbiorach, średnie po źródłach | ●● |

Skala trudności odnosi się do **przygotowania matematycznego**, którego wymaga
zrozumienie metody, a nie do ilości kodu. Temat oznaczony dwiema kropkami nie jest
łatwiejszy do napisania; jest łatwiejszy do zrozumienia.

Trzy kropki to górna granica przyjęta w seminarium. Zakres obowiązkowy jest
ograniczony w briefach, aby nakład pracy był porównywalny. W temacie 10 obejmuje
niewielki model hierarchiczny i jego diagnostykę; nie obejmuje odtwarzania wszystkich
metaregresji autorów. W temacie 01 obejmuje wybrane jawne granice, a pełna rekurencja
i porównawczy solver są rozszerzeniami.
Temat 03 stoi na poziomie najniższym celowo i jest dobrym wyborem, jeżeli matematyka
nie jest Twoją mocną stroną: cały jego aparat to zliczanie par i jedna suma, a ciężar
pracy leży w danych i w rzetelności eksperymentu.

Sześć tematów dotyczy pomiaru skuteczności wyszukiwania, a temat 08 porównywania
rankingów. Można w nich wykorzystać wspólny zbiór i wzajemnie recenzować procedury
oceny. Istniejący kod metody jest punktem odniesienia do sprawdzenia własnej
implementacji. Dotyczy to zwłaszcza tematu 08, dla którego autorzy udostępniają
wszystkie warianty w R, oraz tematu 14 z kodem składowych i porównania baz.
Wkład projektu trzeba określić przez zakres pakietu, walidację i analizę, bez
nieudokumentowanego twierdzenia o braku dostępnych implementacji.

## Jak wybrać

Czytaj brief w tej kolejności: sekcja „po co to badaczowi", potem „pułapki", dopiero
potem algorytm. Jeżeli po pierwszej sekcji nie potrafisz powiedzieć własnymi słowami,
jaki problem metoda rozwiązuje, wybierz inny temat. Wzory da się doczytać, motywacji
nie da się nadrobić.

Sprawdź też dostęp do artykułu. Pozycje oznaczone jako dostęp otwarty pobierzesz od
ręki; pozostałe przez bibliotekę Uniwersytetu.

## Przydział

| Nr | Osoba |
|---|---|
| 01 | |
| 02 | |
| 03 | |
| 04 | |
| 05 | |
| 06 | |
| 07 | |
| 08 | |
| 09 | |
| 10 | |
| 11 | |
| 12 | |
| 13 | |
| 14 | |

## Tematy pokrewne

Osoby pracujące nad tematami z tej samej grupy mogą się wzajemnie recenzować:
mają wspólną literaturę wprowadzającą i podobne pułapki.

- **Pomiar skuteczności wyszukiwania:** 02, 03, 07, 08, 11, 12, 13 – grupa
  najliczniejsza, o wspólnych danych i wspólnej literaturze wprowadzającej
- **Bibliometria i dane cytowań:** 04, 09, 14
- **Wnioskowanie przyczynowe:** 01, 06
- **Tekst i komunikacja:** 05
- **Decyzje i zachowania:** 10, 13
