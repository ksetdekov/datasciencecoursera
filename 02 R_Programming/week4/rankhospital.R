rankhospital <- function(state, outcome, num = "best") {
        ##num can be "best" "worst" or num
        ## if num>number of hospital <-NA
        ## read outcome
        outcomedata <- read.csv("hospital_data/outcome-of-care-measures.csv", colClasses = "character")
        listofstates <- unique(outcomedata$State)
        listofoutcomes <- c("heart attack", "heart failure", "pneumonia")
        ## chec state and outcome are valid
        if (!(state %in% listofstates)) {
                stop("invalid state")
        }
        if (!(outcome %in% listofoutcomes)) {
                stop("invalid outcome")
        }
        ## Return hospital name in that state with the given rank
        ## heart attack - 11, failure - 17, pneumonia - 23
        coloptions<-c(11,17,23)
        colneeded<-coloptions[match(outcome,listofoutcomes)]

        outcomedata2<-subset(outcomedata[,c(2,colneeded)],outcomedata$State==state)
        ##without missing data
        suppressWarnings({
                outcomedata2[, 2] <- as.numeric(outcomedata2[, 2])
                
        })
        outcomedata3<-outcomedata2[complete.cases(outcomedata2),]

        ## ordered
        outcomedata4<-outcomedata3[order(outcomedata3[,2],outcomedata3[,1]),]
        colnames(outcomedata3)[2]<-"Rate"
        ## resulting output
        if(num=="best"){
                num<-1
                print(outcomedata4[num,1])  
        }else if(num=="worst"){
                num<-dim(outcomedata4)[1]
                print(outcomedata4[num,1])  
        }else if(num>dim(outcomedata4)[1]){
                print(NA)
        }else{
                print(outcomedata4[num,1])        
                
        }
        
}