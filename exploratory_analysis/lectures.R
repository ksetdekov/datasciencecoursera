#week 1 ########################################################################
library(datasets)
data("cars")
with(cars, plot(speed, dist))

library(lattice)
state <- data.frame(state.x77, region = state.region)
xyplot(Life.Exp ~ Income | region,
       data = state,
       layout = c(4, 1))
library(party)
cfit1 <- ctree(Life.Exp ~ ., data = state)
plot(cfit1)

library(ggplot2)
data(mpg)
data <- mpg
datamod <- data
datamod$manufacturer <- factor(datamod$manufacturer)
datamod$model <- factor(datamod$model)
datamod$trans <- factor(datamod$trans)
datamod$drv <- factor(datamod$drv)
datamod$fl <- factor(datamod$fl)
datamod$class <- factor(datamod$class)

cfit1 <- ctree(hwy ~ ., data = datamod[, -c(2, 8)])
plot(cfit1)
datamod$predmpg <- predict(cfit1, datamod)
library(InformationValue)
library(MLmetrics)
# plotROC(datamod$predmpg, datamod$hwy)
Gini(datamod$hwy, datamod$predmpg)

library(datasets)
hist(airquality$Ozone) ## Draw a new plot
rug(airquality$Ozone)

with(airquality, plot(Wind, Ozone))

#boxplot
airquality <- transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, airquality, xlab = "Month", ylab = "Ozone (ppb)")
airquality <- na.omit(airquality)
cfit2 <- ctree(Ozone ~ ., data = airquality[, -c(6)])
plot(cfit2)

par("bg")
par("mar")
par("mfrow") # сколько графиков

#base plots
with(airquality, plot(Wind, Ozone))
title(main = "Ozone and with in NY city") ## title

with(airquality, plot(Wind, Ozone, main = " Ozone and Wind in Ny"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))

# type="n" - does now draw

with(airquality,
     plot(Wind, Ozone, main = "Ozone and Wind in New York City",
          type = "n"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))
with(subset(airquality, Month != 5), points(Wind, Ozone, col = "red"))
legend(
        "topright",
        pch = 1,
        col = c("blue", "red"),
        legend = c("May", "Other Months")
)

#adding regression
with(airquality,
     plot(Wind, Ozone, main = "Ozone and Wind in New York City",
          pch = 20))
model <- lm(Ozone ~ Wind, airquality)
abline(model, lwd = 2)

#multiple plots
par(mfrow = c(1, 2))
with(airquality, {
        plot(Wind, Ozone, main = "Ozone and Wind")
        plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
})

#with names
par(
        mfrow = c(1, 3),
        mar = c(4, 4, 2, 1),
        oma = c(0, 0, 2, 0)
)
with(airquality, {
        plot(Wind, Ozone, main = "Ozone and Wind")
        plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
        plot(Temp, Ozone, main = "Ozone and Temperature")
        mtext("Ozone and Weather in New York City", outer = TRUE)
})
dev.off()
#demo
x <- rnorm(100)
hist(x)

y <- rnorm(100)
plot(x, y)

par("mar")
par(mar = c(4, 4, 2, 2))
plot(x, y)
plot(x, y, pch = 20)
plot(x, y, pch = 19)
plot(x, y, pch = 2)
plot(x, y, pch = 3)
plot(x, y, pch = 4)
# example("points")
title("Scatterplot")
text(-2, -2, "Label")
legend("topleft", legend = "Data", pch = 4)
fit <- lm(y ~ x)
abline(fit)
cbind.data.frame(y, x)
corrplot::corrplot(cbind.data.frame(y, x))
library(corrplot)
yx <- cbind.data.frame(y, x)
cor(yx)
corrplot(cor(yx))


plot(x, y, pch = 4)
# example("points")
title("Scatterplot")
text(-2, -2, "Label")
legend("topleft", legend = "Data", pch = 4)
fit <- lm(y ~ x)
abline(fit, lwd = 3, col = "blue")

