# Wymogi formalne

Zestawienie wymagań obowiązujących pracę licencjacką na kierunku elektroniczne
przetwarzanie informacji, z podaniem źródła każdego z nich. Dwa dokumenty Instytutu
uzupełniają się i miejscami rozchodzą — przy rozbieżności o **układzie pracy**
rozstrzygają Standardy EPI, o **zapisie bibliografii** Instrukcja ISI.

Skrót **S** oznacza *Standardy prac dyplomowych na kierunku EPI*, skrót **I** —
*Instrukcję Instytutu Studiów Informacyjnych*.

---

## Skład

| Wymóg | Źródło | Kto realizuje |
|---|---|---|
| Pismo 12 pkt w tekście głównym | S | klasa |
| Interlinia 1,5 | S | klasa |
| Marginesy 2,5 cm z każdej strony | S, I | klasa |
| Przy oprawie: margines wewnętrzny szerszy kosztem zewnętrznego, zewnętrzny nie mniej niż 1,5 cm | I | opcja `oprawa` |
| Tytuły rozdziałów tym samym krojem co tekst, większe i wytłuszczone | S | klasa |
| Tytuły rozdziałów 18 pkt, wyśrodkowane | I | klasa |
| Tytuły podrozdziałów 14 pkt, wytłuszczone, do lewej, z linią odstępu przed i po | I | klasa |
| Numeracja rozdziałów 1, 1.1, 1.2, 2, 2.1 | S, I | klasa |
| Wstęp i Zakończenie bez numeracji, ale w spisie treści | I | klasa |
| Każdy element ze spisu treści od nowej strony; nie dotyczy podrozdziałów | S, I | klasa |
| Wszystkie strony numerowane | S | klasa |
| Numer strony w prawym dolnym rogu; przy druku dwustronnym w rogu zewnętrznym | I | klasa, opcja `dwustronnie` |
| Strona tytułowa liczona jako pierwsza, bez numeru | S, I | klasa |
| Tekst wyjustowany | S, I | klasa |

Wszystkie pozycje z kolumny „klasa" realizuje `epi-praca.cls` bez Twojego udziału.
Nie zmieniaj ustawień składu w preambule — rozbieżność z wymogami obciąża pracę,
a nie klasę.

## Objętość

Tekst od pierwszej strony Wprowadzenia do ostatniej strony Podsumowania: **nie więcej
niż 40 stron znormalizowanych, czyli 72 000 znaków ze spacjami** (I).

Do limitu nie wliczają się: strona tytułowa, strony informacyjne, spis treści, wykaz
źródeł, bibliografia, spisy, indeks i aneksy.

Kontrola:

```
cd wzor-pracy
Rscript tools/policz_znaki.R
```

Skrypt liczy znaki po usunięciu poleceń LaTeX-a, listingów, wzorów i tabel, więc daje
oszacowanie od góry.

## Struktura

Kolejność elementów we wzorze łączy wymagania obu dokumentów:

1. Strona tytułowa (S — Załącznik nr 1)
2. Strona informacyjna z abstraktem i słowami kluczowymi — opcjonalna, wymóg I
3. Spis treści (S, I)
4. Wprowadzenie (S) / Wstęp (I)
5. Rozdziały numerowane (S, I)
6. Podsumowanie (S) / Wnioski (I)
7. Wykaz źródeł (I — gdy przedmiotem badań były publikacje, dokumenty, materiały)
8. Bibliografia (S, I)
9. Spis ilustracji (S, I)
10. Indeks nazwisk (I)
11. Aneksy (S, I)

Standardy EPI opisują treść rozdziałów zasadniczych jako logikę aplikacji (schemat ogólny,
moduły, opis interfejsu ze zrzutami ekranu) oraz implementację (format danych, struktura
bazy, sposób realizacji modułów, biblioteki zewnętrzne, narzędzia). Wzór realizuje to
w rozdziałach 1–3.

### Strona informacyjna

Wymóg Instrukcji ISI, włączany opcją klasy `stronyinfo`. Zawiera:

- opis bibliograficzny pracy w postaci:
  `Nazwisko, imię (rok obrony). Tytuł. Praca licencjacka. Promotor: tytuł, imię i nazwisko.
  Kraków: Instytut Studiów Informacyjnych UJ, liczba stron.`
- abstrakt: **od 1000 do 1500 znaków ze spacjami**, o celu, przedmiocie, metodach
  i kluczowych wynikach; język skondensowany, bez ogólników;
- około **pięciu słów kluczowych** w porządku alfabetycznym, rozdzielonych przecinkami.

Strona angielska powstaje automatycznie, gdy wypełnisz `\tytulen`, `\abstrakten`
i `\keywords`, i zawiera dokładnie te same informacje w tym samym układzie.

### Strona tytułowa

