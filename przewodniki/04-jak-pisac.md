<!-- Plik powstaje automatycznie z przewodnik/rozdzialy/04-jak-pisac.tex.
     Zmiany nanos w pliku zrodlowym, nie tutaj. -->

# Jak napisać pracę

Rozdział prowadzi przez wzór część po części. Każdy podrozdział odpowiada jednemu plikowi w katalogu rozdziałów. Kolejność podrozdziałów jest kolejnością w pracy, ale **nie kolejnością pisania** – o tym w podrozdziale [W jakiej kolejności pisać](#w-jakiej-kolejności-pisać).

Twoja praca opisuje projekt: pakiet języka R implementujący algorytm z artykułu metodycznego. To zmienia sens niektórych części w stosunku do prac czysto teoretycznych. Stanem badań jest tu nie tylko literatura przedmiotu, ale też istniejące oprogramowanie. Materiałem badawczym są dane, na których pokazujesz działanie narzędzia. Wynikiem jest działające, sprawdzone narzędzie oraz wnioski z jego zastosowania.

## Wprowadzenie

Plik `rozdzialy/00-wprowadzenie.tex`, objętość trzy do pięciu stron, bez numeru rozdziału.

Wprowadzenie odpowiada czytelnikowi na cztery pytania w tej kolejności: o czym to jest, dlaczego to problem, co konkretnie zrobiłeś, jak czytać dalej. Recenzent czyta wprowadzenie i podsumowanie uważniej niż resztę – z nich wyrabia sobie zdanie o pracy.

### Co musi zawierać

**Tło problemu.** Zacznij od problemu, który istnieje niezależnie od Twojego pakietu. Nie od narzędzia, tylko od pytania, na które badacz nauk społecznych dziś nie potrafi odpowiedzieć albo odpowiada z trudem. Dopiero na tym tle pojawia się metoda.

**Luka.** Wyjaśnij, czego brakuje. W pracy projektowej luka ma dwie warstwy i warto rozróżnić je wprost. *Luka technologiczna* to sytuacja, w której metoda jest opisana w literaturze, ale nie ma jej implementacji; implementacja istnieje, lecz wymaga przygotowania programistycznego; istniejące narzędzie nie obsługuje danych określonego rodzaju. *Luka poznawcza* to z kolei to, czego badacze nie wiedzą, bo nie mają czym policzyć. Praca, która wypełnia wyłącznie pierwszą, jest sprawozdaniem z programowania, a nie pracą naukową.

Luka musi być sprawdzalna. Wymień narzędzia, które przejrzałeś, i napisz, czego w nich nie ma. Zdanie o nieistnieniu implementacji, podane bez wykazu przeszukanych źródeł, jest zarzutem pod Twoim adresem, a nie argumentem.

**Cel.** Jedno zdanie w formie czynności: celem pracy jest zaprojektowanie, implementacja i weryfikacja pakietu języka R udostępniającego określoną procedurę badaczom nauk społecznych. Cel jest tym, co zrobiłeś, a nie tym, czego się dowiedziałeś.

**Pytanie badawcze.** Cel mówi, co zbudowałeś; pytanie mówi, czego się dzięki temu dowiadujemy. Pytania zaczynające się od „jak” i „dlaczego” prowadzą do analizy, a „co” i „ile” do opisu. Sposób dochodzenia do pytania opisuje podrozdział [Pytanie analityczne](05-warsztat.md#pytanie-analityczne). Przykłady pytań właściwych dla tego typu pracy:

- Jakie warunki musi spełnić implementacja metody, żeby jej wyniki dały się odtworzyć przez osobę trzecią?
- Które założenia metody okazują się najbardziej wrażliwe na jakość danych spotykanych w badaniach społecznych?
- Jak wybór procedury generowania danych testowych wpływa na to, co wolno wywnioskować o poprawności implementacji?

**Materiał i metoda.** Dwa lub trzy zdania: na jakich danych sprawdzasz narzędzie i jak weryfikujesz poprawność. Szczegóły idą do rozdziałów drugiego i trzeciego pracy.

**Zakres i ograniczenia.** Co praca obejmuje, a czego nie. Ograniczenie postawione samodzielnie jest mocniejsze niż ten sam zarzut w recenzji.

**Struktura.** Jedno zdanie o każdym rozdziale.

### Typowe błędy

**Tabela 12. Błędy we wprowadzeniu**

| Błąd | Dlaczego szkodzi |
|---|---|
| Wprowadzenie zaczyna się od opisu pakietu | czytelnik nie wie jeszcze, po co mu ten pakiet |
| Cel sformułowany jako przedstawienie zagadnienia | nie da się sprawdzić, czy został osiągnięty |
| Luka stwierdzona bez wykazu przejrzanych narzędzi | twierdzenie nieudokumentowane |
| Historia dziedziny od połowy zeszłego wieku | wprowadzenie ma wprowadzać do problemu, nie do dyscypliny |
| Pytanie badawcze utożsamione z celem | brakuje warstwy poznawczej pracy |

- [ ] Problem postawiony przed narzędziem
- [ ] Luka wskazana i udokumentowana wykazem przejrzanych rozwiązań
- [ ] Cel w jednym zdaniu, w formie czynności
- [ ] Pytanie badawcze różne od celu
- [ ] Zakres i ograniczenia wypisane
- [ ] Zapowiedź struktury zgodna z faktyczną strukturą pracy
- [ ] Każde twierdzenie o stanie rzeczy ma powołanie

## Rozdział pierwszy: podstawy metodyczne

Plik `rozdzialy/01-podstawy.tex`, objętość osiem do dwunastu stron.

Odpowiednik sekcji poświęconej podstawom metodycznym w czasopismach o oprogramowaniu badawczym. Opisujesz matematykę i logikę, które zaimplementowałeś – jeszcze nie kod. Rozdział ma udowodnić, że rozumiesz metodę, którą zamknąłeś w narzędziu.

### Zasada nadrzędna

**Po każdym wzorze następuje akapit wyjaśniający, co ten wzór robi i po co, językiem zrozumiałym dla badacza bez przygotowania matematycznego.** Wzór bez wyjaśnienia jest w tej pracy błędem merytorycznym, a nie oszczędnością miejsca. Twoim odbiorcą jest osoba, która chce metody użyć, a nie ją wyprowadzić.

Sprawdzian: przeczytaj sam akapit, bez wzoru. Czy nadal wiadomo, co się dzieje? Jeżeli nie, akapit jest za słaby.

### Co musi zawierać

**Osadzenie metody.** Jaki problem metoda rozwiązuje, skąd się wzięła, czym różni się od podejść wcześniejszych. Powołanie na artykuł źródłowy i dwa lub trzy opracowania wprowadzające.

**Aparat formalny.** Wielkości wejściowe wraz z dziedzinami, kolejne kroki algorytmu, wielkości wyjściowe. Numeruj i etykietuj te wzory, do których praca się odwołuje. Objaśnij **każdy** symbol, którego używasz – nawet ten, który wydaje Ci się oczywisty.

**Założenia i granice stosowalności.** Przy jakich warunkach metoda jest poprawna: rozkłady, niezależność obserwacji, kompletność danych, skale pomiarowe. I co się dzieje, gdy założenie jest naruszone. Ta sekcja zasila później kontrakt w specyfikacji oraz testy odporności pakietu – pisząc ją, projektujesz jednocześnie oprogramowanie.

**Rozwiązania pokrewne.** Przegląd istniejących implementacji w układzie problemowym: co już jest, czego brakuje, jak Twoje narzędzie się do tego ma. Nie lista, tylko wywód. Zakończ jednoznacznym stwierdzeniem, jaki wkład wnosi Twój pakiet.

### Skąd brać treść

Z artykułu źródłowego, z sekcji definicyjnej i algorytmicznej. **Nie przepisuj wzorów z opracowań wtórnych ani z zestawień tematycznych** – zapis bywa tam skrócony i niedokładny. Wracaj do publikacji.

Wzoru nie tłumacz na polski w sensie notacji. Symbole zostają takie jak w źródle, żeby czytelnik mógł porównać; tłumaczysz sens, a nie znaki.

**Tabela 13. Błędy w rozdziale metodycznym**

| Błąd | Dlaczego szkodzi |
|---|---|
| Wzory przepisane bez objaśnienia symboli | recenzent nie odróżni zrozumienia od przepisania |
| Opis kodu zamiast opisu metody | kod należy do rozdziału drugiego |
| Pominięcie założeń metody | testy odporności nie mają z czego wyniknąć |
| Przegląd narzędzi w formie listy | brak wywodu problemowego, wymóg Standardów |
| Wzory przepisane z opracowania wtórnego | ryzyko powielenia cudzego błędu |

- [ ] Każdy symbol objaśniony w tekście
- [ ] Po każdym wzorze akapit o tym, co wzór robi
- [ ] Założenia metody wypisane wprost
- [ ] Granice stosowalności opisane
- [ ] Przegląd rozwiązań pokrewnych w układzie problemowym
- [ ] Wkład własny sformułowany jednoznacznie
- [ ] Wzory sprawdzone z publikacją źródłową, nie z zestawieniem

## Rozdział drugi: implementacja i architektura

Plik `rozdzialy/02-implementacja.tex`, objętość dziesięć do czternastu stron.

Odpowiednik sekcji opisującej oprogramowanie. Najważniejszy rozdział inżynierski – tu pokazujesz własny wkład. Standardy wymagają w tym miejscu opisu logiki aplikacji ze schematami oraz opisu implementacji z formatem danych i sposobem realizacji każdego modułu (Standardy EPI).

### Co musi zawierać

**Struktura projektu.** Katalogi, moduły, przepływ danych. Wyjaśnij, co gdzie leży i dlaczego akurat tak. Tabela modułów z odpowiedzialnościami i funkcjami eksportowanymi mówi więcej niż akapit opisu.

**Przetwarzanie i walidacja danych.** Droga od danych surowych do struktury, na której pracuje algorytm: sprawdzanie warunków wstępnych, obsługa braków i kodów błędnych, skalowanie, agregacja. Wypisz, które naruszenia zatrzymują wykonanie i z jakim komunikatem – to jest kontrakt Twojego narzędzia i najmocniejsza część tego rozdziału.

**Silnik obliczeniowy.** Jak wzory z rozdziału pierwszego przełożyły się na kod. Pokaż fragment, nie całość; całość jest w repozytorium. Wyjaśnij decyzje, które nie wynikają wprost ze wzoru: sposób radzenia sobie z dzieleniem przez zero, wybór biblioteki optymalizacyjnej, zamianę pętli na operacje na wektorach.

**System klas i metody generyczne.** Dlaczego wynik jest obiektem określonej klasy, a nie zwykłą ramką danych, i co dzięki temu potrafią funkcje wypisujące, podsumowujące i rysujące.

**Procedura generowania danych testowych.** Rozkłady, parametry, zależności między zmiennymi, kontrolowane braki i wartości odstające, ziarno losowości. To jest element metodologii, a nie dodatek techniczny: dzięki znanej strukturze danych wiadomo, jaki wynik narzędzie **powinno** zwrócić, więc odchylenie jest wykrywalne.

**Weryfikacja poprawności.** Trzy warstwy, opisane osobno. Przypadki analityczne o wyniku policzonym ręcznie: mała macierz, przypadek zdegenerowany, wartości brzegowe. Testy własności: niezmienniczość na skalowanie, monotoniczność, odporność na permutację etykiet. Testy odporności: zerowa wariancja, współliniowość, wartości poza dziedziną, macierz osobliwa – oczekiwanym wynikiem jest kontrolowany błąd z czytelnym komunikatem, a nie poprawny wynik. Podaj rezultat sprawdzenia zgodności na trzech systemach operacyjnych.

**Narzędzia zewnętrzne.** Dla każdej biblioteki nazwa, źródło, przeznaczenie oraz krótki opis wejścia i wyjścia. Wymóg wprost ze Standardów.

### Jak pisać o pracy z narzędziem programistycznym

Jeżeli korzystałeś z narzędzia wspomagającego pisanie kodu, opisz to jako element metodyki inżynierskiej, a nie jako wyznanie. Interesujące jest to, **gdzie specyfikacja wychwyciła błąd**: w którym miejscu narzędzie uprościło założenie metody i jak to wykryłeś. To pokazuje zrozumienie metody lepiej niż bezbłędny kod. Zasada podstawowa pozostaje jedna: musisz umieć objaśnić każdą linię kodu, którą oddajesz.

**Tabela 14. Błędy w rozdziale inżynierskim**

| Błąd | Dlaczego szkodzi |
|---|---|
| Wklejone całe pliki źródłowe | praca nie jest wydrukiem repozytorium |
| Opis funkcji zamiast opisu architektury | dokumentacja funkcji jest na stronie projektu |
| Procedura generowania danych zbyta jednym zdaniem | traci sens cała weryfikacja |
| Brak opisu kontraktu błędów | nie wiadomo, kiedy narzędzie zawodzi świadomie |
| Testy opisane jako napisano testy jednostkowe | nie wiadomo, co właściwie sprawdzono |

- [ ] Schemat lub tabela modułów z odpowiedzialnościami
- [ ] Opisany kontrakt: warunki wstępne, komunikaty błędów
- [ ] Fragmenty kodu, nie całe pliki
- [ ] Procedura generowania danych opisana z parametrami i ziarnem
- [ ] Trzy warstwy weryfikacji opisane osobno
- [ ] Wynik sprawdzenia zgodności na trzech systemach
- [ ] Biblioteki zewnętrzne z nazwą, źródłem, przeznaczeniem, wejściem i wyjściem
- [ ] Listingi zawierają wyłącznie znaki ASCII

## Rozdział trzeci: studium przypadku

Plik `rozdzialy/03-studium-przypadku.tex`, objętość osiem do dziesięciu stron.

Pokazujesz, że narzędzie działa na danych, a nie tylko się kompiluje. Zagadnienie ma należeć do dziedziny wskazanej w tytule pracy – inaczej tytuł przestaje odpowiadać treści, co jest pierwszym kryterium oceny w Standardach.

### Co musi zawierać

**Charakterystyka danych.** Pochodzenie, licencja, liczba obserwacji i zmiennych, skale pomiarowe, braki. Jeżeli używasz danych z własnej procedury, odeślij do rozdziału drugiego i podaj przyjęte parametry. Napisz, jak wybór zbioru wpływa na to, co wolno wywnioskować.

Dane wygenerowane pozwalają sprawdzić poprawność, bo znasz prawdziwą odpowiedź. Dane empiryczne pozwalają pokazać użyteczność, ale prawdziwej odpowiedzi nie znasz. Najmocniejszy rozdział trzeci używa obu i mówi wprost, po co każdego.

**Przebieg analizy.** Pełna ścieżka od danych surowych do wyniku, w postaci listingu. Czytelnik ma móc ją powtórzyć.

**Wyniki.** Tabela i rysunek, a po nich interpretacja w tekście. Tabela nie zastępuje interpretacji. Oddziel to, co pokazuje narzędzie, od tego, co twierdzisz Ty: narzędzie zwraca liczby, a wniosek merytoryczny jest Twój i wymaga uzasadnienia.

**Porównanie.** Zestaw wyniki z rezultatem z artykułu źródłowego albo z metodą odniesienia. Rozbieżność nie jest porażką – jest wynikiem, o ile potrafisz wskazać jej przyczynę. Rozbieżność przemilczana jest błędem.

**Tabela 15. Błędy w studium przypadku**

| Błąd | Dlaczego szkodzi |
|---|---|
| Zbiór danych spoza dziedziny z tytułu pracy | treść przestaje odpowiadać tematowi |
| Tabela wyników bez interpretacji | czytelnik ma wykonać pracę autora |
| Wniosek mocniejszy niż dane | najczęstszy zarzut w recenzjach |
| Brak informacji o licencji danych | uniemożliwia odtworzenie analizy |
| Pominięcie rozbieżności z artykułem źródłowym | podważa wiarygodność weryfikacji |

- [ ] Zbiór opisany: pochodzenie, licencja, rozmiar, skale, braki
- [ ] Uzasadniony wybór danych względem tematu pracy
- [ ] Pełna ścieżka analizy możliwa do powtórzenia
- [ ] Każdy wynik zinterpretowany w tekście
- [ ] Rozdzielone: co pokazuje narzędzie, a co twierdzi autor
- [ ] Porównanie z wynikiem odniesienia wraz z omówieniem rozbieżności

## Podsumowanie

Plik `rozdzialy/04-podsumowanie.tex`, objętość dwie do trzech stron, bez numeru rozdziału.

Podsumowanie domyka klamrę z Wprowadzeniem. Czytelnik, który przeczyta tylko te dwie części, ma wiedzieć, co zostało zrobione i z jakim skutkiem. Zawiera: realizację celu podaną wprost, odpowiedź na pytanie badawcze wynikającą z rozdziałów drugiego i trzeciego, trzy do pięciu wniosków uporządkowanych od najważniejszego, ograniczenia oraz perspektywy rozwoju aplikacji. Ostatni element jest wymogiem wprost ze Standardów – nie zbywaj go jednym zdaniem.

**Nie wprowadzaj tu niczego nowego** i nie powołuj się na nowe źródła. Jeżeli w trakcie pisania podsumowania pojawia się nowy argument, jego miejsce jest wcześniej.

- [ ] Powrót do celu z Wprowadzenia
- [ ] Odpowiedź na pytanie badawcze
- [ ] Wnioski uporządkowane od najważniejszego
- [ ] Ograniczenia
- [ ] Perspektywy rozwoju opisane konkretnie
- [ ] Zero nowych źródeł i nowych tez

## Elementy końcowe

### Wykaz źródeł

Plik `rozdzialy/05-wykaz-zrodel.tex`. To **nie to samo co bibliografia**. Bibliografia obejmuje opracowania naukowe, do których odsyłają powołania w tekście. Wykaz źródeł obejmuje narzędzia i dane: pakiety R, zbiory danych, serwisy udostępniające oprogramowanie. Standardy dopuszczają reprezentowanie narzędzi programistycznych adresami serwisów, które je udostępniają i opisują.

### Bibliografia

Generowana automatycznie z pliku bibliograficznego. Zasada, której pilnuje recenzent: żadnej pozycji w bibliografii bez powołania w tekście i odwrotnie. Pozycje przeczytane, ale niewykorzystane, do bibliografii nie trafiają. Muszą się w niej znaleźć pozycje obcojęzyczne – wymóg zarówno Standardów, jak i Instrukcji. Zapis wpisów opisuje rozdział [Bibliografia: plik BibTeX i Zotero](02-bibliografia.md#bibliografia-plik-bibtex-i-zotero).

### Spis ilustracji i indeks nazwisk

Powstają automatycznie. Indeks zbiera nazwiska wstawione poleceniem `\osoba` – używaj go od pierwszego dnia pisania, bo uzupełnianie indeksu na końcu to praca na kilka godzin.

### Aneksy

Plik `rozdzialy/06-aneksy.tex`. Wzór przewiduje cztery aneksy: metadane oprogramowania, notę wymaganą w serwisie internetowym zgodnie z załącznikiem do Standardów, oświadczenie o wykorzystaniu sztucznej inteligencji oraz wykaz poleceń wydanych narzędziu programistycznemu. Ostatni dotyczy wyłącznie budowy aplikacji i dla każdego polecenia podaje cel, treść, wprowadzone przez Ciebie zmiany i sposób weryfikacji. Aneksy muszą być powiązane z tekstem odsyłaczami.

## W jakiej kolejności pisać

**Tabela 16. Kolejność pisania rozdziałów**

| Etap | Co piszesz | Dlaczego wtedy |
|---|---|---|
| 1 | rozdział 1, aparat formalny | zmusza do zrozumienia metody, zanim powstanie kod |
| 2 | rozdział 1, założenia i granice | staje się kontraktem specyfikacji pakietu |
| 3 | rozdział 2, generowanie danych | piszesz razem z kodem, gdy pamiętasz parametry |
| 4 | rozdział 2, reszta | po zamknięciu implementacji |
| 5 | rozdział 3 | po pierwszym pełnym przebiegu analizy |
| 6 | rozdział 1, rozwiązania pokrewne | dopiero teraz wiesz, z czym się porównujesz |
| 7 | Wprowadzenie | wiadomo już, co się zapowiada |
| 8 | Podsumowanie | domyka klamrę z gotowym Wprowadzeniem |
| 9 | aneksy, wykaz źródeł, redakcja | na końcu |

Wprowadzenie pisane jako pierwsze jest prawie zawsze pisane dwa razy.

Trzy rzeczy prowadź **od pierwszego dnia**, a nie na końcu: plik bibliograficzny, polecenia wstawiające nazwiska do indeksu oraz rejestr poleceń wydanych narzędziu programistycznemu. Odtwarzanie każdej z nich po fakcie kosztuje wielokrotnie więcej czasu.

---

Wersja do druku obejmująca wszystkie rozdziały: [przewodnik.pdf](../przewodnik/przewodnik.pdf).
