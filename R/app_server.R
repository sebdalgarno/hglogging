#' @import shiny
app_server <- function(input, output,session) {
  
  callModule(mod_about_server, "about_ui_1")
  
  callModule(mod_map_server, "map_ui_1")
  }
