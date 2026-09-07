# Aplikacja udostepniajaca narzedzie bez instalowania czegokolwiek.
#
# Aplikacja dziala w dwoch trybach.
#
# W przegladarce nie ma zainstalowanego pakietu, wiec korzysta z plikow katalogu R
# skopiowanych obok przez skrypt eksportujacy oraz z danych zapisanych w formacie
# czytanym bez mechanizmu lazy loading. Warunek ponizej wykrywa ten tryb.
#
# Lokalnie funkcje pochodza z pakietu zaladowanego przed uruchomieniem:
#     devtools::load_all()
#     shiny::runApp("inst/shiny-app")
#
# Nie wywolujemy tu polecenia library dla wlasnego pakietu: narzedzie eksportujace
# czyta takie wywolania statycznie i probowaloby dolaczyc pakiet, ktorego nie ma
# w repozytorium dostepnym w przegladarce.

PLIKI_ZRODLOWE <- c("przygotowanie_danych.R", "wagi.R", "ranking.R",
                    "klasy_s3.R", "wizualizacja.R")

if (all(file.exists(PLIKI_ZRODLOWE))) {
  for (plik in PLIKI_ZRODLOWE) source(plik)
  if (file.exists("dane_przykladowe.rds")) {
    dane_przykladowe <- readRDS("dane_przykladowe.rds")
  }
}

library(shiny)
library(ggplot2)

MODEL_DOMYSLNY <- paste(
  "Koszt   =~ koszt_surowce + koszt_praca",
  "Jakosc  =~ jakosc_trwalosc + jakosc_ux",
  "Dostawa =~ dostawa_niezawodnosc",
  "Rozwoj  =~ eko_co2 + eko_odpady",
  sep = "\n"
)

ui <- fluidPage(
  title = "Analiza wielokryterialna",

  tags$head(tags$style(HTML("
    body { font-family: system-ui, sans-serif; }
    .naglowek { border-bottom: 2px solid #2E5E9E; margin-bottom: 1.2rem;
                padding-bottom: 0.6rem; }
    .naglowek h2 { margin: 0; color: #2E5E9E; font-size: 1.5rem; }
    .naglowek p { margin: 0.3rem 0 0; color: #555; font-size: 0.92rem; }
    .panel-uwaga { background: #f5f7fa; border-left: 3px solid #2E5E9E;
                   padding: 0.6rem 0.9rem; font-size: 0.88rem; color: #444;
                   margin-top: 1rem; }
    .blad { color: #a33; font-weight: 600; }
  "))),

  div(class = "naglowek",
      h2("Analiza wielokryterialna"),
      p("Obliczenia wykonują się w Twojej przeglądarce. Dane nie są nigdzie wysyłane.")
  ),

  sidebarLayout(
    sidebarPanel(
      width = 4,

      h4("Model"),
      helpText("Każdy wiersz deklaruje jedno kryterium i wymienia zmienne,",
               "które się na nie składają."),
      textAreaInput("model", NULL, value = MODEL_DOMYSLNY, rows = 5),

      h4("Ustawienia"),
      selectInput("wagi", "Metoda wyznaczania wag",
                  choices = c("Entropia Shannona" = "entropia",
                              "Odchylenie standardowe" = "std",
                              "Wagi równe" = "rowne"),
                  selected = "entropia"),

      selectInput("braki", "Obsługa braków danych",
                  choices = c("Zastąp medianą" = "mediana",
                              "Usuń obserwację" = "usun"),
                  selected = "mediana"),

      uiOutput("kierunki_ui"),

      div(class = "panel-uwaga",
          "Kryterium kosztowe zadeklaruj jako minimalizowane. ",
          "Wagi wyznaczane z danych mówią, które kryterium różnicuje ",
          "alternatywy, a nie które jest ważne dla decydenta.")
    ),

    mainPanel(
      width = 8,
      tabsetPanel(
        tabPanel("Ranking",
                 br(),
                 uiOutput("komunikat"),
                 tableOutput("tabela"),
                 plotOutput("wykres", height = "320px")),
        tabPanel("Udział kryteriów",
                 br(),
                 plotOutput("udzialy", height = "360px")),
        tabPanel("Macierz decyzyjna",
                 br(),
                 tableOutput("macierz"),
                 h5("Wagi"),
                 tableOutput("wagi_tab")),
        tabPanel("Dane surowe",
                 br(),
                 tableOutput("dane"))
      )
    )
  )
)

server <- function(input, output, session) {

  kryteria <- reactive({
    tryCatch(names(rozbierz_model(input$model)), error = function(e) character(0))
  })

  output$kierunki_ui <- renderUI({
    nazwy <- kryteria()
    if (!length(nazwy)) return(NULL)
    tagList(
      h4("Kierunek optymalizacji"),
      lapply(nazwy, function(k) {
        selectInput(paste0("kier_", k), k,
                    choices = c("maksymalizuj" = "max", "minimalizuj" = "min"),
                    selected = if (grepl("koszt", k, ignore.case = TRUE)) "min" else "max")
      })
    )
  })

  analiza <- reactive({
    nazwy <- kryteria()
    validate(need(length(nazwy) > 0,
                  "Model jest pusty albo niepoprawny. Każdy wiersz musi zawierać operator =~"))

    kierunki <- vapply(nazwy, function(k) {
      wartosc <- input[[paste0("kier_", k)]]
      if (is.null(wartosc)) "max" else wartosc
    }, character(1))

    tryCatch({
      macierz <- przygotuj_dane(dane_przykladowe, input$model, braki = input$braki)
      list(macierz = macierz,
           wynik = oblicz_ranking(macierz, wagi = input$wagi,
                                  kierunki = unname(kierunki)))
    }, error = function(e) {
      list(blad = conditionMessage(e))
    })
  })

  output$komunikat <- renderUI({
    wynik <- analiza()
    if (!is.null(wynik$blad)) {
      div(class = "blad", "Nie udało się przeprowadzić analizy: ", wynik$blad)
    }
  })

  output$tabela <- renderTable({
    wynik <- analiza()
    if (!is.null(wynik$blad)) return(NULL)
    dane <- wynik$wynik$wynik
    data.frame(
      Pozycja = dane$pozycja,
      Alternatywa = dane$alternatywa,
      Wskaznik = round(dane$wskaznik, 4)
    )
  }, digits = 4)

  output$wykres <- renderPlot({
    wynik <- analiza()
    if (!is.null(wynik$blad)) return(NULL)
    plot(wynik$wynik)
  })

  output$udzialy <- renderPlot({
    wynik <- analiza()
    if (!is.null(wynik$blad)) return(NULL)
    wykres_udzialow(wynik$wynik)
  })

  output$macierz <- renderTable({
    wynik <- analiza()
    if (!is.null(wynik$blad)) return(NULL)
    m <- round(unclass(wynik$macierz), 4)
    cbind(Alternatywa = rownames(m), as.data.frame(m))
  }, digits = 4)

  output$wagi_tab <- renderTable({
    wynik <- analiza()
    if (!is.null(wynik$blad)) return(NULL)
    data.frame(Kryterium = names(wynik$wynik$wagi),
               Waga = round(unname(wynik$wynik$wagi), 4))
  }, digits = 4)

  output$dane <- renderTable({
    utils::head(dane_przykladowe, 25)
  })
}

shinyApp(ui, server)