#all
plot(
        x,
        y,
        xlab = "weight",
        ylab = "height",
        main = "scatterplot",
        pch = 20
)
legend("topright", legend = "data", pch = 20)
fit <- lm(y ~ x)
abline(fit, lwd = 3, col = "red")

z <- rpois(100, 2)

par(mfrow = c(2, 1))
plot(x, y, pch = 20)
plot(x, z, pch = 19)
par("mar") ## too big
par(mar = c(2, 2, 1, 1))
plot(x, y, pch = 20)
plot(x, z, pch = 19)

x <- rnorm(100)
y <- x + rnorm(100)
g <- gl(2, 50)
g <- gl(2, 50, labels = c("male", "female"))
str(g)

plot(x, y)
cfit2 <- ctree(g ~ y + x)
plot(cfit2)

plot(x, y, type = "n")
points(x[g == "male"], y[g == "male"], col = "green")
points(x[g == "female"], y[g == "female"], col = "blue", pch = 19)

#devices
library(datasets)
with(faithful, plot(eruptions, waiting))
title(main = "old faithful geyser data")
library(party)
cfit3 <- ctree(eruptions ~ ., data = faithful)
plot(cfit3)

faithful$prederuptions <- predict(cfit3, faithful)
library(InformationValue)
library(MLmetrics)
#plotROC(faithful$eruptions, faithful$prederuptions)
Gini(faithful$prederuptions , faithful$eruptions)
with(faithful, plot(eruptions, prederuptions))
setwd("exploratory_analysis")
#launch graphic dev
pdf(file = "myplot.pdf")
plot(cfit3)
dev.cur()
dev.set(dev.cur())
dev.off()

#dev.copy
with(faithful, plot(eruptions, waiting))
title(main = "old faithful geyser data")
dev.copy(png, file = "geyser.png")
dev.off()

#week 2 ########################################################################
# lattice package
# usefull
# xyplot, xyplot (y~x| f*g, data), f and g - conditional variables
# bwplot
# stripplot
# dotplot
# splom
# levelplot
# contourplot

library(lattice)
library(datasets)
## scatterplot
xyplot(Ozone ~ Wind, data = airquality)

## with factors
airquality <- transform(airquality, Month = factor(Month))
xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(5, 1))
# they do not plot, return class trellis and this is printed

p <- xyplot(Ozone ~ Wind, data = airquality)
print(p)

#have panel functions
set.seed(100)
x <- rnorm(100)
f <- rep(0:1, each = 50)
y <- x + f - f * x + rnorm(100, sd = 0.5)
f <- factor(f, labels = c("gr 1", "gr 2"))
xyplot(y ~ x | f, layout = c(2, 1))
# custom panel function can be applied
xyplot(
        y ~ x | f,
        layout = c(2, 1),
        panel = function(x, y, ...) {
                panel.xyplot(x, y, ...) ## with median
                panel.abline(h = median(y), lty = 2)
        }
)

xyplot(
        y ~ x | f,
        layout = c(2, 1),
        panel = function(x, y, ...) {
                panel.xyplot(x, y, ...)
                panel.lmline(x, y, col = "Green") # with green regression
        }
)

#base annotation do not work here
## great for conditional plotting
## great for many data in quick way

## ggplot2
## implementation of grammar of graphics, can put together and make new graphs
## third graphics system for R
require(ggplot2)
qplot(rnorm(100000) * 3) #qplot
## factors are important, but they should be named
str(mpg)
qplot(displ, hwy, data = mpg)
qplot(displ, hwy, data = mpg, color = drv)
qplot(displ,
      hwy,
      data = mpg,
      geom = c("point", "smooth"))
qplot(hwy, data = mpg, fill = drv)
qplot(displ, hwy, data = mpg, facets = . ~ drv) # colums #facets - panels by drive
qplot(hwy, data = mpg, facets = drv ~ .)  #row
qplot(
        displ,
        hwy,
        data = mpg,
        facets = drv ~ cyl,
        geom = c("point", "smooth")
)  #both

