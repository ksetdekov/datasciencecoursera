
# 1 vectors are collinear - matrix rank
x <- 1/2
y <- -8/5
v1 <- c(0,2,4,3)
v2 <- c(x,2,3,1)
v3 <- c(-1,y,-2,3)
v4 <- c(0,3,4,8)

test <- as.matrix(data.frame(v1,v2,v3,v4))
qr(test)$rank != 4

x <- -8/5
y <- 1/2
v1 <- c(0,2,4,3)
v2 <- c(x,2,3,1)
v3 <- c(-1,y,-2,3)
v4 <- c(0,3,4,8)

test <- as.matrix(data.frame(v1,v2,v3,v4))
qr(test)$rank != 4

x <- -1/5
y <- 73/20
v1 <- c(0,2,4,3)
v2 <- c(x,2,3,1)
v3 <- c(-1,y,-2,3)
v4 <- c(0,3,4,8)

test <- as.matrix(data.frame(v1,v2,v3,v4))
qr(test)$rank != 4

y <- -1/5
x <- 73/20
v1 <- c(0,2,4,3)
v2 <- c(x,2,3,1)
v3 <- c(-1,y,-2,3)
v4 <- c(0,3,4,8)

test <- as.matrix(data.frame(v1,v2,v3,v4))
qr(test)$rank != 4


x <- 2/5
y <- -3/2
v1 <- c(0,2,4,3)
v2 <- c(x,2,3,1)
v3 <- c(-1,y,-2,3)
v4 <- c(0,3,4,8)

test <- as.matrix(data.frame(v1,v2,v3,v4))
qr(test)$rank != 4

y <- 2/5
x <- -3/2
v1 <- c(0,2,4,3)
v2 <- c(x,2,3,1)
v3 <- c(-1,y,-2,3)
v4 <- c(0,3,4,8)

test <- as.matrix(data.frame(v1,v2,v3,v4))
qr(test)$rank != 4

x <- 15/4
y <- -3/10
v1 <- c(0,2,4,3)
v2 <- c(x,2,3,1)
v3 <- c(-1,y,-2,3)
v4 <- c(0,3,4,8)

test <- as.matrix(data.frame(v1,v2,v3,v4))
qr(test)$rank != 4

y <- 15/4
x <- -3/10
v1 <- c(0,2,4,3)
v2 <- c(x,2,3,1)
v3 <- c(-1,y,-2,3)
v4 <- c(0,3,4,8)

test <- as.matrix(data.frame(v1,v2,v3,v4))
qr(test)$rank != 4

#2
x <- seq(0,4, 0.0001)
y1 = x-3
y2 = x^2-2

x2line <- (x-y1)/sqrt(2)
y2line <- (x+y1)/sqrt(2)

x2curve <- (x-y2)/sqrt(2)
y2curve <- (x+y2)/sqrt(2)

round(min(-x2curve+mean(x2line)),digits = 3)


#3 x^3*y^3 =12
y = (12^(1/3))/(x)

integrand <- function(x) {((12^(1/3))/(x))^2}
integrate(integrand, lower = 1, upper = 5)
result <- (integrate(integrand, lower = 1, upper = 5))$value
result*pi

#4 y(dot dot) +4y(dot)+4y=1/2x(e^02x)

#y(dot)1-y(1)=2
#y(dot)1+y(1)=1

#y(1/2)
library(deSolve)

#5
# 4 кубика.
#2 - 2/6 черные
#1 -3/6 черные
#1 - 5/6 черные

# P(4|black) = P(black|4) P(4)/P(Black)

(5/6)*(0.25)/(2/6*0.5+3/6*0.25+5/6*0.25)
