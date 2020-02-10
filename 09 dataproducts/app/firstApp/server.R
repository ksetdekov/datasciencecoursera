library(shiny)
shinyServer(function(input, output) {
    output$plot1 <- renderPlot({
                number_of_points <- input$numeric
        minX <- input$sliderX[1]
        maxX <- input$sliderX[2]
        minY <- input$sliderY[1]
        maxY <- input$sliderY[2]
        # dataX <- runif(number_of_points, minX, maxX)
        dataY <- rnorm(number_of_points, (maxY/2+minY/2), (maxY-(maxY/2+minY/2))/qnorm(input$sliderP, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE))
        dataX <- rnorm(number_of_points, (maxX/2+minX/2), (maxX-(maxX/2+minX/2))/qnorm(input$sliderP, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE))
        # dataY <- runif(number_of_points, minY, maxY)
        xlab <- ifelse(input$show_xlab, "X Axis", "")
        ylab <- ifelse(input$show_ylab, "Y Axis", "")
        main <- ifelse(input$show_title, "Title", "")
        plot(dataX, dataY, xlab = xlab, ylab = ylab, main = main,
             xlim = c(-100, 100), ylim = c(-100, 100))
            })
    output$meanX <-  renderText(paste0(input$sliderX[2],input$sliderX[1]))
})