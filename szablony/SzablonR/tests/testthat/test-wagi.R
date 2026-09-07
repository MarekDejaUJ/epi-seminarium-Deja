# Warstwa pierwsza: przypadki o wyniku policzonym recznie.
#
# Kazdy z ponizszych testow ma znany wynik wyprowadzony ze wzoru, a nie
# zapisany po uruchomieniu kodu. Test, ktorego oczekiwana wartosc pochodzi
# z wlasnej implementacji, sprawdza jedynie, czy implementacja sie nie zmienila.

test_that("kryterium o stalej wartosci otrzymuje wage zero", {
  # Kolumna stala ma entropie rowna jednosci, wiec jej rozbieznosc wynosi zero.
  m <- matrix(c(1, 3, 2, 2), nrow = 2,
              dimnames = list(NULL, c("zmienne", "stale")))

  wagi <- oblicz_wagi_entropia(m)

  expect_equal(unname(wagi), c(1, 0))
  expect_equal(sum(wagi), 1)
})

test_that("entropia dwoch alternatyw zgadza sie z rachunkiem recznym", {
  # p = (0,25; 0,75); e = -(0,25 ln 0,25 + 0,75 ln 0,75) / ln 2
  m <- matrix(c(1, 3, 1, 3), nrow = 2,
              dimnames = list(NULL, c("a", "b")))

  p <- c(0.25, 0.75)
  e <- -sum(p * log(p)) / log(2)
  oczekiwane_d <- 1 - e

  wagi <- oblicz_wagi_entropia(m)

  # Obie kolumny sa identyczne, wiec wagi musza byc rowne.
  expect_equal(unname(wagi), c(0.5, 0.5))
  expect_gt(oczekiwane_d, 0)
})

test_that("macierz calkowicie stala daje wagi rownomierne", {
  m <- matrix(2, nrow = 3, ncol = 4)

  expect_equal(unname(oblicz_wagi_entropia(m)), rep(0.25, 4))
  expect_equal(unname(oblicz_wagi_std(m)), rep(0.25, 4))
})

test_that("wagi z odchylenia standardowego sa proporcjonalne do rozrzutu", {
  m <- cbind(maly = c(1, 1, 1.5), duzy = c(1, 5, 9))

  wagi <- oblicz_wagi_std(m)
  oczekiwane <- c(sd(m[, 1]), sd(m[, 2]))
  oczekiwane <- oczekiwane / sum(oczekiwane)

  expect_equal(unname(wagi), oczekiwane)
})


# Warstwa druga: wlasnosci, ktore musza zachodzic niezaleznie od danych.

test_that("wagi entropii nie zmieniaja sie po przeskalowaniu kolumny", {
  # Udzial alternatywy w sumie kolumny nie zalezy od jednostki pomiaru,
  # wiec zmiana skali kryterium nie moze zmienic jego wagi.
  m <- cbind(a = c(2, 5, 9), b = c(4, 4, 7))
  przeskalowana <- m
  przeskalowana[, "a"] <- przeskalowana[, "a"] * 1000

  expect_equal(oblicz_wagi_entropia(m), oblicz_wagi_entropia(przeskalowana))
})

test_that("wagi nie zaleza od kolejnosci alternatyw", {
  m <- cbind(a = c(2, 5, 9), b = c(4, 4, 7))

  expect_equal(
    unname(oblicz_wagi_entropia(m)),
    unname(oblicz_wagi_entropia(m[c(3, 1, 2), , drop = FALSE]))
  )
})

test_that("wagi zawsze sumuja sie do jednosci", {
  set.seed(1)
  for (i in 1:20) {
    m <- matrix(runif(12, 0.1, 10), nrow = 4)
    expect_equal(sum(oblicz_wagi_entropia(m)), 1)
    expect_equal(sum(oblicz_wagi_std(m)), 1)
  }
})
