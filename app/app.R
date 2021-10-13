# app launching code, e.g.:
#shiny::runApp("./app/shiny/", launch.browser=TRUE)

print("starting app")
source("app/gwidgets/gwidgets_app.R")
print("running app")
runApp()
