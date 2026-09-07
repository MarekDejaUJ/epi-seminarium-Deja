# Objetosc czesci zasadniczej pracy.
#
# Instrukcja ISI ogranicza tekst od pierwszej strony Wstepu do ostatniej strony
# Wnioskow do 40 stron znormalizowanych, czyli 72 000 znakow ze spacjami.
#
# Skrypt liczy znaki w plikach rozdzialow po usunieciu polecen LaTeX-a,
# komentarzy, listingow, wzorow i srodowisk tabelarycznych. Wynik jest
# przyblizeniem od gory - realna objetosc bywa nieco mniejsza.
#
# Uruchomienie z katalogu wzor-pracy:
#   Rscript tools/policz_znaki.R

LIMIT <- 72000

pliki <- c(
  "rozdzialy/00-wprowadzenie.tex",
  "rozdzialy/01-podstawy.tex",
  "rozdzialy/02-implementacja.tex",
  "rozdzialy/03-studium-przypadku.tex",
  "rozdzialy/04-podsumowanie.tex"
)
pliki <- pliki[file.exists(pliki)]

oczysc <- function(tekst) {
  tekst <- paste(tekst, collapse = "\n")
  # srodowiska, ktorych tresc nie jest tekstem ciaglym
  for (srodowisko in c("lstlisting", "equation", "align", "tabular", "tabularx",
                       "verbatim", "comment")) {
    wzorzec <- sprintf("\\\\begin\\{%s\\*?\\}.*?\\\\end\\{%s\\*?\\}",
                       srodowisko, srodowisko)
    tekst <- gsub(wzorzec, "", tekst, perl = TRUE)
  }
  tekst <- gsub("(?<!\\\\)%.*?(?=\n)", "", tekst, perl = TRUE)  # komentarze
  tekst <- gsub("\\$[^$]*\\$", "", tekst)                        # wzory w linii
  tekst <- gsub("\\\\[a-zA-Z@]+\\*?(\\[[^]]*\\])?", "", tekst)   # polecenia
  tekst <- gsub("[{}]", "", tekst)
  tekst <- gsub("[ \t]+", " ", tekst)
  tekst <- gsub("\n{2,}", "\n", tekst)
  trimws(tekst)
}

if (!length(pliki)) {
  message("Nie znaleziono plikow rozdzialow.")
  quit(status = 0L)
}

zestawienie <- data.frame(
  plik = basename(pliki),
  znaki = vapply(pliki, function(p) {
    nchar(oczysc(readLines(p, encoding = "UTF-8", warn = FALSE)))
  }, numeric(1)),
  stringsAsFactors = FALSE
)

razem <- sum(zestawienie$znaki)

message("Objetosc czesci zasadniczej (znaki ze spacjami):\n")
for (i in seq_len(nrow(zestawienie))) {
  message(sprintf("  %-32s %7d", zestawienie$plik[i], zestawienie$znaki[i]))
}
message(sprintf("\n  %-32s %7d", "razem", razem))
message(sprintf("  %-32s %7d", "limit", LIMIT))
message(sprintf("  %-32s %7.1f%%", "wykorzystanie", 100 * razem / LIMIT))

if (razem > LIMIT) {
  message("\nPrzekroczony limit z Instrukcji ISI. Skroc czesc zasadnicza.")
  quit(status = 1L)
}
