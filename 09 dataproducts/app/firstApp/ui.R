library(shiny)
shinyUI(fluidPage(
    headerPanel("Data science FTW!"),
    sidebarPanel(
        h3('Sidebar text')
    ),
    mainPanel(
        h3('Main Panel text')
    )
))