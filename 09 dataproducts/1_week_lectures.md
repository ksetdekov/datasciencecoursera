---
title: "Developing data products lectures 1"
author: "Kirill Setdekov"
date: "Februaru 20 2020"
output:
  html_document:
    keep_md: yes
---



# week 1
Shiny - web application framework

* web bases interactive data products
* need backend hosting
* shiny is free

## prerequisites

* html gives structure and sectioning - needed
* css - style
* Javascript - for interactivity
* uses _Bootstrap_ package for rendering on small devices and look

Tutorials [https://shiny.rstudio.com/tutorial/][https://shiny.rstudio.com/tutorial/]

* mozilla develper network tutorials
* khan academy htmsl and css
* tutorials from free code camp

### HTML tags in shiny

*?builder

### how it works?

back end works all the time, postition of elements in ui is not relevant to the code.

## reactivity

A reactive expression is like a recipe that manipulates inputs from Shiny and then returns a value. Reactivity provides a way for your app to respond since inputs will change depending on how users interact with your user interface. Expressions wrapped by reactive() should be expressions that are subject to change.

Creating a reactive expression is just like creating a function:

```r
calc_sum <- reactive({
  input$box1 + input$box2
})

calc_sum()
```
## Delayed Reactivity
In order to prevent reactive expressions from reacting you can use a submit button in your app.

## advanced ui

There are several other kinds of UI components that you can mix into your app including tabs, navbars, and sidebars. We'll show you an example of how to use tabs to give your app multiple views. The tabsetPanel() function specifies a group of tabs, and then the tabPanel() function specifies the contents of an individual tab.

## alternative
can have shiny server with a different html index page  

## Interactive Graphics

One of my favorite features of Shiny is the ability to create graphics that a user can interact with. One method you can use to select multiple data points on a graph is by specifying the brush argument in plotOutput() on the ui.R side, and then using the brushedPoints() function on the server.R side. The following example app fits a linear model for the selected points and then draws a line of best fit for the resulting model.

```r
plotOutput("plot1", brush = brushOpts(
                id = "brush1"
            ))
```
Brush is a selector of points

##Sharing Shiny Apps

Once you've created a Shiny app, there are several ways to share your app. Using shinyapps.io allows users to interact with your app through a web browser without needing to have R or Shiny installed. Shinyapps.io has a free tier, but if you want to use a Shiny app in your business you may be interested in paying for the service. If you're sharing your app with an R user you can post your app to GitHub and instruct the user to use the runGist() or runGitHub() function to launch your app.

## More Shiny Resources

* [The Official Shiny Tutorial](http://shiny.rstudio.com/tutorial/)
* [Gallery of Shiny Apps](http://shiny.rstudio.com/gallery/)
* [Show Me Shiny: Gallery of R Web Apps](http://www.showmeshiny.com/)
* [Integrating Shiny and Plotly](https://plot.ly/r/shiny-tutorial/)
* [Shiny on Stack Overflow](http://stackoverflow.com/questions/tagged/shiny)

# shiny gadgets

Alternative to manipulate (it is outdated)

Provides a way to use Shiny interactivity and interface tools as a part of data analysis.
Function that opens a mall Shiny app. It is smaller - use miniUI.


```r
library(shiny)
```

```
## Warning: package 'shiny' was built under R version 3.6.2
```

```r
library(miniUI)
```

```
## Warning: package 'miniUI' was built under R version 3.6.2
```

```r
smallgadget <- function() {
    ui <- miniPage(gadgetTitleBar("First gadget"))
    server <- function(input, output, session) {
        observeEvent(input$done, {
            stopApp()
        })
    }
    runGadget(ui, server)
}
smallgadget()
```

```
## 
## Listening on http://127.0.0.1:4135
```

## Gadgets with Arguments: Code Part 1


```r
library(shiny)
library(miniUI)
multiplyNumbers <- function(numbers1, numbers2) {
    ui <- miniPage(
        gadgetTitleBar("Multiply Two Numbers"),
        miniContentPanel(
            selectInput("num1", "First Number", choices = numbers1),
            selectInput("num2", "Second Number", choices = numbers2)
        )
    )
    
    server <- function(input, output, session) {
        observeEvent(input$done, {
            num1 <- as.numeric(input$num1)
            num2 <- as.numeric(input$num2)
            stopApp(num1 * num2)
        })
    }
    runGadget(ui, server)
}
multiplyNumbers(1:5, 6:10)
```

```
## 
## Listening on http://127.0.0.1:4135
```

```
## [1] 6
```

## interactive graphics 


```r
require(shiny)
require(miniUI)

picktrees <- function() {
    ui <- miniPage(
        gadgetTitleBar("Select points by dragging on the plot"),
        miniContentPanel(plotOutput(
            "plot", height = "100%", brush = "brush"
        ))
    )
    server <- function(input, output, session) {
        output$plot <- renderPlot({
            plot(
                trees$Girth,
                trees$Volume,
                main = "trees",
                xlab = "girth",
                ylab = "vol"
            )
        })
        observeEvent(input$done, {
            stopApp(brushedPoints(
                trees,
                input$brush,
                xvar = "Girth",
                yvar = "Volume"
            ))
        })
    }
    runGadget(ui, server)
}
pichedtrees <- picktrees()
```

```
## 
## Listening on http://127.0.0.1:4135
```

```r
summary(pichedtrees)
```

```
##      Girth         Height        Volume   
##  Min.   : NA   Min.   : NA   Min.   : NA  
##  1st Qu.: NA   1st Qu.: NA   1st Qu.: NA  
##  Median : NA   Median : NA   Median : NA  
##  Mean   :NaN   Mean   :NaN   Mean   :NaN  
##  3rd Qu.: NA   3rd Qu.: NA   3rd Qu.: NA  
##  Max.   : NA   Max.   : NA   Max.   : NA
```

# google vis

not working, check with flash? and at home pc


```r
library(googleVis)
```

```
## Warning: package 'googleVis' was built under R version 3.6.2
```

```
## Creating a generic function for 'toJSON' from package 'jsonlite' in package 'googleVis'
```

```
## 
## Welcome to googleVis version 0.6.4
## 
## Please read Google's Terms of Use
## before you start using the package:
## https://developers.google.com/terms/
## 
## Note, the plot method of googleVis will by default use
## the standard browser to display its output.
## 
## See the googleVis package vignettes for more details,
## or visit https://github.com/mages/googleVis.
## 
## To suppress this message use:
## suppressPackageStartupMessages(library(googleVis))
```

```r
M <- gvisMotionChart(Fruits, "Fruit", "Year", chartid = "I_lovemy_fruit")
plot(M)
```

```
## starting httpd help server ...
```

```
##  done
```

googleVis documentation

```r
Geo=gvisGeoChart(Exports, locationvar="Country", 
                 colorvar="Profit",
                 options=list(projection="kavrayskiy-vii"))
plot(Geo)
```


```r
require(datasets)
states <- data.frame(state.name, state.x77)
GeoStates <- gvisGeoChart(states, "state.name", "Illiteracy",
                          options=list(region="US", 
                                       displayMode="regions", 
                                       resolution="provinces",
                                       width=600, height=400))
plot(GeoStates)
```

many options

```r
df=data.frame(country=c("US", "GB", "BR"), 
              val1=c(10,13,14), 
              val2=c(23,12,32))
Line3 <-  gvisLineChart(df, xvar="country", yvar=c("val1","val2"),
                        options=list(
                          title="Hello World",
                          titleTextStyle="{color:'red', 
                                           fontName:'Courier', 
                                           fontSize:16}",                         
                          backgroundColor="#D3D3D3",                          
                          vAxis="{gridlines:{color:'red', count:3}}",
                          hAxis="{title:'Country', titleTextStyle:{color:'blue'}}",
                          series="[{color:'green', targetAxisIndex: 0}, 
                                   {color: 'orange',targetAxisIndex:1}]",
                          vAxes="[{title:'val1'}, {title:'val2'}]",
                          legend="bottom",
                          curveType="function",
                          width=500,
                          height=300                         
                        ))
plot(Line3)
```

merge

```r
G <- gvisGeoChart(Exports, "Country", "Profit", 
                  options=list(width=300, height=300))
T <- gvisTable(Exports, 
               options=list(width=220, height=300))

GT <- gvisMerge(G,T, horizontal=TRUE) 
plot(GT)
```