Wzór odwzorowuje Załącznik nr 1 do Standardów EPI, uzupełniony o adres strony projektu
i adres repozytorium. Wypełniasz wyłącznie polecenia metadanych w `main.tex`.

## Cytowanie

Standardy EPI wymieniają pięć sytuacji, w których wskazanie źródła jest obowiązkowe:

1. cytat bezpośredni — dosłownie przytoczone cudze słowa;
2. graficzna forma cytatu — cudze tabele, rysunki, zestawienia;
3. cytat znany pośrednio, z tekstu jeszcze innego autora;
4. zebrane przez kogoś informacje — ankiety, dane statystyczne, dokumenty, materiały
   ze stron internetowych;
5. cudza teza, argument, opinia, idea, interpretacja, unikalne ujęcie tematu.

Zasady szczegółowe:

- każde przytoczenie w cudzysłowie polskim `„cytat"`, cytat w cytacie `«cytat»`
  albo `'cytat'`;
- wewnątrz cytatu obowiązuje pisownia cytowanego autora; zmianę odnotowujesz w nawiasie
  kwadratowym po cudzysłowie zamykającym;
- tłumaczenie własne oznaczasz `[tłum. własne — XY]`, a cytat w oryginale przywołujesz
  w przypisie dolnym;
- fragment powyżej dwóch–trzech zdań wyodrębniasz graficznie — we wzorze służy do tego
  środowisko `quote`;
- przytoczenie musi być wkomponowane w tekst: wprowadzone lub domknięte komentarzem,
  który sygnalizuje obecność cudzego słowa. Samo wklejenie z przypisem nie wystarcza;
- przy powoływaniu się na cudzą opinię obowiązuje, niezależnie od przypisu, wprowadzenie
  z informacją, do kogo dany pogląd należy.

Brak zasygnalizowania w tekście, że posługujesz się cudzym słowem, oznacza naruszenie
prawa. Brak odpowiednio opisanych źródeł może być powodem dyskwalifikacji pracy.

## Przypisy i bibliografia

Obowiązuje system nawiasowy, tak zwany harwardzki: nazwisko, rok, w razie potrzeby strona.

| Sytuacja | Zapis w tekście | Polecenie |
|---|---|---|
| jeden autor | `(Kowalski 2010)` | `\parencite{klucz}` |
| ze stroną | `(Kowalski 2010, s. 15-21)` | `\parencite[s.~15-21]{klucz}` |
| kilku autorów | `(Nowak, Kowalski 2004, s. 23-25)` | `\parencite[s.~23-25]{klucz}` |
| powyżej trzech autorów | `(Nowak i in. 1999, s. 15)` | `\parencite[s.~15]{klucz}` |
| zbieżne nazwiska | `(Nowak P. 1999, s. 15)` | `\parencite[s.~15]{klucz}` |
| kilka prac z tego samego roku | `(Kowalski 2010a, s. 18)` | `\parencite[s.~18]{klucz}` |
| praca zbiorowa | `(Kowalski red. 1998)` | `\parencite{klucz}` |
| brak autora | `(Elektroniczne publikacje 2008)` | `\parencite{klucz}` |
| kilka pozycji naraz | `(Kowalski 2005, s. 9; Nowak 2006, s. 23)` | `\parencite{klucz1,klucz2}` |
| w zdaniu | `Woźniak (1997) pokazuje...` | `\textcite{klucz}` |

Skracanie listy autorów, dodawanie inicjału i sufiksów rocznika wykonuje styl
automatycznie — Twoim zadaniem jest poprawny wpis w pliku `.bib`.

Do przypisów dolnych trafiają wyłącznie przypisy dygresyjne, których należy unikać,
oraz oryginalne brzmienie tłumaczonych cytatów.

Zasada wiążąca bibliografię z tekstem: **bibliografia zawiera wyłącznie pozycje faktycznie
wykorzystane, do których odsyłają przypisy w tekście**. Pozycje dotyczące tematu, ale
niewykorzystane, do bibliografii nie trafiają. W bibliografii muszą znaleźć się pozycje
obcojęzyczne.

