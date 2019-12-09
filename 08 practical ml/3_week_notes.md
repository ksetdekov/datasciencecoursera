---
title: "Practical machine learning  lectures 3"
author: "Kirill Setdekov"
date: "December 02 2019"
output:
  html_document:
    keep_md: yes
---



# week 3

## predicting with trees

1. start with all vars
2. find the best separating variable
3. divide the data into two leaves on that node
4. within each split, find the best variable/split that separates the outcomes
5. continue until the groups are too small or sufficientrly "pure"

### measures of impurity

Misclassification Error

$$\hat{P}_{mk} = \frac{1}{N_m}\sum_{x_i\; in \; Leaf \; m}\mathbb{1}(y_i = k)$$
__Misclassification Error__: 
$$ 1 - \hat{p}_{m k(m)}; k(m) = {\rm most; common; k}$$ 
* 0 = perfect purity
* 0.5 = no purity

__Gini index__:
$$ \sum_{k \neq k'} \hat{p}_{mk} \times \hat{p}_{mk'} = \sum_{k=1}^K \hat{p}_{mk}(1-\hat{p}_{mk}) = 1 - \sum_{k=1}^K p_{mk}^2$$

* 0 = perfect purity
* 0.5 = no purity

__Deviance/information gain__:

$$ -\sum_{k=1}^K \hat{p}_{mk} \log_2\hat{p}_{mk} $$
* 0 = perfect purity
* 1 = no purity

http://en.wikipedia.org/wiki/Decision_tree_learning


```r
data(iris)
library(ggplot2)
require(caret)
```

```
## Loading required package: caret
```

```
## Loading required package: lattice
```

```r
names(iris)
```

```
## [1] "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width" 
## [5] "Species"
```

```r
table(iris$Species)
```

```
## 
##     setosa versicolor  virginica 
##         50         50         50
```


```r
inTrain <- createDataPartition(y = iris$Species,
                               p = 0.7,
                               list = FALSE)
training <- iris[inTrain, ]
testing <- iris[-inTrain, ]
dim(training)
```

```
## [1] 105   5
```

```r
dim(testing)
```

```
## [1] 45  5
```


---

## Iris petal widths/sepal width


```r
qplot(Petal.Width, Sepal.Width, colour = Species, data = training)
```

![](3_week_notes_files/figure-html/unnamed-chunk-1-1.png)<!-- -->

```r
library(caret)
modFit <- train(Species ~ .,method="rpart",data=training)
print(modFit$finalModel)
```

```
## n= 105 
## 
## node), split, n, loss, yval, (yprob)
##       * denotes terminal node
## 
## 1) root 105 70 setosa (0.3333333 0.3333333 0.3333333)  
##   2) Petal.Length< 2.45 35  0 setosa (1.0000000 0.0000000 0.0000000) *
##   3) Petal.Length>=2.45 70 35 versicolor (0.0000000 0.5000000 0.5000000)  
##     6) Petal.Width< 1.75 38  4 versicolor (0.0000000 0.8947368 0.1052632) *
##     7) Petal.Width>=1.75 32  1 virginica (0.0000000 0.0312500 0.9687500) *
```


## Plot tree


```r
plot(modFit$finalModel, uniform=TRUE, 
      main="Classification Tree")
text(modFit$finalModel, use.n=TRUE, all=TRUE, cex=.8)
```

![](3_week_notes_files/figure-html/unnamed-chunk-2-1.png)<!-- -->
## Prettier plots


```r
library(rattle)
```

```
## Rattle: A free graphical interface for data science with R.
## Version 5.2.0 Copyright (c) 2006-2018 Togaware Pty Ltd.
## Type 'rattle()' to shake, rattle, and roll your data.
```

```r
fancyRpartPlot(modFit$finalModel)
```

![](3_week_notes_files/figure-html/unnamed-chunk-3-1.png)<!-- -->

## Predicting new values


```r
predict(modFit,newdata=testing)
```

```
##  [1] setosa     setosa     setosa     setosa     setosa     setosa    
##  [7] setosa     setosa     setosa     setosa     setosa     setosa    
## [13] setosa     setosa     setosa     versicolor versicolor versicolor
## [19] versicolor versicolor versicolor versicolor versicolor versicolor
## [25] versicolor versicolor versicolor versicolor versicolor versicolor
## [31] virginica  virginica  virginica  virginica  virginica  virginica 
## [37] virginica  virginica  virginica  versicolor virginica  virginica 
## [43] virginica  virginica  virginica 
## Levels: setosa versicolor virginica
```


## Notes and further resources

* Classification trees are non-linear models
  * They use interactions between variables
  * Data transformations may be less important (monotone transformations)
  * Trees can also be used for regression problems (continuous outcome)
