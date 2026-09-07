<!-- Pliki w tym katalogu powstaja automatycznie z przewodnik/rozdzialy/.
     Zmiany nanos w plikach zrodlowych, nie tutaj. -->

# Przewodnik seminaryjny

Przewodnik prowadzi przez cały cykl seminarium – od pierwszego uruchomienia
wzoru, przez budowę pakietu i pisanie kolejnych rozdziałów, po kontrolę formalną
przed oddaniem pracy.

Całość w jednym pliku, do druku: **[przewodnik.pdf](../przewodnik/przewodnik.pdf)**.

| Rozdział | Temat | Kiedy czytać |
|---|---|---|
| 1 | [LaTeX od podstaw](01-latex.md) | na początku, pierwsze dwa poziomy |
| 2 | [Bibliografia: plik BibTeX i Zotero](02-bibliografia.md) | przed pierwszą lekturą |
| 3 | [Overleaf i współpraca](03-overleaf.md) | przy zakładaniu projektu |
| 4 | [Jak napisać pracę](04-jak-pisac.md) | przy pisaniu każdej części |
| 5 | [Warsztat pisania akademickiego](05-warsztat.md) | raz, na samym początku |
| 6 | [Wymogi formalne](06-wymogi.md) | przed oddaniem |

## Skąd się biorą te pliki

Źródłem treści są pliki LaTeX w katalogu [`przewodnik/`](../przewodnik/),
składane tą samą klasą, z której korzystają prace studentów. Wersja w Markdown
powstaje z nich automatycznie:

```bash
python przewodnik/tools/generuj_md.py
```

Dzięki temu obie wersje mówią to samo. Poprawki nanoś w plikach `.tex`.
