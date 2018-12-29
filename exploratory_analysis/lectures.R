#week 1 ########################################################################
library(datasets)
data("cars")
with(cars,plot(speed,dist))

library(lattice)
state <- data.frame(state.x77, region=state.region)
xyplot(Life.Exp~Income | region, data = state, layout= c(4,1))
library(party)
cfit1<-ctree(Life.Exp~.,data=state)
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

cfit1<-ctree(hwy~.,data=datamod[,-c(2,8)])
plot(cfit1)
datamod$predmpg <- predict(cfit1, datamod)
library(InformationValue)
library(MLmetrics)
# plotROC(datamod$predmpg, datamod$hwy)
Gini(datamod$hwy, datamod$predmpg)

library(datasets)
hist(airquality$Ozone) ## Draw a new plot
rug(airquality$Ozone)

with(airquality, plot(Wind,Ozone))

#boxplot
airquality <- transform(airquality, Month=factor(Month))
boxplot(Ozone~Month, airquality, xlab="Month", ylab="Ozone (ppb)")
airquality <- na.omit(airquality)
cfit2<-ctree(Ozone~.,data=airquality[,-c(6)])
plot(cfit2)

par("bg")
par("mar")
par("mfrow") # сколько графиков

#base plots
with(airquality, plot(Wind,Ozone))
title(main="Ozone and with in NY city") ## title

with(airquality, plot(Wind,Ozone, main= " Ozone and Wind in Ny"))
with(subset(airquality,Month==5), points(Wind, Ozone, col="blue"))

# type="n" - does now draw

with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City",
                      type = "n"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))
with(subset(airquality, Month != 5), points(Wind, Ozone, col = "red"))
legend("topright", pch = 1, col = c("blue", "red"), legend = c("May", "Other Months"))

#adding regression
with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City",
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
par(mfrow = c(1, 3), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
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
plot(x,y)

par("mar")
par(mar=c(4,4,2,2))
plot(x,y)
plot(x,y, pch=20)
plot(x,y, pch=19)
plot(x,y, pch=2)
plot(x,y, pch=3)
plot(x,y, pch=4)
# example("points")
title("Scatterplot")
text(-2,-2, "Label")
legend("topleft", legend="Data", pch=4)
fit <- lm(y~x)
abline(fit)
cbind.data.frame(y,x)
corrplot::corrplot(cbind.data.frame(y,x))
library(corrplot)
yx <- cbind.data.frame(y,x)
cor(yx)
corrplot(cor(yx))


plot(x,y, pch=4)
# example("points")
title("Scatterplot")
text(-2,-2, "Label")
legend("topleft", legend="Data", pch=4)
fit <- lm(y~x)
abline(fit, lwd=3, col="blue")

#all
plot(x,y, xlab="weight", ylab="height", main="scatterplot", pch=20)
legend("topright", legend="data", pch=20)
fit <- lm(y~x)
abline(fit, lwd=3, col="red")

z <- rpois(100,2)

par(mfrow=c(2,1))
plot(x,y, pch=20)
plot(x,z, pch=19)
par("mar") ## too big
par(mar=c(2,2,1,1))
plot(x,y, pch=20)
plot(x,z, pch=19)

x <- rnorm(100)
y <- x+rnorm(100)
g <- gl(2,50)
g <- gl(2,50, labels = c("male", "female"))
str(g)

plot(x,y)
cfit2<-ctree(g~y+x)
plot(cfit2)

plot(x,y, type="n")
points(x[g=="male"],y[g=="male"], col="green")
points(x[g=="female"],y[g=="female"], col="blue", pch=19)

#devices
library(datasets)
with(faithful, plot(eruptions,waiting))
title(main = "old faithful geyser data")
library(party)
cfit3<-ctree(eruptions~.,data=faithful)
plot(cfit3)

faithful$prederuptions <- predict(cfit3, faithful)
library(InformationValue)
library(MLmetrics)
#plotROC(faithful$eruptions, faithful$prederuptions)
Gini(faithful$prederuptions , faithful$eruptions)
with(faithful, plot(eruptions,prederuptions))
setwd("exploratory_analysis")
#launch graphic dev
pdf(file = "myplot.pdf")
plot(cfit3)
dev.cur()
dev.set(dev.cur())
dev.off()

#dev.copy
with(faithful, plot(eruptions,waiting))
title(main = "old faithful geyser data")
dev.copy(png,file="geyser.png")
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
xyplot(Ozone~Wind, data = airquality)

## with factors
airquality <- transform(airquality, Month=factor(Month))
xyplot(Ozone~Wind|Month, data = airquality, layout=c(5,1))
# they do not plot, return class trellis and this is printed

p <- xyplot(Ozone~Wind, data = airquality)
print(p)

#have panel functions
set.seed(100)
x <- rnorm(100)
f <- rep(0:1,each=50)
y <- x+f-f*x+rnorm(100,sd=0.5)
f <- factor(f,labels = c("gr 1","gr 2"))
xyplot(y~x|f,layout=c(2,1))
# custom panel function can be applied 
xyplot(y~x|f,layout=c(2,1),panel = function(x,y,...){
        panel.xyplot(x,y,...) ## with median
        panel.abline(h=median(y), lty = 2)
})

xyplot(y~x|f,layout=c(2,1),panel = function(x,y,...){
        panel.xyplot(x,y,...)
        panel.lmline(x,y, col = "Green") # with green regression
})

#base annotation do not work here
## great for conditional plotting 
## great for many data in quick way

## ggplot2
## implementation of grammar of graphics, can put together and make new graphs
## third graphics system for R
require(ggplot2)
qplot(rnorm(100000)*3) #qplot
## factors are important, but they should be named
str(mpg)
qplot(displ, hwy, data = mpg)
qplot(displ, hwy, data = mpg, color=drv)
qplot(displ, hwy, data = mpg, geom = c("point","smooth"))
qplot(hwy, data = mpg, fill=drv)
qplot(displ, hwy, data = mpg, facets = .~drv) # colums #facets - panels by drive
qplot( hwy, data = mpg, facets = drv~.)  #row
qplot( displ,hwy, data = mpg, facets = drv~cyl,geom = c("point","smooth"))  #both

qplot(hwy, data = mpg, fill=drv, geom = c("density")) ## smooth

qplot(hwy, displ, data=mpg, color=drv)+geom_smooth(method = "lm") ## great!
qplot(hwy, displ, data=mpg, facets = .~drv)+geom_smooth(method = "lm") ## same byt split

