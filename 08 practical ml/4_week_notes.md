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



# ensembling methods

* combine classifiers by averaging, Voting
* combininig -> greater accuracy
* reduce interpretability
* boosting, bagging and RF does this with one type of predictions

## approaches

1. boosting, bagging and RF 
    * similar classifier
2. combine different classifiers
    * model stacking 
    * model ensembling


```r
#separate in 3 sets
library(ISLR)
data("Wage")
library(ggplot2)
library(caret)
Wage <- subset(Wage, select = -c(logwage))
inBuild <- createDataPartition(y=Wage$wage, p=0.7, list = FALSE)
validation <- Wage[-inBuild,]
buildData <- Wage[inBuild,]
inTrain <- createDataPartition(y=buildData$wage, p=0.7, list = FALSE)
training <- buildData[inTrain,]
testing <- buildData[-inTrain,]
```

### build 2 models


```r
library(party)
```

```
## Loading required package: grid
```

```
## Loading required package: mvtnorm
```

```
## Loading required package: modeltools
```

```
## Loading required package: stats4
```

```
## Loading required package: strucchange
```

```
## Loading required package: zoo
```

```
## 
## Attaching package: 'zoo'
```

```
## The following objects are masked from 'package:base':
## 
##     as.Date, as.Date.numeric
```

```
## Loading required package: sandwich
```

```r
mod1 <- train(wage~., method ="glm", data = training)
mod2 <- train(wage~., method ="rf", data = training, trControl = trainControl(method = "cv"),number = 3)
mod3 <- train(wage~., method ="rpart", data = training)
mod4 <- train(wage~., method ="ctree", data = training)
mod5 <- mob(wage~age+education|year+maritl+race+region+jobclass+health+health_ins,data = training)
```
### compare them

```r
pred1 <- predict(mod1, testing)
```

```
## Warning in predict.lm(object, newdata, se.fit, scale = 1, type = if (type
## == : prediction from a rank-deficient fit may be misleading
```

```r
pred2 <- predict(mod2, testing)
pred3 <- predict(mod3, testing)
pred4 <- predict(mod4, testing)
pred5 <- predict(mod5, testing)
                 
qplot(pred1,pred2, colour = wage, data = testing)
```

