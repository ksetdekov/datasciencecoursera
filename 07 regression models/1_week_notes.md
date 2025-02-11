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
g <- g + geom_smooth(method = "lm", formula = y~x) 
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

## Basic notation and background 

### Variance

Define the empirical variance as 
$$
S^2 = \frac{1}{n-1} \sum_{i=1}^n (X_i - \bar X)^2 
= \frac{1}{n-1} \left( \sum_{i=1}^n X_i^2 - n \bar X ^ 2 \right)
$$
 
The empirical standard deviation is defined as
$S = \sqrt{S^2}$. Notice that the standard deviation has the same units as the data.

The data defined by $X_i / s$ have empirical standard deviation 1. This is called "scaling" the data.

## Normalization

The data defined by
$$
Z_i = \frac{X_i - \bar X}{s}
$$

have empirical mean zero and empirical standard deviation 1. 

## The empirical covariance
 Consider now when we have pairs of data, $(X_i, Y_i)$.

 Their empirical covariance is 
$$
Cov(X, Y) = 
\frac{1}{n-1}\sum_{i=1}^n (X_i - \bar X) (Y_i - \bar Y)
= \frac{1}{n-1}\left( \sum_{i=1}^n X_i Y_i - n \bar X \bar Y\right)
$$

 The correlation is defined is
$$
Cor(X, Y) = \frac{Cov(X, Y)}{S_x S_y}
$$
where $S_x$ and $S_y$ are the estimates of standard deviations 
for the $X$ observations and $Y$ observations, respectively.

## linear least squares

## Results
* The least squares model fit to the line $Y = \beta_0 + \beta_1 X$ through the data pairs $(X_i, Y_i)$ with $Y_i$ as the outcome obtains the line $Y = \hat \beta_0 + \hat \beta_1 X$ where
  $$\hat \beta_1 = Cor(Y, X) \frac{Sd(Y)}{Sd(X)} ~~~ \hat \beta_0 = \bar Y - \hat \beta_1 \bar X$$
* $\hat \beta_1$ has the units of $Y / X$, $\hat \beta_0$ has the units of $Y$.
* The line passes through the point $(\bar X, \bar Y$)
* The slope of the regression line with $X$ as the outcome and $Y$ as the predictor is $Cor(Y, X) Sd(X)/ Sd(Y)$. 
* The slope is the same one you would get if you centered the data,
$(X_i - \bar X, Y_i - \bar Y)$, and did regression through the origin.
* If you normalized the data, $\{ \frac{X_i - \bar X}{Sd(X)}, \frac{Y_i - \bar Y}{Sd(Y)}\}$, the slope is $Cor(Y, X)$.

## Revisiting Galton's data
### Double check our calculations using R


```r
y <- galton$child
x <- galton$parent
beta1 <- cor(y, x) *  sd(y) / sd(x)
beta0 <- mean(y) - beta1 * mean(x)
rbind(c(beta0, beta1), coef(lm(y ~ x)))
```

```
##      (Intercept)         x
## [1,]    23.94153 0.6462906
## [2,]    23.94153 0.6462906
```

## regression to the mean


```r
x <- rnorm(100)
y <- rnorm(100)
odr <- order(x)
x[odr[100]] #biggest X
```

```
## [1] 1.976297
```

```r
y[odr[100]] #its pair
```

```
## [1] 0.756592
```


```r
require(UsingR)
data("father.son")
y <- (father.son$sheight - mean(father.son$sheight))/sd(father.son$sheight)
x <- (father.son$fheight - mean(father.son$fheight))/sd(father.son$fheight)
rho <- cor(x,y)
g <- ggplot(data.frame(x=x, y=y), aes(x = x, y = y))+
    geom_point(size = 4, colour = "salmon", alpha = 0.2)+
    geom_abline(intercept = 0, slope = 1)+
    geom_vline(xintercept = 0)+
    geom_hline(yintercept = 0)+
    geom_abline(intercept = 0, slope = rho, size = 2)+
    geom_abline(intercept = 0, slope = 1/rho, size = 2)
g
```

![](1_week_notes_files/figure-html/regmeanexample-1.png)<!-- -->
Level of regression to the mean - is just correlation.


```r
all.equal(c(1:10), c(1:10))
```

```
## [1] TRUE
```

## q1

```r
##1
x <- c(0.18, -1.54, 0.42, 0.95)
w <- c(2, 1, 3, 1)
errorfunct <- function(mu,x,w){
    sum(w*(x-mu)^2)
}
 optimize (errorfunct, x=x,w=w, interval=c(-100, 100))
```

```
## $minimum
## [1] 0.1471429
## 
## $objective
## [1] 3.716543
```

```r
 sum(x * w)/sum(w)
```

```
## [1] 0.1471429
```

```r
##2
x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)
lm(y~0+x)
```

```
## 
## Call:
## lm(formula = y ~ 0 + x)
## 
## Coefficients:
##      x  
## 0.8263
```

```r
##3
data("mtcars")
with(mtcars, lm(mpg~wt))
```

```
## 
## Call:
## lm(formula = mpg ~ wt)
## 
## Coefficients:
## (Intercept)           wt  
##      37.285       -5.344
```

```r
##4
0.5*1/0.5
```

```
## [1] 1
```

```r
##5
1.5*0.4
```

```
## [1] 0.6
```

```r
##6
x <- c(8.58, 10.46, 9.01, 9.64, 8.86)
(x-mean(x))/sd(x)
```

```
## [1] -0.9718658  1.5310215 -0.3993969  0.4393366 -0.5990954
```

```r
##7
x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)
lm(y~x)
```

```
## 
## Call:
## lm(formula = y ~ x)
## 
## Coefficients:
## (Intercept)            x  
##       1.567       -1.713
```

```r
##8
#y,x mean - 0,
#intercept -0

##9
x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
mean(x)
```

```
## [1] 0.573
```


The $$\beta_1 = Cor(Y, X) SD(Y) / SD(X)  $$

$$ \gamma_1= Cor(Y, X) SD(X) / SD(Y) $$ 


Thus the ratio is then $$Var(Y) / Var(X)$$ 
