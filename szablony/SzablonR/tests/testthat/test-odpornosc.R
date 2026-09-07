# Warstwa trzecia: dane, przy ktorych metoda nie ma sensu.
#
# Oczekiwanym wynikiem nie jest tu poprawna liczba, lecz zatrzymanie wykonania
# z czytelnym komunikatem. Funkcja, ktora na takich danych zwraca wynik,
# jest grozniejsza od tej, ktora odmawia dzialania.

test_that("brak danych w macierzy zatrzymuje wykonanie", {
  m <- cbind(a = c(1, NA, 3), b = c(2, 2, 2))

  expect_error(oblicz_wagi_entropia(m), "braki danych")
  expect_error(oblicz_ranking(m), "braki danych")
})

test_that("wartosci nieskonczone zatrzymuja wykonanie", {
  m <- cbind(a = c(1, Inf, 3), b = c(2, 2, 2))

  expect_error(oblicz_wagi_entropia(m), "nieskonczone")
})

test_that("wartosci ujemne zatrzymuja wykonanie", {
  # Normalizacja sumacyjna wymaga nieujemnosci; przy wartosciach ujemnych
  # udzialy przestaja byc prawdopodobienstwami i entropia traci sens.
  m <- cbind(a = c(-1, 2, 3), b = c(2, 2, 2))

  expect_error(oblicz_wagi_entropia(m), "ujemne")
})

test_that("kryterium o zerowej sumie zatrzymuje wykonanie", {
  m <- cbind(a = c(0, 0, 0), b = c(1, 2, 3))

  expect_error(oblicz_wagi_entropia(m), "dodatnia sume")
})

test_that("pojedyncza alternatywa zatrzymuje wykonanie metod wazenia", {
  m <- matrix(c(1, 2), nrow = 1)

  expect_error(oblicz_wagi_entropia(m), "dwoch alternatyw")
  expect_error(oblicz_wagi_std(m), "dwoch alternatyw")
})

test_that("niepoprawny typ argumentu zatrzymuje wykonanie", {
  expect_error(oblicz_wagi_entropia(data.frame(a = 1:3)), "liczbowa macierza")
  expect_error(oblicz_wagi_entropia("tekst"), "liczbowa macierza")
  expect_error(skaluj_min_max("tekst"), "liczbowym")
})

test_that("niepoprawny kierunek optymalizacji zatrzymuje wykonanie", {
  m <- cbind(a = c(1, 2), b = c(3, 4))

  expect_error(oblicz_ranking(m, kierunki = c("max", "srednia")), "Dozwolone kierunki")
  expect_error(oblicz_ranking(m, kierunki = "max"), "dlugosci 2")
})

test_that("niepoprawne wagi zatrzymuja wykonanie", {
  m <- cbind(a = c(1, 2), b = c(3, 4))

  expect_error(oblicz_ranking(m, wagi = c(1, 2, 3)), "dlugosc 2")
  expect_error(oblicz_ranking(m, wagi = c(-1, 2)), "ujemne")
  expect_error(oblicz_ranking(m, wagi = c(0, 0)), "dodatnia")
  expect_error(oblicz_ranking(m, wagi = "nieistniejaca"), "arg")
})

test_that("wykres udzialow odrzuca obiekt niewlasciwej klasy", {
  expect_error(wykres_udzialow(list()), "ranking_epi")
})

test_that("macierz bez nazw kolumn otrzymuje nazwy zastepcze", {
  m <- matrix(c(1, 2, 3, 4), nrow = 2)

  expect_named(oblicz_wagi_entropia(m), c("kryterium_1", "kryterium_2"))
})