Postać opisów bibliograficznych oraz sposób zapisu wpisów w pliku `.bib` opisuje
[`wzor-pracy/README.md`](../wzor-pracy/README.md#bibliografia).

## Materiał ilustracyjny

| Wymóg | Źródło |
|---|---|
| Numeracja ciągła przez cały tekst, osobna dla każdego typu | I |
| Tytuł nad ilustracją | I |
| Źródło pod ilustracją | I |
| „oprac. własne" albo „oprac. własne na podstawie + opis bibliograficzny" dla materiału autorskiego | I |
| Pełny opis bibliograficzny dla materiału przejętego | I |
| Interfejs aplikacji zilustrowany zrzutami ekranu | S |

Środowiska `tabelaepi`, `rysunekepi` i `wykresepi` realizują tytuł, numerację i miejsce
na źródło automatycznie.

Prawa do ilustracji: bez zgody autora można wykorzystać materiały z domeny publicznej,
na licencji Creative Commons lub podobnej oraz zrzuty ekranu z publicznie dostępnych
źródeł elektronicznych. Pozostałe wymagają pisemnej zgody właściciela autorskich praw
majątkowych.

## Zapis w tekście

| Element | Zapis | Polecenie |
|---|---|---|
| tytuł czasopisma, książki, zasobu WWW w tekście | kursywa bez cudzysłowu | `\termin{}` |
| wyraz obcojęzyczny | kursywa | `\termin{}` |
| wyróżnienie treściowe | wytłuszczenie | `\wyroznienie{}` |
| cytat | cudzysłów polski | `\enquote{}` |
| nazwa funkcji, argumentu, pakietu, pliku | pismo maszynowe | `\fun{}`, `\argument{}`, `\pkg{}`, `\plik{}` |

## Wymogi projektu dyplomowego

Poza pracą pisemną Standardy EPI wymagają samodzielnie zaprojektowanej i wykonanej
aplikacji z interfejsem WWW. Zaliczenie seminarium następuje dopiero po przyjęciu projektu.

Aplikacja nastawiona na prezentację informacji musi robić więcej niż wyświetlanie
zawartości bazy danych: konieczny jest niestandardowy pomysł prezentacji, dostosowany
projekt graficzny i mechanizm interakcji z użytkownikiem.

W serwisie obowiązkowa jest nota z Załącznika nr 2, umieszczona w zakładce „O serwisie"
albo „Info":

> Autorem niniejszego serwisu jest [imię i nazwisko]. Serwis ten stanowi integralną część
> pracy licencjackiej (kierunek: elektroniczne przetwarzanie informacji), przygotowanej pod
> kierunkiem [tytuł, imię i nazwisko promotora] na Wydziale Zarządzania i Komunikacji
> Społecznej Uniwersytetu Jagiellońskiego.

Ta sama nota trafia do Aneksu 2 pracy.

## Kryteria oceny

Standardy EPI wymieniają wprost, co podlega ocenie promotora i recenzenta:

- zgodność treści pracy z tematem,
- struktura pracy,
- znajomość stanu badań lub praktyki w zakresie wyznaczonym przez tematykę,
- poprawność językowa i terminologiczna,
- metodologia projektu,
- zawartość merytoryczna,
- poprawność działania oraz estetyka aplikacji,
- dobór i wykorzystanie piśmiennictwa.

Recenzje trafiają do Archiwum Prac UJ.

## Lista kontrolna przed oddaniem

**Kompilacja i objętość**

- [ ] `latexmk -lualatex main.tex` kończy się bez błędów
- [ ] brak komunikatów o nierozwiązanych powołaniach i odsyłaczach
- [ ] `Rscript tools/policz_znaki.R` mieści się w limicie
- [ ] `Rscript tools/sprawdz-listingi.R` nie zgłasza znaków spoza ASCII

**Treść**

- [ ] tytuł pracy odpowiada jej zawartości i zawiera zagadnienie ogólniejsze
- [ ] cel z Wprowadzenia domknięty w Podsumowaniu
- [ ] perspektywy rozwoju aplikacji opisane konkretnie
- [ ] wszystkie przytoczenia wprowadzone komentarzem w tekście
- [ ] własne ustalenia oddzielone od cudzych na poziomie zdania

**Bibliografia i źródła**

- [ ] każda pozycja bibliografii ma powołanie w tekście
- [ ] każde powołanie ma pozycję w bibliografii
- [ ] w bibliografii są pozycje obcojęzyczne
- [ ] wykaz źródeł obejmuje wszystkie użyte pakiety R
- [ ] adresy WWW mają datę odczytu

**Elementy końcowe**

- [ ] spis ilustracji zgodny z zawartością pracy
- [ ] indeks nazwisk obejmuje wszystkie nazwiska z tekstu i bibliografii
- [ ] aneksy powiązane z tekstem odsyłaczami
- [ ] Aneks z metadanymi oprogramowania wypełniony
- [ ] Aneks z notą serwisu WWW zgodny z treścią na stronie projektu
- [ ] oświadczenie o wykorzystaniu SI wypełnione, jeżeli dotyczy
- [ ] wykaz poleceń wydanych narzędziu programistycznemu kompletny

**Projekt**

- [ ] strona projektu działa pod adresem podanym na stronie tytułowej
- [ ] nota z Załącznika nr 2 obecna w serwisie
- [ ] repozytorium publiczne i zgodne z adresem ze strony tytułowej
- [ ] sprawdzenie pakietu przechodzi na trzech systemach operacyjnych

**Redakcja**

- [ ] korekta całości po wydruku, nie na ekranie
- [ ] tekst wyjustowany, bez wiszących wierszy
- [ ] konsekwentna terminologia w całej pracy
