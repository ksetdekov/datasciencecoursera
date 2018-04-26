for(i in 1:10){
        print(i
        )
}

x<-c("a","b","c","d")
for (i in 1:4){
        print (x[i])
}
for (i in seq_along(x)){
        print(x[i])
}
for (letter in x){
        print(letter)
}
for (i in 1:4) print(x[i])

##nested loops
x<-matrix(1:6,2,3)
for(i in seq_len(nrow(x))){
        for(j in seq_len(ncol(x))){
                print(x[i,j])
        }
}
## while  loop
count<-6
while(count<10){
        print(count)
        count<-count+1
}
z<-5
while(z>=3&&z<=10){
        print(z)
        coin<-rbinom(1,1,0.5)
        if(coin==1){ ## random walk
                z<-z+1
        } else{
                z<-z-1
        }
}

## next
for(i in 1:100){
        if(i<=20){
                ##skip 20
                next
        }
        print(i)
}
## anrgument matching
mydata<-rnorm(100)
sd(mydata)
sd(x=mydata, na.rm = FALSE)
## dates and times
x<-as.Date("1970-01-01")
x
x<-as.Date("1970-01-02")
#unclass(x)

weekdays(x)
months(x)
quarters(x)
x<-Sys.time()
p<-as.POSIXlt(x)
names(unclass(p))
p$sec
unclass(x)

#parsing strings
datestring <- c("January 10, 2012 10:40", "December 9, 2011 9:10")
x <- strptime(datestring, "%B %d, %Y %H:%M")
x
class(x)
