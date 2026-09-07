# Rubryka projektu dyplomowego

Projekt to pakiet, serwis i aplikacja razem wzięte. Ocena składa się z pięciu
składników. Sto punktów, przełożenie na ocenę według [skali](README.md#skala).

| Składnik | Punkty |
|---|---|
| [Specyfikacja](#specyfikacja) | 20 |
| [Weryfikacja: testy i dane](#weryfikacja-testy-i-dane) | 25 |
| [Jakość pakietu i zgodność](#jakość-pakietu-i-zgodność) | 25 |
| [Dokumentacja i serwis](#dokumentacja-i-serwis) | 20 |
| [Jawność pracy z narzędziem](#jawność-pracy-z-narzędziem) | 10 |

Dwa warunki poza punktacją. Projekt nie zostaje przyjęty, jeżeli sprawdzenie pakietu
kończy się błędem albo jeżeli aplikacja nie działa pod podanym adresem. Są to warunki
zerojedynkowe, nie składniki oceny.

## Specyfikacja

Oceniany jest plik `SPEC.md` w wersji z tygodnia 6 wraz z jego późniejszymi zmianami.
Zmiany są zjawiskiem pożądanym: specyfikacja, która przez trzydzieści tygodni nie
drgnęła, zwykle znaczy, że nikt do niej nie zaglądał.

| Punkty | Opis |
|---|---|
| 18–20 | Kontrakt kompletny i sprawdzalny. Wszystkie symbole zdefiniowane. Niedopowiedzenia artykułu wypisane wraz z rozstrzygnięciem i jego uzasadnieniem. Zmiany specyfikacji w trakcie roku opatrzone powodem. |
| 14–17 | Kontrakt kompletny. Pojedyncze warunki wstępne sformułowane nieostro. Niedopowiedzenia wypisane, rozstrzygnięcia bez uzasadnienia. |
| 10–13 | Wejście, wyjście i błędy opisane, niezmienniki niepełne. Specyfikacja nadąża za kodem zamiast go wyprzedzać. |
| 5–9 | Opis ogólny bez kontraktu. Nie da się z niej odtworzyć zachowania programu. |
| 0–4 | Brak albo streszczenie artykułu zamiast specyfikacji. |

## Weryfikacja: testy i dane

Najwyżej punktowany składnik, bo rozstrzyga o tym, czy komukolwiek wolno zaufać
wynikom Twojego pakietu.

| Punkty | Opis |
|---|---|
| 22–25 | Przypadki analityczne policzone ręcznie z rachunkiem w komentarzu. Każdy niezmiennik ma test. Procedura generowania danych zwraca znany prawdziwy wynik, więc mierzalne są obciążenie i trafność. Jest wariant danych naruszających założenia. Testy powstały przed implementacją, co widać w historii repozytorium. |
| 17–21 | Komplet testów, w tym przypadki analityczne i odpornościowe. Dane generowane ze znanym wynikiem. Kolejność powstawania częściowo odwrócona. |
| 12–16 | Testy pokrywają główną ścieżkę i podstawowe błędy. Brak przypadków analitycznych albo brak danych o znanym wyniku. |
| 6–11 | Testy sprawdzają, że funkcja się wykonuje i zwraca obiekt właściwego typu. |
| 0–5 | Testy szczątkowe albo napisane po fakcie do pustego przebiegu. |

Test sprawdzający, że wynik ma trzy pola i jest liczbą, nie jest testem metody. Jest
testem typu. Rozróżnienie to decyduje o miejscu w tej tabeli.

## Jakość pakietu i zgodność

| Punkty | Opis |
|---|---|
| 22–25 | Sprawdzenie w trybie zgodności czyste na trzech systemach, ciągła integracja zielona. Kod wektorowy tam, gdzie to możliwe, z pomiarem przed i po. Klasy S3 z pełnym zestawem metod. Obsługa błędów przez komunikaty mówiące, co zrobić. |
| 17–21 | Sprawdzenie czyste, ciągła integracja skonfigurowana. Wydajność wystarczająca na dane ze studium przypadku. |
| 12–16 | Sprawdzenie z pojedynczymi uwagami, każda z uzasadnieniem. Struktura pakietu poprawna. |
| 6–11 | Pakiet instaluje się i działa, sprawdzenie zgłasza ostrzeżenia. |
| 0–5 | Pakiet wymaga ręcznych zabiegów, żeby się zainstalował. |

## Dokumentacja i serwis

Składnik obejmuje dokumentację funkcji, winietę oraz publiczny serwis projektu wraz
z aplikacją.

| Punkty | Opis |
|---|---|
| 18–20 | Każda funkcja eksportowana opisana z argumentami, wynikiem i działającym przykładem. Winieta prowadzi przez pełny przepływ analizy. Serwis zawiera opis algorytmu z powołaniami i bibliografią zgodną z pracą. Aplikacja przyjmuje dane użytkownika, pozwala zmieniać parametry i czytelnie obsługuje błędy. Nota wymagana przez Standardy obecna. |
| 14–17 | Dokumentacja kompletna, winieta obecna, serwis i aplikacja działają. Opis algorytmu skrótowy albo bibliografia niepełna. |
| 10–13 | Dokumentacja funkcji kompletna, serwis ogranicza się do dokumentacji. Aplikacja działa na danych wbudowanych. |
| 5–9 | Dokumentacja szczątkowa. Serwis albo aplikacja niedostępne pod stałym adresem. |
| 0–4 | Brak serwisu. |

Aplikacja, która wyświetla wynik policzony wcześniej i nie pozwala zmienić niczego,
nie spełnia wymogu Standardów i nie może dostać więcej niż dziewięć punktów,
niezależnie od tego, jak wygląda.

## Jawność pracy z narzędziem

| Punkty | Opis |
|---|---|
| 9–10 | Rejestr poleceń prowadzony od pierwszego tygodnia, z celem, poleceniem, wprowadzoną zmianą i sposobem weryfikacji. Widoczne miejsca, w których narzędzie się pomyliło, i opis, co je wykryło. |
| 7–8 | Rejestr kompletny, bez opisu weryfikacji. |
| 4–6 | Rejestr uzupełniony pod koniec roku, ogólnikowy. |
| 1–3 | Rejestr szczątkowy. |
| 0 | Brak rejestru przy widocznym użyciu narzędzia. |

Wpisy pokazujące pomyłkę narzędzia są punktowane wyżej niż wpisy pokazujące same
sukcesy. Rejestr, w którym wszystko udało się za pierwszym razem, jest niewiarygodny,
a jego jedyną funkcją byłoby wypełnienie wymogu.

## Kamienie milowe

Punktacja dotyczy stanu na tydzień 26. Kamienie milowe nie dają punktów, ale
opóźnienie ma skutek:

| Sytuacja | Skutek |
|---|---|
| kamień milowy przyjęty w terminie | bez zmian |
| przyjęty z opóźnieniem do dwóch tygodni | bez zmian |
| przyjęty z opóźnieniem powyżej dwóch tygodni | zawężenie zakresu uzgodnione i opisane w pracy |
| kamień milowy 5 nieprzyjęty | brak zaliczenia seminarium |

Zawężenie zakresu nie obniża oceny. Obniża ją zawężenie ukryte, czyli praca opisująca
metodę w pełnej postaci i pakiet realizujący jej połowę.
