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
        
        ## create a blank dataframe with list of states and all NA for results
        df<-as.data.frame(listofstates)
        row.names(df)<-listofstates
        df<-cbind(df,NA)
        ## make all values NA before being filled
        df<-df[,c(2,1)]
        colnames(df)<-c("hospital","state")
        
        ## handle non numeric data
        coloptions<-c(11,17,23)
        colneeded<-coloptions[match(outcome,listofoutcomes)]
        suppressWarnings({
                outcomedata[, colneeded] <- as.numeric(outcomedata[, colneeded])
                
        })
        ## cycle looping over all states
        for (st in 1:dim(df)[1]) {
                curstate<-listofstates[st]
                
                outcomedata2<-data.frame()
                ## subset needed column, take needed state at step
                outcomedata2<-subset(outcomedata[,c(2,colneeded)],outcomedata$State==curstate)
                ## handle missing
                outcomedata3<-outcomedata2[complete.cases(outcomedata2),]
                
                ## ordered
                outcomedata4<-outcomedata3[order(outcomedata3[,2],outcomedata3[,1]),]
                colnames(outcomedata4)[2]<-"Rate"
                ## resulting output for state
                numt<-num
                if(numt=="best"){
                        numt<-1
                        stateresult<-(outcomedata4[numt,1])  
                }else if(numt=="worst"){
                        numt<-dim(outcomedata4)[1]
                        stateresult<-(outcomedata4[numt,1])  
                }else if(numt>dim(outcomedata4)[1]){
                        stateresult<-(NA)
                }else{
                        stateresult<-(outcomedata4[numt,1])        
                }
                #write to dataframe
                df[st,1]<-stateresult
        }   
   
        return(df)
        
}