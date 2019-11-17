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


```
## knitr
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


```
## knitr
```

```
## datasets
```

```
## GGally
```

```
## ggplot2
```

How can adjustment reverse the sign of an effect? Let's try a simulation.

```
## knitr
```

```
## datasets
```

```
## GGally
```

```
## ggplot2
```

---

```
## knitr
```

```
## datasets
```

```
## GGally
```

```
## ggplot2
```

## Dummy variables

More than 2 levels

* Consider a multilevel factor level. For didactic reasons, let's say a three level factor (example, US political party affiliation: Republican, Democrat, Independent)

* $Y_i = \beta_0 + X_{i1} \beta_1 + X_{i2} \beta_2 + \epsilon_i$.

* $X_{i1}$ is 1 for Republicans and 0 otherwise.

* $X_{i2}$ is 1 for Democrats and 0 otherwise.

* If $i$ is Republican $E[Y_i] = \beta_0 +\beta_1$

* If $i$ is Democrat $E[Y_i] = \beta_0 + \beta_2$.

* If $i$ is Independent $E[Y_i] = \beta_0$. 

* $\beta_1$ compares Republicans to Independents.

* $\beta_2$ compares Democrats to Independents.

* $\beta_1 - \beta_2$ compares Republicans to Democrats.

* (Choice of reference category changes the interpretation.)


```
## knitr
```

```
## datasets
```

```
## GGally
```

```
## ggplot2
```

```
## datasets
```

```
## stats
```

```
## graphics
```
Hardcode dummy - I are instances.
Reference level is "C"

```
## knitr
```

```
## datasets
```

```
## GGally
```

```
## ggplot2
```

```
## datasets
```

```
## stats
```

```
## graphics
```
Better way to relevel:


```
## knitr
```

```
## datasets
```

```
## GGally
```

```
## ggplot2
```

```
## datasets
```

```
## stats
```

```
## graphics
```

Fitting multiple lines. ANCOVA

```
## knitr
```

```
## datasets
```

```
## GGally
```

```
## ggplot2
```

```
## datasets
```

```
## stats
```

```
## graphics
```

```
## datasets
```

```
## dplyr
```

Could mace a factor - with x2 = 1 for CatholicBin


```
## knitr
```

```
## datasets
```

```
## GGally
```

```
## ggplot2
```

```
## datasets
```

```
## stats
```

```
## graphics
```

```
## datasets
```

```
## dplyr
```

```
## knitr
```

```
## datasets
```

```
## GGally
```

```
## ggplot2
```

```
## datasets
```

```
## stats
```

```
## graphics
```

```
## datasets
```

```
## dplyr
```

With interaction

```
## knitr
```

```
## datasets
```

```
## GGally
```

```
## ggplot2
```

```
## datasets
```

```
## stats
```

```
## graphics
```

```
## datasets
```

```
## dplyr
```

Adding adjustments

## Consider the following simulated data
Code for the first plot, rest omitted


```
## knitr
```

```
## datasets
```

```
## GGally
```

```
## ggplot2
```

```
## datasets
```

```
## stats
```

```
## graphics
```

```
## datasets
```

```
## dplyr
```

## Simulation 2
strong marginal effect when disregard effect, very subtle effect if adjust for X


## Simulation 3 
illustration of simpson's paradox


## Simulation 4
no marginal effect, but a huge effect, when adjust for X


## Simulation 5
This will be wrong if we think that slopes are equeal - need to have an interaction term


### Simulation 6
Binary treatment - not necessary.



Need to look in 3d


```
## knitr
```

```
## datasets
```

```
## GGally
```

```
## ggplot2
```

```
## datasets
```

```
## stats
```

```
## graphics
```

```
## datasets
```

```
## dplyr
```

```
## rgl
```
Better to look at residuals
Strong relationsip between Y and X2


# residual diagnostics.
Linear model.
Define the residuals as

* $e_i = Y_i -  \hat Y_i =  Y_i - \sum_{k=1}^p X_{ik} \hat \beta_j$

* Our estimate of residual variation is $\hat \sigma^2 = \frac{\sum_{i=1}^n e_i^2}{n-p}$, the $n-p$ so that $E[\hat \sigma^2] = \sigma^2$


```
## knitr
```

```
## datasets
```

```
## GGally
```

```
## ggplot2
```

```
## datasets
```

```
## stats
```

```
## graphics
```

```
## datasets
```

```
## dplyr
```

```
## rgl
```

Influential vs outlier points.
Leverage - how high away from the average is the point
Influence - how far away from the regression line.

## Influential, high leverage and outlying points


* Outlier - too vague.
* Could be rear or spurious process.
* Can conform or not to the regression.

solutions - ```?influence.measures```

Main plot - residuals vs fitted values - if we have systematic patterns
Residual Q-Q plot - check normality
Leverage plot

## Influence measures
  * `rstandard` - standardized residuals, residuals divided by their standard deviations)
  * `rstudent` - standardized residuals, residuals divided by their standard deviations, where the ith data point was deleted in the calculation of the standard deviation for the residual to follow a t distribution
  * `hatvalues` - measures of leverage
  * `dffits` - change in the predicted response when the $i^{th}$ point is deleted in fitting the model.
  * `dfbetas` - change in individual coefficients when the $i^{th}$ point is deleted in fitting the model.
  * `cooks.distance` - overall change in the coefficients when the $i^{th}$ point is deleted.
  * `resid` - returns the ordinary residuals
  * `resid(fit) / (1 - hatvalues(fit))` where `fit` is the linear model fit returns the PRESS residuals, i.e. the leave one out cross validation residuals - the difference in the response and the predicted response at data point $i$, where it was not included in the model fitting.
  
# simulation experiments

## Case 1

```
## knitr
```

```
## datasets
```

```
## GGally
```

```
## ggplot2
```

```
## datasets
```

```
## stats
```

```
## graphics
```

```
## datasets
```

```
## dplyr
```

```
## rgl
```

```
## knitr
```

```
## datasets
```

```
## GGally
```

```
## ggplot2
```

```
## datasets
```

```
## stats
```

```
## graphics
```

```
## datasets
```

```
## dplyr
```

```
## rgl
```
for point 1 there is a higher level of both metrics

## Case 2

```
## knitr
```

```
## datasets
```

```
## GGally
```

```
## ggplot2
```

```
## datasets
```

```
## stats
```

```
## graphics
```

```
## datasets
```

```
## dplyr
```

```
## rgl
```


```
## knitr
```

```
## datasets
```

```
## GGally
```

```
## ggplot2
```

```
## datasets
```

```
## stats
```

```
## graphics
```

```
## datasets
```

```
## dplyr
```

```
## rgl
```

** Example by stefanski **

```
## knitr
```

```
## datasets
```

```
## GGally
```

```
## ggplot2
```

```
## datasets
```

```
## stats
```

```
## graphics
```

```
## datasets
```

```
## dplyr
```

```
## rgl
```

```
## GGally
```

```
## ggplot2
```

## Got our P-values, should we bother to do a residual plot?

```
## knitr
```

```
## datasets
```

```
## GGally
```

```
## ggplot2
```

```
## datasets
```

```
## stats
```

```
## graphics
```

```
## datasets
```

```
## dplyr
```

```
## rgl
```

```
## GGally
```

```
## ggplot2
```

## Residual plot - fin
### P-values significant, O RLY?

```
## knitr
```

```
## datasets
```

```
## GGally
```

```
## ggplot2
```

```
## datasets
```

```
## stats
```

```
## graphics
```

```
## datasets
```

```
## dplyr
```

```
## rgl
```

```
## GGally
```

```
## ggplot2
```

## Back to the Swiss data

```
## knitr
```

```
## datasets
```

```
## GGally
```

```
## ggplot2
```

```
## datasets
```

```
## stats
```

```
## graphics
```

```
## datasets
```

```
## dplyr
```

```
## rgl
```

```
## GGally
```

```
## ggplot2
```

* not many signs of heteroskedasticity
* looks normal
* third plots - scaled residuals
* residual vs scale - we dont want high leverage with high residuals

# model Selection
We want parsimony - simplest model, interpretable, but not simpler

A model is a lense through which to look at your data. (I attribute this quote to Scott Zeger)

*There are known knowns. These are things we know that we know. There are known unknowns. That is to say, there are things that we know we don't know. But there are also unknown unknowns. There are things we don't know we don't know.* Donald Rumsfeld

Variance inflation
## Variance inflation

```
## knitr
```

```
## datasets
```

```
## GGally
```

```
## ggplot2
```

```
## datasets
```

```
## stats
```

```
## graphics
```

```
## datasets
```

```
## dplyr
```

```
## rgl
```

```
## GGally
```

```
## ggplot2
```
neglidgeble change as new variables are not dependatn on X1

but if they depend?

## Variance inflation

```
## knitr
```

```
## datasets
```

```
## GGally
```

```
## ggplot2
```

```
## datasets
```

```
## stats
```

```
## graphics
```

```
## datasets
```

```
## dplyr
```

```
## rgl
```

```
## GGally
```

```
## ggplot2
```

* The variance inflation factor (VIF) is the increase in the variance for the ith regressor compared to the ideal setting where it is orthogonal to the other regressors.
  * (The square root of the VIF is the increase in the sd ...)
## Swiss data VIFs, 

```
## knitr
```

```
## datasets
```

```
## GGally
```

```
## ggplot2
```

```
## datasets
```

```
## stats
```

```
## graphics
```

```
## datasets
```

```
## dplyr
```

```
## rgl
```

```
## GGally
```

```
## ggplot2
```

```
## car
```

Good approach - looking at nested models


```
## knitr
```

```
## datasets
```

```
## GGally
```

```
## ggplot2
```

```
## datasets
```

```
## stats
```

```
## graphics
```

```
## datasets
```

```
## dplyr
```

```
## rgl
```

```
## GGally
```

```
## ggplot2
```

```
## car
```

# swirl

```
## knitr
```

```
## datasets
```

```
## GGally
```

```
## ggplot2
```

```
## datasets
```

```
## stats
```

```
## graphics
```

```
## datasets
```

```
## dplyr
```

```
## rgl
```

```
## GGally
```

```
## ggplot2
```

```
## car
```

```
## datasets
```

adding interaction
`lmInter <- lm(Numeric ~Year+Sex+Sex*Year, data = hunger)`

функция, которая выводит метрику dfbeta для результатов регрессии (что если исключить каждое значение по очереди, построить модель и посмотреть, как коэффициенты изменятся. Сильные изменения коэффициентов - вероятно это лишнее значение.)
`View(dfbeta(fit))`

А стандартизированное - dfbetas
`View(dfbetas(fit))`

Функция, которая показывает насколько каждое значение разница остатков для включения и исключения значения отличается у конкретного наблюдения от единицы - leverage или hat value
`View(hatvalues(fit))`

Стандартизированные остатки
`View(rstandard(fit))`
их график выводится
`plot(fit, which=3)`

График нормальности остатков - 
`plot(fit, which=2)`

Стьюдентизированные остатки -
`View(rstudent(fit))`

Cook's distance
`plot(fit, which=5)`

```
## knitr
```

```
## datasets
```

```
## GGally
```

```
## ggplot2
```

```
## datasets
```

```
## stats
```

```
## graphics
```

```
## datasets
```

```
## dplyr
```

```
## rgl
```

```
## GGally
```

```
## ggplot2
```

```
## car
```

```
## datasets
```


```
## knitr
```

```
## datasets
```

```
## GGally
```

```
## ggplot2
```

```
## datasets
```

```
## stats
```

```
## graphics
```

```
## datasets
```

```
## dplyr
```

```
## rgl
```

```
## GGally
```

```
## ggplot2
```

```
## car
```

```
## datasets
```

```
## dplyr
```

