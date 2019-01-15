setwd("~/datasciencecoursera/04 exploratory_analysis/final")
#read data
NEI <-
        readRDS("~/datasciencecoursera/04 exploratory_analysis/pm25_data/summarySCC_PM25.rds")
SCC <-
        readRDS(
                "~/datasciencecoursera/04 exploratory_analysis/pm25_data/Source_Classification_Code.rds"
        )

##5How have emissions from motor vehicle sources changed from 1999–2008 in
##Baltimore City?
