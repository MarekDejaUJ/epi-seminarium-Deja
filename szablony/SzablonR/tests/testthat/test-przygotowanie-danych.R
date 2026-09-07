# Kontrakt funkcji przygotowujacej dane: co wolno podac, a co zatrzymuje
# wykonanie. Test sprawdza takze tresc komunikatu, bo komunikat jest czescia
# interfejsu - to on mowi uzytkownikowi, co poprawic.

test_that("rozbior modelu zwraca kryteria i ich skladniki", {
  skladniki <- rozbierz_model("Koszt =~ a + b\nJakosc =~ c")

  expect_named(skladniki, c("Koszt", "Jakosc"))
  expect_equal(skladniki$Koszt, c("a", "b"))
  expect_equal(skladniki$Jakosc, "c")
})

test_that("rozbior modelu przyjmuje srednik jako separator wierszy", {
  expect_equal(
    rozbierz_model("Koszt =~ a; Jakosc =~ b"),
    rozbierz_model("Koszt =~ a\nJakosc =~ b")
  )
})

test_that("model bez operatora jest odrzucany", {
  expect_error(rozbierz_model("Koszt ~ a"), "operator")
  expect_error(rozbierz_model(""), "niepustym")
  expect_error(rozbierz_model(character(0)), "niepustym")
})

test_that("powtorzona nazwa kryterium jest odrzucana", {
  expect_error(rozbierz_model("Koszt =~ a\nKoszt =~ b"), "unikalne")
})

test_that("skalowanie sprowadza wektor do przedzialu jednostkowego", {
  expect_equal(skaluj_min_max(c(2, 4, 6)), c(0, 0.5, 1))
})

test_that("wektor o zerowym rozrzucie otrzymuje wartosc srodkowa", {
  # Zmienna stala nie rozroznia alternatyw. Zwrocenie wartosci srodkowej
  # zachowuje model zadeklarowany przez uzytkownika, a dzielenie przez zero
  # dalaby wartosci nieskonczone.
  expect_equal(skaluj_min_max(rep(3, 4)), rep(0.5, 4))
})

test_that("macierz decyzyjna ma wymiar zgodny z modelem", {
  model <- "Koszt  =~ koszt_surowce + koszt_praca
            Jakosc =~ jakosc_trwalosc + jakosc_ux"

  macierz <- przygotuj_dane(dane_przykladowe, model)

  expect_s3_class(macierz, "macierz_decyzyjna")
  expect_equal(dim(macierz), c(6L, 2L))
  expect_equal(colnames(macierz), c("Koszt", "Jakosc"))
  expect_equal(rownames(macierz), LETTERS[1:6])
  expect_false(anyNA(macierz))
})

test_that("kod bledny nie trafia do macierzy jako wartosc", {
  # Kolumna jakosc_ux zawiera kod 999. Gdyby przeszedl bez zamiany na brak,
  # srednia kryterium Jakosc byla by zawyzona o kilka rzedow wielkosci.
  macierz <- przygotuj_dane(dane_przykladowe, "Jakosc =~ jakosc_ux")

  expect_true(all(macierz >= 0 & macierz <= 1))
})

test_that("zmienna spoza ramki danych zatrzymuje wykonanie", {
  expect_error(
    przygotuj_dane(dane_przykladowe, "Koszt =~ nie_ma_takiej"),
    "nieobecne w danych"
  )
})

test_that("zmienna nieliczbowa zatrzymuje wykonanie", {
  expect_error(
    przygotuj_dane(dane_przykladowe, "Cos =~ alternatywa"),
    "liczbowe"
  )
})

test_that("brak kolumny alternatyw zatrzymuje wykonanie", {
  dane <- dane_przykladowe
  names(dane)[1] <- "inna_nazwa"

  expect_error(
    przygotuj_dane(dane, "Koszt =~ koszt_praca"),
    "identyfikujacej alternatywy"
  )
})

test_that("obsluga brakow dziala zgodnie z wyborem", {
  model <- "Rozwoj =~ eko_odpady"

  mediana <- przygotuj_dane(dane_przykladowe, model, braki = "mediana")
  usuniecie <- przygotuj_dane(dane_przykladowe, model, braki = "usun")

  expect_equal(dim(mediana), dim(usuniecie))
  expect_equal(attr(mediana, "liczba_obserwacji"), 120L)
  expect_equal(attr(usuniecie, "liczba_obserwacji"), 112L)
  expect_error(
    przygotuj_dane(dane_przykladowe, model, braki = "blad"),
    "obsluge `blad`"
  )
})

test_that("pusta ramka danych zatrzymuje wykonanie", {
  expect_error(
    przygotuj_dane(dane_przykladowe[0, ], "Koszt =~ koszt_praca"),
    "pusta"
  )
})

test_that("argument nie bedacy ramka danych zatrzymuje wykonanie", {
  expect_error(przygotuj_dane(1:10, "Koszt =~ a"), "ramka danych")
})
