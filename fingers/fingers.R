library(googledrive)
drive_find(n_max = 50)
as_id("1A09wH_fi6NcGAQQU3Q3vihW2ZS5kxJhjET0cdmEe4xY")
remote <- drive_get(as_id("1A09wH_fi6NcGAQQU3Q3vihW2ZS5kxJhjET0cdmEe4xY"))
drive_download(remote, path = "fingers", type = "csv")

library(readr)
fingers <- read_csv("fingers.csv", col_types = cols(`Отметка времени` = col_datetime(format = "%d.%m.%Y %H:%M:%S")))
View(fingers)

require(dplyr)
require(stringi)
require(lubridate)

names(fingers) <- tolower(stri_trans_general(names(fingers), "russian-latin/bgn"))

names(fingers) <- c("time","damage","activity") 

fingers_mod <-
    fingers %>% 
    mutate(damage = tolower(stri_trans_general(damage, "russian-latin/bgn"))) %>% 
    mutate(damage = ifelse(damage == "da", 1, 0)) %>% 
    mutate(damage = factor(damage,
                           levels = c(1, 0),
                           labels = c("yes", "no")
            )) %>% 
    mutate(daystart=floor_date(time, "day")) %>% 
    mutate(dayhour=as.numeric(time-daystart)/3600)

fingers_mod <- fingers_mod %>% 
    mutate(day=    as.numeric((daystart-startingday)/86400)) %>% 
    mutate(weekday =as.numeric(factor(weekdays(time))))

startingday <- min(fingers_mod$daystart)
require(party)
cfit <- ctree(damage~dayhour, data = fingers_mod)
plot(cfit)

cfit2 <- mob(damage~dayhour|dayhour, data = fingers_mod,model = glinearModel, 
             family = binomial())
plot(cfit2)

