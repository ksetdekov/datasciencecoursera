setwd("D:/Dropbox/datascience/datasciencecoursera/get_clear_data")
if(!file.exists("data")){
        dir.create("data")
}
fileUrl<-"https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile = "./data/cameras.csv",method = "curl")
list.files("./data")
dateDownloaded<-date()
dateDownloaded

cameraData<-read.table("./data/cameras.csv", sep = ",", header = TRUE)
head(cameraData)


## reading from excel
fileUrl<-"https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
download.file(fileUrl,destfile = "./data/cameras.xlsx",method = "curl")
dateDownloaded<-date()
library(xlsx)
cameraData<-read.xlsx("./data/cameras.xlsx",sheetIndex = 1, header = TRUE)
head(cameraData)

## reading xml
library(XML)
fileUrl<-"./data/simple.xml"
doc<-xmlTreeParse(fileUrl,useInternal = TRUE)
rootNode<-xmlRoot(doc)
xmlName(rootNode)

#names
names(rootNode)

#access xml directly
rootNode[[1]]
#deeper
rootNode[[1]][[1]]

#extract part of the file
#for all
xmlSApply(rootNode,xmlValue)

##indepth into xml
## names
xpathSApply(rootNode,"//name",xmlValue)
## value
xpathSApply(rootNode,"//price",xmlValue)

## from a website
library(RCurl)
fileUrl<-"http://www.espn.com/nfl/team/_/name/bal/baltimore-ravens"
htmlContent <- getURL(fileUrl)

doc<-htmlTreeParse(htmlContent,useInternalNodes =TRUE)
score<-xpathSApply(doc,"//div[@class='score']",xmlValue)
teams<-xpathSApply(doc,"//div[@class='game-info']",xmlValue)

teams

## reading json
library(jsonlite)
jsonData<-fromJSON("https://api.github.com/users/ksetdekov/repos")
names(jsonData)
names(jsonData$owner)
jsonData$owner$login

#writing to json
myjson<-toJSON(iris,pretty = TRUE)
cat(myjson)

## convert back
iris2<-fromJSON(myjson)
head(iris2)

##data.table
## much faster that data frame
library(data.table)
DF=data.frame(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
head(DF,3)

DT=data.table(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
head(DT,3)

tables() #how much in memory
# subsetting data tables
DT[2,]

DT[DT$y=="a",]

#subsetting with 1 index - takes rows
DT[c(2,3)] #does by row
DT[,c(2,3)]

## values for variables
DT[,list(mean(x),sum(z))]
DT[,table(y)]

## adding new columns
DT[,w:=z^2]
# be carefull, that this is editing
##multiple step functions
DT[,m:={tmp<-(x+z);log2(tmp+5)}]
## plyr like operations
DT[,a:=x>0]
DT
## use tis for summary, groped by varible
DT[,b:=mean(x+w),by=a]

## special variables
## .N - integer, length 1, conting the number r

set.seed(123)
DT<-data.table(x=sample(letters[1:3],1E5,TRUE))
DT[,.N, by=x] # .N used for counting

#can have keys.
DT<-data.table(x=rep(c("a","b","c"),each=100),y=rnorm(300))
setkey(DT,x)
DT['a'] #looks at the x variable

## use keys for subsetting - merging
DT1<-data.table(x=c('a','a','b','dt1'),y=1:4)
DT2<-data.table(x=c('a','b','dt2'),y=5:7)
setkey(DT1,x);setkey(DT2,x)
merge(DT1,DT2)

## advantage - fast reading

getwd()
big_df<-data.frame(x=rnorm(1E6),y=rnorm(1E6))
file<-tempfile()
write.table(big_df, file = file,row.names = FALSE,col.names = TRUE,sep = "\t",quote = FALSE)
system.time(fread(file))

system.time(read.table(file,header = TRUE,sep = "\t"))

## week1 quiz
##1
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl,destfile = "./get_clear_data/data/houses.csv")
list.files("./get_clear_data/data/")
dateDownloaded<-date()
dateDownloaded

howsing<-read.table("./get_clear_data/data/houses.csv", sep = ",", header = TRUE)
head(howsing)
table(howsing$VAL)

##3
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl,destfile = "./get_clear_data/data/ngas.xlsx")
#library(xlsx)
#ngas<-read.xlsx("./get_clear_data/data//ngas.xlsx",sheetIndex = 1, header = TRUE)
#head(ngas)

ngas<-read.table("./get_clear_data/data//ngas.csv", sep = ";", header = TRUE)
head(ngas)
dat<-ngas
sum(dat$Zip*dat$Ext,na.rm=T)

## 4
#read xml
fileUrl<-"./get_clear_data/data/restaurants.xml"
doc<-xmlTreeParse(fileUrl,useInternal = TRUE)
rootNode<-xmlRoot(doc)
xmlName(rootNode)

#names
names(rootNode)

#access xml directly
rootNode[[1]]
#deeper
rootNode[[1]][[1]]

#extract part of the file
#for all
xmlSApply(rootNode,xmlValue)

##indepth into xml
## names
zipcodelist<-xpathSApply(rootNode,"//zipcode",xmlValue)
table(zipcodelist)

##5
file<-"./get_clear_data/data/pid.csv"

system.time(fread(file))
DT<-fread(file)


system.time({mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)})
system.time({rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]})
system.time({sapply(split(DT$pwgtp15,DT$SEX),mean)})
system.time({mean(DT$pwgtp15,by=DT$SEX)})
system.time({DT[,mean(pwgtp15),by=SEX]})
system.time({tapply(DT$pwgtp15,DT$SEX,mean)})




