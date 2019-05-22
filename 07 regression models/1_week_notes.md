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
```

```
## Loading required package: UsingR
```

```
## Warning: package 'UsingR' was built under R version 3.5.2
```

```
## Loading required package: MASS
```

```
## Loading required package: HistData
```

```
## Warning: package 'HistData' was built under R version 3.5.2
```

```
## Loading required package: Hmisc
```

```
## Warning: package 'Hmisc' was built under R version 3.5.2
```

```
## Loading required package: lattice
```

```
## Loading required package: survival
```

```
## Loading required package: Formula
```

```
## Loading required package: ggplot2
```

```
## Warning: package 'ggplot2' was built under R version 3.5.2
```

```
## 
## Attaching package: 'Hmisc'
```

```
## The following objects are masked from 'package:base':
## 
##     format.pval, units
```

```
## 
## Attaching package: 'UsingR'
```

```
## The following object is masked from 'package:survival':
## 
##     cancer
```

```r
require(ggplot2)
require(reshape2)
```

```
## Loading required package: reshape2
```

```r
data("galton")
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

