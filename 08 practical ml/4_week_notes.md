---
title: "Practical machine learning  lectures 4"
author: "Kirill Setdekov"
date: "December 20 2019"
output:
  html_document:
    keep_md: yes
---



# week 4

## reguralized regressions

_idea_

1. fit regression
2. shrink large coefficients.

*good*

* can help with bias
* can help with model selection

*bad*

* may be computationally hard on big data
* worse than random forest and boosting


```r
library(ElemStatLearn)
data("prostate")
str(prostate)
```

```
## 'data.frame':	97 obs. of  10 variables:
##  $ lcavol : num  -0.58 -0.994 -0.511 -1.204 0.751 ...
##  $ lweight: num  2.77 3.32 2.69 3.28 3.43 ...
##  $ age    : int  50 58 74 58 62 50 64 58 47 63 ...
##  $ lbph   : num  -1.39 -1.39 -1.39 -1.39 -1.39 ...
##  $ svi    : int  0 0 0 0 0 0 0 0 0 0 ...
##  $ lcp    : num  -1.39 -1.39 -1.39 -1.39 -1.39 ...
##  $ gleason: int  6 6 7 6 6 6 6 6 6 6 ...
##  $ pgg45  : int  0 0 20 0 0 0 0 0 0 0 ...
##  $ lpsa   : num  -0.431 -0.163 -0.163 -0.163 0.372 ...
##  $ train  : logi  TRUE TRUE TRUE TRUE TRUE TRUE ...
```

<img class="center" src="prostate.png" height="450">

