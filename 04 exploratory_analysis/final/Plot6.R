setwd("~/datasciencecoursera/04 exploratory_analysis/final")
#read data
NEI <-
        readRDS("~/datasciencecoursera/04 exploratory_analysis/pm25_data/summarySCC_PM25.rds")
SCC <-
        readRDS(
                "~/datasciencecoursera/04 exploratory_analysis/pm25_data/Source_Classification_Code.rds"
        )

##6Compare emissions from motor vehicle sources in Baltimore City with emissions
##from motor vehicle sources in Los Angeles County, California
##(\color{red}{\verb|fips == "06037"|}fips=="06037"). Which city has seen
##greater changes over time in motor vehicle emissions?