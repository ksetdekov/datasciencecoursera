library(shiny)
shinyUI(fluidPage(
    headerPanel("Data science FTW!"),
    sidebarPanel(
        h1("h1 tst"),
        h2("h2"),
        h3('Sidebar text h3'),
        em("emphasis test")
    ),
    mainPanel(
        h3('Main Panel text')
    )
))