# Temat 11. Diagnoza umiejętności bez macierzy Q

## Metryka

| | |
|---|---|
| Artykuł źródłowy | Duan, Hao; Tang, James; Madison, Matthew J.; Cotterell, Michael; Jeon, Minjeong (2025). *Variational Bayesian Inference for a Q-Matrix-Free Hidden Markov Log-Linear Additive Cognitive Diagnostic Model*. Algorithms 18(11), 675 |
| Identyfikator | [10.3390/a18110675](https://doi.org/10.3390/a18110675) |
| Dostęp | otwarty |
| Dziedzina | psychometria, analityka uczenia się |
| Proponowany tytuł pracy | Pakiet R do śledzenia rozwoju umiejętności w czasie jako przykład zastosowania wnioskowania wariacyjnego w diagnozie edukacyjnej |
| Proponowana nazwa pakietu | `DiagnozaHMR` |
| Trudność | ●●●● |

> **Uwaga do nazwy metody.** Skrót w tytule oznacza model **log-liniowy**, a nie
> podłużny, i model jest **wolny od macierzy Q**. Opracowania wtórne mylą te
> określenia. Pracuj na tytule i treści z artykułu.

## Po co to badaczowi

Badania edukacyjne rzadko interesuje sam wynik testu. Interesuje je, **które
umiejętności** uczeń opanował, a których nie – bo dopiero to pozwala zaplanować
działanie. Modele diagnostyczne właśnie to dają: zamiast jednej liczby zwracają
profil opanowanych umiejętności.

Mają jednak dwa ograniczenia, które w praktyce bardzo bolą.

Pierwsze: wymagają **tablicy specyfikacji** mówiącej, które zadanie mierzy którą
umiejętność. Tablicę wypełniają eksperci, a eksperci się mylą (o czym jest temat 03).
Model postawiony na błędnej tablicy zwraca diagnozę, która wygląda wiarygodnie i jest
fałszywa.

Drugie: klasyczne modele opisują **jeden moment**. Tymczasem uczenie się jest
procesem, a pytanie brzmi nie „co uczeń umie", tylko „czego się nauczył od
poprzedniego pomiaru i co przewidujemy dalej". Modele obsługujące wiele pomiarów
istnieją, ale ich estymacja przy kilkunastu umiejętnościach i kilku falach badania
staje się obliczeniowo nieosiągalna: liczba możliwych profili rośnie wykładniczo.

Artykuł mierzy się z obydwoma naraz. Model **nie wymaga tablicy specyfikacji** – 
zamiast tego pozwala ją odtworzyć z oszacowanych parametrów zadań. A wnioskowanie
wariacyjne zastępuje kosztowne całkowanie zadaniem optymalizacji, dzięki czemu
estymacja jest wykonalna dla realnych rozmiarów danych.

Dla badacza edukacji jest to narzędzie do analizy badań podłużnych, które dziś
zwykle sprowadza się do porównywania średnich między falami.

## Algorytm

**Wejście.** Macierz odpowiedzi w trzech wymiarach: uczniowie, zadania, fale pomiaru.
Liczba umiejętności. Opcjonalnie wagi próby i obsługa wypadnięcia z badania.

**Wyjście.** Rozkłady opanowania umiejętności dla każdego ucznia i fali; parametry
zadań; macierze przejść między falami; odtworzona tablica specyfikacji; miary
dopasowania.

**Kroki.**

1. Sprawdzenie wejścia: kompletność wymiarów, zgodność zestawu zadań między falami,
   obsługa wypadnięcia.
2. Inicjalizacja rozkładów wariacyjnych dla profili umiejętności i parametrów zadań.
3. Naprzemienne uaktualnianie: przy ustalonych parametrach zadań uaktualnij rozkłady
   profili, przy ustalonych profilach uaktualnij parametry.
4. Uaktualnienie macierzy przejść między falami.
5. Powtarzanie do zbieżności mierzonej kryterium wariacyjnym.
6. Odtworzenie tablicy specyfikacji z oszacowanych parametrów zadań.

**Co wynotować z artykułu.** Z sekcji metodycznej: postać modelu odpowiedzi
log-liniowego wraz z parametrami zadań; postać rozkładów wariacyjnych i przyjętą
faktoryzację; **pełne wzory uaktualnień** dla każdego bloku parametrów; definicję
kryterium zbieżności; regułę odtwarzania tablicy specyfikacji z parametrów zadań;
sposób inicjalizacji i jego wpływ na wynik.

## Kontrakt

**Warunki wstępne.** Macierz odpowiedzi zero-jedynkowa; co najmniej dwie fale
pomiaru; ten sam zestaw zadań albo jawnie zadeklarowane powiązanie zadań między
falami; liczba umiejętności co najmniej dwa i mniejsza od liczby zadań.

**Niezmienniki.** Kryterium wariacyjne nie maleje między iteracjami. Rozkłady profili
sumują się do jedności dla każdego ucznia i fali. Wiersze macierzy przejść sumują się
do jedności. Wynik nie zależy od kolejności uczniów.

**Wyjście.** Klasa `diagnoza_hm` ze składnikami: rozkłady profili, parametry zadań,
macierze przejść, odtworzona tablica specyfikacji, przebieg kryterium, liczba iteracji.

**Błędy zatrzymujące wykonanie.** Jedna fala pomiaru; liczba umiejętności większa od
liczby zadań; odpowiedzi spoza zbioru zero-jedynkowego; brak zbieżności w zadanej
liczbie iteracji.

## Plan pakietu

| Plik | Odpowiedzialność |
|---|---|
| `R/przygotowanie_danych.R` | walidacja macierzy trójwymiarowej, obsługa wypadnięcia |
| `R/model.R` | model odpowiedzi, prawdopodobieństwa warunkowe |
| `R/wariacyjne.R` | uaktualnienia rozkładów wariacyjnych |
| `R/przejscia.R` | macierze przejść między falami |
| `R/tablica_q.R` | odtworzenie tablicy specyfikacji |
| `R/klasy_s3.R` | obiekt wyniku, metody `print` i `summary` |
| `R/wizualizacja.R` | trajektorie opanowania, mapa cieplna przejść |

Zależności: `stats` i `ggplot2`. **Uaktualnienia licz na macierzach, nie w pętlach
po uczniach** – to jedyna decyzja przesądzająca o wykonalności przy realnych danych.

## Dane

**Procedura generowania.** Ustalasz prawdziwą tablicę specyfikacji, parametry zadań
i macierze przejść, losujesz trajektorie opanowania umiejętności i generujesz
odpowiedzi. Znasz wtedy prawdziwe profile, przejścia i tablicę, więc możesz zmierzyć
trzy rzeczy naraz: trafność klasyfikacji profili, obciążenie oszacowań przejść oraz
zgodność odtworzonej tablicy z prawdziwą. Ostatnia jest najciekawsza, bo dotyczy
głównego twierdzenia artykułu.

Parametry: liczba uczniów, zadań, umiejętności, fal, tempo uczenia się, parametry
zgadywania i przeoczenia, odsetek wypadnięć, ziarno.

**Przypadki o znanym wyniku.** Brak zmian między falami: macierz przejść bliska
jednostkowej. Umiejętności całkowicie opanowane od początku: rozkłady skupione.
Model z jedną umiejętnością i dwoma zadaniami: uaktualnienia policzalne ręcznie.

**Przypadki patologiczne.** Uczeń bez odpowiedzi w jednej fali; zadanie, na które
wszyscy odpowiedzieli poprawnie; dwie fale przy trzech umiejętnościach.

**Zbiór empiryczny.** Otwarte dane z badań podłużnych osiągnięć edukacyjnych albo
z platform uczenia się udostępniających dane badawcze. Sprawdź licencję i wymagania
dotyczące danych o osobach niepełnoletnich – to jest w tym temacie warunek konieczny.

## Mapowanie na pracę

| Sekcja briefu | Rozdział pracy |
|---|---|
| Po co to badaczowi, oba ograniczenia | Wprowadzenie: tło i luka |
| Algorytm, co wynotować | Rozdział 1: aparat formalny |
| Kontrakt, przybliżenie wariacyjne | Rozdział 1: granice stosowalności |
| Plan pakietu, dane, trzy miary skuteczności | Rozdział 2 |
| Zbiór empiryczny | Rozdział 3 |

**Wstępne pytanie badawcze.** Przy jakiej liczbie uczniów i fal pomiaru odtworzona
tablica specyfikacji zgadza się z prawdziwą na tyle, żeby oprzeć na niej diagnozę,
i jak zależy to od liczby umiejętności?

## Polecenia startowe

1. Model odpowiedzi jako funkcja profilu i parametrów zadania. Sprawdź na przykładzie
   jednej umiejętności policzonym ręcznie.
2. Uaktualnienie rozkładów profili przy ustalonych parametrach zadań, na macierzach.
3. Uaktualnienie parametrów zadań i macierzy przejść.
4. Kryterium zbieżności i pętla główna z jawnym warunkiem zatrzymania.
5. Procedura generowania ze znaną tablicą specyfikacji i znanymi przejściami.
6. Badanie zgodności odtworzonej tablicy z prawdziwą.

## Pułapki

**Wnioskowanie wariacyjne to przybliżenie.** Nie daje rozkładu prawdziwego, tylko
najbliższy w obrębie przyjętej rodziny. Zwykle **zaniża niepewność**. Praca musi to
powiedzieć, bo inaczej przedziały wiarygodności zostaną odczytane dosłownie.

**Kryterium nie może maleć.** Spadek między iteracjami oznacza błąd w uaktualnieniach.
To najlepszy test poprawności implementacji, jaki masz w tym temacie, i wart osobnego
testu jednostkowego.

**Zamiana etykiet umiejętności.** Model nie wie, która umiejętność jest którą.
Porównanie odtworzonej tablicy z prawdziwą wymaga dopasowania kolejności kolumn.
Pominięcie tego kroku da wynik pozornie fatalny.

**Pętle po uczniach.** Przy tysiącu uczniów, kilkunastu umiejętnościach i kilku falach
kod się nie skończy. Przeniesienie uaktualnień na operacje macierzowe jest sednem
części inżynierskiej.

**Na obronie** musisz umieć wyjaśnić, co zastępuje wnioskowanie wariacyjne, dlaczego
zamienia całkowanie na optymalizację i co się przez to traci.

## Literatura

Artykuł źródłowy: `duan2025hmlacdm`.

Wprowadzenie: podręcznikowe omówienie modeli diagnostycznych; wprowadzenie do
wnioskowania wariacyjnego. Dwie do czterech pozycji dobierasz sam. Temat pokrewny
z tematem 03 – warto uzgodnić wspólną część literatury o tablicy specyfikacji.

Środowisko: `rcore2026`. Wymagania formalne: `standardyEPI`.
