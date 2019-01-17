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
library(stringr)
library(ggplot2)
library(dplyr)
library(reshape2)
SCC_motor <-
        SCC[str_detect(SCC$EI.Sector, regex("vehic", ignore_case = TRUE)), ]
vehid <- lapply(SCC_motor$SCC, as.character)
NEIveh <- NEI[NEI$SCC %in% vehid, ]

yearly <-
        NEI %>%  filter(fips == "24510") %>% group_by(year) %>%     summarise(Emissions = sum(Emissions))
names(yearly)[2] <- "baltimore"
yearlyall <-
        NEI %>% group_by(year) %>%     summarise(Emissions = sum(Emissions))
names(yearlyall)[2] <- "all"
total <- merge(yearly,yearlyall,by="year")
total$baltimore <- log10(total$baltimore )
total$all <- log10(total$all )

total_long <- melt(total, id="year")  # convert to long format


g <- ggplot(total_long, aes(x = year, y = value, colour=variable))+geom_point()
png(
        file = "plot5.png",
        width = 480,
        height = 480,
        bg = "white"
)
g +geom_smooth(aes(x = year, y = value), method = "lm", se = FALSE, col = "steelblue") +theme_bw()+facet_grid(.~variable)+
        labs(y = "log 10 PM2.5 Emissions in tons/year") + labs(title = "Pollution dynamics from Motor vehicles for whole US vs Balitmore")
dev.off()
