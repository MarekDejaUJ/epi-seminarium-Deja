# Kontrola zawartosci listingow kodu.
#
# Wnetrze listingu sklada sie wylacznie ze znakow ASCII. Pakiet listings ma
# tablice znakow obejmujaca tylko ASCII, wiec znaki polskie wewnatrz listingu
# wychodza przestawione. To samo ograniczenie naklada sprawdzanie pakietu R,
# ktore zglasza znaki spoza ASCII w kodzie zrodlowym jako problem przenosnosci.
#
# Uruchomienie z katalogu wzor-pracy:
#   Rscript tools/sprawdz-listingi.R

pliki <- list.files(c(".", "rozdzialy"), pattern = "\\.tex$", full.names = TRUE)
pliki <- unique(normalizePath(pliki))

znajdz_naruszenia <- function(plik) {
  linie <- readLines(plik, encoding = "UTF-8", warn = FALSE)
  w_listingu <- FALSE
  wynik <- list()

  for (i in seq_along(linie)) {
    linia <- linie[[i]]

    if (grepl("\\\\begin\\{lstlisting\\}", linia)) {
      w_listingu <- TRUE
      next
    }
    if (grepl("\\\\end\\{lstlisting\\}", linia)) {
      w_listingu <- FALSE
      next
    }
    if (!w_listingu) next

    znaki <- strsplit(linia, "")[[1]]
    if (!length(znaki)) next
    poza_ascii <- utf8ToInt(linia) > 127
    if (any(poza_ascii)) {
      obce <- unique(znaki[poza_ascii])
      wynik[[length(wynik) + 1L]] <- data.frame(
        plik = plik, linia = i,
        znaki = paste(obce, collapse = " "),
        tresc = trimws(linia),
        stringsAsFactors = FALSE
      )
    }
  }
  if (length(wynik)) do.call(rbind, wynik) else NULL
}

naruszenia <- do.call(rbind, lapply(pliki, znajdz_naruszenia))

if (is.null(naruszenia)) {
  message("Listingi zawieraja wylacznie znaki ASCII.")
} else {
  message("Znaki spoza ASCII wewnatrz listingow:\n")
  for (i in seq_len(nrow(naruszenia))) {
    message(sprintf("  %s:%d  [%s]  %s",
                    basename(naruszenia$plik[i]), naruszenia$linia[i],
                    naruszenia$znaki[i], naruszenia$tresc[i]))
  }
  message("\nZastap znaki polskie odpowiednikami bez znakow diakrytycznych.")
  quit(status = 1L)
}
