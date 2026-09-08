# Temat 03. Ocena wyszukiwarki, gdy nie wszystko oceniono

## Metryka

| | |
|---|---|
| Artykuł źródłowy | Buckley, Chris; Voorhees, Ellen M. (2004). *Retrieval Evaluation with Incomplete Information*. SIGIR '04, s. 25-32 |
| Identyfikator | [kopia w repozytorium NIST](https://tsapps.nist.gov/publication/get_pdf.cfm?pub_id=150469) |
| Dostęp | wolny |
| Dziedzina | wyszukiwanie informacji, ocena systemów |
| Proponowany tytuł pracy | Pakiet R do oceny skuteczności wyszukiwania przy niepełnych sądach o trafności jako przykład zastosowania miar preferencyjnych w badaniach nad systemami informacyjnymi |
| Proponowana nazwa pakietu | `NiepelnaOcenaR` |
| Trudność | ● |

Temat o najniższym progu matematycznym w całym zestawie. Cały aparat to liczenie par
dokumentów i jedna suma. Trudność projektu leży w danych i w rzetelnym eksperymencie,
nie we wzorze.

## Po co to badaczowi

Skuteczność wyszukiwarki mierzy się, porównując to, co zwróciła, z tym, co jest
naprawdę trafne. Problem w tym, że **nikt nigdy nie ocenił całej kolekcji**. Przy
milionie dokumentów i pięćdziesięciu zapytaniach ocena wszystkiego jest niewykonalna,
więc od czasów pierwszych konferencji ewaluacyjnych ocenia się tylko pulę: kilkaset
dokumentów najwyżej ustawionych przez badane systemy.

Powstaje wtedy cicha luka. Dokument nieoceniony traktuje się jak nietrafny. Dopóki
porównujemy systemy, które współtworzyły pulę, jest to przybliżenie do przyjęcia.
Kłopot zaczyna się, gdy pojawia się **system nowy**, którego w puli nie było: jego
trafne trafienia mogą być nieocenione, a więc policzone jako nietrafne. Nowy system
wygląda gorzej, niż jest.

Jest to problem realny, nie hipotetyczny. Kolekcje testowe żyją latami, a systemy
oceniane na nich powstają długo po zamknięciu puli. Dotyczy też każdego, kto buduje
własną kolekcję: sądy o trafności kosztują czas eksperta, więc zawsze jest ich za mało.

Artykuł pokazuje, jak bardzo klasyczne miary zawodzą przy niepełnych ocenach, i podaje
miarę odporną: **bpref**, liczoną wyłącznie na dokumentach ocenionych, z pominięciem
nieocenionych zamiast uznawania ich za nietrafne.

## Algorytm

**Wejście.** Ranking dokumentów zwrócony przez system dla zapytania oraz zbiór sądów
o trafności: dla części dokumentów wiadomo, że są trafne, dla części, że nietrafne,
o reszcie nie wiadomo nic.

**Wyjście.** Wartość miary dla zapytania, wartość uśredniona po zapytaniach, liczba
dokumentów nieocenionych w rankingu oraz miary klasyczne do porównania.

**Wzór.** Niech $R$ oznacza liczbę dokumentów ocenionych jako trafne, $r$ pojedynczy
dokument trafny, a $n$ dokument oceniony jako nietrafny, należący do pierwszych $R$
takich dokumentów w rankingu. Wtedy

$$\mathrm{bpref} = \frac{1}{R}\sum_{r}\left(1 - \frac{|n \text{ przed } r|}{R}\right)$$

gdzie $|n \text{ przed } r|$ to liczba tych dokumentów nietrafnych, które w rankingu
stoją wyżej niż dany dokument trafny.

Miara odpowiada na pytanie: **jak często oceniony dokument trafny wyprzedza oceniony
dokument nietrafny**. Dokumenty nieoceniane nie występują w tym wzorze w ogóle, więc
nie da się ukarać systemu za znalezienie czegoś, czego nikt nie obejrzał.

Przy małej liczbie dokumentów trafnych miara robi się skokowa, bo par jest bardzo
mało. Autorzy podają dla takich przypadków wariant

$$\mathrm{bpref\text{-}10} = \frac{1}{R}\sum_{r}\left(1 - \frac{|n \text{ przed } r|}{10 + R}\right)$$

w którym $n$ przebiega pierwszych $10 + R$ ocenionych dokumentów nietrafnych. Gwarantuje
to co najmniej dziesięć par nawet wtedy, gdy trafny dokument jest jeden.

**Kroki.**

1. Sprawdzenie danych: zgodność identyfikatorów rankingu i sądów, brak powtórzeń,
   obecność co najmniej jednego dokumentu trafnego.
2. Zredukowanie rankingu do dokumentów ocenionych, z zapamiętaniem, ile odrzucono.
3. Dla każdego dokumentu trafnego policzenie, ile dokumentów nietrafnych z ustalonego
   początku listy stoi wyżej.
4. Złożenie sumy i podzielenie przez liczbę dokumentów trafnych.
5. Powtórzenie dla wariantu z przesunięciem oraz dla miar klasycznych.
6. Uśrednienie po zapytaniach i porównanie uporządkowania systemów.

**Co wynotować z artykułu.** Dokładne sformułowanie obu wzorów wraz z tym, które
dokumenty nietrafne wchodzą do liczenia; procedurę symulowania niepełnych sądów przez
losowe usuwanie ocen; sposób porównywania uporządkowań systemów miarą korelacji rangowej;
wielkości spadku zgodności dla miar klasycznych przy kolejnych poziomach niekompletności.

## Kontrakt

**Warunki wstępne.** Ranking bez powtórzeń; sądy o trafności zerojedynkowe; co najmniej
jeden dokument trafny wśród ocenionych; identyfikatory rankingu i sądów z tej samej
przestrzeni.

**Niezmienniki.** Wynik należy do przedziału od zera do jedności. Ranking, w którym
wszystkie dokumenty trafne stoją przed wszystkimi nietrafnymi, daje jedność. Ranking
odwrotny daje zero. Wstawienie dokumentu nieocenionego w dowolne miejsce nie zmienia
wyniku – to jest własność, dla której miara powstała, i ma własny test.

**Wyjście.** Klasa `ocena_niepelna` ze składnikami: wartość miary dla każdego zapytania,
wartość średnia, odsetek dokumentów nieocenionych, liczba dokumentów trafnych.

**Błędy zatrzymujące wykonanie.** Brak dokumentów trafnych dla zapytania; powtórzone
identyfikatory w rankingu; sądy o trafności spoza zbioru dwuelementowego.

## Plan pakietu

| Plik | Odpowiedzialność |
|---|---|
| `R/przygotowanie_danych.R` | walidacja rankingu i sądów, redukcja do ocenionych |
| `R/bpref.R` | obie postaci miary |
| `R/miary_klasyczne.R` | średnia precyzja i precyzja na zadanej głębokości do porównania |
| `R/zgodnosc.R` | korelacja rangowa między uporządkowaniami systemów |
| `R/klasy_s3.R` | obiekt wyniku, metody `print` i `summary` |
| `R/wizualizacja.R` | spadek zgodności w funkcji odsetka usuniętych ocen |

Zależności: `stats` i `ggplot2`. **Liczenie par rób na posortowanych pozycjach**, a nie
przez podwójną pętlę po dokumentach – przy rankingu tysiąca pozycji różnica jest
odczuwalna, a sam zabieg jest dobrym materiałem do rozdziału drugiego.

## Dane

**Procedura generowania.** Generujesz ranking o **zadanej jakości**: ustalasz liczbę
dokumentów trafnych i prawdopodobieństwo, z jakim system ustawia je wysoko. Znasz wtedy
oczekiwaną wartość miary. Następnie **usuwasz część sądów o trafności** z zadanym
odsetkiem i sprawdzasz, jak zmieniają się miary klasyczne, a jak bpref. To jest
odtworzenie eksperymentu z artykułu i zarazem odpowiedź na pytanie badawcze.

Parametry: liczba zapytań, długość rankingu, liczba dokumentów trafnych, jakość systemu,
odsetek usuniętych ocen, ziarno.

**Przypadki o znanym wyniku.** Wszystkie trafne przed wszystkimi nietrafnymi: wynik
równy jeden. Kolejność odwrotna: zero. Ranking `t n t n` przy dwóch dokumentach trafnych:
wynik policzalny ręcznie w dwóch linijkach – wpisz rachunek do komentarza testu.

**Przypadki patologiczne.** Zero dokumentów trafnych; jeden dokument trafny i zero
nietrafnych; ranking złożony wyłącznie z dokumentów nieocenionych; sądy o dokumentach
spoza rankingu.

**Zbiór empiryczny.** Publicznie dostępne kolekcje testowe z sądami o trafności, na
przykład kolekcje udostępniane przez organizatorów konferencji ewaluacyjnych albo
zbiory oceny wyszukiwania w otwartych repozytoriach. Wystarczy jeden zestaw zapytań
z sądami i kilka rankingów. Sprawdź warunki licencyjne przed pobraniem.

## Mapowanie na pracę

| Sekcja briefu | Rozdział pracy |
|---|---|
| Po co to badaczowi, problem niekompletnej puli | Wprowadzenie: tło i luka |
| Wzory, sens miary preferencyjnej | Rozdział 1: aparat formalny |
| Kontrakt, niezmienniki | Rozdział 1: granice stosowalności |
| Plan pakietu, procedura generowania, badanie odporności | Rozdział 2 |
| Zbiór empiryczny, porównanie uporządkowań | Rozdział 3 |

**Wstępne pytanie badawcze.** Przy jakim odsetku usuniętych sądów o trafności
uporządkowanie systemów według miary klasycznej przestaje odpowiadać uporządkowaniu
przy pełnych sądach, i o ile dłużej wytrzymuje miara preferencyjna?

## Polecenia startowe

1. Walidacja rankingu i sądów o trafności wraz z redukcją do dokumentów ocenionych.
2. Obie postaci miary, na operacjach wektorowych, zgodnie z wzorami z notatek.
3. Miary klasyczne do porównania: średnia precyzja i precyzja na zadanej głębokości.
4. Procedura generowania rankingu o zadanej jakości i kontrolowanym usuwaniu ocen.
5. Dane naruszające warunki wstępne wraz z oczekiwanym zachowaniem.
6. Badanie zgodności uporządkowań w funkcji odsetka usuniętych ocen.

## Pułapki

**Traktowanie nieocenionych jak nietrafnych.** Agent napisze tak, bo tak wygląda typowy
kod liczenia precyzji. To jest dokładnie ten błąd, który miara ma usunąć. Test wstawiający
dokument nieoceniony w środek rankingu wychwyci to natychmiast.

**Które dokumenty nietrafne liczyć.** We wzorze $n$ nie przebiega wszystkich dokumentów
nietrafnych, tylko pierwsze $R$ z nich w kolejności rankingu. Pominięcie tego
ograniczenia daje inne liczby i niezgodność z artykułem.

**Uśrednianie.** Miarę liczy się osobno dla każdego zapytania, a dopiero potem uśrednia.
Policzenie jej raz na połączonych zapytaniach daje wynik pozbawiony sensu.

**Mała liczba dokumentów trafnych.** Przy jednym dokumencie trafnym miara przyjmuje
bardzo niewiele wartości. Stąd wariant z przesunięciem, i stąd wymóg, żeby w studium
przypadku podać rozkład liczby dokumentów trafnych na zapytanie.

**Na obronie** musisz umieć wyjaśnić, dlaczego miara liczy pary zamiast pozycji, i podać
przykład rankingu, dla którego miara klasyczna i preferencyjna dają różne uporządkowanie
dwóch systemów.

## Literatura

Artykuł źródłowy: `buckleyVoorhees2004incomplete`.

Wprowadzenie: podręcznikowe omówienie oceny systemów wyszukiwawczych i metodyki
Cranfield; opracowanie o budowie kolekcji testowych i puli dokumentów. Dwie do czterech
pozycji dobierasz sam. Tematy pokrewne: 02, 07, 08, 11, 12, 13 – wszystkie dotyczą
pomiaru skuteczności wyszukiwania i można je porównywać na tych samych danych.

Środowisko: `rcore2026`. Wymagania formalne: `standardyEPI`.
