setwd("~/datasciencecoursera/get_clear_data")
#need to install mysql
#dev.mysql.com/doc/refman/5.7/en/installing.html
install.packages("RMySQL")
#follow step 2 from the lecture
library(RMySQL)
#always apply a handle to the connection
ucscDb<-dbConnect(MySQL(),user="genome",host="genome-mysql.cse.ucsc.edu")
result<-dbGetQuery(ucscDb,"show databases;");dbDisconnect(ucscDb) #we send a MySQL command and then disconnect

result #get a list of dbs

#conntcting to the hg19 and list tables
hg19<-dbConnect(MySQL(),user="genome",db="hg19",host="genome-mysql.cse.ucsc.edu")
allTables<-dbListTables(hg19)
length(allTables)
allTables[1:5]# get the initial tables this db

#get specific table dims
dbListFields(hg19,"affyU133Plus2")
dbGetQuery(hg19,"select count(*) from affyU133Plus2") #get numver of elements in a table

#reading a table
affyData<-dbReadTable(hg19,"affyU133Plus2")
head(affyData)

#selecting only a subset of the table
query<-dbSendQuery(hg19,"select * from affyU133Plus2 where  misMatches between 1 and 3")
affyMis<-fetch(query);quantile(affyMis$Matches)
#send a querry
affyMisSmall<-fetch(query,n=10);dbClearResult(query); 
# sucking only top 10 rows
# also send a clear query command
dim(affyMisSmall)

### always close the connection
dbDisconnect(hd19)



#### reading from HDF5
## hierarchichal data type
source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")

library(rhdf5)
create = h5createFile("example.H5")
create

##creating groups
create=h5createGroup("example.H5","foo")
create=h5createGroup("example.H5","baa")
create=h5createGroup("example.H5","foo/foobaa") ## subgroups

##loop at files
h5ls("example.H5")

# write to groups
A=matrix(1:10,nr=5,nc=2)
h5write(A,"example.H5","foo/a") ## write to a group
B =array(seq(0.1,2.0,by=0.1),dim = c(5,2,2))
attr(B,"scale") <- "liter"
h5write(B,"example.H5","foo/foobaa/B") ## write to a group
h5ls("example.H5")

#write a data set directly into root of HDF5
df=data.frame(1L:5L, seq(0,1, length.out=5),c("ab","cde","fghi","a","s"), stringsAsFactors=FALSE)
h5write(df,"example.H5","df")
h5ls("example.H5")

## reading
readA=h5read("example.H5","foo/a")
readB=h5read("example.H5","foo/foobaa/B")
readdf=h5read("example.H5","df")
readA
readdf
H5close()
## writing into a part of the file
h5write(c(12,13,14),"example.H5","foo/a", index=list(1:3,1))
h5read("example.H5","foo/a")


## reading data from the web
con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con)
head(htmlCode,1)

## better - parse with xml
library(XML)
url <- "https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes=T)

xpathSApply(html, "//title", xmlValue)
xpathSApply(html, "//td[@id='col-citedby']", xmlValue)

## using httr pachage
library(httr); html2 = GET(url)
content2 = content(html2,as="text")
parsedHtml = htmlParse(content2,asText=TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)


#using passwords
pg1 = GET("http://httpbin.org/basic-auth/user/passwd")
pg1

## accessing
pg2 = GET("http://httpbin.org/basic-auth/user/passwd",
          authenticate("user","passwd"))
pg2
names(pg2)

## handles
google = handle("http://google.com")
pg1 = GET(handle=google,path="/")
pg2 = GET(handle=google,path="search")

## reading from API's
##Accessing Twitter from R
myapp = oauth_app("twitter",
                  key="yourConsumerKeyHere",secret="yourConsumerSecretHere")
sig = sign_oauth1.0(myapp,
                    token = "yourTokenHere",
                    token_secret = "yourTokenSecretHere")
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)

##Converting the json object
json1 = content(homeTL)
json2 = jsonlite::fromJSON(toJSON(json1))
json2[1,1:4]

##httr allows GET, POST, PUT, DELETE requests if you are authorized

## quiz
csvlint<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
acs<-read.csv(csvlint)
install.packages("sqldf" )
library("sqldf")
sqldf("select pwgtp1 from acs where AGEP < 50")

##testing distinct
uniqueacs<-unique(acs$AGEP)

uniquesql<-sqldf("select distinct AGEP from acs")

##
#How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:
        
#        http://biostat.jhsph.edu/~jleek/contact.html

#(Hint: the nchar() function in R may be helpful)

con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
close(con)
otputvector<-c(1:4)
for (i in c(10,20,30,100)) {
        otputvector[i]<-nchar(htmlCode[i])
}
otputvector[c(10,20,30,100)]
## read fwf
fwfurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"

forsum<-read.fwf(fwfurl, widths = c(10,9,4,9),skip = 4)
sum(forsum$V4)