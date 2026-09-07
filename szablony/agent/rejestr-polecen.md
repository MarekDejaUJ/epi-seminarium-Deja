# Rejestr poleceń

Plik prowadzisz w repozytorium swojego pakietu **od pierwszego dnia**. Z niego
powstaje aneks pracy z wykazem poleceń wydanych narzędziu programistycznemu.

Odtworzenie rejestru przed oddaniem jest niewykonalne: po pół roku nie pamięta
się, które polecenie doprowadziło do której funkcji ani co w otrzymanym wyniku
trzeba było poprawić.

Rejestr dotyczy **wyłącznie budowy aplikacji**. Poleceń dotyczących korekty
językowej tekstu pracy tu nie zapisujesz – wystarczy wzmianka w oświadczeniu
o wykorzystaniu SI.

## Jak wypełniać

Kolumny **zmiany własne** i **weryfikacja** są najważniejsze: to one pokazują
Twój wkład. Wpis, w którym kolumna zmian własnych jest pusta, oznacza kod,
którego nie sprawdziłeś.

Do aneksu pracy przenosisz wpisy istotne, a nie wszystkie: te, które doprowadziły
do powstania funkcji publicznych, oraz te, przy których musiałeś poprawić
otrzymany wynik.

---

## 2027-02-14 · Wagi metodą entropii

**Cel.** Implementacja funkcji `oblicz_wagi_entropia()` zgodnie z krokami 1–3
specyfikacji.

**Polecenie.**

```
Zaimplementuj funkcje oblicz_wagi_entropia w pliku R/wagi.R.

Wzor:
  e_j = -(1 / ln m) * suma_i p_ij * ln p_ij
gdzie p_ij to udzial alternatywy i w sumie kolumny j, a m to liczba alternatyw.
...
```

**Zmiany własne.** Dodano obsługę kolumny o zerowej sumie, której polecenie nie
obejmowało – bez tego funkcja zwracała wartości nieokreślone zamiast błędu.
Zmieniono komunikat błędu tak, żeby wskazywał nazwę kryterium, a nie tylko numer
kolumny.

**Weryfikacja.** Przypadek analityczny z macierzą dwa na dwa policzony ręcznie ze
wzoru; sprawdzono niezmienniczość wag na przeskalowanie kolumny.

---

## 2027-02-16 · Dane do testów odporności

**Cel.** Zestawy danych naruszające warunki wstępne, do testów odporności.

**Polecenie.**

```
Wypisz dziesiec zestawow danych wejsciowych dla funkcji oblicz_wagi_entropia,
przy ktorych metoda opisana w SPEC.md nie ma sensu...
```

**Zmiany własne.** Z dziesięciu propozycji przyjęto sześć. Odrzucono cztery,
w których proponowanym zachowaniem było ostrzeżenie zamiast błędu – zgodnie ze
specyfikacją naruszenie warunku wstępnego zatrzymuje wykonanie. Dopisano przypadek
macierzy o jednym wierszu, którego propozycja nie obejmowała.

**Weryfikacja.** Każdy przypadek sprawdzony ręcznie pod kątem tego, który warunek
wstępny narusza; testy napisane samodzielnie na podstawie tej listy.

---

## RRRR-MM-DD · [tytuł]

**Cel.**

**Polecenie.**

```
```

**Zmiany własne.**

**Weryfikacja.**