qplot(hwy,
      data = mpg,
      fill = drv,
      geom = c("density")) ## smooth

qplot(hwy, displ, data = mpg, color = drv) + geom_smooth(method = "lm") ## great!
qplot(hwy, displ, data = mpg, facets = . ~ drv) + geom_smooth(method = "lm") ## same byt split

## need data frame
## aethetic mapping - how data mappet
## geoms - geometric objects
## facets - conditioanl plots
## stats - statistic transf
## scales what scale an aethetic map uses

## vs qplot - articsitc palette
## plots are built up in laers

g <- ggplot(mpg, aes(displ, hwy))
summary(g)
print(g)
p <- g + geom_point()
g + geom_point() ## auto print
print(p)
g + geom_point() + geom_smooth()
g + geom_point() + geom_smooth(method = "glm")
g + geom_point() + geom_smooth(method = "lm")
g + geom_point() + geom_smooth(method = "gam")
mpg <- mpg
mpg$year <- as.factor(mpg$year)
qplot(displ, hwy, col = year, data = mpg) + geom_smooth(method = "lm")
g + geom_point() + geom_smooth(method = "lm") + facet_grid(. ~ cyl) ## adding facets by additional variable
g + geom_point(aes(col = cyl)) + geom_smooth(
        method = "lm",
        size = 4,
        linetype = 3,
        se = FALSE
) + theme_bw(base_family = "Arial")## adding colot

## about outliers
testdat <- data.frame(x = 1:100, y = rnorm(100))
testdat[50, 2] <- 100
plot(testdat$x, testdat$y, type = "l", ylim = c(-3, 3))
g <- ggplot(testdat, aes(x = x, y = y))
g + geom_line()
g + geom_line() + ylim(-3, 3)
g + geom_line() + coord_cartesian(ylim = c(-3, 3)) ## proper limit

## cutting data by displacement
cutpoints <-
        quantile(mpg$displ, seq(0, 1, length = 4), na.rm = TRUE)

mpg$displcat <- cut(mpg$displ, cutpoints)


levels(mpg$displcat)
g <- ggplot(mpg, aes(cyl, hwy))
g + geom_point(alpha = 1 / 3) + facet_wrap(year ~ displcat, nrow = 2, ncol = 4) + geom_smooth(method = "lm", se = FALSE, col = "steelblue") + theme_bw(base_size = 10) +
        labs(x = "number of cyls") + labs(y = "hyw mpg") + labs(title = "mpg data")
dev.off
# week 2 quiz
library(nlme)
library(lattice)
xyplot(weight~Time|Diet, BodyWeight)

library(lattice)
library(datasets)
data("airquality")
p <- xyplot(Ozone~Wind|factor(Month), data = airquality)
p
qplot(Wind,Ozone, data = airquality, facets = .~factor(Month))
install.packages("ggplot2movies")
library(ggplot2movies)
g <- ggplot(movies, aes(votes,rating))
print(g)
movies <- movies
qplot(votes,rating, data = movies)+geom_smooth()


#week 3 #####################
#clustering
## what is close, how we group,  how visualize, how do we interpret?
# hierarchichal
# find two closest
# put them together
# find nex closest

#need 1) define distance 2) merge approach

# distance - euclidean distance, similarity, binary = manhattan distance

set.seed(1234)
par(mar=c(0,0,0,0))
x <- rnorm(12, mean = rep(1:3, each=4), sd=0.2)
y <- rnorm(12, mean=rep(c(1,2,1), each=4), sd=0.2)
plot(x,y, col="blue", pch=19, cex=2)
text(x+0.05, y+0.05, labels=as.character(1:12))
dataFrame <- data.frame(x=x,y=y)
distxy <- dist(dataFrame)## dist matrix
hclustering <- hclust(distxy)
plot(hclustering)
## need to choose where to cut
# useing better plot
source("prettyclust.R")
myplclust(hclustering, lab = rep(1:3, each=4), lab.col = rep(1:3,each=4))
# distance - average - average distance
# there is a different - complete linkage, use maximum difference

