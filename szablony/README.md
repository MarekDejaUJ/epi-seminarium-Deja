# Szablony

| Katalog | Zawartość |
|---|---|
| [`SzablonR/`](SzablonR/) | szkielet pakietu R przechodzący sprawdzenie w trybie zgodności z CRAN |
| [`spec/`](spec/SPEC-szablon.md) | szablon dokumentu `SPEC.md` – kontraktu algorytmu spisywanego przed kodem |
| [`agent/`](agent/) | pliki do pracy z narzędziem wspomagającym: instrukcje repozytorium, szablony poleceń, rejestr |

## Kolejność pracy

1. **`SPEC.md`** – przeczytaj artykuł źródłowy i spisz kontrakt: wejście, warunki
   wstępne, kroki algorytmu, wyjście, niezmienniki, przypadki o znanym wyniku.
   Ten dokument jest jednocześnie materiałem do rozdziału pierwszego pracy.
2. **Testy** – z przypadków wypisanych w specyfikacji zrób testy. Piszesz je
   przed implementacją, bo test napisany po kodzie sprawdza kod, a nie metodę.
3. **Implementacja** – dopiero teraz. Skopiuj `SzablonR/`, zmień nazwę
   i podmieniaj moduł po module.
4. **Dokumentacja** – bloki `roxygen2` i winieta prowadząca przez pełną ścieżkę
   analizy.

Odwrócenie tej kolejności jest najczęstszą przyczyną tego, że narzędzie działa,
ale nie wiadomo, czy poprawnie.

## Szkielet pakietu

`SzablonR/` nie jest gotowym narzędziem, tylko układem odniesienia. Metoda
w nim zaimplementowana jest celowo prosta – ważona suma znormalizowanych ocen – 
żeby każdy wynik dało się policzyć ręcznie, a więc żeby testy mogły sprawdzać
poprawność, a nie tylko niezmienność.

Stan wyjściowy: **0 błędów, 0 ostrzeżeń, 0 uwag** w `R CMD check --as-cran`,
126 przechodzących testów, sprawdzanie na macOS, Windows i Linuksie przez
ciągłą integrację. Twoim zadaniem jest utrzymać ten stan, podmieniając treść.

Do tego gotowy serwis wymagany Standardami: dokumentacja funkcji, opis algorytmu
z wzorami i cytowaniami, nota z Załącznika nr 2 oraz aplikacja działająca
w przeglądarce bez serwera R. Serwis buduje i publikuje przepływ pracy, więc
osiemdziesięciomegabajtowy eksport nie trafia do historii repozytorium.

Szczegóły: [`SzablonR/README.md`](SzablonR/README.md).
