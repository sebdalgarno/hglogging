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
  fluidPage(
    fluidRow(
      column(12, align = "center",
             shinyCustom::customSliderInput(ns("sliderYear"), label = "Select year", 
                         width = "100%", timeFormat = "%Y",
                         dragRange = TRUE, 
                         min = as.Date("1901-01-01"), max = as.Date("2017-01-01"), 
                         value = as.Date("1940-01-01")))),
    fluidRow(
      r2d3::d3Output(ns("d3YearTotal"))
    )
  )
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
    year <- dttr::dtt_year(input$sliderYear)
    x[x$Year <= year,]
  })
  
  output$d3YearTotal <-  r2d3::renderD3({
    data <- filter_data() 
    data$Year <- as.Date(paste0(data$Year, "-01-01"))
    r2d3::r2d3(
      data = data,
      script = system.file("app/js/yeartotal_barchart.js", package = "hglogging")
    )
  })
}
 
