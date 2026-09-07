# Rubryka pracy licencjackiej

Standardy wymieniają osiem kryteriów oceny pracy dyplomowej. Poniższa rubryka
rozwija każde z nich do postaci, którą da się sprawdzić na tekście, i pokazuje, jak
kryterium wygląda w pracy opisującej pakiet obliczeniowy.

Recenzja nie jest sumą punktów. Jest oceną opisową, w której osiem kryteriów pełni
rolę porządkującą. Kolumna „niewystarczająca" opisuje stan, przy którym recenzent ma
podstawę do oceny negatywnej w danym aspekcie.

## 1. Zgodność treści pracy z tematem

Temat pracy w konwencji przyjętej na kierunku ma dwie części: konkretne narzędzie
oraz ogólniejsze zagadnienie, którego jest przykładem. Oceniane jest, czy praca
realizuje obie.

| Poziom | Opis |
|---|---|
| wyróżniająca | Praca realizuje obie części tematu. Zagadnienie ogólniejsze nie jest ozdobnikiem w tytule, tylko wraca w wprowadzeniu, w uzasadnieniu decyzji projektowych i w podsumowaniu. |
| poprawna | Praca realizuje temat. Część ogólniejsza obecna we wprowadzeniu, słabiej w dalszych rozdziałach. |
| niewystarczająca | Praca opisuje coś innego niż zapowiada tytuł albo ogranicza się do dokumentacji technicznej bez zagadnienia ogólniejszego. |

## 2. Struktura pracy

| Poziom | Opis |
|---|---|
| wyróżniająca | Układ rozdziałów wynika z logiki wywodu. Każdy rozdział ma jasną funkcję, a przejścia między nimi są uzasadnione. Proporcje objętości odpowiadają wadze treści. |
| poprawna | Układ zgodny z wymaganym. Pojedyncze fragmenty w niewłaściwym rozdziale. |
| niewystarczająca | Rozdziały nie mają wyodrębnionej funkcji, treść powtarza się między nimi albo brakuje któregoś z elementów wymaganych. |

Najczęstsza usterka strukturalna w pracach tego typu to aparat formalny rozsypany
po całym tekście: część wzorów w rozdziale pierwszym, część w drugim przy okazji
implementacji, część w trzecim przy okazji wyników. Wzory należą do rozdziału
pierwszego, a późniejsze rozdziały się do nich odwołują.

## 3. Znajomość stanu badań lub praktyki

| Poziom | Opis |
|---|---|
| wyróżniająca | Stan badań przedstawiony w układzie problemowym: co już wiadomo, czego jeszcze nie, gdzie jest spór. Przegląd obejmuje istniejące implementacje metody i podobnych metod, z rzetelnym porównaniem. Luka wynika z przeglądu, nie jest przed nim postawiona. |
| poprawna | Przegląd literatury obejmuje najważniejsze pozycje i istniejące narzędzia. Układ bliższy chronologicznemu niż problemowemu. |
| niewystarczająca | Przegląd sprowadza się do wyliczenia prac w kolejności przypadkowej. Istniejące implementacje pominięte. |

Pominięcie istniejącej implementacji tej samej metody jest w tym seminarium usterką
poważną, bo pierwsze pytanie recenzenta brzmi, czym Twój pakiet różni się od tego,
co już jest. Odpowiedź „nie wiedziałem, że jest" nie jest odpowiedzią.

## 4. Poprawność językowa i terminologiczna

| Poziom | Opis |
|---|---|
| wyróżniająca | Terminologia konsekwentna w całej pracy. Terminy angielskie wprowadzone raz, z polskim odpowiednikiem, potem stosowane jednolicie. Rejestr naukowy utrzymany bez sztuczności. Tekst po korekcie. |
| poprawna | Język poprawny, pojedyncze wahania terminologiczne, drobne usterki interpunkcyjne. |
| niewystarczająca | Ta sama rzecz nazywana różnie w różnych miejscach. Kalki z angielskiego zamiast terminów. Tekst bez korekty. |

Wahanie terminologiczne to nie jest kwestia estetyki. Jeżeli w rozdziale pierwszym
piszesz „wagi jednostek", w drugim „wagi obserwacji", a w trzecim „wagi próby",
czytelnik nie wie, czy to trzy rzeczy, czy jedna.

