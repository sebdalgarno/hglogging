#' @import shiny
app_ui <- function() {
  tagList(
    shinyjs::useShinyjs(),
    golem_add_external_resources(),
    navbarPage(title =  "Haida Gwaii Logging History", selected = 'Map',
               tabPanel(title = 'Map',
                        br(),
                        mod_map_ui("map_ui_1")),
               # tabPanel(title = 'Data',
               #          br(),
               #          mod_data_ui("data_ui_1")),
               tabPanel(title = 'About',
                        br(),
                        mod_about_ui("about_ui_1")
               ))
  )
}

golem_add_external_resources <- function(){
  
  addResourcePath(
    'www', system.file('app/www', package = 'hglogging')
  )
  tagList(tags$link(rel="stylesheet", type="text/css", href="www/style.css"))
  
}
