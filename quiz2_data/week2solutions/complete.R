complete<-function(directory,id=1:332){
        dat <- data.frame()                             #creates an empty data frame
        outputdf<-data.frame()
         files_list <- list.files(directory, full.names=TRUE)   #creates a list of files
        
        filelistselected<-files_list[id]
        for (i in 1:length(filelistselected)) {                                
                #loops through the files, rbinding them together 
                
                dat <- read.csv(filelistselected[i])
                dat2complete<-dat[complete.cases(dat),]
                outputdf<- rbind(outputdf,c(id[i],dim(dat2complete)[1]))
                
        }
        names(outputdf)<-c("id","nobs")
        outputdf
}