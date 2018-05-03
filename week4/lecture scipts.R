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
