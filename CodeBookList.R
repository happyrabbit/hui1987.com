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
library(tibble)
dat<-read.csv("/Users/happyrabbit/Documents/GitHub/hui1987.com/ReadingListHui.csv",stringsAsFactors = F)

# combine "Chinese.Version","English.Version","Audio" together
c1<-toupper(dat$Chinese.Version)
table(c1)
c1<-paste("CN",c1,sep="_")
c1[which(c1=="CN_")]<-""
###########
c2<-toupper(dat$English.Version)
table(c2)
c2<-paste("EN",c2,sep="_")
c2[which(c2=="EN_")]<-""
c2[which(c2=="EN_NO ")]<-"EN_NO"
###########
c0<-paste(c1,c2,sep=" & ")

table(c0)
summary(dat)

dat<-as_tibble(dat)
######## Adding new book
x1<- tibble("艺用人体结构运动学",0,90,"P",NA,"someone","Art",'ART')
names(x1)<-names(dat)
tes<-rbind(dat,x1)

