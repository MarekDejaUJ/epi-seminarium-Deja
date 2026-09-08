# Szablony poleceń

Cztery schematy pokrywające większość pracy nad pakietem. Kopiujesz, uzupełniasz
miejsca w nawiasach ostrych, wydajesz. Każde wydane polecenie zapisujesz
w [rejestrze](rejestr-polecen.md).

Metoda, w której te polecenia mają sens, jest opisana w rozdziale o pracy z agentem
programistycznym w przewodniku seminaryjnym.

---

## 1. Wzór na kod

Najczęstsze polecenie. Podajesz wzór **razem z objaśnieniem symboli**, bo bez
tego agent dobierze interpretację z najpopularniejszego wariantu metody,
niekoniecznie z Twojego artykułu.

```
Zaimplementuj funkcje <nazwa> w pliku R/<plik>.R.

Wzor:
  <wzor w notacji z artykulu>
gdzie:
  <objasnienie kazdego symbolu wraz z dziedzina>

Wejscie: <typ, ksztalt, dziedzina>
Wyjscie: <typ i znaczenie>

Wymagania:
- operacje na wektorach zamiast petli po wierszach,
- warunki wstepne sprawdzane na poczatku, z komunikatem po polsku,
- bez nowych zaleznosci,
- testy w tests/testthat/test-<nazwa>.R musza przejsc bez zmian.

Po napisaniu uruchom devtools::test() i pokaz wynik.
```

**Czego się spodziewać:** kodu, który przechodzi testy. **Co sprawdzić:** czy
normalizacja, wartości domyślne i kolejność kroków są te z artykułu, a nie
typowe dla innej metody.

---

## 2. Dane, na których metoda nie ma sensu

Polecenie do budowy testów odporności. Prosisz o **dane**, nie o testy: to Ty
decydujesz, jaki wynik jest poprawny.

```
Wypisz dziesiec zestawow danych wejsciowych dla funkcji <nazwa>, przy ktorych
metoda opisana w SPEC.md nie ma sensu albo dziala na granicy stosowalnosci.

Dla kazdego podaj:
- dane w postaci wywolania R,
- ktory warunek wstepny narusza,
- co powinno sie stac: blad, ostrzezenie czy poprawny wynik.

Nie pisz testow. Nie zmieniaj kodu funkcji.
```

**Czego się spodziewać:** listy przypadków, z których część będzie trafna,
a część nie. **Co sprawdzić:** czy proponowane zachowanie zgadza się z Twoją
specyfikacją – to Ty rozstrzygasz, nie agent.

---

## 3. Diagnostyka zamiast zgadywania

Gdy obliczenie nie zbiega albo daje wynik spoza oczekiwanego zakresu, agent ma
skłonność do zmieniania kodu na chybił trafił. To polecenie przerywa taki cykl.

```
Funkcja <nazwa> zwraca <opis objawu> dla danych <opis>.

Nie zmieniaj kodu. Wypisz wartosci posrednie po kazdym kroku algorytmu
opisanego w SPEC.md i wskaz krok, w ktorym wynik przestaje odpowiadac
oczekiwaniu. Podaj wartosci, ktore o tym swiadcza.
```

**Czego się spodziewać:** wskazania kroku, w którym coś się psuje.
**Co sprawdzić:** czy wartości pośrednie zgadzają się z tym, co sam policzysz
na kartce dla małego przypadku.

---

## 4. Dokumentacja ze specyfikacji

```
Napisz bloki dokumentacyjne roxygen2 dla funkcji eksportowanych w pliku
R/<plik>.R, na podstawie SPEC.md, a nie na podstawie kodu.

Wymagania:
- opis argumentu mowi, co argument znaczy, nie jakiego jest typu,
- sekcja o wartosci zwracanej opisuje strukture wyniku,
- przyklad wykonuje sie ponizej piatej sekundy i korzysta z danych pakietu,
- odwolanie do artykulu zrodlowego w sekcji references,
- tekst po polsku, identyfikatory bez znakow diakrytycznych.
```

**Czego się spodziewać:** kompletnych bloków. **Co sprawdzić:** czy przykłady
faktycznie się wykonują (`devtools::run_examples()`) i czy opis argumentu nie
powtarza jego nazwy innymi słowami.

---

## Czego nie zlecamy

Poniższe czynności rozstrzyga rozumienie metody, a nie znajomość języka:

- lektura artykułu i spisanie specyfikacji,
- rozstrzygnięcie niedopowiedzeń artykułu wraz z uzasadnieniem,
- ręczne wyliczenie przypadków analitycznych,
- decyzja o obsłudze braków danych i wartości brzegowych,
- projekt procedury generowania danych,
- decyzja o każdej zależności pakietu,
- interpretacja wyników,
- **cały tekst pracy oraz wszystkie cytowania i opisy bibliograficzne.**
