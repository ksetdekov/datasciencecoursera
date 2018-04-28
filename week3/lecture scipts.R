x<-list(a=1:5, b=rnorm(10))
lapply(x, mean)
#lapply
x<-list(a=1:4, b=rnorm(10),c=rnorm(20,1),d=rnorm(100,5))
lapply(x, mean)
#passing arguments
x<-1:4
lapply(x, runif,min=0,max=10)
## heavy use of anonymous functios
x<- list(a=matrix(1:4,2,2),b=matrix(1:6,3,2))
x
#want extract 1 column
# this anonymous function
lapply(x, function(elt) elt[,1])

##apply
x<-matrix(rnorm(200),20,10)
apply(x,2,mean)
apply(x,1,sum)
#shortcuts
rowSums(x)
rowMeans(x)
colSums(x)
colMeans(x)
#quantiles
apply(x,1,quantile,probs=c(0.25,0.75))
# average matrix in an array
a<-array(rnorm(2*2*10),c(2,2,10))
apply(a,c(1,2),mean)
rowMeans(a,dim=2)

#mapply
list(rep(1,4), rep(2,3),rep(3,2),rep(4,1))
mapply(rep, 1:4,4:1)

noise<-function(n,mean,sd){
        rnorm(n,mean,sd)
}
mapply(noise,1:5,1:5,2)
#tapply
x<-c(rnorm(10),runif(10),rnorm(10,1))
f<-gl(3,10)
f
tapply(x, f, mean)
#no simplification
tapply(x, f, mean, simplify = FALSE)
 #split
str(split)
split(x,f) #splits the object into factor -> returns a list
#instead of tapply can use lapply+split
lapply(split(x,f),mean)
#usefull for more complecated stuff
library(datasets)
head(airquality)
s<-split(airquality,airquality$Month)
lapply(s,function(x) colMeans(x[,c("Ozone","Solar.R","Wind")]))
#but there are missing
sapply(s,function(x) colMeans(x[,c("Ozone","Solar.R","Wind")]))
# delete nas
lapply(s,function(x) colMeans(x[,c("Ozone","Solar.R","Wind")], na.rm = TRUE))

#splitting in multiple levels
x<-rnorm(10)
f1<-gl(2,5)
f2<-gl(5,2)
f1
f2
interaction(f1,f2)
str(split(x,list(f1,f2)))
#drop empty
str(split(x,list(f1,f2)),drop=TRUE)

##debugging
#warning
log(-1)

printmessage<-function(x){
        if(x>0)
                print("x is greater than 0")
        else
                print("x is less than or equal to zero")
        invisible(x)
}
printmessage(1)
#getting error
printmessage(NA)

printmessage2<-function(x){
        if(is.na(x))
                print("x is a missing value!")
        else if(x>0)
                print("x is greater than 0")
        else
                print("x is less than or equal to zero")
        invisible(x)
}
printmessage2(NA)

x<-log(-1)
#generating a NaN
printmessage2(x)
# expecting something different, there is no error
mean(y)
traceback() # first level error

#more complicated error
lm(y~q)
traceback()

#debugging
debug(lm)
lm(y~q)

#recover
options(error=recover)
read.csv("noshucl")

#quiz3
library(datasets)
data(iris)
?iris
tapply(iris$Sepal.Length, iris$Species, mean)
apply(iris[, 1:4], 2, mean)

?mtcars
hpave<-tapply(mtcars$hp, mtcars$cyl, mean)
hpave[3]-hpave[1]

#for programming assignment
makeVector <- function(x = numeric()) {
        m <- NULL
        set <- function(y) {
                x <<- y
                m <<- NULL
        }
        get <- function() x
        setmean <- function(mean) m <<- mean
        getmean <- function() m
        list(set = set, get = get,
             setmean = setmean,
             getmean = getmean)
}

cachemean <- function(x, ...) {
        m <- x$getmean()
        if(!is.null(m)) {
                message("getting cached data")
                return(m)
        }
        data <- x$get()
        m <- mean(data, ...)
        x$setmean(m)
        m
}