source("app/nlrxsample.R")


  resultsCache <<- NULL
  bins <- 30

  print("start net logo model?")
  start <- readLines(con=file("stdin"),n=1)
  if (start == "y" || start == "yes") {
    print("starting netlogo")
    resultsCache <<- get_nl_results()
  } else {
    return()
  }

  print("how many bins?")
  bins <- as.integer(readLines(con=file("stdin"),n=1))

  png()
  if (is.null(resultsCache)) {
    return()
  }
  # generate bins based on input$bins from ui.R
  x <- resultsCache$`count sheep`
  # draw the histogram with the specified number of bins
  hist(x, breaks = bins + 1, col = 'darkgray', border = 'white')
  dev.off()

