# library(dplyr)
# library(pipeR)
# library(stringi)
# translate<-function(x) {
#   x %>% stri_trans_general("Cyrillic-Latin")%>%make.names()
# }
library("base64enc")
library("stringr")
library("twitteR")
library("textcat")
library("tm")
library(readr)
Sys.setlocale("LC_ALL","Russian_Russia")
idonlycommadelimited <- read_csv("plusbank/idonlycommadelimited.csv",  locale = locale("ru"))
 messages.lang_category<-textcat(idonlycommadelimited)
 