# Wymogi formalne

Zestawienie wymagań obowiązujących pracę licencjacką na kierunku elektroniczne przetwarzanie informacji, z podaniem źródła każdego z nich. Dwa dokumenty Instytutu uzupełniają się i miejscami rozchodzą – przy rozbieżności o **układzie pracy** rozstrzygają Standardy (Standardy EPI), a o **zapisie bibliografii** Instrukcja (Instrukcja ISI). W tabelach skrót S oznacza Standardy, a skrót I – Instrukcję.

## Skład

**Tabela 22. Wymogi składu**

| Wymóg | Źródło | Kto realizuje |
|---|---|---|
| Pismo 12 pkt w tekście głównym | S | klasa |
| Interlinia 1,5 | S | klasa |
| Marginesy 2,5 cm z każdej strony | S, I | klasa |
| Przy oprawie margines wewnętrzny szerszy kosztem zewnętrznego, nie mniej niż 1,5 cm | I | opcja klasy |
| Tytuły rozdziałów tym samym krojem, większe i wytłuszczone | S | klasa |
| Tytuły rozdziałów 18 pkt, wyśrodkowane | I | klasa |
| Tytuły podrozdziałów 14 pkt, wytłuszczone, do lewej | I | klasa |
| Numeracja rozdziałów wielopoziomowa | S, I | klasa |
| Wstęp i Zakończenie bez numeracji, ale w spisie treści | I | klasa |
| Każdy element ze spisu treści od nowej strony | S, I | klasa |
| Wszystkie strony numerowane | S | klasa |
| Numer strony w prawym dolnym rogu | I | klasa |
| Strona tytułowa liczona, bez numeru | S, I | klasa |
| Tekst wyjustowany | S, I | klasa |

Wszystkie pozycje realizuje klasa dokumentu bez Twojego udziału. Nie zmieniaj ustawień składu w preambule – rozbieżność z wymogami obciąża pracę, a nie klasę.

## Objętość

Tekst od pierwszej strony Wprowadzenia do ostatniej strony Podsumowania nie może przekraczać **czterdziestu stron znormalizowanych, czyli 72 000 znaków ze spacjami** (Instrukcja ISI). Do limitu nie wliczają się: strona tytułowa, strony informacyjne, spis treści, wykaz źródeł, bibliografia, spisy, indeks i aneksy.

**Lokalnie.** Kontrolę wykonuje skrypt `tools/policz_znaki.R`, uruchamiany z katalogu wzoru poleceniem `Rscript tools/policz_znaki.R`. Liczy znaki po usunięciu poleceń, listingów, wzorów i tabel, więc daje oszacowanie od góry. Wymaga zainstalowanego R.

**Na Overleaf.** R-a tam nie ma i skrypt się nie uruchomi. Zgrubną kontrolę daje wbudowane liczenie słów z menu projektu: strona znormalizowana to około 250 słów tekstu polskiego, więc limit odpowiada mniej więcej dziesięciu tysiącom słów. Kontrolę rozstrzygającą robisz na gotowym dokumencie: zaznacz tekst od pierwszej strony Wprowadzenia do ostatniej strony Podsumowania, wklej do edytora tekstu i odczytaj liczbę znaków ze spacjami.

## Struktura

Kolejność elementów we wzorze łączy wymagania obu dokumentów: strona tytułowa, opcjonalna strona informacyjna z abstraktem i słowami kluczowymi, spis treści, Wprowadzenie, rozdziały numerowane, Podsumowanie, wykaz źródeł, bibliografia, spis ilustracji, indeks nazwisk, aneksy.

Standardy opisują treść rozdziałów zasadniczych jako logikę aplikacji – schemat ogólny, moduły, opis interfejsu ze zrzutami ekranu – oraz implementację, czyli format danych, strukturę bazy, sposób realizacji modułów, biblioteki zewnętrzne i narzędzia. Wzór realizuje to w trzech rozdziałach.

### Strona informacyjna

Wymóg Instrukcji, włączany opcją klasy. Zawiera opis bibliograficzny pracy w postaci obejmującej nazwisko i imię autora, rok obrony, tytuł, oznaczenie rodzaju pracy, promotora, miejsce, jednostkę i liczbę stron. Dalej abstrakt liczący **od 1000 do 1500 znaków ze spacjami**, przedstawiający cel, przedmiot, metody i kluczowe wyniki, napisany językiem skondensowanym i bez ogólników. Na końcu **około pięciu słów kluczowych** w porządku alfabetycznym, rozdzielonych przecinkami.

