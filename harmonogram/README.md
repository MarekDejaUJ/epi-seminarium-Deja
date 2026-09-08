# Harmonogram

Seminarium trwa trzydzieści tygodni: piętnaście w semestrze zimowym i piętnaście
w letnim. Przez cały ten czas prowadzisz dwa przedsięwzięcia naraz. Budujesz pakiet
i piszesz o nim pracę.

To nie są dwie osobne rzeczy, z których jedna wypada wcześniej, a druga później.
Praca licencjacka na tym kierunku opisuje projekt dyplomowy, więc jeżeli projekt
powstanie w listopadzie, a opis w maju, opis będzie rekonstrukcją z pamięci. Rozdział
drugi pisze się dobrze wtedy, gdy pisze się go tydzień po tym, jak się podjęło
opisywane decyzje.

Dlatego każdy tydzień ma produkt po obu stronach.

## Trzy dokumenty

| Dokument | Do czego służy |
|---|---|
| [Trzydzieści tygodni](tygodnie.md) | co robisz w danym tygodniu, po stronie pakietu i po stronie pracy |
| [Kamienie milowe](kamienie-milowe.md) | sześć punktów kontrolnych z warunkami zaliczenia |
| [Przebieg zajęć](zajecia.md) | jak wygląda spotkanie, czego dotyczy część wykładowa, jak działa przegląd wzajemny |

## Zasada nadrzędna

Kolejność jest zawsze ta sama: **specyfikacja, testy, implementacja, dokumentacja**.
Nie da się jej skrócić i nie opłaca się jej odwracać. Wyjaśnienie, dlaczego odwrotna
kolejność zawodzi, jest w [przewodniku o pracy z agentem
programistycznym](../przewodniki/07-agent-cli.md#dlaczego-odwrotna-kolejność-zawodzi).

Harmonogram jest zbudowany wokół tej kolejności. Pierwsze sześć tygodni nie zawiera
ani jednej linii kodu obliczeniowego i to jest zamierzone.

## Ramy kalendarzowe

Numeracja tygodni liczy się od pierwszego spotkania seminaryjnego w październiku
2026 roku. Kolumna z miesiącem podaje przybliżone umiejscowienie tygodnia
w kalendarzu; dokładne daty rozpoczęcia semestrów, sesji i przerw wynikają
z zarządzenia o organizacji roku akademickiego i mogą przesunąć poszczególne tygodnie
o jeden w przód lub w tył. Kamienie milowe są przypisane do numerów tygodni, nie do dat.

Obrona odbywa się w sesji letniej lub we wrześniu 2027 roku. Rok na stronie tytułowej
wpisujesz zgodnie z rokiem obrony.

## Kiedy wypadniesz z rytmu

Wypadniesz. Każdy wypada, zwykle w okolicach dziesiątego tygodnia, kiedy rdzeń
obliczeniowy nie chce się zbiegać, a termin części pierwszej pracy jest już blisko.

Reguła jest wtedy taka: **nadrabiasz ścieżkę pisania, nie ścieżkę kodu**. Tekst
napisany z tygodniowym opóźnieniem jest tak samo dobry jak napisany w terminie. Kod
napisany w pośpiechu, bez testów, zabiera potem trzy tygodnie na odkręcenie i zwykle
i tak trzeba go napisać drugi raz.

Jeżeli obsuwa przekracza dwa tygodnie, zgłoś to na konsultacjach, zanim minie trzeci.
Zakres da się zawęzić – wariant metody, liczba obsługiwanych przypadków, rozmiar
studium przypadku. Zawężenie zakresu uzgodnione w marcu jest decyzją projektową
i opisuje się je w pracy. To samo zawężenie odkryte w czerwcu jest brakiem.

## Co prowadzisz od pierwszego dnia

| Co | Gdzie | Dlaczego |
|---|---|---|
| plik bibliograficzny | katalog `bibliografia/` w repozytorium pracy | odtwarzanie po fakcie zajmuje kilka dni |
| rejestr poleceń wydanych agentowi | repozytorium pakietu | wymagany w aneksie, nie da się odtworzyć z pamięci |
| dziennik decyzji projektowych | plik `NEWS.md` albo osobna notatka | rozdział drugi to w dużej części ten dziennik |

Trzeci punkt bywa lekceważony. Kiedy w kwietniu piszesz, dlaczego wybrałeś jeden
wariant algorytmu zamiast drugiego, pamiętasz już tylko, że wybrałeś. Powód znika
w ciągu dwóch tygodni.
