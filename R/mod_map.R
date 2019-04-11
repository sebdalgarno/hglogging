# Module UI
  
#' @title   mod_map_ui and mod_map_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_map
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_map_ui <- function(id){
  ns <- NS(id)
  sidebarLayout(
    sidebarPanel(width = 4, class = 'sidebar',
                 sliderInput(ns("sliderYear"), label = "Select year",
                             min = 1901, max = 2017, value = 1910)
                 ),
    mainPanel(width = 8,
              r2d3::d3Output(ns("d3YearTotal"))
              ))
}
    
# Module Server
    
#' @rdname mod_map
#' @export
#' @keywords internal
    
mod_map_server <- function(input, output, session){
  ns <- session$ns
  
  filter_data <- reactive({
    req(input$sliderYear)
    x <- hglogging::year_totals
    x[x$Year <= input$sliderYear,]
  })
  
  output$d3YearTotal <-  r2d3::renderD3({
    data <- filter_data() 
    print(data)
    print(year_pal(data$Year))
    data$Colour <- year_pal(data$Year)
    print(data)
    r2d3::r2d3(
      data = data,
      script = system.file("app/js/yeartotal_barchart.js", package = "hglogging")
    )
  })
}
 
