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
