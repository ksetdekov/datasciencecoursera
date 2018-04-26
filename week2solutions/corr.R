corr<-function(directory,threshold=0){
        dat <- data.frame()                             #creates an empty data frame
        x<-numeric()
        files_list <- list.files(directory, full.names=TRUE)   #creates a list of files
        xcount<-1
        filelistselected<-files_list
        for (i in 1:length(filelistselected)) {                                
                #loops through the files, rbinding them together 
                
                dat <- read.csv(filelistselected[i])
                dat2complete<-dat[complete.cases(dat),]
                if(dim(dat2complete)[1]>threshold) {
                        x[xcount]<-cor(dat2complete$sulfate,dat2complete$nitrate)
                        xcount<-xcount+1
                }
                
        }
        ## make output
        x
}