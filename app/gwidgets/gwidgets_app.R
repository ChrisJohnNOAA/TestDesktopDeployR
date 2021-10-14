
require(RGtk2) # required for gtkMain()
require(gWidgets2)
options(guiToolkit="RGtk2")
source("app/nlrxsample.R")

runApp = function() {
  resultsCache <<- NULL
  runModel = function(h, ...) {
    resultsCache <<- get_nl_results()
    updatePlot(h)
  }

  updatePlot = function(h, ...) {

    if (is.null(resultsCache)) {
      return()
    }
    # generate bins based on input$bins from ui.R
    x <- resultsCache$`count sheep`
    bins <- seq(min(x), max(x), length.out = as.numeric(svalue(binsSlider)) + 1)
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  }

  win <- gwindow("R + NetLogo + DesktopDeplyR + gWidgets2",
                 handler = function(h, ...) {
                    gtkMainQuit() # stop main loop when windows is closed.
                  })
  winContents <- ggroup(cont=win)
  lhs <- ggroup(horizontal=FALSE, container=winContents)
  runButton <- gbutton(text="Run NetLogo", container=lhs, handler=runModel )

  binFrame <- gframe("Number of bins", container=lhs)
  binsSlider <- gslider(from=1, to=50, by=1, value=30, handler=updatePlot, cont=binFrame)

  add(winContents, ggraphics())

  visible(win) <- TRUE

  gtkMain()
}

