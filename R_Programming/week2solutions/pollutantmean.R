pollutantmean <- function(directory, pollutant, id=1:332){
        ## that calculates the mean of a pollutant (sulfate or nitrate) across a
        ## specified list of monitors. The function 'pollutantmean' takes three
        ## arguments: 'directory', 'pollutant', and 'id'. Given a vector monitor
        ## ID numbers, 'pollutantmean' reads that monitors' particulate matter
        ## data from the directory specified in the 'directory' argument and
        ## returns the mean of the pollutant across all of the monitors,
        ## ignoring any missing values coded as NA.
        files_list <- list.files(directory, full.names=TRUE)   #creates a list of files
        dat <- data.frame()                             #creates an empty data frame
        filelistselected<-files_list[id]
        for (i in 1:length(filelistselected)) {                                
                #loops through the files, rbinding them together 
                dat <- rbind(dat, read.csv(filelistselected[i]))
        }
      
        
        #subsets the rows that match the 'ID' argument
        mean(dat[, pollutant], na.rm=TRUE)      
        #identifies the mean pollutantwhile stripping out the NAs
}

