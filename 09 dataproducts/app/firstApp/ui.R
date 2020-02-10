library(shiny)
shinyUI(fluidPage(
    headerPanel("Data science FTW!"),
    sidebarPanel(
        h1("move the slider"),
        sliderInput("slider2","Slide me",0,100,0)
    ),
    mainPanel(
        h3('slider value:'),
        textOutput("text1")
    )
))