setwd("~/datasciencecoursera/04 exploratory_analysis/final")
#read data
NEI <-
        readRDS("~/datasciencecoursera/04 exploratory_analysis/pm25_data/summarySCC_PM25.rds")
SCC <-
        readRDS(
                "~/datasciencecoursera/04 exploratory_analysis/pm25_data/Source_Classification_Code.rds"
        )

##1Have total emissions from PM2.5 decreased in the United States from 1999 to
##2008? Using the base plotting system, make a plot showing the total PM2.5
##emission from all sources for each of the years 1999, 2002, 2005, and 2008.

library(dplyr)
yearly <-
        NEI %>%   group_by(year) %>%     summarise(Emissions = sum(Emissions))

png(
        file = "plot1.png",
        width = 480,
        height = 480,
        bg = "white"
)
with(yearly, plot(
        year,
        Emissions,
        type = "l",
        xaxp  = c(1999, 2008, 9)
))
dev.off()