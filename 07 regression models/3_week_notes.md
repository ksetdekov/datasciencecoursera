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
## [1] 0.9894494
```

```r
coef(lm(ey ~ ex - 1))
```

```
##        ex 
## 0.9894494
```

```r
coef(lm(y ~ x + x2 + x3))
```

```
## (Intercept)           x          x2          x3 
##   1.0042747   0.9894494   1.0033950   0.9828312
```

## Fitted values, residuals and residual variation
All of our SLR quantities can be extended to linear models

* Model $Y_i = \sum_{k=1}^p X_{ik} \beta_{k} + \epsilon_{i}$ where $\epsilon_i \sim N(0, \sigma^2)$

* Fitted responses $\hat Y_i = \sum_{k=1}^p X_{ik} \hat \beta_{k}$

* Residuals $e_i = Y_i - \hat Y_i$

* Variance estimate $\hat \sigma^2 = \frac{1}{n-p} \sum_{i=1}^n e_i ^2$

* To get predicted responses at new values, $x_1, \ldots, x_p$, simply plug them into the linear model $\sum_{k=1}^p x_{k} \hat \beta_{k}$

* Coefficients have standard errors, $\hat \sigma_{\hat \beta_k}$, and
$\frac{\hat \beta_k - \beta_k}{\hat \sigma_{\hat \beta_k}}$
follows a $T$ distribution with $n-p$ degrees of freedom.

* Predicted responses have standard errors and we can calculate predicted and expected response intervals.


```r
require(datasets)
data("swiss")
require(GGally)
```

```
## Loading required package: GGally
```

```
## Warning: package 'GGally' was built under R version 3.5.3
```

```
## Loading required package: ggplot2
```

```
## Warning: package 'ggplot2' was built under R version 3.5.2
```

```r
require(ggplot2)
ggpairs(swiss, lower = list(continuous = wrap("smooth", method = "loess")))
```

![](3_week_notes_files/figure-html/examples-1.png)<!-- -->

```r
#fitting all
summary(lm(Fertility~., data = swiss))
```

```
## 
## Call:
## lm(formula = Fertility ~ ., data = swiss)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -15.2743  -5.2617   0.5032   4.1198  15.3213 
## 
## Coefficients:
##                  Estimate Std. Error t value Pr(>|t|)    
## (Intercept)      66.91518   10.70604   6.250 1.91e-07 ***
## Agriculture      -0.17211    0.07030  -2.448  0.01873 *  
## Examination      -0.25801    0.25388  -1.016  0.31546    
## Education        -0.87094    0.18303  -4.758 2.43e-05 ***
## Catholic          0.10412    0.03526   2.953  0.00519 ** 
## Infant.Mortality  1.07705    0.38172   2.822  0.00734 ** 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 7.165 on 41 degrees of freedom
## Multiple R-squared:  0.7067,	Adjusted R-squared:  0.671 
## F-statistic: 19.76 on 5 and 41 DF,  p-value: 5.594e-10
```

```r
summary(lm(Fertility~., data = swiss))$coefficients
```

```
##                    Estimate  Std. Error   t value     Pr(>|t|)
## (Intercept)      66.9151817 10.70603759  6.250229 1.906051e-07
## Agriculture      -0.1721140  0.07030392 -2.448142 1.872715e-02
## Examination      -0.2580082  0.25387820 -1.016268 3.154617e-01
## Education        -0.8709401  0.18302860 -4.758492 2.430605e-05
## Catholic          0.1041153  0.03525785  2.952969 5.190079e-03
## Infant.Mortality  1.0770481  0.38171965  2.821568 7.335715e-03
```

