#' This is an example shiny application
#' It is the same as example_02 in the RStudio Shiny Tutorial

library(shiny)

ui = fluidPage(
  titlePanel("Example Shiny App"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
  # sidebarLayout(
  #
  #   sidebarPanel(
  #     selectInput(
  #       inputId = "dataset",
  #       label = "Choose a dataset",
  #       choices = c("rock", "pressure", "cars", "iris")),
  #
  #     numericInput(
  #       inputId = "obs",
  #       label = "Number of observations to view:",
  #       value = 10)
  #   ),
  #
  #   mainPanel(
  #     tags$div(sprintf("Global Variable Value: %s", GLOBAL_VAR)),
  #     verbatimTextOutput("commandArgs"),
  #     verbatimTextOutput("dataSummary"),
  #     tableOutput("dataView")
  #   )
  # )
)
