add2<-function(x,y){
  x+y
}

above10<-function(x){
  use<-x>10
  x[use]
}

above<-function(x,n=10){
  use<-x>n
  x[use]
}

columnmean<-function(y, removeNA=TRUE){
  nc<-ncol(y)
  means<-numeric(nc)
  for(i in 1:nc){
    means[i]<-mean(y[,i],na.rm = removeNA)
  }
  means
}

f<-function(a,b=1,c=2, d=NULL){
  
}
##lazy evaluation
## evaluated as needed
f<-function(a,b){
a^2
}

##lazy 2
f<-function(a,b){
  print(a)
  print(b)
}

## ... argument
myplot<-function(x,y,type="l",...){
  plot(x,y,type = type,...)
}

##nested functions
##lexical scoping
make.power <-function(n){
  pow <-function(x) {
    x^n
  }
  pow
}
cube<-make.power(3)
square<-make.power(2)
cube(10)
square(10)
## смотрим что внутри функции
ls(environment(cube))
get("n",environment(cube))

## lexical scoping vs dynamic scoping
g<-function(x){
  a<-3
  x+a+y
}
#get error, y not defined
g(2)
y<-3
g(2)
## all stored in memory
## constructor functions
make.NegLogLik <- function(data, fixed=c(FALSE,FALSE)) {
  params <- fixed
  function(p) {
    params[!fixed] <- p
    mu <- params[1]
    sigma <- params[2]
    a <- -0.5*length(data)*log(2*pi*sigma^2)
    b <- -0.5*sum((data-mu)^2) / (sigma^2)
    -(a + b)
  }
}
set.seed(1); normals <- rnorm(100, 1, 2)
nLL <- make.NegLogLik(normals)
nLL
ls(environment(nLL))
optim(c(mu=0,sigma=1),nLL)$par
##fixing variables
nll<-make.NegLogLik(normals,c(FALSE,2))
optimize(nLL,c(-1,3))$minimum
nll<-make.NegLogLik(normals,c(1,FALSE))
optimize(nLL,c(1e-6,10))$minimum

##plotting
nll<-make.NegLogLik(normals,c(1,FALSE))
x<-seq(1.5,1.8,len=100)
y<-sapply(x,nLL)
plot(x,exp(-(y-min(y))),type = "l")

