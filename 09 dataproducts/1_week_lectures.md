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
