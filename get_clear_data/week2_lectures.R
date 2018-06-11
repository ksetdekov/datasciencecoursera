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
query<-sbSendQuety(hg19,"select * from affyU133Plus2 where  misMatches between 1 and 3")
affyMis<-fetch(query);quantile(affyMis$Matches)
#send a querry
affyMisSmall<-fetch(query,n=10);dbClearResult(query); 
# sucking only top 10 rows
# also send a clear query command
dim(affyMisSmall)

### always close the connection
dbDisconnect(hd19)



