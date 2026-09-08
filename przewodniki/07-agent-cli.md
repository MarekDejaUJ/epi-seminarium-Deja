<!-- Plik powstaje automatycznie z przewodnik/rozdzialy/07-agent-cli.tex.
     Zmiany nanos w pliku zrodlowym, nie tutaj. -->

# Praca z narzędziem programistycznym

Rozdział opisuje metodę budowy pakietu z użyciem narzędzia wspomagającego pisanie kodu. Granice dozwolonego użycia i sposób ich dokumentowania opisuje rozdział [Jawność i odpowiedzialność](08-etyka-si.md#jawność-i-odpowiedzialność); tutaj chodzi o to, **jak** pracować, żeby powstało narzędzie, za które da się odpowiadać.

Punkt wyjścia jest taki: implementacja algorytmu z artykułu metodycznego to zadanie, w którym trudność nie leży w składni języka, tylko w zrozumieniu metody. Narzędzie wspomagające zdejmuje z Ciebie pierwsze i **nie zdejmuje drugiego**. Twoja rola przesuwa się z pisania linii kodu na projektowanie kontraktu i sprawdzanie, czy wynik ten kontrakt spełnia. To trudniejsza rola, nie łatwiejsza.

## Środowisko

### Positron

Positron jest środowiskiem pracy zbudowanym wokół języka R. Ma konsolę R, podgląd zmiennych, podgląd ramek danych i wbudowany terminal, więc pakiet, wykresy i tekst powstają w jednym miejscu. Jest zbudowany na tej samej podstawie co popularne edytory kodu, więc rozszerzenia i skróty klawiszowe działają tak, jak można się spodziewać.

Instalacja obejmuje trzy kroki: samo środowisko, aktualną wersję R oraz rozszerzenie do LaTeX-a, jeżeli chcesz pisać w nim także pracę. Po pierwszym uruchomieniu sprawdź w konsoli, czy widzi właściwą wersję R:

```r
R.version.string
.libPaths()
```

### Narzędzie wspomagające

Seminarium standaryzuje pracę na narzędziu dostępnym w ramach pakietu studenckiego platformy, na której trzymasz repozytorium. Uruchamiasz je z terminala w katalogu pakietu, dzięki czemu widzi cały projekt: pliki źródłowe, testy i komunikaty z ich uruchomienia.

Warunkiem sensownej pracy jest to, żeby narzędzie **samo uruchamiało testy**. Bez tego dostajesz kod, który wygląda poprawnie, i musisz sprawdzać go ręcznie. Z tym dostajesz kod, który przechodzi testy, które napisałeś wcześniej.

### Konfiguracja repozytorium

W katalogu głównym swojego pakietu umieszczasz plik z instrukcjami dla narzędzia. Jest to zwykły plik tekstowy, który narzędzie czyta przy każdym uruchomieniu. Gotowy do uzupełnienia znajdziesz w materiałach seminarium.

Instrukcje robią trzy rzeczy. Ustalają konwencje projektu, żeby nie trzeba było ich powtarzać przy każdym poleceniu. Zakazują tego, co w tym projekcie jest niedopuszczalne, na przykład dopisywania zależności do pliku opisu pakietu bez uzgodnienia. Wymuszają uruchomienie testów po każdej zmianie.

**Rozgraniczenie odpowiedzialności** zapisz wprost. Pliki, których narzędzie nie zmienia bez Twojej decyzji, to: specyfikacja, testy, procedura generowania danych oraz plik opisu pakietu. Są to miejsca, w których zapisane są Twoje ustalenia metodyczne. Kod obliczeniowy i dokumentacja funkcji są obszarem, w którym narzędzie pracuje.

## Kolejność pracy

### Cztery kroki

Obowiązująca kolejność to specyfikacja, testy, implementacja, dokumentacja. Nie jest to preferencja stylistyczna, tylko jedyny układ, w którym da się stwierdzić, czy kod jest poprawny.

**Krok pierwszy: specyfikacja.** Czytasz artykuł źródłowy i spisujesz kontrakt: co wchodzi, w jakich dziedzinach, jakie warunki muszą zachodzić, co wychodzi, jakie własności muszą być spełnione. Szablon dokumentu znajdziesz w materiałach seminarium. Ten dokument piszesz sam, bez narzędzia, bo powstaje z lektury, a nie z kodu.

**Krok drugi: testy.** Z przypadków wypisanych w specyfikacji robisz testy. Każdy przypadek analityczny ma wynik policzony ręcznie ze wzoru. Testy piszesz **przed** implementacją i uruchamiasz je: mają zawieść, bo funkcji jeszcze nie ma. To brzmi absurdalnie, dopóki nie zobaczysz, jak łatwo napisać test, który przechodzi zawsze.

**Krok trzeci: implementacja.** Dopiero teraz uruchamiasz narzędzie, dając mu specyfikację i testy jako kontekst. Polecenie brzmi: zaimplementuj funkcję tak, żeby przechodziła te testy, nie zmieniając testów.

**Krok czwarty: dokumentacja.** Bloki dokumentacyjne powstają ze specyfikacji, a nie z kodu. Opis argumentu ma mówić, co argument znaczy, a nie jakiego jest typu.

### Dlaczego odwrotna kolejność zawodzi

Kiedy najpierw powstaje kod, a testy potem, testy powstają **z obserwacji zachowania kodu**. Jeżeli implementacja zawiera błąd, test ten błąd utrwala. Sprawdzasz wtedy, czy kod się nie zmienił, a nie czy liczy poprawnie.

To rozróżnienie jest sednem całej metody i wraca w rozdziale [Jak napisać pracę](04-jak-pisac.md#jak-napisać-pracę) jako wymóg wobec rozdziału drugiego pracy. Test, którego oczekiwana wartość pochodzi z uruchomienia własnego kodu, nie jest dowodem poprawności.

## Pętla naprawcza

Po wydaniu polecenia narzędzie pracuje w cyklu: pisze kod, uruchamia testy, czyta komunikat błędu, poprawia, uruchamia ponownie. Cykl kończy się, gdy testy przechodzą.

Twoja rola w tym cyklu nie polega na czekaniu. Polega na obserwowaniu, **co narzędzie zmienia**, żeby doprowadzić do przejścia testów.

### Kiedy przerwać

Są trzy sytuacje, w których pętlę trzeba zatrzymać, bo dalsze krążenie tylko pogarsza kod.

**Narzędzie zmienia test zamiast kodu.** Test jest zapisem tego, co metoda ma robić. Zmiana testu, żeby przechodził, jest zmianą definicji problemu. Jeżeli test jest błędny, poprawiasz go sam, po sprawdzeniu w artykule, i odnotowujesz to w specyfikacji.

**Narzędzie osłabia warunek wstępny.** Sprawdzenie, które zatrzymywało wykonanie przy danych spoza dziedziny, znika albo zamienia się w ostrzeżenie. Funkcja zaczyna zwracać wynik tam, gdzie powinna odmówić działania. To najgroźniejszy rodzaj regresu, bo testy przechodzą, a narzędzie staje się niebezpieczne.

**Narzędzie dodaje zależność.** Zamiast rozwiązać problem, sięga po gotową funkcję z pakietu, którego w projekcie nie ma. Każda zależność zwiększa ryzyko, że pakiet przestanie się instalować, i wymaga Twojej świadomej decyzji.

### Miejsca, w których narzędzie zgaduje

Narzędzie nie zna artykułu, który czytasz. Zna wzorce z kodu, który widziało wcześniej. Tam, gdzie Twoja metoda odbiega od wzorca, dostaniesz rozwiązanie typowe, a nie właściwe.

**Tabela 24. Typowe miejsca rozejścia się implementacji z metodą**

| Sytuacja | Co sprawdzić |
|---|---|
| Metoda wymaga określonej normalizacji | czy zastosowano tę z artykułu, a nie najpopularniejszą |
| Artykuł podaje wartość domyślną parametru | czy nie została zastąpiona wartością typową dla innej metody |
| Wzór zawiera logarytm albo dzielenie | jak obsłużono zero i wartości ujemne |
| Metoda zakłada określoną kolejność kroków | czy kroków nie przestawiono dla wygody |
| Wynik ma być obiektem określonej klasy | czy nie zwrócono zwykłej ramki danych |
| Występują remisy w porządkowaniu | czy sposób ich rozstrzygania jest ten sam co w artykule |

Każde z tych miejsc powinno mieć wcześniej wpis w specyfikacji, w tabeli niedopowiedzeń artykułu. Jeżeli go ma, wychwycenie rozejścia zajmuje chwilę. Jeżeli nie ma, wychwycisz je dopiero wtedy, gdy wynik nie zgodzi się z publikacją.

## Szablony poleceń

Polecenie wydane narzędziu jest tekstem, który warto przygotować, a nie improwizować. Cztery poniższe schematy pokrywają większość pracy nad pakietem. Wersje gotowe do uzupełnienia znajdziesz w materiałach seminarium.

### Wzór na kod

Najczęstsze polecenie w tym seminarium. Kluczowe jest podanie wzoru **razem z objaśnieniem symboli** oraz wskazanie, że wynik ma być liczony na wektorach, a nie w pętli.

```latex
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

### Dane, na których metoda nie ma sensu

Polecenie do budowy testów odporności. Sedno polega na tym, żeby prosić o **dane**, a nie o testy: testy piszesz sam, bo to Ty decydujesz, jaki wynik jest poprawny.

```latex
Wypisz dziesiec zestawow danych wejsciowych dla funkcji <nazwa>, przy ktorych
metoda opisana w SPEC.md nie ma sensu albo dziala na granicy stosowalnosci.

Dla kazdego podaj:
- dane w postaci wywolania R,
- ktory warunek wstepny narusza,
- co powinno sie stac: blad, ostrzezenie czy poprawny wynik.

Nie pisz testow. Nie zmieniaj kodu funkcji.
```

### Diagnostyka zamiast zgadywania

Gdy obliczenie nie zbiega albo daje wynik spoza oczekiwanego zakresu, narzędzie ma skłonność do zmieniania kodu na chybił trafił. To polecenie przerywa taki cykl.

```latex
Funkcja <nazwa> zwraca <opis objawu> dla danych <opis>.

Nie zmieniaj kodu. Wypisz wartosci posrednie po kazdym kroku algorytmu
opisanego w SPEC.md i wskaz krok, w ktorym wynik przestaje odpowiadac
oczekiwaniu. Podaj wartosci, ktore o tym swiadcza.
```

### Dokumentacja ze specyfikacji

```latex
Napisz bloki dokumentacyjne roxygen2 dla funkcji eksportowanych w pliku
R/<plik>.R, na podstawie SPEC.md, a nie na podstawie kodu.

Wymagania:
- opis argumentu mowi, co argument znaczy, nie jakiego jest typu,
- sekcja o wartosci zwracanej opisuje strukture wyniku,
- przyklad wykonuje sie ponizej piatej sekundy i korzysta z danych pakietu,
- odwolanie do artykulu zrodlowego w sekcji references,
- tekst po polsku, identyfikatory bez znakow diakrytycznych.
```

## Rejestr poleceń

Wykaz poleceń jest wymaganym aneksem pracy, ale prowadzi się go **od pierwszego dnia**, a nie odtwarza z pamięci przed oddaniem. Odtworzenie jest niewykonalne: po pół roku nie pamięta się, które polecenie doprowadziło do której funkcji.

Rejestr jest plikiem w repozytorium pakietu. Dla każdego polecenia zapisujesz cztery rzeczy: cel, treść polecenia, co zmieniłeś w otrzymanym wyniku oraz jak sprawdziłeś poprawność. Trzecia i czwarta kolumna są najważniejsze, bo to one pokazują Twój wkład.

**Tabela 25. Wpis w rejestrze poleceń**

| Pole | Treść |
|---|---|
| Cel | Implementacja wyznaczania wag metodą entropii |
| Polecenie | pełna treść wydanego polecenia |
| Zmiany własne | Dodano obsługę kolumny o zerowej sumie, której polecenie nie obejmowało; zmieniono komunikat błędu na wskazujący nazwę kryterium |
| Weryfikacja | Przypadek analityczny z macierzą dwa na dwa policzony ręcznie; sprawdzono niezmienniczość na przeskalowanie kolumny |

Rejestr ma jeszcze jedno zastosowanie, ważniejsze od formalnego. Wpis, w którym kolumna „zmiany własne” jest pusta, oznacza kod, którego nie sprawdziłeś. Przed obroną warto przejrzeć rejestr pod tym kątem.

## Co robisz sam

Lista zamykająca rozdział. Poniższe czynności nie są zadaniem dla narzędzia, bo w każdej z nich rozstrzyga rozumienie metody, a nie znajomość języka.

- lektura artykułu źródłowego i spisanie specyfikacji;
- rozstrzygnięcie niedopowiedzeń artykułu wraz z uzasadnieniem;
- wyliczenie ręczne przypadków analitycznych;
- decyzja o obsłudze braków danych i wartości brzegowych;
- projekt procedury generowania danych;
- decyzja o każdej zależności pakietu;
- interpretacja wyników w studium przypadku;
- cały tekst pracy.

Sprawdzian na koniec: **musisz umieć objaśnić każdą linię kodu, którą oddajesz**. Nie chodzi o pamiętanie składni, tylko o umiejętność powiedzenia, co ta linia liczy i dlaczego akurat tak. Linia, której nie umiesz objaśnić, jest linią, której w Twoim pakiecie nie powinno być.

---

Wersja do druku obejmująca wszystkie rozdziały: [przewodnik.pdf](../przewodnik/przewodnik.pdf).
