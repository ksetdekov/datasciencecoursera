# task1
setwd("get_clear_data")
t1linl <-
        "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

download.file(t1linl, "data/acs.csv")
library(readr)
library(dplyr)
acs <- read_csv("data/acs.csv")
View(acs)
#Create a logical vector that identifies the households on greater than 10 acres (ACR==3)
#who sold more than $10,000 worth of agriculture products (AGS==6). Assign that logical
#vector to the variable agricultureLogical.
acs2 = mutate(acs, agricultureLogical = (AGS==6)&(ACR==3))

agricultureLogical <- (acs$AGS==6)&(acs$ACR==3)
which(agricultureLogical)

# task2
library(jpeg )
l2link <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(l2link, "data/sample.jpg")
readimage <- readJPEG("data/sample.jpg", native = TRUE)
quantile(readimage,0.3)
quantile(readimage,0.8)


#task3
t3link <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(t3link, "data/gdp.csv")
t3link2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(t3link2, "data/edu.csv")

gdp <- read_csv("data/gdp.csv", skip = 8) ## ranink X2
edu <- read_csv("data/edu.csv")
colnames(gdp)[2] <- "rankinggdp"
colnames(gdp)[1] <- "CountryCode"
colnames(gdp)[4] <- "Country"
joined<- full_join(gdp,edu)

joined%>%count(is.na(CountryCode)|is.na(rankinggdp))
# Sort the data frame in descending order by GDP rank (so United States is last).
joined$rankinggdp<-as.numeric(joined$rankinggdp)
joined$`Income Group`<-as.factor(joined$`Income Group`)
joined%>% arrange(desc(rankinggdp))
joined%>% select(-starts_with("X"))%>%filter(!(is.na(CountryCode)|is.na(rankinggdp)))%>% arrange(desc(rankinggdp))%>% head(15)
joined%>% select(`Income Group`,rankinggdp,CountryCode)%>%filter(!(is.na(CountryCode)|is.na(rankinggdp)))%>% group_by(incomegroup)%>% summarise(mean(rankinggdp))
colnames(joined)[12]<-"incomegroup"
                       

joined%>% select(incomegroup,rankinggdp,CountryCode)%>%filter(!(is.na(CountryCode)|is.na(rankinggdp)))%>% group_by(incomegroup)%>% summarise(mean(rankinggdp))
joined%>% mutate(quant=(as.integer(cut(joined$rankinggdp, quantile(joined$rankinggdp, probs=0:5/5,na.rm = T),include.lowest=TRUE))))->joined
joined$quant
result<-joined%>% select(incomegroup,rankinggdp,CountryCode,quant)%>%filter(!(is.na(CountryCode)|is.na(rankinggdp)))%>% group_by(incomegroup,quant)%>% summarise(n())
