---
title: "Regression models lectures 2"
author: "Kirill Setdekov"
date: "May 22, 2019"
output:
  html_document:
    keep_md: yes
---



# week 2

## Statistical linear regression models

How do we do inference?

Consider developing a probabilistic model for linear regression
$$
Y_i = \beta_0 + \beta_1 X_i + \epsilon_{i}
$$
Here the $\epsilon_{i}$ are assumed iid $N(0, \sigma^2)$. 

Note, $E[Y_i ~|~ X_i = x_i] = \mu_i = \beta_0 + \beta_1 x_i$

Note, $Var(Y_i ~|~ X_i = x_i) = \sigma^2$.

### Interpretting regression coefficients, the slope
* $\beta_0$ is the expected value of the response when the predictor is 0
* $\beta_1$ is the expected change in response for a 1 unit change in the predictor
$$
E[Y ~|~ X = x+1] - E[Y ~|~ X = x] =
\beta_0 + \beta_1 (x + 1) - (\beta_0 + \beta_1 x ) = \beta_1
$$
* Consider the impact of changing the units of $X$. 
$$
Y_i = \beta_0 + \beta_1 X_i + \epsilon_i
= \beta_0 + \frac{\beta_1}{a} (X_i a) + \epsilon_i
= \beta_0 + \tilde \beta_1 (X_i a) + \epsilon_i
$$
* Therefore, multiplication of $X$ by a factor $a$ results in dividing the coefficient by a factor of $a$. 
* Example: $X$ is height in $m$ and $Y$ is weight in $kg$. Then $\beta_1$ is $kg/m$. Converting $X$ to $cm$ implies multiplying $X$ by $100 cm/m$. To get $\beta_1$ in the right units, we have to divide by $100 cm /m$ to get it to have the right units. 
$$
X m \times \frac{100cm}{m} = (100 X) cm
~~\mbox{and}~~
\beta_1 \frac{kg}{m} \times\frac{1 m}{100cm} = 
\left(\frac{\beta_1}{100}\right)\frac{kg}{cm}
$$


### linear regression for prediciton

Better if X is from the input cloud range.


```r
require(UsingR)
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
data("diamond")
require(ggplot2)
ggplot(diamond, aes(x = carat, y = price))+
    labs( x = "Mass (carats)", y = "Price")+
    geom_point(size = 5, colour = "blue", alpha=0.2)+
    geom_smooth(method = "lm", colour = "black")
```

![](2_week_notes_files/figure-html/diamondexample-1.png)<!-- -->

```r
fit <- lm(price~carat, data=diamond)
fit
```

```
## 
## Call:
## lm(formula = price ~ carat, data = diamond)
## 
## Coefficients:
## (Intercept)        carat  
##      -259.6       3721.0
```

```r
summary(fit)
```

```
## 
## Call:
## lm(formula = price ~ carat, data = diamond)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -85.159 -21.448  -0.869  18.972  79.370 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  -259.63      17.32  -14.99   <2e-16 ***
## carat        3721.02      81.79   45.50   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 31.84 on 46 degrees of freedom
## Multiple R-squared:  0.9783,	Adjusted R-squared:  0.9778 
## F-statistic:  2070 on 1 and 46 DF,  p-value: < 2.2e-16
```

```r
coef(fit)
```

```
## (Intercept)       carat 
##   -259.6259   3721.0249
```

Getting a better interpretable intercept


```r
fit2 <- lm(price ~ I(carat - mean(carat)), diamond)
coef(fit2)
```

```
##            (Intercept) I(carat - mean(carat)) 
##               500.0833              3721.0249
```
Intercept is a price for a mean diamond


```r
fit3 <- lm(price ~ I(carat * 10), diamond)
coef(fit3)
```

```
##   (Intercept) I(carat * 10) 
##     -259.6259      372.1025
```

This is 1/10 th carat.


```r
newx <- c(0.16, 0.27, 0.4)
# manual precition
coef(fit)[1] + coef(fit)[2] * newx
```

```
## [1]  335.7381  745.0508 1228.7840
```

