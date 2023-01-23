#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

ui1 <- fluidPage(

    textInput("name", "What's your name?"),

    textOutput("text"),
    verbatimTextOutput("code")
)

server1 <- function(input, output, session) {

    output$text <- renderText({
        input$name
    })
    output$code <- renderPrint({
        summary(1:10)
    })
}

# Run the application
shinyApp(ui = ui1, server = server1)
