---
title: "Regression models lectures"
author: "Kirill Setdekov"
date: "May 22, 2019"
output:
  html_document:
    keep_md: yes
---



# week 1
# Introduction to regression

## linear model - great start

## material

read simply statistics blog

https://simplystatistics.org

https://github.com/bcaffo/courses/tree/master/07_RegressionModels

https://www.youtube.com/playlist?list=PLpl-gQkQivXjqHAJd2t-J_One_fYE55tC

https://leanpub.com/regmods

http://datasciencespecialization.github.io/ 

### advanced

https://leanpub.com/lm 

## questions for the class

* use simple relations - parents and child heights
* find parsimonious, easily described mean relationship
* quantify what genotype info has beyond parental height in child height
* how we take data and generalize? what assumptions are needed for this?
* why there is a regression to the mean?

### install regression models _SWIRL_

`
install_from_swirl("Regression Models")
`
Galton data

Looking at distributions


```r
require("UsingR")
require(ggplot2)
require(reshape2)
data("galton")
library(dplyr)
```

```
## Warning: package 'dplyr' was built under R version 3.5.2
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:Hmisc':
## 
##     src, summarize
```

```
## The following object is masked from 'package:MASS':
## 
##     select
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
long <- melt(galton)
```

```
## No id variables; using all as measure variables
```

```r
g <- ggplot(long, aes(x = value, fill = variable))+
    geom_histogram(color="black",
                   binwidth = 1)+
    facet_grid(.~variable)
g
```

![](1_week_notes_files/figure-html/galtondata1-1.png)<!-- -->

### finding the middle with least squares

$\mu$
  that minimizes $$\sum_{i=1}^n (Y_i - \mu)^2$$


```r
require(manipulate)
```

```
## Loading required package: manipulate
```

```
## Warning: package 'manipulate' was built under R version 3.5.2
```

```r
myHist <- function(mu) {
    mse <- mean((galton$child - mu) ^ 2)
    g <- ggplot(galton, aes(x = child)) +
        geom_histogram(fill = "salmon", binwidth = 1) +
        geom_vline(xintercept = mu, size = 3) +
        ggtitle(paste("mu =", mu, ", MSE = ", round(mse, 2), sep = ""))
    g
}
#manipulate(myHist(mu), mu=slider(62, 74, step = 0.1))

## true mean
g <- ggplot(galton, aes(x = child)) +
    geom_histogram(fill = "salmon",
                   binwidth = 1,
                   color = "black") +
    geom_vline(xintercept = mean(galton$child), size = 3)
g
```

![](1_week_notes_files/figure-html/manupulatemean-1.png)<!-- -->


```r
ggplot(galton, aes(x = parent, y = child)) +
    geom_jitter()
```

![](1_week_notes_files/figure-html/childplot-1.png)<!-- -->

```r
freqData <- as.data.frame(table(galton$child, galton$parent))
names(freqData) <- c("child", "parent", "freq")
freqData$child <- as.numeric(as.character(freqData$child))
freqData$parent <- as.numeric(as.character(freqData$parent))
g <- ggplot(filter(freqData, freq > 0), aes(x = parent, y = child))
g <- g  + scale_size(range = c(2, 20), guide = "none" )
g <- g + geom_point(colour="grey50", aes(size = freq+20, show_guide = FALSE))
```

```
## Warning: Ignoring unknown aesthetics: show_guide
```

```r
g <- g + geom_point(aes(colour=freq, size = freq))
g <- g + scale_colour_gradient(low = "lightblue", high="white")                    
g
```

![](1_week_notes_files/figure-html/childplot-2.png)<!-- -->

### Regreassion through the origin.

Consider picking the slope $\beta$ that minimizes $$\sum_{i=1}^n (Y_i - X_i \beta)^2$$


### In the next few lectures we'll talk about why this is the solution

```r
lm(I(child - mean(child))~ I(parent - mean(parent)) - 1, data = galton)
```

```
## 
## Call:
## lm(formula = I(child - mean(child)) ~ I(parent - mean(parent)) - 
##     1, data = galton)
## 
## Coefficients:
## I(parent - mean(parent))  
##                   0.6463
```

