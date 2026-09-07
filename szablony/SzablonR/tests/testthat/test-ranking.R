# Ranking: przypadki o znanym wyniku, wlasnosci algebraiczne oraz odtworzenie
# struktury zapisanej w procedurze generowania danych.

test_that("przy jednym kryterium ranking odtwarza porzadek ocen", {
  m <- matrix(c(1, 5, 3), ncol = 1,
              dimnames = list(c("A", "B", "C"), "k"))

  wynik <- oblicz_ranking(m, wagi = "rowne")

  expect_equal(wynik$wynik$alternatywa, c("B", "C", "A"))
  expect_equal(wynik$wynik$pozycja, 1:3)
})

test_that("kierunek min odwraca porzadek", {
  m <- matrix(c(1, 5, 3), ncol = 1,
              dimnames = list(c("A", "B", "C"), "k"))

  wynik <- oblicz_ranking(m, wagi = "rowne", kierunki = "min")

  expect_equal(wynik$wynik$alternatywa, c("A", "C", "B"))
})

test_that("wskaznik przy rownych wagach jest srednia znormalizowanych ocen", {
  m <- cbind(a = c(0, 10), b = c(10, 0))
  rownames(m) <- c("A", "B")

  wynik <- oblicz_ranking(m, wagi = "rowne")

  # Po normalizacji obie alternatywy maja 0 i 1, wiec wskaznik wynosi 0,5.
  expect_equal(wynik$wynik$wskaznik, c(0.5, 0.5))
})

test_that("wlasne wagi sa normalizowane do sumy jeden", {
  m <- cbind(a = c(1, 2), b = c(3, 4))

  wynik <- oblicz_ranking(m, wagi = c(2, 6))

  expect_equal(unname(wynik$wagi), c(0.25, 0.75))
})


# Wlasnosci

test_that("ranking nie zalezy od kolejnosci wierszy wejscia", {
  m <- cbind(a = c(2, 5, 9), b = c(4, 4, 7))
  rownames(m) <- c("A", "B", "C")

  pierwotny <- oblicz_ranking(m, wagi = "entropia")
  przestawiony <- oblicz_ranking(m[c(3, 1, 2), , drop = FALSE], wagi = "entropia")

  expect_equal(pierwotny$wynik, przestawiony$wynik)
})

test_that("ranking nie zmienia sie po przeskalowaniu kryterium", {
  # Normalizacja min-max i wagi entropii sa niezmiennicze wzgledem mnozenia
  # kolumny przez dodatnia stala, wiec zmiana jednostki nie moze zmienic wyniku.
  m <- cbind(a = c(2, 5, 9), b = c(4, 4, 7))
  rownames(m) <- c("A", "B", "C")
  przeskalowana <- m
  przeskalowana[, "a"] <- przeskalowana[, "a"] * 100

  expect_equal(
    oblicz_ranking(m)$wynik,
    oblicz_ranking(przeskalowana)$wynik
  )
})

test_that("wskaznik miesci sie w przedziale jednostkowym", {
  set.seed(7)
  for (i in 1:20) {
    m <- matrix(runif(15, 0.5, 20), nrow = 5)
    wskazniki <- oblicz_ranking(m)$wynik$wskaznik
    expect_true(all(wskazniki >= 0 & wskazniki <= 1))
  }
})


# Odtworzenie struktury z procedury generowania danych

test_that("ranking odtwarza ukryta jakosc zapisana w danych", {
  # Procedura generowania nadaje alternatywom malejaca ukryta jakosc od A do F.
  # Poprawna implementacja musi ustawic je w tej kolejnosci, gdy kryterium
  # kosztowe zostanie zadeklarowane jako minimalizowane.
  model <- "Koszt   =~ koszt_surowce + koszt_praca
            Jakosc  =~ jakosc_trwalosc + jakosc_ux
            Dostawa =~ dostawa_niezawodnosc
            Rozwoj  =~ eko_co2 + eko_odpady"

  macierz <- przygotuj_dane(dane_przykladowe, model)
  wynik <- oblicz_ranking(macierz, wagi = "rowne",
                          kierunki = c("min", "max", "max", "max"))

  expect_equal(wynik$wynik$alternatywa, LETTERS[1:6])
})

test_that("metody generyczne dzialaja na obiekcie wyniku", {
  macierz <- przygotuj_dane(dane_przykladowe, "Jakosc =~ jakosc_trwalosc")
  wynik <- oblicz_ranking(macierz)

  expect_output(print(wynik), "Ranking alternatyw")
  expect_output(podsumowanie <- summary(wynik), "Wagi kryteriow")
  expect_named(podsumowanie, c("wynik", "wagi", "rozpietosc"))
  expect_s3_class(plot(wynik), "ggplot")
  expect_s3_class(wykres_udzialow(wynik), "ggplot")
  expect_output(print(macierz), "Macierz decyzyjna")
})
