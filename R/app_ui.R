#' @import shiny
app_ui <- function() {
  tagList(
    # Leave this function for adding external resources
    # from inst/app/www
    golem_add_external_resources(),
    # List the first level UI elements here 
    fluidPage(
      mod_about_ui("about_ui_1"),
      mod_map_ui("map_ui_1")
    )
  )
}

golem_add_external_resources <- function(){
  
  addResourcePath(
    'www', system.file('app/www', package = 'hglogging')
  )
 
  tagList(
    # Add here all the external resources
    # If you have a custom.css in the inst/app/www
    #tags$link(rel="stylesheet", type="text/css", href="www/custom.css")
  )
}
