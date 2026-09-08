# Instrukcje dla agenta

Plik kopiujesz do repozytorium swojego pakietu i uzupełniasz miejsca w nawiasach
kwadratowych. Agent czyta go przy każdym uruchomieniu, dzięki czemu nie musisz
powtarzać konwencji projektu w każdym poleceniu.

Umieść go w miejscu, w którym Twój agent szuka instrukcji projektowych – dla agenta
zalecanego w seminarium jest to `.github/copilot-instructions.md`. Jeżeli korzystasz
z innego programu, sprawdź w jego dokumentacji i użyj tej samej treści.

---

## Kontekst projektu

Pakiet języka R implementujący metodę opisaną w artykule: **[autor, rok, tytuł]**.
Powstaje jako projekt dyplomowy na kierunku elektroniczne przetwarzanie informacji
w Instytucie Studiów Informacyjnych Uniwersytetu Jagiellońskiego.

Kontrakt algorytmu jest w pliku `SPEC.md`. **To jest dokument nadrzędny wobec kodu.**
Gdy kod i specyfikacja się rozchodzą, błąd jest w kodzie.

## Konwencje

- Nazwy funkcji i argumentów po polsku, wyłącznie znakami ASCII, bez znaków
  diakrytycznych: `przygotuj_dane`, `oblicz_wagi_entropia`.
- Nazwy funkcji czasownikowe. Funkcje pomocnicze bez eksportu.
- Treść dokumentacji i komunikatów błędów po polsku, w UTF-8.
- Pola pliku `DESCRIPTION` bez znaków diakrytycznych.
- Komentarze w kodzie bez znaków diakrytycznych: kod trafia do listingów w pracy,
  a pakiet składający listingi obsługuje tylko ASCII.
- Obliczenia na wektorach i macierzach, nie w pętlach po wierszach.
- Wynik metody jest obiektem klasy S3 z metodami `print`, `summary` i `plot`.

## Czego nie wolno zmieniać bez mojej decyzji

Te pliki zawierają ustalenia metodyczne, a nie implementację:

- `SPEC.md` – kontrakt algorytmu,
- `tests/` – wszystkie testy,
- `data-raw/` – procedura generowania danych,
- `DESCRIPTION` – w szczególności lista zależności.

Jeżeli uważasz, że test jest błędny, **napisz o tym zamiast go poprawiać**.
Jeżeli rozwiązanie wymaga nowej zależności, **zapytaj zamiast ją dodawać**.

## Czego wymagam po każdej zmianie

1. Uruchom `devtools::test()` i pokaż wynik.
2. Jeżeli testy nie przechodzą, popraw **kod**, nie test.
3. Przy zmianie sygnatury funkcji zaktualizuj blok dokumentacyjny.
4. Nie usuwaj sprawdzeń warunków wstępnych ani nie zamieniaj błędów na ostrzeżenia.

## Kontrakt błędów

Funkcja publiczna sprawdza warunki wstępne **na początku**, przed jakimkolwiek
obliczeniem. Naruszenie warunku zatrzymuje wykonanie komunikatem, który mówi,
co jest nie tak i co poprawić. Komunikat po polsku, bez znaków diakrytycznych,
z `call. = FALSE`.

Zwrócenie wyniku dla danych spoza dziedziny jest gorsze niż odmowa działania.

## Zakres pracy

Pracujesz w plikach `R/` oraz w blokach dokumentacyjnych. Nie piszesz tekstu pracy
dyplomowej, nie tworzysz opisów bibliograficznych i nie proponujesz powołań na
literaturę.

## Cel jakościowy

`R CMD check --as-cran` z wynikiem zero błędów, zero ostrzeżeń, zero uwag,
na systemach macOS, Windows i Linux.
