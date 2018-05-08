best<-function(state,outcome){
        ## state expects a value from outcome$State ,outcomename is on of "heart
        ## attack", "heart failure", or "pneumonia" Hospitals that do not have
        ## data on a particular outcome should be excluded from the set of
        ## hospitals when deciding the rankings.
        
        ## read outcome
        outcomedata <- read.csv("hospital_data/outcome-of-care-measures.csv", colClasses = "character")
        listofstates<-unique(outcomedata$State)
        listofoutcomes<-c("heart attack","heart failure","pneumonia")
        ## chec state and outcome are valid
        if(!(state %in% listofstates)){
                stop("invalid state")
        }
        if(!(outcome %in% listofoutcomes)){
                stop("invalid outcome")
        }
        ## Return hospital name in that state with lowest 30-day death rate
        ## heart attack - 11, failure - 17, pneumonia - 23
        coloptions<-c(11,17,23)
        colneeded<-coloptions[match(outcome,listofoutcomes)]
        suppressWarnings({
                    outcomedata[, colneeded] <- as.numeric(outcomedata[, colneeded])
    
        })
        outcomedata2<-subset(outcomedata,outcomedata$State==state)
        minlevel<-min(outcomedata2[,colneeded],na.rm = TRUE)
        ## resulting output
        print(min(outcomedata2$Hospital.Name[which(outcomedata2[,colneeded]==minlevel)]))        
}