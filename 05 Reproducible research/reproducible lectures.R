setwd("C:/Users/ksetd/Dropbox/datascience/datasciencecoursera/05 Reproducible research")
library(kernlab)
data(spam)
set.seed(3435)
trainIndicator=rbinom(dim(spam)[1],size = 1,prob=0.5)
table(trainIndicator)

trainSpam=spam[trainIndicator==1,]
testSpam=spam[trainIndicator==0,]
names(trainSpam)
table(trainSpam$type)
plot(trainSpam$capitalAve~trainSpam$type)
library(party)
cfit1 <- ctree(type ~ ., data = trainSpam)
plot(cfit1)
traintypepred <- predict(cfit1, trainSpam)
library(InformationValue)
library(MLmetrics)
traintypepred <-ifelse(traintypepred=="spam",1,0)
truth <- ifelse(trainSpam$type=="spam",1,0)

testtypepred <- predict(cfit1, testSpam)
testtypepred <-ifelse(testtypepred=="spam",1,0)
truthtest <- ifelse(testSpam$type=="spam",1,0)

plotROC(traintypepred, truth)
Gini(truth, traintypepred)

plotROC(testtypepred, truthtest)
Gini(truthtest, testtypepred)

plot(log10(trainSpam$capitalAve+1)~trainSpam$type)
plot(log10(trainSpam[,1:4]+1))

#use hclust
hClust <- hclust(dist(t(trainSpam[,1:57])))
plot(hClust)
hClustup <- hclust(dist(t(log10(trainSpam[,1:57]+1))))
plot(hClustup)
## statistical model #### 

trainSpam$numType = as.numeric(trainSpam$type) - 1
costFunction = function(x, y) sum(x != (y > 0.5))
cvError = rep(NA, 55)
library(boot)
for (i in 1:55) {
        lmFormula = reformulate(names(trainSpam)[i], response = "numType")
        glmFit = glm(lmFormula, family = "binomial", data = trainSpam)
        cvError[i] = cv.glm(trainSpam, glmFit, costFunction, 2)$delta[2]
}
## Which predictor has minimum cross-validated error?
names(trainSpam)[which.min(cvError)]

## Use the best model from the group
predictionModel = glm(numType ~ charDollar, family = "binomial", data = trainSpam)
## Get predictions on the test set
predictionTest = predict(predictionModel, testSpam)
predictedSpam = rep("nonspam", dim(testSpam)[1])
## Classify as `spam' for those with prob > 0.5
predictedSpam[predictionModel$fitted > 0.5] = "spam"
table(predictedSpam, testSpam$type)
traintypepredlect <-ifelse(predictedSpam=="spam",1,0)
(61 + 458)/(1346 + 458 + 61 + 449)

Gini(truthtest, traintypepredlect)
Gini(truthtest, testtypepred)

table( testtypepred,truthtest)
(107+104)/(107+104+1300+803)
