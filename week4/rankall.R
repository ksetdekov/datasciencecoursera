rankall <- function(outcome, num = "best") {
        ## Read outcome data
        outcomedata <- read.csv("hospital_data/outcome-of-care-measures.csv", colClasses = "character")
        listofstates <- unique(outcomedata$State)
        listofstates<-sort(listofstates)
        listofoutcomes <- c("heart attack", "heart failure", "pneumonia")
        ## Check that state and outcome are valid

        if (!(outcome %in% listofoutcomes)) {
                stop("invalid outcome")
        }
        ## For each state, find the hospital of the given rank
        ## Return a data frame with the hospital names and the
        ## (abbreviated) state name
        df<-as.data.frame(listofstates)
        row.names(df)<-listofstates
        df<-cbind(df,NA)
        ## make all values NA before being filled
        df<-df[,c(2,1)]
        colnames(df)<-c("hospital","state")
        ## cycle looping over
        
        return(df)
        
}