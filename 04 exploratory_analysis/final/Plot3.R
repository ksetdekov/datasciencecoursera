setwd("~/datasciencecoursera/04 exploratory_analysis/final")
#read data
NEI <-
        readRDS("~/datasciencecoursera/04 exploratory_analysis/pm25_data/summarySCC_PM25.rds")
SCC <-
        readRDS(
                "~/datasciencecoursera/04 exploratory_analysis/pm25_data/Source_Classification_Code.rds"
        )

##3Of the four types of sources indicated by the \color{red}{\verb|type|}type
##(point, nonpoint, onroad, nonroad) variable, which of these four sources have
##seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen
##increases in emissions from 1999–2008? Use the ggplot2 plotting system to make
##a plot answer this question.

library(ggplot2)
library(dplyr)
yearly <-
        NEI %>%  filter(fips == "24510") %>% group_by(year, type) %>%     summarise(Emissions = sum(Emissions))
g <- ggplot(yearly, aes(x = year, y = Emissions))
png(
        file = "plot3.png",
        width = 480,
        height = 480,
        bg = "white"
)
g + geom_line()+geom_smooth(method = "lm", se = FALSE, col = "steelblue") +facet_grid(.~type)+theme_bw()+
        scale_x_continuous(breaks = pretty(yearly$year, n = 4))
dev.off()
