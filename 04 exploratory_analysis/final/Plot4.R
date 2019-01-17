setwd("~/datasciencecoursera/04 exploratory_analysis/final")
#read data
NEI <- readRDS("~/datasciencecoursera/04 exploratory_analysis/pm25_data/summarySCC_PM25.rds")
SCC <- readRDS("~/datasciencecoursera/04 exploratory_analysis/pm25_data/Source_Classification_Code.rds")

##4Across the United States, how have emissions from coal combustion-related
##sources changed from 1999–2008?
library(stringr)
library(ggplot2)
library(dplyr)
SCC_coal <-
        SCC[str_detect(SCC$EI.Sector, regex("coal", ignore_case = TRUE)), ]
coalid <- lapply(SCC_coal$SCC, as.character)
NEIcoal <- NEI[NEI$SCC %in% coalid, ]
yearly <-
        NEIcoal  %>% group_by(year) %>%     summarise(Emissions = sum(Emissions))
g <- ggplot(yearly, aes(x = year, y = Emissions))
png(
        file = "plot4.png",
        width = 480,
        height = 480,
        bg = "white"
)
g + geom_line() + geom_smooth(method = "lm", se = FALSE, col = "steelblue") +
        theme_bw() + scale_x_continuous(breaks = pretty(yearly$year, n = 9)) +
        labs(y = "PM2.5 Emissions in tons/year") + labs(title = "Pollution dynamics from coal sources")
dev.off()
