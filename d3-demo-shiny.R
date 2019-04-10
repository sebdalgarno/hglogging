library(r2d3)

ui <- fluidPage(
  verbatimTextOutput("selected"),
  d3Output("d3")
)

server <- function(input, output) {
  output$d3 <- renderD3({
    r2d3(
      c(0.3, 0.6, 0.8, 0.95, 0.40),
      script = "d3-demo.js"
    )
  })
  output$selected <- renderText({
    bar_number <- as.numeric(req(input$bar_clicked))
    if (bar_number > 0) bar_number
  })
}

shinyApp(ui, server)
