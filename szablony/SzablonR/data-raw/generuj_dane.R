# Procedura generowania danych o znanej strukturze.
#
# Skrypt nie wchodzi w sklad zbudowanego pakietu; zapisuje zbior do katalogu
# data/. Uruchamiaj go z katalogu glownego pakietu:
#     Rscript data-raw/generuj_dane.R
#
# Zbior ma znana strukture zaleznosci, dzieki czemu wiadomo, jaki wynik
# narzedzie powinno zwrocic. Kazda alternatywa ma ukryta jakosc `q`, malejaca
# od A do F. Zmienne surowe powstaja jako funkcje tej jakosci powiekszone
# o szum, wiec poprawnie dzialajacy ranking powinien odtworzyc kolejnosc liter.
# Odchylenie od tej kolejnosci jest wykrywalnym bledem implementacji, a nie
# kwestia interpretacji.

set.seed(2027)

ALTERNATYWY <- LETTERS[1:6]
OBSERWACJE  <- 20L                       # liczba ocen na alternatywe
UKRYTA      <- seq(1, 0, length.out = 6) # ukryta jakosc, malejaca
names(UKRYTA) <- ALTERNATYWY

n <- length(ALTERNATYWY) * OBSERWACJE
alternatywa <- rep(ALTERNATYWY, each = OBSERWACJE)
q <- UKRYTA[alternatywa]

# Skorelowana para zaklocen dla zmiennych kosztowych. Cholesky zamiast
# gotowego generatora rozkladu wielowymiarowego, zeby nie wprowadzac
# zaleznosci spoza pakietow bazowych.
korelacja <- matrix(c(1, 0.6, 0.6, 1), nrow = 2)
zaklocenie <- matrix(rnorm(2 * n), ncol = 2) %*% chol(korelacja)

skala_likerta <- function(wartosc, poziomy) {
  pmin(poziomy, pmax(1, round(1 + (poziomy - 1) * wartosc)))
}

dane_przykladowe <- data.frame(
  alternatywa = alternatywa,
  ekspert = rep(seq_len(OBSERWACJE), times = length(ALTERNATYWY)),

  # Koszt: rozklad log-normalny, wysoka jakosc kosztuje wiecej.
  koszt_surowce = round(exp(6.2 + 0.55 * q + 0.18 * zaklocenie[, 1]), 2),
  koszt_praca   = round(exp(5.4 + 0.40 * q + 0.18 * zaklocenie[, 2]), 2),

  # Jakosc: skale porzadkowe zalezne od ukrytej jakosci.
  jakosc_trwalosc = skala_likerta(q + rnorm(n, 0, 0.12), 5),
  jakosc_ux       = skala_likerta(q + rnorm(n, 0, 0.15), 5),

  # Dostawa: czas krotszy przy wyzszej jakosci, niezawodnosc wyzsza.
  dostawa_czas          = round(pmax(1, 14 - 8 * q + rnorm(n, 0, 1.2)), 1),
  dostawa_niezawodnosc  = round(pmin(100, 82 + 14 * q + rnorm(n, 0, 2.5)), 1),

  # Zrownowazony rozwoj: skale siedmiostopniowe.
  eko_co2    = skala_likerta(q + rnorm(n, 0, 0.18), 7),
  eko_odpady = skala_likerta(q + rnorm(n, 0, 0.18), 7),

  stringsAsFactors = FALSE
)

# Kontrolowane zanieczyszczenia. Kod 999 odpowiada bledowi wprowadzania danych,
# brak danych - pominietej odpowiedzi. Oba przypadki musi obsluzyc funkcja
# przygotowujaca dane; bez nich testy odpornosci nie mialyby na czym pracowac.
zepsute <- sample(seq_len(n), size = 6L)
dane_przykladowe$jakosc_ux[zepsute] <- 999

puste <- sample(setdiff(seq_len(n), zepsute), size = 8L)
dane_przykladowe$eko_odpady[puste] <- NA_integer_

# Walidacja przed zapisem. Zbior, ktory nie przechodzi tych warunkow, nie
# nadaje sie do testowania, bo nie wiadomo, co wlasciwie sprawdza.
stopifnot(
  nrow(dane_przykladowe) == n,
  all(ALTERNATYWY %in% dane_przykladowe$alternatywa),
  sum(dane_przykladowe$jakosc_ux == 999, na.rm = TRUE) == length(zepsute),
  sum(is.na(dane_przykladowe$eko_odpady)) == length(puste),
  all(dane_przykladowe$koszt_surowce > 0),
  all(dane_przykladowe$dostawa_niezawodnosc <= 100)
)

dir.create("data", showWarnings = FALSE)
save(dane_przykladowe, file = "data/dane_przykladowe.rda",
     compress = "xz", version = 3)

message("Zapisano data/dane_przykladowe.rda (", n, " obserwacji).")