Strona angielska powstaje automatycznie po wypełnieniu angielskich metadanych i zawiera dokładnie te same informacje w tym samym układzie.

## Cytowanie

Standardy wymieniają pięć sytuacji, w których wskazanie źródła jest obowiązkowe:

1. cytat bezpośredni, czyli dosłownie przytoczone cudze słowa;
2. graficzna forma cytatu – cudze tabele, rysunki, zestawienia;
3. cytat znany pośrednio, z tekstu jeszcze innego autora;
4. zebrane przez kogoś informacje: ankiety, dane statystyczne, dokumenty, materiały ze stron internetowych;
5. cudza teza, argument, opinia, idea, interpretacja, unikalne ujęcie tematu.

Każde przytoczenie umieszczasz w cudzysłowie polskim, a cytat w cytacie w cudzysłowie wewnętrznym. Wewnątrz cytatu obowiązuje pisownia cytowanego autora; zmianę odnotowujesz w nawiasie kwadratowym po cudzysłowie zamykającym. Tłumaczenie własne oznaczasz w nawiasie kwadratowym, a cytat w oryginale przywołujesz w przypisie dolnym. Fragment powyżej dwóch lub trzech zdań wyodrębniasz graficznie.

Przytoczenie musi być **wkomponowane w tekst**: wprowadzone lub domknięte komentarzem, który sygnalizuje obecność cudzego słowa. Samo wklejenie z cytowaniem nie wystarcza. Przy powoływaniu się na cudzą opinię obowiązuje, niezależnie od cytowania, wprowadzenie z informacją, do kogo dany pogląd należy.

Brak zasygnalizowania w tekście, że posługujesz się cudzym słowem, oznacza naruszenie prawa (Dz.U. 2022 poz. 2509). Brak odpowiednio opisanych źródeł może być powodem dyskwalifikacji pracy.

## Przypisy i bibliografia

Obowiązuje system nawiasowy, tak zwany harwardzki: nazwisko, rok, w razie potrzeby strona. Postacie cytowań i odpowiadające im polecenia są zestawione w tabeli **Postacie cytowania**. Skracanie listy autorów, dodawanie inicjału i sufiksów rocznika wykonuje styl automatycznie – Twoim zadaniem jest poprawny wpis w pliku bibliograficznym.

Do przypisów dolnych trafiają wyłącznie przypisy dygresyjne, których należy unikać, oraz oryginalne brzmienie tłumaczonych cytatów.

Zasada wiążąca bibliografię z tekstem: **bibliografia zawiera wyłącznie pozycje faktycznie wykorzystane, do których odsyłają cytowania w tekście**. Pozycje dotyczące tematu, ale niewykorzystane, do bibliografii nie trafiają. Muszą się w niej znaleźć pozycje obcojęzyczne.

## Materiał ilustracyjny

**Tabela 23. Wymogi wobec materiału ilustracyjnego**

| Wymóg | Źródło |
|---|---|
| Numeracja ciągła przez cały tekst, osobna dla każdego typu | I |
| Tytuł nad ilustracją | I |
| Źródło pod ilustracją | I |
| Oznaczenie opracowania własnego, także na podstawie cudzego materiału | I |
| Pełny opis bibliograficzny dla materiału przejętego | I |
| Interfejs aplikacji zilustrowany zrzutami ekranu | S |

Środowiska wzoru realizują tytuł, numerację i miejsce na źródło automatycznie.

Prawa do ilustracji: bez zgody autora można wykorzystać materiały z domeny publicznej, na licencji Creative Commons lub podobnej oraz zrzuty ekranu z publicznie dostępnych źródeł elektronicznych. Pozostałe wymagają pisemnej zgody właściciela autorskich praw majątkowych.

## Zapis w tekście

**Tabela 24. Zapis elementów w tekście**

