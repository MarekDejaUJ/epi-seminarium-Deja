# SPEC – kontrakt algorytmu

Dokument spisuje się **przed napisaniem kodu**. Powstaje z lektury artykułu
źródłowego i jest jednocześnie materiałem do rozdziału pierwszego pracy:
założenia metody, które tu wypiszesz, staną się warunkami wstępnymi funkcji.

Wypełniony `SPEC.md` leży w katalogu głównym repozytorium pakietu. Zmieniasz go,
gdy zmienia się rozumienie metody – nie wtedy, gdy zmienia się kod.

---

## 1. Metryka

| | |
|---|---|
| Artykuł źródłowy | *autor, rok, tytuł, czasopismo, DOI* |
| Sekcja z definicją algorytmu | *numer sekcji i strony* |
| Nazwa pakietu | |
| Autor | |
| Data ostatniej zmiany | |

## 2. Po co to badaczowi

Trzy do pięciu zdań językiem ogólnym: jaki problem metoda rozwiązuje, czego bez
niej nie da się zrobić, na jakie pytanie pozwala odpowiedzieć. Bez wzorów.

Jeżeli nie potrafisz tego napisać, nie rozumiesz jeszcze metody na tyle, żeby ją
zaimplementować.

## 3. Wejście

Dla każdej wielkości wejściowej podaj typ, kształt i dziedzinę.

| Nazwa | Typ | Kształt | Dziedzina | Obowiązkowa |
|---|---|---|---|---|
| | | | | |

Uzupełnij o reguły, których nie da się zapisać w tabeli:

- co znaczy brak danych w każdej ze zmiennych i czy wolno go zastąpić;
- czy kolejność wierszy lub kolumn ma znaczenie;
- jakie wartości są kodami błędu, a nie pomiarami;
- jakie skale pomiarowe zakłada metoda.

## 4. Warunki wstępne

Warunki, które muszą zachodzić, żeby wynik miał sens. Każdy z nich stanie się
sprawdzeniem w kodzie i testem odporności.

| # | Warunek | Komunikat przy naruszeniu |
|---|---|---|
| P1 | | |
| P2 | | |

Warunek bez komunikatu jest niedokończony: użytkownik ma dowiedzieć się nie
tylko, że coś jest nie tak, ale co poprawić.

## 5. Algorytm

Kolejne kroki wraz ze wzorami z artykułu. Każdy symbol objaśniony. Po każdym
wzorze zdanie o tym, co ten wzór robi.

**Krok 1.** *nazwa*

$$
\text{wzór}
$$

gdzie *objaśnienie symboli*.

*Co robi ten krok:* …

**Krok 2.** …

### Decyzje, których artykuł nie rozstrzyga

Miejsca, w których publikacja milczy, a implementacja musi zająć stanowisko:
wartości domyślne parametrów, sposób normalizacji, kolejność kroków,
zachowanie przy remisach. Dla każdej pozycji podaj przyjęte rozwiązanie
**i jego uzasadnienie**.

| Niedopowiedzenie | Przyjęte rozwiązanie | Uzasadnienie |
|---|---|---|
| | | |

Ta tabela jest najcenniejszą częścią dokumentu. To ona odróżnia implementację
od przepisania i to ona najczęściej trafia do wniosków pracy.

## 6. Wyjście

Struktura zwracana przez funkcję główną.

| Składnik | Typ | Znaczenie |
|---|---|---|
| | | |

Klasa obiektu: `______`. Metody generyczne: `print`, `summary`, `plot`.

## 7. Niezmienniki

Własności, które muszą zachodzić niezależnie od danych. Każda z nich stanie się
testem własności.

- [ ] niezmienniczość na przeskalowanie …
- [ ] niezmienniczość na kolejność …
- [ ] zakres wartości wyniku: …
- [ ] monotoniczność względem …

## 8. Złożoność i granice stosowalności

Złożoność obliczeniowa względem liczby obserwacji i zmiennych. Rozmiar danych,
przy którym metoda przestaje być praktyczna. Warunki, przy których wynik traci
sens mimo poprawnego wykonania.

## 9. Przypadki testowe o znanym wyniku

Przypadki policzone ręcznie ze wzoru, nie uruchomieniem kodu.

| # | Wejście | Oczekiwany wynik | Skąd wiadomo |
|---|---|---|---|
| T1 | | | |
| T2 | | | |

Co najmniej jeden przypadek zdegenerowany (dane minimalne) i jeden brzegowy
(wartości na krańcach dziedziny).

## 10. Procedura generowania danych

Struktura, którą wprowadzasz do danych testowych, i wynik, jakiego w związku
z tym oczekujesz.

- rozkłady zmiennych i ich parametry:
- zależności między zmiennymi:
- ukryta struktura, którą narzędzie ma odtworzyć:
- kontrolowane zanieczyszczenia (braki, kody błędne, wartości odstające):
- ziarno losowości:

## 11. Zbiór empiryczny

Zbiór do studium przypadku: nazwa, adres, licencja, rozmiar, powód wyboru.
Sprawdź licencję **przed** rozpoczęciem analizy.

## 12. Zależności

| Pakiet | Do czego | Imports czy Suggests |
|---|---|---|
| | | |

Każda zależność zwiększa ryzyko, że pakiet przestanie się instalować. Dodawaj
tylko te, bez których nie da się obejść.
