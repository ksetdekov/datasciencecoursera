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
library(stringr)
library(ggplot2)
library(dplyr)
library(reshape2)
SCC_motor <-
        SCC[str_detect(SCC$EI.Sector, regex("vehic", ignore_case = TRUE)), ]
vehid <- lapply(SCC_motor$SCC, as.character)
NEIveh <- NEI[NEI$SCC %in% vehid, ]

yearly <-
        NEI %>%  filter(fips == "24510") %>% group_by(year) %>% summarise(Emissions = sum(Emissions))
names(yearly)[2] <- "Baltimore"
yearlyLA <-
        NEI %>% filter(fips == "06037") %>%  group_by(year) %>% summarise(Emissions = sum(Emissions))
names(yearlyLA)[2] <- "Los_Angeles"
total <- merge(yearly, yearlyLA, by = "year")
total$Baltimore <- (total$Baltimore) / total$Baltimore[1]
total$Los_Angeles <- (total$Los_Angeles) / total$Los_Angeles[1]

total_long <- melt(total, id = "year")  # convert to long format


g <-
        ggplot(total_long, aes(x = year, y = value, colour = variable)) + geom_line()
png(
        file = "plot6.png",
        width = 480,
        height = 480,
        bg = "white"
)
g + theme_bw() + labs(y = "relative change of PM 2.5 (1999 as base)") + labs(title = "Relative pollution dynamics from Motor vehicles for Balitmore vs Los Angeles")
dev.off()
