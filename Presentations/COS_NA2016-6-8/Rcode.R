library(plyr)
library(dplyr)
library(psych)
library(caret)
sim.dat<-read.csv("https://raw.githubusercontent.com/happyrabbit/DataScientistR/master/Data/SegData.csv")
## sim.dat<-read.csv("/Users/happyrabbit/Documents/GitHub/DataScientistR/Data/SegData.csv")
## --------------------------------------------------------
## psych包中的describle函数可以给出更多关于数据的描述性信息
describe(sim.dat,na.rm = T, skew = F)
## --------------------------------------------------------
## `apply()`、`lapply()`和`sapply()`
## 之前通过`preProcess()`函数对数据进行KNN填补时用过
## 提取数据框中所有的数值变量
## 这里不能用`apply()`函数是因为`apply()`函数自动将对象转化成矩阵，这样就会丢失每列的类别信息
apply(sim.dat,class)
sdat<-sim.dat[,!lapply(sim.dat,class)=="factor"]
## --------------------------------------------------------
## 现在的数据框`sdat`中只包括数值型的变量
## 用`apply()`函数对每列求均值和标准差
apply(sdat, MARGIN=2,function(x) mean(na.omit(x)))
apply(sdat, MARGIN=2,function(x) sd(na.omit(x)))
## --------------------------------------------------------
## plyr包中的函数ddply()
## 各组客户的人口统计学和消费行为档案
ddply(sim.dat,"segment",summarize, Age=round(mean(na.omit(age)),0),
      FemalePct=round(mean(gender=="Female"),2),
      HouseYes=round(mean(house=="Yes"),2),
      store_exp=round(mean(na.omit(store_exp),trim=0.1),0),
      online_exp=round(mean(online_exp),0),
      store_trans=round(mean(store_trans),1),
      online_trans=round(mean(online_trans),1))
## 计算在线和实体店平均每次购买的花销
ddply(sim.dat,"segment",summarize,avg_online=round(sum(online_exp)/sum(online_trans),2),
      avg_store=round(sum(store_exp)/sum(store_trans),2))
## --------------------------------------------------------
## 我们按照消费者类别比例随机抽取11个样本，
## 选择3个变量（`age`，`store_exp`和`segment`）
## 用于展示（数据框：`examp`）
## --------------------------------------------------------
library(caret)
set.seed(2016)
trainIndex<-createDataPartition(sim.dat$segment,p=0.01,list=F,times=1)
examp<-sim.dat[trainIndex,c("age","store_exp","segment")]
## `transform`设置的作用
ddply(examp,"segment",transform,store_pct=round(store_exp/sum(store_exp),2))
## `subset`设置
ddply(examp,"segment",subset,store_exp>median(store_exp))
## --------------------------------------------------------
## dplyr包
## 数据框显示
## tbl_df()函数: 能将数据转化成`tbl`类，这样查看起来更加方便，输出会调整适应当前窗口
dplyr::tbl_df(sim.dat)
## glimpse()函数：类似之前的`tbl_df()`函数，只是转了方向。变量由列变成行。输出结果同样可以自动调整以适应窗口。
dplyr::glimpse(sim.dat)
##
## 数据截选（按行／列）
## 提取出满足条件的行
dplyr::filter(sim.dat, income >300000) %>%
  dplyr::tbl_df()
## 将`%>%`左边的对象传递给右边的函数，作为第一个选项的设置（或剩下唯一一个选项的设置）
ave_exp <- filter( 
  summarise(
    group_by( 
      filter(
        sim.dat, 
        !is.na(income)
      ), 
      segment
    ), 
    ave_online_exp = mean(online_exp), 
    n = n()
  ), 
  n > 200
) 
## 再看看用管道操作符进行相同操作的代码：
avg_exp <- sim.dat %>% 
  filter(!is.na(income)) %>% 
  group_by(segment) %>% 
  summarise( 
    ave_online_exp = mean(online_exp), 
    n = n() ) %>% 
  filter(n > 200)

## `distinct()`函数可以删除数据框中重复的行。可以说是`unique()`函数在数据框上的扩展。

dplyr::distinct(sim.dat)

## `sample_frac()`函数可以随机选取一定比例的行。`sample_n()`函数可以随机选取一定数目的行。

dplyr::sample_frac(sim.dat, 0.5, replace = TRUE) 
dplyr::sample_n(sim.dat, 10, replace = TRUE) 

## `slice()`可以选取指定位置的行。和`sim.dat[10:15,]`类似。
## 选取sim.dat的10到15行
dplyr::slice(sim.dat, 10:15) 

## `top_n()`可以选取某变量取值最高的若干观测。如果有指定组的话，可以对每组选择相应变量取值最高的观测。
## 选取收入最高的两个观测
dplyr::top_n(sim.dat,2,income)

## 数据总结
## 生成新变量
## 合并数据集