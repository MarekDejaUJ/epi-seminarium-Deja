# Warsztat pisania pracy akademickiej

Przewodnik o tym, **jak** pisać: skąd wziąć pytanie, jak zbudować argument, jak
rozmawiać z literaturą i jak nie stracić panowania nad źródłami. Co ma się znaleźć
w którym rozdziale, opisuje osobno [`04-jak-pisac-prace.md`](04-jak-pisac-prace.md);
czego wymaga Instytut — [`06-wymogi-formalne-isi-epi.md`](06-wymogi-formalne-isi-epi.md).

---

## Pytanie analityczne

Celem pracy licencjackiej nie jest prezentacja wiedzy, lecz zrozumienie problemu.
Proces ten obejmuje analizę dowodów i założeń oraz przemyślenie logiki argumentów.
Punktem wyjścia jest pytanie — i nie każde pytanie się do tego nadaje.

### Jakie pytanie nadaje się na fundament pracy

Dobre pytanie analityczne:

- dotyczy realnego dylematu obecnego w źródłach, a nie wymyślonego na potrzeby pracy;
- daje odpowiedź, która nie jest oczywista przed przeprowadzeniem analizy;
- sugeruje odpowiedź na tyle złożoną, że wymaga pełnej dyskusji, a nie akapitu;
- da się na nie odpowiedzieć dostępnymi źródłami i dostępnymi danymi.

### Skąd brać pytania: punkty napięcia

Pytania rodzą się w miejscach, gdzie źródła nie są ze sobą zgodne albo gdzie coś zgrzyta.
Warto myśleć o nich jak o momentach, w których trzeba się zatrzymać i zastanowić, zanim
da się iść dalej. Szukaj:

- stanowiska, które wydaje Ci się nieprzekonujące — zapytaj, czego brakuje albo jak
  dowody można przeczytać inaczej;
- nieścisłości, luki lub dwuznaczności w dowodach — zapytaj, jak to zmienia rozumienie
  problemu;
- nieoczekiwanego wniosku, który nie do końca się zgadza — zapytaj, jak autorzy do niego
  doszli;
- kontrowersji, która wymaga rozstrzygnięcia — zapytaj, jak można ją rozstrzygnąć;
- problemu, który został zignorowany — zapytaj, dlaczego, albo spróbuj go rozwiązać;
- dowodu, który zasługuje na bliższe przyjrzenie się.

### Punkty napięcia właściwe dla pracy o oprogramowaniu badawczym

W Twoim temacie napięcia są też innego rodzaju — między metodą a jej użyciem:

- artykuł podaje algorytm, ale **nie precyzuje**, co zrobić z brakami danych,
  wartościami brzegowymi albo przypadkiem zdegenerowanym;
- metoda zakłada dane, których w badaniach społecznych zwykle **nie ma** w tej postaci;
- istniejąca implementacja daje **inny wynik** niż opis w publikacji;
- autorzy pokazują metodę na danych symulowanych i nie mówią, co się dzieje na danych
  rzeczywistych;
- procedura wymaga decyzji parametrycznej, którą publikacja przemilcza, choć wynik
  od niej zależy.

Każde z tych napięć jest gotowym punktem wyjścia dla pytania badawczego — i jednocześnie
dla decyzji projektowej w pakiecie.

### Jak formułować

- pytania „jak" i „dlaczego" wymagają więcej analizy niż „kto", „co", „gdzie", „kiedy";
- dobre pytanie podkreśla wzorzec i związek albo sprzeczność i dylemat;
- pytanie wyznacza zakres argumentacji — pozwala skupić się na części szerokiego tematu;
- może dotyczyć implikacji i konsekwencji analizy.

Pytanie prowadzi przez cały proces badawczy i pisanie. Kształtuje strukturę pracy,
terminologię i kierunek poszukiwań — dlatego warto poświęcić mu pierwsze tygodnie
seminarium, a nie wymyślać je w tydzień przed oddaniem.

---

## Od pytania do tezy

Pytanie otwiera, teza domyka. Teza to zdanie oznajmujące, z którym da się nie zgodzić.
Jeśli nikt rozsądny nie mógłby zaprzeczyć Twojej tezie, to nie jest teza, tylko
stwierdzenie faktu.

| Pytanie | Teza |
|---|---|
| Jakie warunki musi spełnić implementacja metody X, żeby wynik dał się odtworzyć? | Odtwarzalność wyniku metody X zależy w większym stopniu od jawnego opisu obsługi braków danych niż od precyzji samego algorytmu. |
| Które założenia metody X są najbardziej wrażliwe na jakość danych społecznych? | Metoda X traci stabilność przy współliniowości kryteriów wcześniej niż przy brakach danych, co odwraca kolejność zaleceń podawanych w literaturze. |

