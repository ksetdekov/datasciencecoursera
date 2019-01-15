setwd("~/datasciencecoursera/04 exploratory_analysis/final")
#read data
NEI <-
        readRDS("~/datasciencecoursera/04 exploratory_analysis/pm25_data/summarySCC_PM25.rds")
SCC <-
        readRDS(
                "~/datasciencecoursera/04 exploratory_analysis/pm25_data/Source_Classification_Code.rds"
        )

##2Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
##(\color{red}{\verb|fips == "24510"|}fips=="24510") from 1999 to 2008? Use the
##base plotting system to make a plot answering this question.

library(dplyr)
yearly <-
        NEI %>%  filter(fips == "24510") %>% group_by(year) %>%     summarise(Emissions = sum(Emissions))
png(
        file = "plot2.png",
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
