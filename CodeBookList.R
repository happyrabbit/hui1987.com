library(readr)
library(dplyr)
dat<-read.csv("/Users/happyrabbit/Documents/GitHub/hui1987.com/ReadingListHui.csv",stringsAsFactors = F)
dat<-dat%>%
  select(-ID)%>%
  select(-Hui.s.Comment)%>%
  select(-X)%>%
  select(-MindMap)

dat$Progress<-as.numeric(gsub("%","",dat$Progress))/100
###########
write.csv(dat,"/Users/happyrabbit/Documents/GitHub/hui1987.com/ReadingListHui.csv",row.names = F)
###########
library(readr)
library(dplyr)
dat<-read.csv("/Users/happyrabbit/Documents/GitHub/hui1987.com/ReadingListHui.csv",stringsAsFactors = F)

library(tibble)
dat<-as_tibble(dat)
######## Adding new book
x1<- tibble("艺用人体结构运动学",0,90,"P",NA,"someone","Art",'ART')
names(x1)<-names(dat)
tes<-rbind(dat,x1)