Teza może się zmienić w trakcie pracy. To normalne i nie jest porażką — zmiana tezy
pod wpływem wyników jest dowodem uczciwości, o ile praca opisuje wersję finalną,
a nie obie naraz.

---

## Wejście w dyskusję akademicką

Praca ma być głosem w rozmowie, która toczy się bez Ciebie. Są trzy sposoby włączenia się.

### Krok w przód

Prezentujesz własną wiedzę i wkład: co zrobiłeś, czego to dowodzi, dlaczego to ważne.
Wykazujesz znajomość literatury i podkreślasz, na czym polega unikalność Twojego
rozwiązania. To dominujący tryb Wprowadzenia i rozdziału drugiego.

Zacznij od przeglądu istniejących prac, teorii i terminów. Czytaj nie tylko to, co autorzy
mówią, ale też **to, co pomijają albo traktują pobieżnie** — tam zwykle leży luka.
Następnie wskaż, gdzie dokładnie Twoja praca wpisuje się w te dyskusje. Nie wystarczy
powiedzieć, że praca jest z tym związana; trzeba określić, jak Twoje podejście różni się
od obecnego rozumienia albo je rozszerza.

### Krok w tył

Umieszczasz własną argumentację w szerszym kontekście: jak praca koreluje z innymi
badaniami, jak rozszerza albo kwestionuje istniejące ustalenia. To dominujący tryb
rozdziału trzeciego i Podsumowania.

Zastanów się też, kto będzie Twoją pracą zainteresowany — inni badacze, praktycy,
szersza publiczność. Odbiorca decyduje o języku i o tym, które konsekwencje warto
wyeksponować. Praca o oprogramowaniu badawczym ma odbiorcę podwójnego: metodologa,
którego interesuje wierność implementacji, i badacza, którego interesuje, czy narzędzie
da się użyć.

### Kwestionowanie

Podważasz przyjęte założenia i pokazujesz alternatywne perspektywy. Wyjaśniasz, dlaczego
te alternatywy są poznawczo ważne, ale niemożliwe do wykorzystania przy Twoim celu —
i że stanowią obszar ograniczenia Twojej perspektywy, wykraczający poza Twój problem.

Bądź gotowy na kontrargumenty. To normalne, że recenzent nie zgodzi się z częścią
wniosków. Przewidywanie sprzeciwów i odpowiadanie na nie w tekście wzmacnia pracę
bardziej niż ich pominięcie.

---

## Zapożyczanie i rozwijanie teorii

Zidentyfikuj teorie i pojęcia istotne dla tematu. Zwróć uwagę na kluczowe idee, definicje
i argumenty — bez tego nie da się ich skutecznie wprowadzić do własnej pracy.

W pracach z zakresu nauki o informacji pojawiają się terminy wymagające definicji:
*metadane*, *analiza semantyczna*, *uczenie maszynowe*, *odtwarzalność*. Wyjaśnij, jak
używasz ich **w kontekście swojej pracy** i jakie mają znaczenie dla zrozumienia problemu.
Definicja robocza jest lepsza niż definicja słownikowa, o ile powiesz, skąd ją bierzesz.

Następnie rozwiń te idee: jak teorie stosują się do Twojego tematu, co trzeba w nich
dostosować. Wreszcie pokaż, w jaki sposób te założenia wpłynęły na Twoje decyzje —
na kształt metod, na sposób weryfikacji, na interpretację wyników. Nie chodzi
o powierzchowne odniesienia, lecz o widoczne konsekwencje.

W pracy projektowej ten mechanizm ma konkretną postać: **założenie teoretyczne staje się
warunkiem wstępnym funkcji**. Jeżeli metoda zakłada nieujemność ocen, w kodzie pojawia się
sprawdzenie i komunikat błędu. Rozdział pierwszy i rozdział drugi mają się w tym miejscu
spotkać — i recenzent to sprawdzi.

---

## Czytanie artykułu metodycznego

Artykuł, na którym opierasz pracę, czytasz inaczej niż literaturę przeglądową.

**Kolejność.** Najpierw abstrakt i wnioski — po co to powstało. Potem sekcja definicyjna
i algorytmiczna — to jest Twój materiał. Sekcje dowodowe i porównawcze na końcu,
i tylko w takim zakresie, w jakim wpływają na implementację.