# heatpmap info
dataFrame <- data.frame(x=x,y=y)
set.seed(143)
dataMatrix <- as.matrix(dataFrame)[sample(1:12),]
heatmap(dataMatrix)

#kmeans clustering
#fix number of clusters
# get centroids
#assign thigs to closest centroid
# recalculate ceentroids

#need 1) distance 2)cluster N 3) initital guest
set.seed(1234)
par(mar=c(0,0,0,0))
x <- rnorm(12, mean = rep(1:3, each=4), sd=0.2)
y <- rnorm(12, mean=rep(c(1,2,1), each=4), sd=0.2)
plot(x,y, col="blue", pch=19, cex=2)
text(x+0.05, y+0.05, labels=as.character(1:12))

#kmeans()
dataFrame <- data.frame(x,y)
kmeansObj <- kmeans(dataFrame,centers = 3)
names(kmeansObj)
kmeansObj$cluster
plot(x,y,col=kmeansObj$cluster, pch=19, cex=2)
points(kmeansObj$centers, col=1:3, pch=3, cex=2, lwd=3)

#visualize tables
dataMatrix <- as.matrix(dataFrame)[sample(1:12),]
kmeansObj2 <- kmeans(dataMatrix,centers = 3)
par(mfrow=c(1,2), mar=c(2,4,0.1,0.1))
image(t(dataMatrix)[,nrow(dataMatrix):1],yaxt="n")
image(t(dataMatrix)[,order(kmeansObj2$cluster)],yaxt="n")

#dimension reduction
set.seed(12345)
par(mar=rep(0.2,4))
dataMatrix <- matrix(rnorm(400),nrow = 40)
image(1:10,1:40,t(dataMatrix)[,nrow(dataMatrix):1])
heatmap(dataMatrix) # no pattern

#add pattern
set.seed(678910)
for(i in 1:40){
        #flip a coin
        coinFlip <- rbinom(1, size = 1, prob = 0.5)
        if(coinFlip){
                dataMatrix[i,] <- dataMatrix[i,]+rep(c(0,3), each=5)
        }
}
heatmap(dataMatrix) # with pattern

#look at patterns in rows and colimns
hh <- hclust(dist(dataMatrix))
dataMatrixOrdered <- dataMatrix[hh$order,]
par(mfrow=c(1,3))
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1])
plot(rowMeans(dataMatrixOrdered) ,xlab = "rowmean", ylab = "row")
plot(colMeans(dataMatrixOrdered),xlab = "column", ylab = "col mean")

#related problem - create uncorrelated set of data with reduced set of variables
#lower rank matrix with reasonable explaination
## SVD - Singular value decomposition X=UDV^T
## PCA - run SVD on normalized data

svd1 <- svd(scale(dataMatrixOrdered))
par(mfrow=c(1,3))
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1])
plot(svd1$u[,1 ],xlab = "row", ylab = "first left singular vector")
plot(svd1$v[,1 ],xlab = "column", ylab = "First right singular vector")

#component of svd - variance explained (% of variance explained by this component)
par(mfrow=c(1,2))
plot(svd1$d, xlab = "column", ylab = "singular value")
plot(svd1$d^2/sum(svd1$d^2), xlab = "column", ylab = "Proportion of variance explained", pch = 19)

#1 pc in x, single vector
svd1 <- svd(scale(dataMatrixOrdered))
pca1 <- prcomp(dataMatrixOrdered, scale=TRUE)
plot(pca1$rotation[,1], svd1$v[,1], pch=19, xlab = "principal component 1", ylab = "Right singular vector 1")
abline(c(0,1))

# components of svd - variance explained
constantMatrix <- dataMatrixOrdered*0
for(i in 1:dim(dataMatrixOrdered)[1]){
        constantMatrix[i,] <- rep(c(0,1), each=5)
}
svd1 <- svd(constantMatrix)
par(mfrow=c(1,3))
image(t(constantMatrix)[,nrow(constantMatrix):1])
plot(svd1$d, xlab = "column", ylab = "singular value") ## because there is only one pattern
plot(svd1$d^2/sum(svd1$d^2), xlab = "column", ylab = "Proportion of variance explained", pch = 19)

