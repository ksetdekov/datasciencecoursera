## test 
##1
setwd("get_clear_data")
link <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(link,destfile="./data/microdata.csv")
micdata <- read.csv("./data/microdata.csv")
ans1 <- strsplit(names(micdata),"wgtp") 
ans1[123]

##2
link2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(link2,destfile="./data/gdpdata.csv")
gdpdata <- read.csv("./data/gdpdata.csv", skip = 4)

library(dplyr)
gdpdata %>% select(X.4) %>% slice(1:190) %>% mutate(X.4=as.numeric(gsub(",","",X.4))) %>% summarise(mean=mean(X.4))

##3
countryNames <- gdpdata %>% select(X.3) %>% slice(1:190)
countryNames %>% mutate_if(is.factor, as.character) -> countryNames
countryNames<-countryNames[1]
grep("^United",countryNames[,])

##4
link3="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(link3,destfile="./data/educational.csv")
educ <- read.csv("./data/educational.csv")
shortcountry<-gdpdata[1:190,]
names(shortcountry)[1] <- "CountryCode"

testdata<-inner_join(shortcountry, educ, by = "CountryCode")
ending<- testdata%>%select(Special.Notes) %>% mutate_if(is.factor, as.character) 
length(grep("^Fiscal year end: June",ending[,]))


## 5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
sum(year(sampleTimes)==2012)

sum(wday(sampleTimes[year(sampleTimes)==2012])==2)
