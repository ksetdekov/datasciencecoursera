## week 4 lectures
## str function
x<-rnorm(100,2,4)
str(x)
summary(x)

#for factors
f<-gl(40,10)
str(f)
summary(f)

#on datasets
library(datasets)
head(airquality)
str(airquality)

#matrix
m<-matrix(rnorm(100),10,10)
str(m) #first column

#lists
s<-split(airquality,airquality$Month)
str(s)

##genereating random numbers
set.seed(100)
rnorm(5)
rnorm(5)
set.seed(100)
rnorm(5)

##poisson
rpois(10,1)
rpois(10,2)
rpois(10,20)

##cumulative
ppois(2,2)
ppois(4,2)
ppois(6,2)

## linear model generation
set.seed(20)
x<-rnorm(100)
e<-rnorm(100,0,2)
y<-0.5+2*x+e
summary(y)
plot(x,y)
library(ggplot2)
f<-data.frame(cbind(x,y))
qplot(f[,1],f[,2])

## binom
set.seed(10)
x<-rbinom(100,1,0.5)
e<-rnorm(100,0,2)
y<-0.5+2*x+e
qplot(x,y)

##
set.seed(1)
x<-rnorm(100)
log.mu<-0.5+0.3*x
y<-rpois(100,exp(log.mu))
summary(y)
qplot(x,y)

## sampling
set.seed(1)
sample(1:10,4)
sample(letters,5)
sample(1:10) ## get a permutation
sample(1:10) 
sample(1:10, replace = TRUE)

## system.time
system.time({
        sample(1:10, replace = TRUE)
        
})

returnd<-getwd()
## waiting
system.time({
        setwd("C:/Users/ksetdekov/Documents/datascience coursera/week4")
        
        #get data
        dataset_url <- "https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2FProgAssignment3-data.zip"
        download.file(dataset_url, "hospital_data.zip")
        unzip("hospital_data.zip", exdir = "hospital_data")
        list.files("hospital_data")
        
        
})
setwd(returnd)
## parallel
hilbert<-function(n){
        i<-1:n
        1/outer(i-1,i,"+")
}
x<-hilbert(10000)
system.time(svd(x))
