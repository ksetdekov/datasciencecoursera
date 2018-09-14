if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/cameras.csv")
cameraData <- read.csv("./data/cameras.csv")
names(cameraData)
tolower(names(cameraData))

splitNames=strsplit(names(cameraData),"\\.")
splitNames[[5]]
splitNames[[6]]
## for lists
mylist <- list(letters=c("A","b", "c"), numbers=1:3, matrix(1:25,ncol=5))
head(mylist)

mylist$letters

## function 1 element
firstElement <- function(x){x[1]}
sapply(splitNames, firstElement)


## peer review data
fileUrl1 <- "https://github.com/DataScienceSpecialization/courses/blob/master/03_GettingData/04_01_editingTextVariables/data/reviews.csv"
fileUrl2 <- "https://github.com/DataScienceSpecialization/courses/blob/master/03_GettingData/04_01_editingTextVariables/data/solutions.csv"
download.file(fileUrl1,destfile="./data/reviews.csv")
download.file(fileUrl2,destfile="./data/solutions.csv")
reviews <- read.csv("./data/reviews.csv"); solutions <- read.csv("./data/solutions.csv")
head(reviews,2)
head(solutions,2)

## replace with sup
names(reviews)
sub("_","",names(reviews))

# fixing with multiples
testName <- "this_is_a_test"
sub("_","",testName)

#with gsub
gsub("_","",testName)


## search
grep("Alameda", cameraData$intersection)
# logical results - if search resulted
table(grepl("Alameda", cameraData$intersection))

cameraData2 <- cameraData[!grepl("Alameda", cameraData$intersection),]

#more on grep()
## can give value
grep("Alameda",cameraData$intersection,value = T)


grep("random",cameraData$intersection)

length(grep("random",cameraData$intersection))

## useful string functions
library(stringr)
nchar("Jeffrey Leek") # length

substr("Jeffrey Leek",1,7) #cut out

paste("Jeffrey","Leek") #separate with " "
paste0("Jeffrey","Leek") #paste without spaces
str_trim("Jeff                ")


## working with dates
d1 = date()
d1
class(d1)

## date class
d2 = Sys.Date()
d2
class(d2)

#reformatting dates # date formats # %d = day as number (0-31), %a = abbreviated
#weekday,%A = unabbreviated weekday, %m = month (00-12), %b = abbreviated month,
#%B = unabbrevidated month, %y = 2 digit year, %Y = four digit year
format(d2, "%a %b %d")


#creating dates
x = c("1jan1960", "2jan1960", "31mar1960", "30jul1960"); z = as.Date(x, "%d%b%Y")
z
z[1] - z[2]
as.numeric(z[1]-z[2])

## convert to julian
weekdays(d2)
months(d2)
julian(d2) #days since origin

library(lubridate)
ymd("20140108")
dmy("03 /02/2013")

ymd_hms("2011-08-03 10:15:03")
ymd_hms("2011-08-03 10:15:03",tz="Pacific/Auckland")
?Sys.timezone


## different weekday
x = dmy(c("1jan2013", "2jan2013", "31mar2013", "30jul2013"))
wday(x[1])
wday(x[1],label=TRUE)
