# Seminarium licencjackie EPI

Materiały seminarium licencjackiego na kierunku **elektroniczne przetwarzanie
informacji**. Instytut Studiów Informacyjnych, Wydział Zarządzania i Komunikacji
Społecznej Uniwersytetu Jagiellońskiego. Prowadzący: dr Marek Deja.

Tematem seminarium jest tworzenie oprogramowania badawczego dla nauk społecznych.
Wybierasz artykuł metodyczny opisujący algorytm, implementujesz ten algorytm jako
pakiet języka R, publikujesz stronę z opisem metody i działającym narzędziem,
a następnie opisujesz całość w pracy licencjackiej.

Praca dyplomowa składa się więc z dwóch powiązanych części: projektu dyplomowego oraz
pracy licencjackiej, która ten projekt opisuje. Zaliczenie seminarium następuje po
przyjęciu projektu.

## Od zera do obrony

Ścieżka ułożona w kolejności, w jakiej naprawdę się ją przechodzi.

**1. Zanim napiszesz pierwsze zdanie.** Przeczytaj [warsztat pisania
akademickiego](przewodniki/05-warsztat.md) i sformułuj pytanie analityczne. To jedyna
rzecz, której nie da się nadrobić później.

**2. Wybierz temat.** Czternaście [tematów](tematy/README.md), po jednym na osobę.
Każdy ma brief prowadzący od artykułu do gotowego pakietu.

**3. Postaw środowisko.** [Overleaf albo Positron](przewodniki/03-overleaf.md) dla
pracy, [narzędzia programistyczne](przewodniki/07-agent-cli.md) dla pakietu.

**4. Naucz się składu.** [LaTeX od podstaw](przewodniki/01-latex.md) – jeden wieczór
wystarczy, żeby zacząć pisać. Zapisu każdego elementu szukaj w
[przykładzie](wzor-pracy/README.md).

**5. Uruchom bibliografię.** [Plik BibTeX i Zotero](przewodniki/02-bibliografia.md).
Skonfiguruj to **przed** pierwszą lekturą, nie po dwudziestej.

**6. Napisz specyfikację.** [Szablon](szablony/spec/SPEC-szablon.md) i
[szkielet pakietu](szablony/README.md). Kod pisze się dopiero po tym kroku.

**7. Pisz i buduj równolegle.** [Harmonogram trzydziestu
tygodni](harmonogram/tygodnie.md) mówi, co ma powstać w którym tygodniu po obu
stronach. Wskazówki do każdej części pracy są w przewodniku [Jak napisać
pracę](przewodniki/04-jak-pisac.md).

**8. Sprawdź się przed oddaniem.** [Listy kontrolne](ocenianie/listy-kontrolne.md)
i [wymogi formalne](przewodniki/06-wymogi.md).

**9. Przygotuj się do obrony.** [Pytania](ocenianie/pytania-na-obrone.md) sprawdzające,
czy rozumiesz to, co oddajesz.

## Zawartość

| Katalog | Zawartość |
|---|---|
| [Wzór pracy](wzor-pracy/README.md) | wzór w LaTeX ze stylem bibliograficznym zgodnym z wymaganiami Instytutu oraz wypełniony przykład |
| [Przewodnik](przewodniki/README.md) | osiem rozdziałów: LaTeX, bibliografia, Overleaf, pisanie pracy, warsztat, wymogi formalne, praca z narzędziami, jawność użycia |
| [Szablony](szablony/README.md) | szkielet pakietu R przechodzący sprawdzenie w trybie zgodności, szablon specyfikacji, materiały do pracy z narzędziem |
| [Tematy](tematy/README.md) | czternaście briefów wraz z bibliografią źródłową i notą o doborze tematów |
| [Harmonogram](harmonogram/README.md) | trzydzieści tygodni, sześć kamieni milowych, przebieg zajęć |
| [Ocenianie](ocenianie/README.md) | rubryki projektu i pracy, listy kontrolne, pytania na obronę |

Cały przewodnik w jednym pliku, do druku: [przewodnik.pdf](przewodnik/przewodnik.pdf).

## Wymagania formalne

Wzór realizuje wymagania dwóch dokumentów Instytutu: *Standardów prac dyplomowych na
kierunku EPI* oraz *Instrukcji ISI* w części dotyczącej składu, przypisów i opisów
bibliograficznych. Przy rozbieżnościach o układzie rozdziałów rozstrzygają Standardy
EPI, o zapisie bibliografii – Instrukcja ISI.

## Zasada, o której warto wiedzieć od pierwszego dnia

Narzędzia programistyczne wolno stosować przy budowie aplikacji, pod warunkiem pełnej
jawności: każde polecenie trafia do rejestru, a rejestr do aneksu pracy. W tekście
pracy wolno ich używać wyłącznie do poprawiania tekstu, który już napisałeś. Żaden
fragment pracy nie może zostać wygenerowany, a powołań i opisów bibliograficznych nie
generuje się w ogóle.

Pełne omówienie: [Jawność i odpowiedzialność](przewodniki/08-etyka-si.md).
