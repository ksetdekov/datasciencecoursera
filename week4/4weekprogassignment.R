setwd("C:/Users/ksetdekov/Documents/datascience coursera/week4")

#get data
dataset_url <- "https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2FProgAssignment3-data.zip"
download.file(dataset_url, "hospital_data.zip")
unzip("hospital_data.zip", exdir = "hospital_data")
list.files("hospital_data")

#read data
outcome <- read.csv("hospital_data/outcome-of-care-measures.csv", colClasses = "character")
head(outcome)
#how many columns
ncol(outcome)
###
#1 Plot the 30-day mortality rates for heart attack
###
outcome[, 11] <- as.numeric(outcome[, 11])
## You may get a warning about NAs being introduced; that is okay
hist(outcome[, 11])

## finding the best hospital
source("best.R")
best("SC", "heart attack")
best("NY", "pneumonia")
best("AK", "pneumonia")
