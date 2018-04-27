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