**Co wynotować.** Dla każdego wzoru: co jest wejściem, co wyjściem, jakiego typu i z jakiej
dziedziny jest każdy symbol. Dla każdego kroku: co się dzieje, gdy wejście jest brzegowe.
Osobno wypisz zdania zaczynające się od „zakładamy", „przy założeniu", „o ile" — to jest
przyszły kontrakt Twojego pakietu.

**Czego szukać między wierszami.** Decyzji, które autorzy podjęli, ale nieuzasadnili:
wartości domyślnych parametrów, sposobu normalizacji, kolejności kroków. Każda taka
decyzja jest miejscem, w którym Twoja implementacja musi zająć stanowisko — i w którym
narzędzie wspomagające pisanie kodu najczęściej zgaduje.

---

## Notatki i zarządzanie źródłami

Bibliografię prowadź **od pierwszego dnia**. Odtwarzanie jej po fakcie zajmuje kilka dni
i zawsze kończy się brakującym numerem strony.

Praktyka minimalna:

1. Kolekcja w Zotero dla pracy, z podkolekcjami na metodę, dziedzinę i narzędzia.
2. Eksport do `wzor-pracy/bibliografia/literatura.bib` — najlepiej automatyczny.
3. Notatka przy każdej pozycji: jedno–dwa zdania o tym, **do czego Ci ta pozycja jest
   potrzebna w pracy**. Nie streszczenie — streszczenie jest w abstrakcie.
4. Powołanie w tekście od razu przy pisaniu akapitu, nie na końcu rozdziału.

Sprawdzanie metadanych po imporcie jest obowiązkowe: bazy bibliograficzne notorycznie
gubią drugie imiona, mylą typ dokumentu i skracają tytuły czasopism.

