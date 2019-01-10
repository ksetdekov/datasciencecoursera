setwd("~/datascience coursera/quiz2_data")
#get data
dataset_url <- "https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2Fspecdata.zip"
download.file(dataset_url, "specdata.zip")
unzip("specdata.zip")
# #full file names
# files_full <- list.files("specdata", full.names=TRUE)
# files_full
#looping to create binded data
# dat <- data.frame() #empty
# for (i in 1:length(files_full)) {
#         dat <- rbind(dat,
#                      read.csv(files_full[i])
#                      )
# }
# dat2<-dat
# dat2[,1]<-as.POSIXct(strptime(dat[,1], format = "%Y-%m-%d"))
# dat_subset <- dat2[which(dat2[, "ID"] == 1),]  #subsets the rows that match the 'day' argument
# datacomplete<-dat_subset[complete.cases(dat_subset),]
# dat2complete<-dat_subset[complete.cases(dat2),]


source("pollutantmean.R")
source("complete.R")
source("corr.R")
