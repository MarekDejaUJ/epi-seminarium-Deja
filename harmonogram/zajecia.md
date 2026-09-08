# Przebieg zajęć

Spotkanie trwa dziewięćdziesiąt minut i ma zawsze tę samą budowę. Powtarzalność jest
tu celowa: kiedy wiadomo, co się wydarzy, nie traci się czasu na ustalanie, co się
wydarzy.

## Struktura spotkania

| Minuty | Blok | Co się dzieje |
|---|---|---|
| 0–15 | przegląd postępów | trzy lub cztery osoby pokazują na ekranie, w którym miejscu są i co je blokuje |
| 15–45 | część wykładowa | jeden temat z [tabeli tygodni](tygodnie.md), z pokazem na żywo |
| 45–80 | studio | pracujesz nad własnym pakietem, prowadzący chodzi po sali |
| 80–90 | domknięcie | wysyłasz zmiany do repozytorium i zapisujesz jedno zadanie na następny tydzień |

Blok pierwszy obraca się rotacyjnie, więc każdy pokazuje postęp mniej więcej co
czwarty tydzień. Pokaz trwa trzy minuty i ma odpowiedzieć na trzy pytania: co
działa, co nie działa, czego potrzebujesz. Nie jest to prezentacja i nie przygotowuje
się do niego slajdów.

Blok czwarty jest krótki, ale go nie skracamy. Zmiany wysłane do repozytorium na
zajęciach to zmiany, których nie zgubisz, i historia pracy, która potem posłuży za
materiał do rozdziału drugiego. Zadanie zapisane na piśmie to zadanie, które
w środę nadal znaczy to samo co w poniedziałek.

## Co przynosisz

Komputer z działającym środowiskiem: R, Positron, Git, dostęp do repozytorium.
Konfiguracja jest w przewodniku [Praca z agentem
programistycznym](../przewodniki/07-agent-cli.md#środowisko).

Od tygodnia 5 przynosisz też aktualną specyfikację, bo w bloku studia korzystasz
z niej co tydzień.

## Przegląd wzajemny

Dwa razy w roku czytasz cudzą pracę i dwa razy ktoś czyta Twoją.

### Tydzień 6: przegląd specyfikacji

Dostajesz specyfikację osoby pracującej nad tematem pokrewnym. Tematy pokrewne są
wskazane w [zestawieniu tematów](../tematy/README.md), a par dobiera prowadzący.

Recenzent odpowiada na pięć pytań:

1. Czy potrafisz z tej specyfikacji napisać program, nie znając artykułu?
2. Który warunek wstępny jest niesprawdzalny programowo?
3. Który symbol pojawia się we wzorze, ale nie ma definicji?
4. Co się stanie przy danych, o których specyfikacja milczy?
5. Które rozstrzygnięcie autora specyfikacji podjąłbyś inaczej i dlaczego?

Recenzja ma formę listy uwag, nie oceny. Autor rozstrzyga każdą uwagę: przyjmuje ją
albo uzasadnia odrzucenie. Rozstrzygnięcia zostają w historii repozytorium.

Pytanie pierwsze jest najważniejsze i zwykle najboleśniejsze. Specyfikacja, którą
rozumie tylko jej autor, nie jest specyfikacją, tylko notatką.

### Tydzień 27: audyt pakietu

Dostajesz cudzy pakiet i próbujesz go zepsuć. Instalujesz go od zera, na własnym
systemie, bez pomocy autora.

Audytor sprawdza i zapisuje w zgłoszeniu:

- czy pakiet instaluje się z repozytorium bez ręcznych poprawek,
- czy przykład z pliku `README` działa po skopiowaniu,
- czy da się doprowadzić do komunikatu o błędzie, który nic nie wyjaśnia,
- czy walidacja przepuszcza dane, których nie powinna,
- czy dokumentacja opisuje to, co funkcja rzeczywiście robi,
- czy aplikacja działa na innej przeglądarce niż ta, w której powstawała.

Znalezione usterki trafiają do zgłoszeń w repozytorium autora. Autor ma tydzień na
poprawki. Zgłoszenia i ich rozstrzygnięcia są materiałem do rozdziału drugiego pracy:
opis usterki znalezionej przez kogoś innego jest mocniejszym dowodem dojrzałości
projektu niż zapewnienie, że wszystko działa.

Audyt jest oceniany po stronie audytora, nie tylko autora. Audyt, który nie znalazł
niczego, oznacza, że audytor nie próbował.

## Konsultacje

Między zajęciami obowiązuje jedna zasada: **zanim zapytasz, przygotuj najkrótszy
przykład, który pokazuje problem**. Zwykle w trakcie przygotowywania takiego przykładu
problem się rozwiązuje sam, a jeżeli nie, odpowiedź przychodzi w kilka minut zamiast
w kilka dni.

Pytanie, na które da się odpowiedzieć, zawiera:

- co uruchomiłeś, w postaci kodu, który da się wkleić,
- co się stało, w postaci pełnego komunikatu,
- czego się spodziewałeś,
- co już sprawdziłeś.

Pytanie „nie działa mi solver" nie zawiera żadnego z tych elementów.

Sprawy dotyczące treści pracy omawiamy na konsultacjach, nie w blokach studia.
Blok studia służy pracy nad kodem, bo kod jest tym, co blokuje najczęściej i co
najłatwiej odblokować przy dwóch osobach patrzących w jeden ekran.

## Dla prowadzącego

Rytm czternastu osób utrzymuje się dzięki temu, że sprawdzanie jest rozłożone
w czasie i oparte na wynikach, które generują się same.

**Przegląd tygodniowy.** Ciągła integracja w repozytorium każdego pakietu daje
kolorowy wskaźnik stanu. Przegląd czternastu repozytoriów przed zajęciami to przegląd
czternastu wskaźników; wchodzisz tylko tam, gdzie świeci na czerwono dłużej niż
tydzień.

**Sprawdzanie kamieni milowych.** Warunki przyjęcia w [kamieniach
milowych](kamienie-milowe.md) są sformułowane jako lista kontrolna właśnie po to, żeby
sprawdzenie jednej osoby zajmowało kilka minut. Kamienie 2 i 4 sprawdzają się niemal
wyłącznie automatycznie: wynik `devtools::test()` i wynik sprawdzenia w trybie
zgodności.

**Przegląd tekstu.** Czternaście prac przeglądanych naraz w maju to sytuacja nie do
utrzymania. Harmonogram rozkłada to na trzy tury: rozdział pierwszy w tygodniach
9–11, rozdział drugi w 18–19, rozdział trzeci w 21–22. Każda tura obejmuje jeden
rozdział, więc czyta się czternaście razy ten sam typ tekstu, co jest znacznie
szybsze niż czternaście różnych.

**Tryb pracy z uwagami.** Warianty obiegu przez Overleaf, przez repozytorium i tryb
mieszany są w przewodniku [Overleaf i
współpraca](../przewodniki/03-overleaf.md). Na instalacji uczelnianej działają
komentarze w trybie przeglądu i historia zmian, nie ma natomiast śledzenia zmian.
Stąd zasada obiegu: prowadzący komentuje, student poprawia.

**Terminy w kalendarzu.** Harmonogram jest przypięty do numerów tygodni. Na początek
roku wystarczy raz przypisać tygodnie do dat i rozesłać tę tabelę; wszystkie
odesłania w materiałach seminarium pozostają wtedy aktualne.
