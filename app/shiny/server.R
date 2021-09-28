#' This is an example Shiny application
#' It is the same as example_02 in the RStudio Shiny Tutorial

library(shiny)
source("../nlrxsample.R")

server = function(input, output, session) {

  # IMPORTANT!
  # this is needed to terminate the R process when the
  # shiny app session ends. Otherwise, you end up with a zombie process
  session$onSessionEnded(function() {
    stopApp()
  })

  resultsCache <- get_nl_results()

  output$distPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    x <- resultsCache$`count sheep`
    print(x)
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  })

  # dataset = reactive({
  #   switch(
  #     input$dataset,
  #     "rock" = rock,
  #     "pressure" = pressure,
  #     "cars" = cars,
  #     "iris" = iris)
  # })
  #
  # output$commandArgs = renderPrint({
  #   commandArgs()
  # })
  #
  # output$dataSummary = renderPrint({
  #   summary(dataset())
  # })
  #
  # output$dataView = renderTable({
  #   head(dataset(), n = input$obs)
  # })
}
