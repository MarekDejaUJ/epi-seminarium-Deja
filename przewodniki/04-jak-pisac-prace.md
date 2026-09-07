# Jak napisać pracę licencjacką — rozdział po rozdziale

Przewodnik prowadzi przez wzór z katalogu [`wzor-pracy/`](../wzor-pracy/). Każda sekcja
odpowiada jednemu plikowi w `wzor-pracy/rozdzialy/`. Kolejność sekcji jest kolejnością
w pracy, ale nie kolejnością pisania — o tym w sekcji [W jakiej kolejności pisać](#w-jakiej-kolejności-pisać).

Twoja praca opisuje projekt: pakiet języka R implementujący algorytm z artykułu
metodycznego. To zmienia sens niektórych części w stosunku do prac czysto teoretycznych.
Stanem badań jest tu nie tylko literatura przedmiotu, ale też istniejące oprogramowanie.
Materiałem badawczym są dane, na których pokazujesz działanie narzędzia. Wynikiem jest
działające, sprawdzone narzędzie plus wnioski z jego zastosowania.

---

## Wprowadzenie

Plik: `rozdzialy/00-wprowadzenie.tex` · objętość: 3–5 stron · bez numeru rozdziału

### Funkcja

Wprowadzenie odpowiada czytelnikowi na cztery pytania w tej kolejności: o czym to jest,
dlaczego to problem, co konkretnie zrobiłeś, jak czytać dalej. Recenzent czyta wprowadzenie
i podsumowanie uważniej niż resztę — z nich wyrabia sobie zdanie o pracy.

### Co musi zawierać

**Tło problemu.** Zacznij od problemu, który istnieje niezależnie od Twojego pakietu.
Nie od narzędzia — od pytania, na które badacz nauk społecznych dziś nie potrafi
odpowiedzieć albo odpowiada z trudem. Dopiero na tym tle pojawia się metoda.

**Luka.** Wyjaśnij, czego brakuje. W pracy projektowej luka ma dwie warstwy i warto
rozróżnić je wprost:

- luka technologiczna — metoda jest opisana w literaturze, ale nie ma jej implementacji;
  implementacja istnieje, lecz wymaga przygotowania programistycznego; istniejące
  narzędzie nie obsługuje danych określonego rodzaju;
- luka poznawcza — czego badacze nie wiedzą, bo nie mają czym policzyć.

Luka musi być sprawdzalna. Wymień narzędzia, które przejrzałeś, i napisz, czego w nich
nie ma. Zdanie „nie istnieje implementacja tej metody" bez wykazu przeszukanych źródeł
jest zarzutem pod Twoim adresem, nie argumentem.

**Cel.** Jedno zdanie, w formie czynności: *Celem pracy jest zaprojektowanie, implementacja
i weryfikacja pakietu języka R udostępniającego procedurę X badaczom nauk społecznych.*
Cel jest tym, co zrobiłeś, a nie tym, czego się dowiedziałeś.

**Pytanie badawcze.** Cel mówi, co zbudowałeś; pytanie mówi, czego się dzięki temu
dowiadujemy. Pytania „jak" i „dlaczego" prowadzą do analizy, „co" i „ile" do opisu.
Sposób dochodzenia do pytania opisuje osobno
[przewodnik warsztatowy](05-warsztat-pisania-akademickiego.md#pytanie-analityczne).

Przykłady pytań właściwych dla tego typu pracy:

- Jakie warunki musi spełnić implementacja metody X, żeby jej wyniki dały się odtworzyć
  przez osobę trzecią?
- Które założenia metody X okazują się najbardziej wrażliwe na jakość danych spotykanych
  w badaniach społecznych?
- Jak wybór procedury generowania danych testowych wpływa na to, co wolno wywnioskować
  o poprawności implementacji?

**Materiał i metoda.** Dwa–trzy zdania: na jakich danych sprawdzasz narzędzie i jak
weryfikujesz poprawność. Szczegóły idą do rozdziału drugiego i trzeciego.

**Zakres i ograniczenia.** Co praca obejmuje, a czego nie. Ograniczenie postawione
samodzielnie jest mocniejsze niż ten sam zarzut w recenzji.

**Struktura.** Jedno zdanie o każdym rozdziale.

### Typowe błędy

| Błąd | Dlaczego szkodzi |
|---|---|
| Wprowadzenie zaczyna się od opisu pakietu | czytelnik nie wie jeszcze, po co mu ten pakiet |
| Cel sformułowany jako „przedstawienie zagadnienia" | nie da się sprawdzić, czy został osiągnięty |
| Luka stwierdzona bez wykazu przeszukanych narzędzi | twierdzenie nieudokumentowane |
| Historia dziedziny od lat sześćdziesiątych | wprowadzenie ma wprowadzać do problemu, nie do dyscypliny |
| Pytanie badawcze utożsamione z celem | brakuje warstwy poznawczej pracy |

### Lista kontrolna

- [ ] Problem postawiony przed narzędziem
- [ ] Luka wskazana i udokumentowana wykazem przejrzanych rozwiązań
- [ ] Cel w jednym zdaniu, w formie czynności
- [ ] Pytanie badawcze różne od celu
- [ ] Zakres i ograniczenia wypisane
- [ ] Zapowiedź struktury zgodna z faktyczną strukturą pracy
- [ ] Każde twierdzenie o stanie rzeczy ma powołanie

---

## Rozdział 1. Podstawy metodyczne

Plik: `rozdzialy/01-podstawy.tex` · objętość: 8–12 stron

### Funkcja

Odpowiednik sekcji *Methodological Background* w czasopismach poświęconych oprogramowaniu
badawczemu. Opisujesz matematykę i logikę, które zaimplementowałeś — jeszcze nie kod.
Ten rozdział ma udowodnić, że rozumiesz metodę, którą zamknąłeś w narzędziu.

### Zasada nadrzędna rozdziału

**Po każdym wzorze następuje akapit wyjaśniający, co ten wzór robi i po co, językiem
zrozumiałym dla badacza bez przygotowania matematycznego.** Wzór bez wyjaśnienia jest
w tej pracy błędem merytorycznym, nie oszczędnością miejsca. Twoim odbiorcą jest osoba,
która chce metody użyć, a nie ją wyprowadzić.

Sprawdzian: przeczytaj sam akapit, bez wzoru. Czy nadal wiadomo, co się dzieje?
Jeśli nie, akapit jest za słaby.

### Co musi zawierać

**Osadzenie metody.** Jaki problem metoda rozwiązuje, skąd się wzięła, czym różni się
od podejść wcześniejszych. Powołanie na artykuł źródłowy i dwa–trzy opracowania
wprowadzające.

**Aparat formalny.** Wielkości wejściowe wraz z dziedzinami, kolejne kroki algorytmu,
wielkości wyjściowe. Numeruj i etykietuj te wzory, do których praca się odwraca:

```latex
\begin{equation}\label{eq:cc}
  CC_i = \frac{d_i^{-}}{d_i^{+} + d_i^{-}}.
\end{equation}

We wzorze \eqref{eq:cc} symbol $CC_i$ oznacza...
```

Objaśnij **każdy** symbol, którego używasz — nawet ten, który wydaje Ci się oczywisty.

**Założenia i granice stosowalności.** Przy jakich warunkach metoda jest poprawna:
rozkłady, niezależność obserwacji, kompletność danych, skale pomiarowe. I co się dzieje,
gdy założenie jest naruszone. Ta sekcja zasila później kontrakt w `SPEC.md` oraz testy
odporności pakietu — pisząc ją, projektujesz jednocześnie oprogramowanie.

**Rozwiązania pokrewne.** Przegląd istniejących implementacji w układzie problemowym:
co już jest, czego brakuje, jak Twoje narzędzie się do tego ma. Nie lista, tylko wywód.
Zakończ jednoznacznym stwierdzeniem, jaki wkład wnosi Twój pakiet.

### Skąd brać treść

Z artykułu źródłowego — sekcji definicyjnej i algorytmicznej. **Nie przepisuj wzorów
z opracowań wtórnych ani z zestawień tematycznych**: zapis bywa tam skrócony i niedokładny.
Wracaj do publikacji.

Wzoru nie tłumacz na polski w sensie notacji — symbole zostają takie jak w źródle,
żeby czytelnik mógł porównać. Tłumaczysz sens, nie znaki.

### Typowe błędy

| Błąd | Dlaczego szkodzi |
|---|---|
| Wzory przepisane bez objaśnienia symboli | recenzent nie odróżni zrozumienia od przepisania |
| Opis kodu zamiast opisu metody | kod należy do rozdziału drugiego |
| Pominięcie założeń metody | testy odporności nie mają z czego wyniknąć |
| Przegląd narzędzi w formie listy | brak wywodu problemowego, wymóg Standardów EPI |
| Wzory przepisane z opracowania wtórnego | ryzyko powielenia cudzego błędu |

### Lista kontrolna

- [ ] Każdy symbol objaśniony w tekście
- [ ] Po każdym wzorze akapit o tym, co wzór robi
- [ ] Założenia metody wypisane wprost
- [ ] Granice stosowalności opisane
- [ ] Przegląd rozwiązań pokrewnych w układzie problemowym
- [ ] Wkład własny sformułowany jednoznacznie
- [ ] Wzory sprawdzone z publikacją źródłową, nie z zestawieniem

---

## Rozdział 2. Implementacja i architektura pakietu

Plik: `rozdzialy/02-implementacja.tex` · objętość: 10–14 stron

### Funkcja

Odpowiednik sekcji *Software Description*. Najważniejszy rozdział inżynierski — tu
pokazujesz własny wkład. Standardy prac dyplomowych EPI wymagają w tym miejscu opisu
logiki aplikacji ze schematami oraz opisu implementacji z formatem danych i sposobem
realizacji każdego modułu.

### Co musi zawierać

**Struktura projektu.** Katalogi, moduły, przepływ danych. Wyjaśnij, co gdzie leży
i dlaczego akurat tak. Tabela modułów z odpowiedzialnościami i funkcjami eksportowanymi
mówi więcej niż akapit opisu.

**Przetwarzanie i walidacja danych.** Droga od danych surowych do struktury, na której
pracuje algorytm: sprawdzanie warunków wstępnych, obsługa braków i kodów błędnych,
skalowanie, agregacja. Wypisz, które naruszenia zatrzymują wykonanie i z jakim
komunikatem — to jest kontrakt Twojego narzędzia i najmocniejsza część tego rozdziału.

**Silnik obliczeniowy.** Jak wzory z rozdziału pierwszego przełożyły się na kod. Pokaż
fragment, nie całość — całość jest w repozytorium. Wyjaśnij decyzje, które nie wynikają
wprost ze wzoru: sposób radzenia sobie z dzieleniem przez zero, wybór biblioteki
optymalizacyjnej, zamiana pętli na operacje na wektorach.

**System klas i metody generyczne.** Dlaczego wynik jest obiektem określonej klasy,
a nie zwykłą ramką danych, i co dzięki temu potrafią `print()`, `summary()` i `plot()`.

**Procedura generowania danych testowych.** Rozkłady, parametry, zależności między
zmiennymi, kontrolowane braki i wartości odstające, ziarno losowości. To jest element
metodologii, nie dodatek techniczny: dzięki znanej strukturze danych wiadomo, jaki wynik
narzędzie **powinno** zwrócić, więc odchylenie jest wykrywalne.

**Weryfikacja poprawności.** Trzy warstwy, opisane osobno:

1. przypadki analityczne o wyniku policzonym ręcznie — mała macierz, przypadek
   zdegenerowany, wartości brzegowe;
2. testy własności — niezmienniczość na skalowanie, monotoniczność, odporność
   na permutację etykiet;
3. testy odporności — zerowa wariancja, współliniowość, wartości poza dziedziną,
   macierz osobliwa; oczekiwanym wynikiem jest kontrolowany błąd z czytelnym komunikatem,
   nie poprawny wynik.

Podaj rezultat sprawdzenia zgodności z wymaganiami repozytorium na trzech systemach
operacyjnych. Zrzut ekranu z przebiegu ciągłej integracji jest tu na miejscu.

**Narzędzia zewnętrzne.** Dla każdej biblioteki: nazwa, źródło, przeznaczenie, krótki opis
wejścia i wyjścia. Wymóg wprost ze Standardów EPI.

### Jak pisać o pracy z narzędziem programistycznym

Jeżeli korzystałeś z narzędzia wspomagającego pisanie kodu, opisz to jako element
metodyki inżynierskiej, a nie jako wyznanie. Interesujące jest to, **gdzie specyfikacja
wychwyciła błąd**: w którym miejscu narzędzie uprościło założenie metody i jak to
wykryłeś. To pokazuje zrozumienie metody lepiej niż bezbłędny kod.

Zakres dopuszczalnego użycia i sposób dokumentowania opisuje osobny przewodnik.
Zasada podstawowa: musisz umieć objaśnić każdą linię kodu, którą oddajesz.

### Typowe błędy

| Błąd | Dlaczego szkodzi |
|---|---|
| Wklejone całe pliki źródłowe | praca nie jest wydrukiem repozytorium |
| Opis funkcji zamiast opisu architektury | dokumentacja funkcji jest w `man/` i na stronie |
| Procedura generowania danych zbyta jednym zdaniem | traci sens cała weryfikacja |
| Brak opisu kontraktu błędów | nie wiadomo, kiedy narzędzie zawodzi świadomie |
| Testy opisane jako „napisano testy jednostkowe" | nie wiadomo, co właściwie sprawdzono |

### Lista kontrolna

- [ ] Schemat lub tabela modułów z odpowiedzialnościami
- [ ] Opisany kontrakt: warunki wstępne, komunikaty błędów
- [ ] Fragmenty kodu, nie całe pliki
- [ ] Procedura generowania danych opisana z parametrami i ziarnem
- [ ] Trzy warstwy weryfikacji opisane osobno
- [ ] Wynik sprawdzenia zgodności na trzech systemach
- [ ] Biblioteki zewnętrzne z nazwą, źródłem, przeznaczeniem, wejściem i wyjściem
- [ ] Listingi zawierają wyłącznie znaki ASCII (`Rscript tools/sprawdz-listingi.R`)

---

## Rozdział 3. Studium przypadku

Plik: `rozdzialy/03-studium-przypadku.tex` · objętość: 8–10 stron

### Funkcja

Odpowiednik sekcji *Illustrative Examples*. Pokazujesz, że narzędzie działa na danych,
a nie tylko się kompiluje. Zagadnienie ma należeć do dziedziny wskazanej w tytule pracy —
inaczej tytuł przestaje odpowiadać treści, co jest pierwszym kryterium oceny w Standardach EPI.

### Co musi zawierać

**Charakterystyka danych.** Pochodzenie, licencja, liczba obserwacji i zmiennych, skale
pomiarowe, braki. Jeżeli używasz danych z własnej procedury, odeślij do rozdziału drugiego
i podaj przyjęte parametry. Napisz, jak wybór zbioru wpływa na to, co wolno wywnioskować.

Dane wygenerowane pozwalają sprawdzić poprawność, bo znasz prawdziwą odpowiedź.
Dane empiryczne pozwalają pokazać użyteczność, ale prawdziwej odpowiedzi nie znasz.
Najmocniejszy rozdział trzeci używa obu i mówi wprost, po co każdego.

**Przebieg analizy.** Pełna ścieżka od danych surowych do wyniku, w postaci listingu.
Czytelnik ma móc ją powtórzyć.

**Wyniki.** Tabela i rysunek, a po nich interpretacja w tekście. Tabela nie zastępuje
interpretacji. Oddziel to, co pokazuje narzędzie, od tego, co twierdzisz Ty: narzędzie
zwraca liczby, wniosek merytoryczny jest Twój i wymaga uzasadnienia.

**Porównanie.** Zestaw wyniki z rezultatem z artykułu źródłowego albo z metodą odniesienia.
Rozbieżność nie jest porażką — jest wynikiem, o ile potrafisz wskazać jej przyczynę.
Rozbieżność przemilczana jest błędem.

### Typowe błędy

| Błąd | Dlaczego szkodzi |
|---|---|
| Zbiór danych spoza dziedziny z tytułu pracy | treść przestaje odpowiadać tematowi |
| Tabela wyników bez interpretacji | czytelnik ma wykonać pracę autora |
| Wniosek mocniejszy niż dane | najczęstszy zarzut w recenzjach |
| Brak informacji o licencji danych | uniemożliwia odtworzenie analizy |
| Pominięcie rozbieżności z artykułem źródłowym | podważa wiarygodność całej weryfikacji |

### Lista kontrolna

- [ ] Zbiór opisany: pochodzenie, licencja, rozmiar, skale, braki
- [ ] Uzasadniony wybór danych względem tematu pracy
- [ ] Pełna ścieżka analizy możliwa do powtórzenia
- [ ] Każdy wynik zinterpretowany w tekście
- [ ] Rozdzielone: co pokazuje narzędzie, a co twierdzi autor
- [ ] Porównanie z wynikiem odniesienia wraz z omówieniem rozbieżności

---

## Podsumowanie

Plik: `rozdzialy/04-podsumowanie.tex` · objętość: 2–3 strony · bez numeru rozdziału

### Funkcja

Podsumowanie domyka klamrę z Wprowadzeniem. Czytelnik, który przeczyta tylko te dwie
części, ma wiedzieć, co zostało zrobione i z jakim skutkiem.

### Co musi zawierać

- realizacja celu — wprost, w jakim stopniu cel został osiągnięty;
- odpowiedź na pytanie badawcze, wynikająca z rozdziałów drugiego i trzeciego;
- trzy do pięciu wniosków, każdy w osobnym akapicie, od najważniejszego;
- ograniczenia — czego narzędzie nie potrafi i przy jakich danych zawodzi;
- perspektywy rozwoju aplikacji — wymóg wprost ze Standardów EPI, nie zbywaj go jednym zdaniem.

**Nie wprowadzaj tu niczego nowego** i nie powołuj się na nowe źródła. Jeżeli w trakcie
pisania podsumowania pojawia się nowy argument, jego miejsce jest wcześniej.

### Lista kontrolna

- [ ] Powrót do celu z Wprowadzenia
- [ ] Odpowiedź na pytanie badawcze
- [ ] Wnioski uporządkowane od najważniejszego
- [ ] Ograniczenia
- [ ] Perspektywy rozwoju opisane konkretnie
- [ ] Zero nowych źródeł i nowych tez

---

## Elementy końcowe

### Wykaz źródeł

Plik: `rozdzialy/05-wykaz-zrodel.tex`

To **nie to samo co bibliografia**. Bibliografia obejmuje opracowania naukowe, do których
odsyłają powołania w tekście. Wykaz źródeł obejmuje narzędzia i dane: pakiety R, zbiory
danych, serwisy udostępniające oprogramowanie. Standardy EPI dopuszczają reprezentowanie
narzędzi programistycznych adresami serwisów, które je udostępniają i opisują.

Opis pakietu R pobierz w konsoli: `citation("nazwa_pakietu")`.

### Bibliografia

Generowana automatycznie z `bibliografia/literatura.bib`. Zasada, której pilnuje recenzent:
**żadnej pozycji w bibliografii bez powołania w tekście i odwrotnie**. Pozycje, które
przeczytałeś, ale których nie wykorzystałeś, do bibliografii nie trafiają.

W bibliografii muszą znaleźć się pozycje obcojęzyczne — wymóg zarówno Standardów EPI,
jak i Instrukcji ISI.

Zapis wpisów opisuje [`wzor-pracy/README.md`](../wzor-pracy/README.md#bibliografia).

### Spis ilustracji i indeks nazwisk

Powstają automatycznie. Indeks zbiera nazwiska wstawione przez `\osoba{Nazwisko}{Imię}` —
używaj tego polecenia od pierwszego dnia pisania, bo uzupełnianie indeksu na końcu
to praca na kilka godzin.

### Aneksy

Plik: `rozdzialy/06-aneksy.tex`

Cztery aneksy przewidziane we wzorze:

1. **Metadane oprogramowania** — tabela z nazwą, wersją, licencją, repozytorium, językiem
   i zależnościami.
2. **Nota wymagana w serwisie WWW** — treść z Załącznika nr 2 do Standardów EPI. Ta sama
   nota musi znaleźć się na stronie projektu, w zakładce „O serwisie".
3. **Oświadczenie o wykorzystaniu sztucznej inteligencji** — jeżeli korzystałeś z narzędzi SI.
4. **Wykaz poleceń wydanych narzędziu programistycznemu** — dotyczy wyłącznie budowy
   aplikacji; dla każdego polecenia cel, treść, co zmieniłeś w wyniku i jak sprawdziłeś
   poprawność.

Aneksy muszą być powiązane z tekstem odsyłaczami w rodzaju „(zob. Aneks 1)".

---

## W jakiej kolejności pisać

Kolejność w pracy nie jest kolejnością pisania. Sprawdzona kolejność dla tego typu tematu:

| Etap | Co piszesz | Dlaczego wtedy |
|---|---|---|
| 1 | Rozdział 1, sekcja o aparacie formalnym | zmusza do zrozumienia metody, zanim powstanie kod |
| 2 | Rozdział 1, założenia i granice | staje się kontraktem specyfikacji pakietu |
| 3 | Rozdział 2, procedura generowania danych | piszesz razem z kodem, gdy pamiętasz parametry |
| 4 | Rozdział 2, reszta | po zamknięciu implementacji |
| 5 | Rozdział 3 | po pierwszym pełnym przebiegu analizy |
| 6 | Rozdział 1, rozwiązania pokrewne | dopiero teraz wiesz, z czym się porównujesz |
| 7 | Wprowadzenie | wiadomo już, co się zapowiada |
| 8 | Podsumowanie | domyka klamrę z gotowym Wprowadzeniem |
| 9 | Aneksy, wykaz źródeł, redakcja | na końcu |

Wprowadzenie pisane jako pierwsze jest prawie zawsze pisane dwa razy.

Trzy rzeczy prowadź **od pierwszego dnia**, nie na końcu: plik `.bib`, polecenia
`\osoba{}{}` w tekście oraz rejestr poleceń wydanych narzędziu programistycznemu.
Odtwarzanie każdej z nich po fakcie kosztuje wielokrotnie więcej czasu.

---

## Zanim oddasz

Kontrola formalna: [`06-wymogi-formalne-isi-epi.md`](06-wymogi-formalne-isi-epi.md#lista-kontrolna-przed-oddaniem).

Kontrola automatyczna, z katalogu `wzor-pracy/`:

```
Rscript tools/policz_znaki.R
Rscript tools/sprawdz-listingi.R
latexmk -lualatex main.tex
```

Kompilacja musi kończyć się bez błędów i bez nierozwiązanych powołań.
