library(shiny)
shinyServer(
    function(input, output) {
        output$text1 = renderText(input$slider2+sample(1:10,1))
    }
)