[Code here](http://www.cbcb.umd.edu/~hcorrada/PracticalML/src/selection.R)

## Most common pattern

<img class="center" src="trainingandtest.png" height="450">

http://www.biostat.jhsph.edu/~ririzarr/Teaching/649/


## good solution - split samples
* No method better when data/computation time permits it

* Approach
  1. Divide data into training/test/validation
  2. Treat validation as test data, train all competing models on the train data and pick the best one on validation. 
  3. To appropriately assess performance on new data apply to test set
  4. You may re-split and reperform steps 1-3

* Two common problems
  * Limited data
  * Computational complexity
  
http://www.biostat.jhsph.edu/~ririzarr/Teaching/649/
http://www.cbcb.umd.edu/~hcorrada/PracticalML/

Reqularized regression trades of variance for better bias

Assume $Y_i = f(X_i) + \epsilon_i$

$EPE(\lambda) = E\left[\{Y - \hat{f}_{\lambda}(X)\}^2\right]$

Suppose $\hat{f}_{\lambda}$ is the estimate from the training data and look at a new data point $X = x^*$

$$E\left[\{Y - \hat{f}_{\lambda}(x^*)\}^2\right] = \sigma^2 + \{E[\hat{f}_{\lambda}(x^*)] - f(x^*)\}^2 + var[\hat{f}_\lambda(x_0)]$$

<center> = Irreducible error + Bias$^2$ + Variance </center>

#### One more issue with high-dimensional data

More predictors than samples


```r
small = prostate[1:5, ]
lm(lpsa~., data = small)
```

```
## 
## Call:
## lm(formula = lpsa ~ ., data = small)
## 
## Coefficients:
## (Intercept)       lcavol      lweight          age         lbph  
##     9.60615      0.13901     -0.79142      0.09516           NA  
##         svi          lcp      gleason        pgg45    trainTRUE  
##          NA           NA     -2.08710           NA           NA
```
## Hard thresholding

* Model $Y = f(X) + \epsilon$

* Set $\hat{f}_{\lambda}(x) = x'\beta$

* Constrain only $\lambda$ coefficients to be nonzero. 

* Selection problem is after chosing $\lambda$ figure out which $p - \lambda$ coefficients to make nonzero

http://www.biostat.jhsph.edu/~ririzarr/Teaching/649/
http://www.cbcb.umd.edu/~hcorrada/PracticalML/

---

## Regularization for regression

If the $\beta_j$'s are unconstrained:
* They can explode
* And hence are susceptible to very high variance

To control variance, we might regularize/shrink the coefficients. 

$$ PRSS(\beta) = \sum_{j=1}^n (Y_j - \sum_{i=1}^m \beta_{1i} X_{ij})^2 + P(\lambda; \beta)$$

where $PRSS$ is a penalized form of the sum of squares. Things that are commonly looked for

* Penalty reduces complexity
* Penalty reduces variance
* Penalty respects structure of the problem

---

## Ridge regression

Solve:

$$ \sum_{i=1}^N \left(y_i - \beta_0 + \sum_{j=1}^p x_{ij}\beta_j \right)^2 + \lambda \sum_{j=1}^p \beta_j^2$$

equivalent to solving

$\sum_{i=1}^N \left(y_i - \beta_0 + \sum_{j=1}^p x_{ij}\beta_j \right)^2$ subject to $\sum_{j=1}^p \beta_j^2 \leq s$ where $s$ is inversely proportional to $\lambda$ 


Inclusion of $\lambda$ makes the problem non-singular even if $X^TX$ is not invertible.

http://www.biostat.jhsph.edu/~ririzarr/Teaching/649/
http://www.cbcb.umd.edu/~hcorrada/PracticalML/

## Tuning parameter $\lambda$

* $\lambda$ controls the size of the coefficients
* $\lambda$ controls the amount of {\bf regularization}
* As $\lambda \rightarrow 0$ we obtain the least square solution
* As $\lambda \rightarrow \infty$ we have $\hat{\beta}_{\lambda=\infty}^{ridge} = 0$


## Lasso 

$\sum_{i=1}^N \left(y_i - \beta_0 + \sum_{j=1}^p x_{ij}\beta_j \right)^2$ subject to $\sum_{j=1}^p |\beta_j| \leq s$ 

also has a lagrangian form 

$$ \sum_{i=1}^N \left(y_i - \beta_0 + \sum_{j=1}^p x_{ij}\beta_j \right)^2 + \lambda \sum_{j=1}^p |\beta_j|$$

For orthonormal design matrices (not the norm!) this has a closed form solution

$$\hat{\beta}_j = sign(\hat{\beta}_j^0)(|\hat{\beta}_j^0 - \gamma)^{+}$$
 
but not in general. 

Good model as it 

## Notes and further reading


* [Hector Corrada Bravo's Practical Machine Learning lecture notes](http://www.cbcb.umd.edu/~hcorrada/PracticalML/)
* [Hector's penalized regression reading list](http://www.cbcb.umd.edu/~hcorrada/AMSC689.html#readings)
* [Elements of Statistical Learning](http://statweb.stanford.edu/~tibs/ElemStatLearn/)
* In `caret` methods are:
  * `ridge`
  * `lasso`
  * `relaxo`
  

```r
library(dplyr)

library(caret)
require(ISLR)
data(Wage)
require(ggplot2)

Wage <- subset(Wage, select = -c(logwage))
inTrain <- createDataPartition(y=Wage$wage, p=0.7, list = FALSE)
training <- Wage[inTrain,]
testing <- Wage[-inTrain,]
modFit <- train(wage~., method = "lm", data = training, verbose = FALSE)

print(modFit)
```

```
## Linear Regression 
## 
## 2102 samples
##    9 predictor
## 
## No pre-processing
## Resampling: Bootstrapped (25 reps) 
## Summary of sample sizes: 2102, 2102, 2102, 2102, 2102, 2102, ... 
## Resampling results:
## 
##   RMSE      Rsquared   MAE     
##   34.53186  0.3289216  23.25285
## 
## Tuning parameter 'intercept' was held constant at a value of TRUE
```

Это результат для простой модели


```r
qplot(predict(modFit,testing), wage, data = testing)
```

![](4_week_notes_files/figure-html/unnamed-chunk-3-1.png)<!-- -->

```r
MLmetrics::RMSE(y_pred = predict(modFit,testing),y_true = testing$wage)
```

```
## [1] 34.18433
```

```r
lasso_caret<- train(wage~., data = training, method = "glmnet", lambda= 0,
                    tuneGrid = expand.grid(alpha = 1,  lambda = 0))
print(lasso_caret)
```

```
## glmnet 
## 
## 2102 samples
##    9 predictor
## 
## No pre-processing
## Resampling: Bootstrapped (25 reps) 
## Summary of sample sizes: 2102, 2102, 2102, 2102, 2102, 2102, ... 
## Resampling results:
## 
##   RMSE      Rsquared   MAE     
##   34.08297  0.3155644  23.04166
## 
## Tuning parameter 'alpha' was held constant at a value of 1
## 
## Tuning parameter 'lambda' was held constant at a value of 0
```

```r
qplot(predict(lasso_caret,testing), wage, data = testing)
```

![](4_week_notes_files/figure-html/unnamed-chunk-3-2.png)<!-- -->

```r
MLmetrics::RMSE(y_pred = predict(lasso_caret,testing),y_true = testing$wage)
```

```
## [1] 34.18404
```
Это результат для модели с Lasso




