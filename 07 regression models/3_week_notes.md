---
title: "Regression models lectures 3"
author: "Kirill Setdekov"
date: "August 7, 2019"
output:
  html_document:
    keep_md: yes
---

# week 3

## Multivariable  regression analyses.

If lots of predictors, not one.

The linear model - linear in coefficients
$$Y_i = \sum^p_{k=1}{X_{ik}\beta_j}+\epsilon_i$$


```r
n = 100
x <- rnorm(n)
x2 <- rnorm(n)
x3 <- rnorm(n)
y <- 1 + x + x2 + x3 + rnorm(n, sd = .1)
ey <- resid(lm(y ~ x2 + x3))
ex <- resid(lm(x ~ x2 + x3))
sum(ey * ex) / sum(ex ^ 2)
```

```
## [1] 1.005818
```

```r
coef(lm(ey ~ ex - 1))
```

```
##       ex 
## 1.005818
```

```r
coef(lm(y ~ x + x2 + x3))
```

```
## (Intercept)           x          x2          x3 
##   1.0186190   1.0058177   0.9937916   1.0149180
```

