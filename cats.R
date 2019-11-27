sea <- c(2,4,4,1,1,2,0,2,4,1,4)
land <- c(4,3,4,5,6,6,4,3,12,3,6)
timeaftersunrize <- c(1.6,3.18,4.85,7.35,0.8,1.133,1.61,1.866,10.283,0.916,1.216)
t.test(sea,land)
t.test(sea,land, paired = TRUE)

library(party)
cats <- as.data.frame(cbind(sea,land,timeaftersunrize))
cfit <- ctree(land~., cats,controls = ctree_control(mincriterion=0.5, minsplit = 2, minbucket = 2))
plot(cfit)

corrplot::corrplot(cor(cats), order = "hclust", addrect = 2)
cats <- as.matrix(cats)
cats <- as.data.frame(cats)
cfit2 <- mob(land~.|timeaftersunrize, data=cats,control = mob_control(alpha = 0.9, minsplit =2),model = linearModel)
plot(cfit2)