![](4_week_notes_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

```r
qplot(pred3,pred4, colour = wage, data = testing)
```

![](4_week_notes_files/figure-html/unnamed-chunk-5-2.png)<!-- -->

```r
library(rattle)
```

```
## Rattle: A free graphical interface for data science with R.
## Version 5.2.0 Copyright (c) 2006-2018 Togaware Pty Ltd.
## Type 'rattle()' to shake, rattle, and roll your data.
```

```r
fancyRpartPlot(mod3$finalModel)
```

![](4_week_notes_files/figure-html/unnamed-chunk-5-3.png)<!-- -->

```r
plot(mod4$finalModel)
```

![](4_week_notes_files/figure-html/unnamed-chunk-5-4.png)<!-- -->

```r
plot(mod5)
```

![](4_week_notes_files/figure-html/unnamed-chunk-5-5.png)<!-- -->

```r
qplot(wage,pred5, colour = wage, data = testing)
```

![](4_week_notes_files/figure-html/unnamed-chunk-5-6.png)<!-- -->

### make a model that combines predictors


```r
predDF2 <- data.frame(pred1, pred2, wage = testing$wage)
#variant with 5
predDF5 <- data.frame(pred1, pred2, pred3, pred4, pred5, wage = testing$wage)

combModFit2 <- train(wage~., method = "gam", data = predDF2)
```

```
## Loading required package: mgcv
```

```
## Loading required package: nlme
```

```
## 
## Attaching package: 'nlme'
```

```
## The following object is masked from 'package:dplyr':
## 
##     collapse
```

```
## This is mgcv 1.8-28. For overview type 'help("mgcv-package")'.
```

```r
combModFit5 <- train(wage~., method = "gam", data = predDF5)
combPred2 <- predict(combModFit2,predDF2)
combPred5 <- predict(combModFit5,predDF2)
```

#### testing errors

```r
MLmetrics::RMSE(y_pred = pred1,y_true = testing$wage)
```

```
## [1] 38.44443
```

```r
MLmetrics::RMSE(y_pred = pred2,y_true = testing$wage)
```

```
## [1] 39.17575
```

```r
MLmetrics::RMSE(y_pred = combPred2,y_true = testing$wage)
```

```
## [1] 38.14702
```

```r
MLmetrics::RMSE(y_pred = pred3,y_true = testing$wage)
```

```
## [1] 41.56397
```

```r
MLmetrics::RMSE(y_pred = pred4,y_true = testing$wage)
```

```
## [1] 40.02504
```

```r
MLmetrics::RMSE(y_pred = pred5,y_true = testing$wage)
```

```
## [1] 38.57218
```

```r
MLmetrics::RMSE(y_pred = combPred5,y_true = testing$wage)
```

```
## [1] 37.84403
```

```r
plot(combModFit5$finalModel)
```

![](4_week_notes_files/figure-html/unnamed-chunk-7-1.png)<!-- -->![](4_week_notes_files/figure-html/unnamed-chunk-7-2.png)<!-- -->![](4_week_notes_files/figure-html/unnamed-chunk-7-3.png)<!-- -->
### on a validation

```r
pred1V <- predict(mod1, validation)
```

```
## Warning in predict.lm(object, newdata, se.fit, scale = 1, type = if (type
## == : prediction from a rank-deficient fit may be misleading
```

```r
pred2V <- predict(mod2, validation)
predVDF2 <- data.frame(pred1 = pred1V, pred2 = pred2V)
combPredV2 <- predict(combModFit2, predVDF2)

pred3V <- predict(mod3, validation)
pred4V <- predict(mod4, validation)
pred5V <- predict(mod5, validation)
predVDF5 <-
    data.frame(
        pred1 = pred1V,
        pred2 = pred2V,
        pred3 = pred3V,
        pred4 = pred4V,
        pred5 = pred5V
    )
combPredV5 <- predict(combModFit5,predVDF5)
MLmetrics::RMSE(y_pred = pred1V,y_true = validation$wage)
```

```
## [1] 32.12092
```

```r
MLmetrics::RMSE(y_pred = pred2V,y_true = validation$wage)
```

```
## [1] 32.61731
```

```r
MLmetrics::RMSE(y_pred = combPredV2,y_true = validation$wage)
```

```
## [1] 31.80675
```

```r
## 5 part model
MLmetrics::RMSE(y_pred = pred3V,y_true = validation$wage)
```

```
## [1] 34.92727
```

```r
MLmetrics::RMSE(y_pred = pred4V,y_true = validation$wage)
```

```
## [1] 33.49814
```

```r
MLmetrics::RMSE(y_pred = pred5V,y_true = validation$wage)
```

```
## [1] 32.17834
```

```r
MLmetrics::RMSE(y_pred = combPredV5,y_true = validation$wage)
```

```
## [1] 31.70679
```

## Notes and further resources

* Even simple blending can be useful
* Typical model for binary/multiclass data
  * Build an odd number of models
  * Predict with each model
  * Predict the class by majority vote
* This can get dramatically more complicated
  * Simple blending in caret: [caretEnsemble](https://github.com/zachmayer/caretEnsemble) (use at your own risk!)
  * Wikipedia [ensemlbe learning](http://en.wikipedia.org/wiki/Ensemble_learning)

---

## Recall - scalability matters

[http://www.techdirt.com/blog/innovation/articles/20120409/03412518422/](http://www.techdirt.com/blog/innovation/articles/20120409/03412518422/)

[http://techblog.netflix.com/2012/04/netflix-recommendations-beyond-5-stars.html](http://techblog.netflix.com/2012/04/netflix-recommendations-beyond-5-stars.html)