```r
# using predict
predict(fit, newdata = data.frame(carat = newx))
```

```
##         1         2         3 
##  335.7381  745.0508 1228.7840
```

## residuals

###Properties of the residuals

* $E[e_i] = 0$.
* If an intercept is included, $\sum_{i=1}^n e_i = 0$
* If a regressor variable, $X_i$, is included in the model $\sum_{i=1}^n e_i X_i = 0$. 
* Residuals are useful for investigating poor model fit.
* Positive residuals are above the line, negative residuals are below.
* Residuals can be thought of as the outcome ($Y$) with the
  linear association of the predictor ($X$) removed.
* One differentiates residual variation (variation after removing
the predictor) from systematic variation (variation explained by the regression model).
* Residual plots highlight poor model fit.


```r
data("diamond")
y <- diamond$price
x <- diamond$carat
n <- length(y)
fit <- lm(y ~ x)
e <- resid(fit)
yhat <- predict(fit)
max(abs(e - (y - yhat)))
```

```
## [1] 9.485746e-13
```

```r
max(abs(e - (y - coef(fit)[1] - coef(fit)[2] * x)))
```

```
## [1] 9.485746e-13
```


```r
plot(x, e,  
     xlab = "Mass (carats)", 
     ylab = "Residuals (SIN $)", 
     bg = "lightblue", 
     col = "black", cex = 2, pch = 21,frame = FALSE)
abline(h = 0, lwd = 2)
for (i in 1 : n) 
  lines(c(x[i], x[i]), c(e[i], 0), col = "red" , lwd = 2)
```

![](2_week_notes_files/figure-html/residplot-1.png)<!-- -->
### Diamond data residual plot


```r
diamond$e <- resid(lm(price ~ carat, data = diamond))
g = ggplot(diamond, aes(x = carat, y = e))
g = g + xlab("Mass (carats)")
g = g + ylab("Residual price (SIN $)")
g = g + geom_hline(yintercept = 0, size = 2)
g = g + geom_point(size = 5, colour = "blue", alpha=0.2)
g
```

![](2_week_notes_files/figure-html/diamondresidualsgg-1.png)<!-- -->
### Diamond data residual plot mean model vs linear model


```r
e = c(resid(lm(price ~ 1, data = diamond)),
      resid(lm(price ~ carat, data = diamond)),
      resid(lm(price~ I(carat)+I(exp(carat)), data = diamond)))
fit = factor(c(rep("Itc", nrow(diamond)),
               rep("Itc, slope", nrow(diamond)),
               rep("Itc, slope and exp", nrow(diamond))))
g = ggplot(data.frame(e = e, fit = fit), aes(y = e, x = fit, fill = fit))
g = g + geom_dotplot(binaxis = "y", size = 2, stackdir = "center", binwidth = 20)
```

```
## Warning: Ignoring unknown parameters: size
```

```r
g = g + xlab("Fitting approach")
g = g + ylab("Residual price")
g
```

![](2_week_notes_files/figure-html/twomodels-1.png)<!-- -->

## residual variance

- The total variability in our response is the variability around an intercept
(think mean only regression) $\sum_{i=1}^n (Y_i - \bar Y)^2$
- The regression variability is the variability that is explained by adding the
predictor $\sum_{i=1}^n  (\hat Y_i - \bar Y)^2$
- The error variability is what's leftover around the regression line
$\sum_{i=1}^n (Y_i - \hat Y_i)^2$
- Neat fact
$$
\sum_{i=1}^n (Y_i - \bar Y)^2 
= \sum_{i=1}^n (Y_i - \hat Y_i)^2 + \sum_{i=1}^n  (\hat Y_i - \bar Y)^2 
$$

### R squared
- R squared is the percentage of the total variability that is explained
by the linear relationship with the predictor
$$
R^2 = \frac{\sum_{i=1}^n  (\hat Y_i - \bar Y)^2}{\sum_{i=1}^n (Y_i - \bar Y)^2}
$$

* $R^2$ is the sample correlation squared.
