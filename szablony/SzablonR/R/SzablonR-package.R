#' SzablonR: szkielet pakietu badawczego
#'
#' Pakiet stanowi punkt wyjscia do wlasnej implementacji algorytmu opisanego
#' w artykule metodycznym. Pokazuje uklad, ktorego oczekuje sprawdzanie
#' zgodnosci z repozytorium: rozdzielenie przygotowania danych od silnika
#' obliczeniowego, jawny kontrakt bledow, klase wyniku z metodami generycznymi
#' oraz procedure generowania danych o znanej strukturze.
#'
#' Sciezka analizy przebiega przez trzy funkcje. \code{\link{przygotuj_dane}}
#' zamienia surowa ramke danych w macierz decyzyjna. \code{\link{oblicz_ranking}}
#' wyznacza wagi i wskaznik. Metody \code{print}, \code{summary} i \code{plot}
#' pokazuja wynik.
#'
#' @keywords internal
#' @importFrom utils globalVariables
"_PACKAGE"

# Nazwy kolumn uzywane wewnatrz wyrazen graficznych nie sa zmiennymi
# globalnymi, ale sprawdzanie pakietu nie potrafi tego rozstrzygnac.
globalVariables(c("wskaznik", "alternatywa", "wklad", "kryterium"))