## 5. Metodologia projektu

Kryterium dotyczy sposobu, w jaki projekt został zbudowany i sprawdzony.

| Poziom | Opis |
|---|---|
| wyróżniająca | Praca opisuje kolejność: specyfikacja, testy, implementacja, i pokazuje, co z niej wynikło. Strategia testowania opisana jako element metodologii, z uzasadnieniem doboru przypadków. Procedura generowania danych opisana na tyle dokładnie, żeby dało się ją odtworzyć. Ograniczenia metody nazwane. |
| poprawna | Sposób budowy i sprawdzania opisany. Procedura generowania danych podana. Uzasadnienia doboru przypadków testowych skrótowe. |
| niewystarczająca | Praca opisuje, co program robi, nie opisując, skąd wiadomo, że robi to poprawnie. |

## 6. Zawartość merytoryczna

| Poziom | Opis |
|---|---|
| wyróżniająca | Aparat formalny przedstawiony samodzielnie, nie przepisany. Każdy wzór objaśniony, każdy symbol zdefiniowany. Widoczna różnica między tym, co pochodzi z artykułu, a tym, co jest własnym opracowaniem. Interpretacja wyników utrzymana w granicach tego, co pokazują dane. |
| poprawna | Treść merytorycznie poprawna, aparat formalny przedstawiony rzetelnie, miejscami bliżej referowania niż opracowania. |
| niewystarczająca | Błędy rzeczowe w opisie metody. Wzory przepisane bez objaśnień. Wnioski wykraczające poza to, co wynika z wyników. |

## 7. Poprawność działania oraz estetyka aplikacji

Kryterium dotyczy projektu, ale oceniane jest przy pracy, bo praca ma projekt
wiarygodnie opisywać.

| Poziom | Opis |
|---|---|
| wyróżniająca | Aplikacja działa pod adresem podanym w pracy, obsługuje dane użytkownika i błędne dane, ma czytelny układ i zrozumiałe opisy. Zrzuty ekranu w pracy odpowiadają stanowi faktycznemu. |
| poprawna | Aplikacja działa i realizuje metodę. Interfejs prosty, komunikaty techniczne. |
| niewystarczająca | Aplikacja niedostępna, zatrzymuje się przy danych spoza wzorca albo różni się od opisu w pracy. |

## 8. Dobór i wykorzystanie piśmiennictwa

| Poziom | Opis |
|---|---|
| wyróżniająca | Piśmiennictwo dobrane do problemu, nie do tematu ogólnie. Pozycje obcojęzyczne obecne i faktycznie wykorzystane. Powołania w miejscach, w których rzeczywiście coś podpierają. Opisy bibliograficzne zgodne z wymaganym stylem, bez wyjątków. |
| poprawna | Dobór trafny, powołania poprawne, pojedyncze niezgodności w opisach bibliograficznych. |
| niewystarczająca | Pozycje w bibliografii bez powołań w tekście. Powołania do prac, których treść nie odpowiada twierdzeniu. Opisy niezgodne ze stylem. |

Powołanie do pracy, która nie mówi tego, co jej przypisano, jest usterką cięższą niż
błąd w zapisie opisu bibliograficznego. Recenzent sprawdza to wyrywkowo i zwykle
trafia.

## Co najczęściej obniża ocenę

Poniższe usterki powtarzają się niezależnie od tematu i wszystkie da się usunąć przed
oddaniem pracy.

| Usterka | Kryterium |
|---|---|
| rozdział pierwszy referuje artykuł zamiast go opracowywać | 6 |
| brak przeglądu istniejących implementacji metody | 3 |
| wzory bez objaśnienia, co robią | 6 |
| ta sama rzecz nazwana w pracy trzema określeniami | 4 |
| wnioski szersze niż wyniki | 6 |
| pozycje w bibliografii bez powołań | 8 |
| opis aplikacji niezgodny z jej stanem | 7 |
| brak opisu, skąd wiadomo, że program liczy poprawnie | 5 |

Lista kontrolna do przejścia przed oddaniem jest [tutaj](listy-kontrolne.md).
