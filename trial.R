library(shiny)

ui <- fluidPage(
  mainPanel(
    htmlTemplate("{{content}}")
  )
)

server <- function(input, output) {
  output$html_output <- renderText({
    input$content <- "This is my content"
    renderTemplate(htmlTemplate("{{content}}"))
  })
}

shinyApp(ui, server)