# add a second pattern
set.seed(678910)
for (i in 1:40){
        coinFlip1 <- rbinom(1,size = 1, prob = 0.5)
        coinFlip2 <- rbinom(1,size = 1, prob = 0.5)
        if(coinFlip1){
                dataMatrix[i,] <- dataMatrix[i,]+rep(c(0,5), each=5)
        }
        if(coinFlip2){
                dataMatrix[i,] <- dataMatrix[i,]+rep(c(0,5),5)
        }
        
}
hh <- hclust(dist(dataMatrix))
dataMatrixOrdered <- dataMatrix[hh$order,]

svd2 <- svd(scale(dataMatrixOrdered))
par(mfrow=c(1,3))
image(t(dataMatrixOrdered)[,1:nrow(dataMatrixOrdered)])
plot(rep(c(0,1),each=5), xlab = "col", ylab = "pattern 1")
plot(rep(c(0,1),5), xlab = "col", ylab = "pattern 2")


#v and patternss in variance in row
par(mfrow=c(1,3))
image(t(dataMatrixOrdered)[,1:nrow(dataMatrixOrdered)])
plot(svd2$v[,1], xlab = "col", ylab = "first right singular vector")
plot(svd2$v[,2], xlab = "col", ylab = "second right singular vector")
## pattern similar, but hard to see the truth

#d and variance explained
svd1 <- svd(scale(dataMatrixOrdered))
par(mfrow=c(1,2))
plot(svd1$d, xlab = "column", ylab = "singular value")
plot(svd1$d^2/sum(svd1$d^2), xlab = "column", ylab = "Proportion of variance explained", pch = 19)

# issues with PCA and SVD
#problem with missing values
dataMatrix2 <- dataMatrixOrdered
dataMatrix2[sample(1:100, size = 40, replace = FALSE)] <- NA
svd1 <- svd(scale(dataMatrix2)) ##doesnt work with missing variables

# battling missing variables
library(impute)
dataMatrix2 <- dataMatrixOrdered
dataMatrix2[sample(1:100, size = 40, replace = FALSE)] <- NA
dataMatrix2 <- impute.knn(dataMatrix2)$data
svd1 <- svd(scale(dataMatrixOrdered))
svd2 <- svd(scale(dataMatrix2))
par(mfrow=c(1,2))
plot(svd1$v[,1])
plot(svd2$v[,1])


## face exapmle
library(imager)
face <- load.image("face.jpg")
bwface <- grayscale(face, method = "Luma", drop = TRUE)
bwface <- resize(bwface,round(width(bwface)/10),round(height(bwface)/10))
plot(bwface)
faceData <- matrix(bwface, nrow = 346)
faceData <- t(faceData)
image(t(faceData)[,nrow(faceData):1]) # my face

svd1 <- svd(scale(faceData))
plot(svd1$d^2/sum(svd1$d^2), xlab = "singular vector", ylab = "Proportion of variance explained", pch = 19)

#face create approximations
approx1 <- svd1$u[,1]%*%t(svd1$v[,1])*svd1$d[1]
# make diagonal matrix out of d and multiplicate many pc
approx10 <- svd1$u[,1:10] %*% diag(svd1$d[1:10])%*%t(svd1$v[,1:10])
approx20 <- svd1$u[,1:20]%*%diag(svd1$d[1:20])%*%t(svd1$v[,1:20])
dev.off()
par(mfrow=c(1,4))
image(t(approx1)[,nrow(approx1):1], main="1") 
image(t(approx10)[,nrow(approx10):1], main="10") 
image(t(approx20)[,nrow(approx20):1], main="20") 

image(t(faceData)[,nrow(faceData):1], main="d") 

#alternatives
#factor analysys
# ingependent component analysis
# latent semantic analysis