Szczegóły techniczne opisuje przewodnik o bibliografii; postać wpisów —
[`wzor-pracy/README.md`](../wzor-pracy/README.md#bibliografia).

---

## Styl naukowy

### Terminologia

Termin raz wprowadzony ma jedną formę w całej pracy. Jeżeli w rozdziale pierwszym piszesz
*wariant*, nie przechodź w rozdziale trzecim na *alternatywę*. Konsekwencja terminologiczna
jest osobnym kryterium oceny.

Termin obcojęzyczny wprowadzasz raz, z polskim odpowiednikiem i zapisem oryginalnym
w nawiasie, dalej używasz jednej formy. Nazw funkcji i pakietów nie odmieniamy —
poprzedzamy je rzeczownikiem: „funkcja `przygotuj_dane()`", „pakiet `ggplot2`".

### Akapit

Akapit ma jedną myśl i mieści się na jednej trzeciej strony. Pierwsze zdanie mówi,
o czym akapit będzie. Ostatnie wiąże go z następnym. Akapit na całą stronę zawsze da się
podzielić i zawsze na tym zyskuje.

### Rejestr

Praca naukowa różni się od publicystyki i od dokumentacji technicznej.

| Zamiast | Napisz |
|---|---|
| „Niesamowicie ważnym zagadnieniem jest…" | „Zagadnienie X ma znaczenie dla…, ponieważ…" |
| „Jak wiadomo, media społecznościowe…" | „Badania nad mediami społecznościowymi wskazują, że… (powołanie)" |
| „Postanowiłem użyć TOPSIS-a, bo jest fajny" | „Wybrano metodę TOPSIS ze względu na…" |
| „Funkcja bierze dane i je przetwarza" | „Funkcja przyjmuje macierz ocen i zwraca wektor wag" |

Unikaj: nadmiernych skrótów myślowych, wypowiedzi emocjonalnych i publicystycznych,
rozbudowanych dygresji, treści luźno związanych z tokiem rozumowania. Nie opieraj wniosków
na nieujawnionych przesłankach ani na niepotwierdzonych naukowo przekonaniach.

### Precyzja

Tezy, sądy i wnioski formułuj precyzyjnie. „Metoda działa lepiej" nie znaczy nic;
„metoda daje niższy błąd średniokwadratowy przy próbach poniżej stu obserwacji" znaczy.
Każde twierdzenie porównawcze wymaga wskazania, względem czego i na jakiej podstawie.

---

## Rzetelność

### Oryginalność

Praca nie może powielać badań przeprowadzonych wcześniej przez inne osoby — z wyjątkiem
sytuacji, gdy chodzi o ich weryfikację lub aktualizację. Implementacja opublikowanej
metody **jest** dopuszczalna i mieści się w tym wyjątku, o ile praca wnosi własny wkład:
rozstrzygnięcie niedopowiedzeń, procedurę weryfikacji, zastosowanie w nowym obszarze.

### Kompilacja

Praca ani żaden jej fragment nie może być zestawieniem zapożyczeń — ani dosłownych
cytatów, ani fragmentów sparafrazowanych. Zasada obejmuje także tłumaczenia z języka obcego.

Parafraza nie zwalnia z powołania. „Wyrażenie własnymi słowami" cudzej myśli bez wskazania
autora jest naruszeniem, nawet jeżeli żadne zdanie nie zostało przepisane.

Dosłowne cytowanie i referowanie cudzych ustaleń ogranicz do minimum koniecznego do
ustalenia stanu badań, podjęcia z nimi dyskusji albo osadzenia własnych wyników.

### Granica między własnym a cudzym

Wypowiedź musi być tak skonstruowana, a przypisy umieszczone w takich miejscach, żeby
jednoznacznie oddzielić własne poglądy od zapożyczonych. **W żadnym miejscu czytelnik nie
może mieć wątpliwości, co jest wynikiem Twojej pracy, a co odwołaniem do cudzej.**

W praktyce oznacza to zwroty sygnalizujące:

- cudze: „zdaniem X…", „jak wykazuje X…", „w ujęciu X…", „X argumentuje, że…";
- własne: „w niniejszej pracy przyjęto…", „uzyskane wyniki wskazują…", „na tej podstawie
  można stwierdzić…".

Zasada nie dotyczy wiedzy powszechnej, danych powszechnie dostępnych i ogólnie określonych
metod badawczych. Dotyczy natomiast konkretnych teorii, idei, danych i narzędzi
badawczych, które stanowią dorobek konkretnych osób.

### Stan badań w układzie problemowym

Dotychczasowy dorobek poddajesz samodzielnej analizie i przedstawiasz w postaci własnych
wniosków, uporządkowanych **problemowo, nie chronologicznie ani alfabetycznie**. Układ
docelowy: co już wiemy i co jeszcze wymaga zbadania.

Przegląd, który brzmi „Kowalski (2019) napisał… Nowak (2020) napisał…", nie jest analizą,
tylko listą. Analiza brzmi: „W kwestii X literatura jest zgodna co do… (powołania),
natomiast rozchodzi się w sprawie…, gdzie Kowalski (2019) wskazuje…, a Nowak (2020)
przeciwnie…".

---

## Redakcja i korekta

Redakcja to osobny etap, nie przedłużenie pisania. Zaplanuj na nią co najmniej tydzień.

**Kolejność przeglądów.** Za każdym razem szukaj jednej rzeczy:

1. Struktura — czy kolejność rozdziałów i sekcji odpowiada logice wywodu.
2. Argument — czy każda teza ma uzasadnienie, a każde uzasadnienie prowadzi do tezy.
3. Powołania — czy każde twierdzenie o cudzym dorobku ma przypis i czy każda pozycja
   bibliografii ma powołanie.
4. Terminologia — czy nazwy są konsekwentne w całej pracy.
5. Język — zdania, akapity, interpunkcja.
6. Skład — wiszące wiersze, pływające tabele, przeniesienia, spisy.

**Korekta.** Rób ją na wydruku albo w innym kroju pisma. Czytaj na głos zdania,
które wydają się długie. Zdanie, którego nie da się przeczytać jednym tchem, wymaga
podziału.

**Odstęp.** Odłóż tekst na dwa–trzy dni przed ostatnim przeglądem. Nie ma sposobu,
żeby to obejść.

---

## Harmonogram

Pisanie i budowa pakietu idą równolegle. Rozdziały powstają w kolejności innej niż
kolejność w pracy — tabelę podaje
[`04-jak-pisac-prace.md`](04-jak-pisac-prace.md#w-jakiej-kolejności-pisać).

Trzy rzeczy prowadź od pierwszego dnia:

| Co | Gdzie | Dlaczego |
|---|---|---|
| plik `.bib` | `wzor-pracy/bibliografia/` | odtwarzanie po fakcie zajmuje kilka dni |
| `\osoba{Nazwisko}{Imię}` w tekście | rozdziały | indeks nazwisk powstaje sam |
| rejestr poleceń dla narzędzia | repozytorium pakietu | wymagany w aneksie, nie da się odtworzyć z pamięci |

Reguła praktyczna: **nie pisz akapitu, którego nie umiesz opowiedzieć na głos w trzech
zdaniach.** Jeżeli nie umiesz — nie jest to problem pisania, tylko znak, że ta część
nie jest jeszcze przemyślana.