* Note that there are multiple tree building options
in R both in the caret package - [party](http://cran.r-project.org/web/packages/party/index.html), [rpart](http://cran.r-project.org/web/packages/rpart/index.html) and out of the caret package - [tree](http://cran.r-project.org/web/packages/tree/index.html)
* [Introduction to statistical learning](http://www-bcf.usc.edu/~gareth/ISL/)
* [Elements of Statistical Learning](http://www-stat.stanford.edu/~tibs/ElemStatLearn/)
* [Classification and regression trees](http://www.amazon.com/Classification-Regression-Trees-Leo-Breiman/dp/0412048418)

## bootstrap aggregating (bagging)

1. reasmple causes and make predictions
2. average or majority vote for model


```r
library(ElemStatLearn)
data(ozone, package = "ElemStatLearn")
ozone <- ozone[order(ozone$ozone),]
head(ozone)
```

```
##     ozone radiation temperature wind
## 17      1         8          59  9.7
## 19      4        25          61  9.7
## 14      6        78          57 18.4
## 45      7        48          80 14.3
## 106     7        49          69 10.3
## 7       8        19          61 20.1
```

bagging example

```r
ll <- matrix(NA, nrow = 10, ncol = 155)
for (i in 1:10) {
    ss <- sample(1:dim(ozone)[1], replace = T)
    ozone0 <- ozone[ss, ]
    ozone0 <- ozone0[order(ozone0$ozone), ]
    loess0 <- loess(temperature ~ ozone, data = ozone0, span = 0.2)
    ll[i, ] <- predict(loess0, newdata = data.frame(ozone = 1:155))
}
#average
with(ozone, plot(ozone, temperature, pch = 19, cex = 0.5))
for (i in 1:10) {
    lines(1:155, ll[i,], col="grey", lwd=1)
}
lines(1:155, apply(ll,2,mean), col="red", lwd=2)
```

![](3_week_notes_files/figure-html/unnamed-chunk-5-1.png)<!-- -->


bagging - lower variability with same bias


## baggin in caret

Some models perform bagging in train with $method$ options

* bagEarth
* treebag
* bagFDA

## custom bagging


```r
predictors = data.frame(ozone = ozone$ozone)
temperature = ozone$temperature
library(caret)
treebag <-
    bag(
        predictors,
        temperature,
        B = 10,
        bagControl = bagControl(
            fit = ctreeBag$fit,
            predict = ctreeBag$pred,
            aggregate = ctreeBag$aggregate
        )
    )
```

```
## Warning: executing %dopar% sequentially: no parallel backend registered
```
### custom bagging examples
greqy - actual
red - one tree
blue - fit from bagged regression

```r
with(ozone, plot(ozone, temperature, col = "lightgrey", pch = 19, cex = 0.5))
points(ozone$ozone, predict(treebag$fits[[1]]$fit, predictors), pch=19, col="red")
points(ozone$ozone, predict(treebag, predictors), pch=19, col="blue")
```

![](3_week_notes_files/figure-html/unnamed-chunk-7-1.png)<!-- -->
exploration

```r
ctreeBag$fit
```

```
## function (x, y, ...) 
## {
##     loadNamespace("party")
##     data <- as.data.frame(x)
##     data$y <- y
##     party::ctree(y ~ ., data = data)
## }
## <bytecode: 0x000000002496ba10>
## <environment: namespace:caret>
```

```r
ctreeBag$pred
```

```
## function (object, x) 
## {
##     if (!is.data.frame(x)) 
##         x <- as.data.frame(x)
##     obsLevels <- levels(object@data@get("response")[, 1])
##     if (!is.null(obsLevels)) {
##         rawProbs <- party::treeresponse(object, x)
##         probMatrix <- matrix(unlist(rawProbs), ncol = length(obsLevels), 
##             byrow = TRUE)
##         out <- data.frame(probMatrix)
##         colnames(out) <- obsLevels
##         rownames(out) <- NULL
##     }
##     else out <- unlist(party::treeresponse(object, x))
##     out
## }
## <bytecode: 0x000000002496b000>
## <environment: namespace:caret>
```

```r
ctreeBag$aggregate
```

```
## function (x, type = "class") 
## {
##     if (is.matrix(x[[1]]) | is.data.frame(x[[1]])) {
##         pooled <- x[[1]] & NA
##         classes <- colnames(pooled)
##         for (i in 1:ncol(pooled)) {
##             tmp <- lapply(x, function(y, col) y[, col], col = i)
##             tmp <- do.call("rbind", tmp)
##             pooled[, i] <- apply(tmp, 2, median)
##         }
##         if (type == "class") {
##             out <- factor(classes[apply(pooled, 1, which.max)], 
##                 levels = classes)
##         }
##         else out <- as.data.frame(pooled)
##     }
##     else {
##         x <- matrix(unlist(x), ncol = length(x))
##         out <- apply(x, 1, median)
##     }
##     out
## }
## <bytecode: 0x0000000024976858>
## <environment: namespace:caret>
```
__Notes__:

* Good for nonlinear model
* often used with trees - an extension is random forstrs
* some models use bagging in caret's train function

__Further resources__:

* [Bagging](http://en.wikipedia.org/wiki/Bootstrap_aggregating)
* [Bagging and boosting](http://stat.ethz.ch/education/semesters/FS_2008/CompStat/sk-ch8.pdf)
* [Elements of Statistical Learning](http://www-stat.stanford.edu/~tibs/ElemStatLearn/)

