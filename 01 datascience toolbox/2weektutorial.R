setwd("C:/Users/ksetdekov/Documents/datascience coursera/week2")
#get data
dataset_url <- "http://s3.amazonaws.com/practice_assignment/diet_data.zip"
download.file(dataset_url, "diet_data.zip")
unzip("diet_data.zip", exdir = "diet_data")
list.files("diet_data")
# setwd("diet_data")
andy <- read.csv("diet_data/Andy.csv")
#looking at andy
head(andy)
length(andy$Day)
#size
dim(andy)
#descrive
str(andy)
#discriptive stats
summary(andy)
#variable names
names(andy)
andy[1, "Weight"]
#subsetting
andy[which(andy$Day == 30), "Weight"]
#begin and end weightr
andy_start <- andy[1, "Weight"]
andy_end <- andy[30, "Weight"]
#weight difference
andy_loss <- andy_start - andy_end
andy_loss
#list all files
files <- list.files("diet_data")
files
#full file names
files_full <- list.files("diet_data", full.names=TRUE)
files_full
#top of the 3rd file
head(read.csv(files_full[3]))

#unite files
andy_david <- rbind(andy, read.csv(files_full[2]))
head(andy_david)
tail(andy_david)

#subset day 25
day_25 <- andy_david[which(andy_david$Day == 25), ]
day_25
#looping
for (i in 1:5) {print(i)}

#looping to create binded data 
dat <- data.frame() #empty
for (i in 1:5) {
        dat <- rbind(dat, read.csv(files_full[i]))
}
str(dat)

#descriptives on total data
median(dat$Weight,na.rm=TRUE)

#for day 30
dat_30 <- dat[which(dat[, "Day"] == 30),]
dat_30
median(dat_30$Weight)

#mean function
weightmedian <- function(directory, day)  {
        files_list <- list.files(directory, full.names=TRUE)   #creates a list of files
        dat <- data.frame()                             #creates an empty data frame
        for (i in 1:5) {                                
                #loops through the files, rbinding them together 
                dat <- rbind(dat, read.csv(files_list[i]))
        }
        dat_subset <- dat[which(dat[, "Day"] == day),]  #subsets the rows that match the 'day' argument
        median(dat_subset[, "Weight"], na.rm=TRUE)      #identifies the median weight 
        #while stripping out the NAs
}

#results
weightmedian(directory = "diet_data", day = 20)
weightmedian("diet_data", 4)
weightmedian("diet_data", 17)

medianplot<-matrix(0, ncol=2, nrow=max(dat$Day))
for (i in 1:max(dat$Day)) {
        medianplot[i,]<-c(i,weightmedian("diet_data", i))
}
plot(medianplot[,1],medianplot[,2])

## better way to do it
summary(files_full)
tmp <- vector(mode = "list", length = length(files_full))
summary(tmp)

for (i in seq_along(files_full)) {
        tmp[[i]] <- read.csv(files_full[[i]])
}
str(tmp)

str(lapply(files_full, read.csv))

head(tmp[[1]][,"Day"])

output <- do.call(rbind, tmp)

identical(output,dat)
str(output)