| Element | Zapis | Polecenie |
|---|---|---|
| tytuł czasopisma, książki, zasobu sieciowego | kursywa bez cudzysłowu | `\termin` |
| wyraz obcojęzyczny | kursywa | `\termin` |
| wyróżnienie treściowe | wytłuszczenie | `\wyroznienie` |
| cytat | cudzysłów polski | `\enquote` |
| nazwa funkcji | pismo maszynowe | `\fun` |
| nazwa argumentu | pismo maszynowe | `\argument` |
| nazwa pakietu | pismo maszynowe | `\pkg` |
| nazwa pliku | pismo maszynowe | `\plik` |

## Wymogi projektu dyplomowego

Poza pracą pisemną Standardy wymagają samodzielnie zaprojektowanej i wykonanej aplikacji z interfejsem internetowym. Zaliczenie seminarium następuje dopiero po przyjęciu projektu (Standardy EPI; Prawo o szkolnictwie wyższym).

Aplikacja nastawiona na prezentację informacji musi robić więcej niż wyświetlanie zawartości bazy danych: konieczny jest niestandardowy pomysł prezentacji, dostosowany projekt graficzny i mechanizm interakcji z użytkownikiem.

W serwisie obowiązkowa jest nota z załącznika do Standardów, umieszczona w zakładce o serwisie. Podaje ona autora serwisu, informację, że serwis stanowi integralną część pracy licencjackiej na kierunku elektroniczne przetwarzanie informacji, oraz promotora i jednostkę. Ta sama nota trafia do aneksu pracy.

## Kryteria oceny

Standardy wymieniają wprost, co podlega ocenie promotora i recenzenta: zgodność treści pracy z tematem, strukturę pracy, znajomość stanu badań lub praktyki w zakresie wyznaczonym przez tematykę, poprawność językową i terminologiczną, metodologię projektu, zawartość merytoryczną, poprawność działania oraz estetykę aplikacji, a także dobór i wykorzystanie piśmiennictwa. Recenzje trafiają do Archiwum Prac.

## Lista kontrolna przed oddaniem

### Kompilacja i objętość

- [ ] Pełna kompilacja kończy się bez błędów
- [ ] Brak komunikatów o nierozwiązanych cytowaniach i odsyłaczach
- [ ] Objętość mieści się w limicie
- [ ] Listingi nie zawierają znaków spoza ASCII

### Treść

- [ ] Tytuł pracy odpowiada zawartości i zawiera zagadnienie ogólniejsze
- [ ] Cel z Wprowadzenia domknięty w Podsumowaniu
- [ ] Perspektywy rozwoju aplikacji opisane konkretnie
- [ ] Wszystkie przytoczenia wprowadzone komentarzem w tekście
- [ ] Własne ustalenia oddzielone od cudzych na poziomie zdania

### Bibliografia i źródła

- [ ] Każda pozycja bibliografii ma cytowanie w tekście
- [ ] Każde cytowanie ma pozycję w bibliografii
- [ ] W bibliografii są pozycje obcojęzyczne
- [ ] Wykaz źródeł obejmuje wszystkie użyte pakiety
- [ ] Adresy sieciowe mają datę odczytu

### Elementy końcowe

- [ ] Spis ilustracji zgodny z zawartością pracy
- [ ] Indeks nazwisk obejmuje nazwiska z tekstu i bibliografii
- [ ] Aneksy powiązane z tekstem odsyłaczami
- [ ] Aneks z metadanymi oprogramowania wypełniony
- [ ] Aneks z notą serwisu zgodny z treścią na stronie projektu
- [ ] Oświadczenie o wykorzystaniu sztucznej inteligencji wypełnione, jeżeli dotyczy
- [ ] Wykaz poleceń wydanych narzędziu programistycznemu kompletny

### Projekt

- [ ] Strona projektu działa pod adresem podanym na stronie tytułowej
- [ ] Nota z załącznika obecna w serwisie
- [ ] Repozytorium publiczne i zgodne z adresem ze strony tytułowej
- [ ] Sprawdzenie pakietu przechodzi na trzech systemach operacyjnych

### Redakcja

- [ ] Korekta całości po wydruku, nie na ekranie
- [ ] Tekst wyjustowany, bez wiszących wierszy
- [ ] Konsekwentna terminologia w całej pracy
- [ ] Wyszukanie uwag promotora w plikach źródłowych nie daje wyników
- [ ] Usunięte własne komentarze robocze i wskazówki wzoru

---

Wersja do druku obejmująca wszystkie rozdziały: [przewodnik.pdf](../przewodnik/przewodnik.pdf).
