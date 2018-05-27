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

