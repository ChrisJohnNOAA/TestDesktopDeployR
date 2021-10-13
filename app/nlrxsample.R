# Windows default NetLogo installation path (adjust to your needs!):
# netlogopath <- file.path(file.path(getwd(), "dist", "NetLogo 6.2.0"))
# netlogopath <- file.path("C:/Users/Chris/Documents/TestDesktopDeployR/dist/NetLogo 6.2.0")

#basedir <- dirname(dirname(getwd()))
basedir <- getwd()

netlogopath <- file.path(file.path(basedir, "dist", "NetLogo 6.2.0"))
modelpath <- file.path(netlogopath, "app/models/Sample Models/Biology/Wolf Sheep Predation.nlogo")
outpath <- file.path(getwd(), "out")
# Unix default NetLogo installation path (adjust to your needs!):
#netlogopath <- file.path("/home/NetLogo 6.0.3")
#modelpath <- file.path(netlogopath, "app/models/Sample Models/Biology/Wolf Sheep Predation.nlogo")
#outpath <- file.path("/home/out")

print(netlogopath)
print(getwd())
nl <- nlrx::nl(nlversion = "6.2.0",
               nlpath = netlogopath,
               modelpath = modelpath,
               jvmmem = 1024)



# Attach results to nl object:
#setsim(nl, "simoutput") <- results

# Write output to outpath of experiment within nl
#write_simoutput(nl)

# Do further analysis:
#analyze_nl(nl)

#' Gets the results from running the NetLogo model.
#'
#' @return the table of results.
#' @export
get_nl_results <- function() {
  nl@experiment <- nlrx::experiment(expname="wolf-sheep",
                                    outpath=outpath,
                                    repetition=1,
                                    tickmetrics="true",
                                    idsetup="setup",
                                    idgo="go",
                                    runtime=50,
                                    evalticks=seq(40,50),
                                    metrics=c("count sheep", "count wolves", "count patches with [pcolor = green]"),
                                    variables = list('initial-number-sheep' = list(min=50, max=150, qfun="qunif"),
                                                     'initial-number-wolves' = list(min=50, max=150, qfun="qunif")),
                                    constants = list("model-version" = "\"sheep-wolves-grass\"",
                                                     "grass-regrowth-time" = 30,
                                                     "sheep-gain-from-food" = 4,
                                                     "wolf-gain-from-food" = 20,
                                                     "sheep-reproduce" = 4,
                                                     "wolf-reproduce" = 5,
                                                     "show-energy?" = "false"))

  nl@simdesign <- nlrx::simdesign_lhs(nl=nl,
                                      samples=1, # formerly 100
                                      nseeds=3,
                                      precision=3)

  # Evaluate nl object:
  nlrx::eval_variables_constants(nl)
  print(nl)

  # Run all simulations (loop over all siminputrows and simseeds)
  results <- nlrx::run_nl_all(nl)

  return (results)
}


