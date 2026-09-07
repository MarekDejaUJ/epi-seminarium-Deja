# Przewodnik seminaryjny

Gotowy do czytania: **[`przewodnik.pdf`](przewodnik.pdf)**.

Przewodnik prowadzi przez cały cykl seminarium — od pierwszego uruchomienia wzoru,
przez budowę pakietu i pisanie kolejnych rozdziałów, po kontrolę formalną przed
oddaniem pracy.

Dokument złożono tą samą klasą i tym samym stylem bibliograficznym, z których korzystają
prace studentów. Jest więc jednocześnie instrukcją i pełnowymiarowym przykładem działania
wzoru: każdy element opisany w rozdziale pierwszym występuje dalej w praktyce. Kiedy nie
pamiętasz zapisu, zajrzyj do źródła odpowiedniego rozdziału.

## Zawartość

| Rozdział | Temat | Kiedy czytać |
|---|---|---|
| 1 | LaTeX od podstaw | na początku, pierwsze dwa poziomy |
| 2 | Bibliografia i Zotero | przed pierwszą lekturą |
| 3 | Overleaf i współpraca | przy zakładaniu projektu |
| 4 | Jak napisać pracę | przy pisaniu każdej części |
| 5 | Warsztat pisania akademickiego | raz, na samym początku |
| 6 | Wymogi formalne | przed oddaniem |

## Kompilacja

```
cd przewodnik
latexmk -lualatex przewodnik.tex
```

Plik `latexmkrc` wskazuje katalog [`../wzor-pracy`](../wzor-pracy/), w którym leżą klasa
dokumentu i styl bibliograficzny. Dzięki temu wzór pozostaje samowystarczalny przy
wgrywaniu na Overleaf, a przewodnik nie powiela jego plików.
