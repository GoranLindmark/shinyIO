#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
    fileInput( "upload",  "Upload a file"),

    selectInput("dataset", "Pick a dataset", ls("package:datasets")),
    tableOutput("preview"),
    downloadButton("download", "Download .tsv")
)

server <- function(input, output, session) {
    output$files <- renderTable(input$upload)

    data <- reactive({
        out <- get(input$dataset, "package:datasets")
        if (!is.data.frame(out)) {
            validate(paste0("'", input$dataset, "' is not a data frame"))
        }
        out
    })

    output$preview <- renderTable({
        head(data())
    })

    output$download <- downloadHandler(
        filename = function() {
            paste0(input$dataset, ".tsv")
        },
        content = function(file) {
            vroom::vroom_write(data(), file)
        })


}
