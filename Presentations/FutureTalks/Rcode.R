# 先安装这些包才能用library()函数载入
# caret: 提供获取、使用、评估成百上千个机器学习模型及其拟合效果的系统交互界面
# 为机器学习提供了结构化的方法并且对一系列机器学习过程进行评估
library(caret)
# e1071: 各类计量经济和机器学习的延伸；我们通过naiveBayes()函数进行朴素贝叶斯判别
library(e1071)
# gridExtra: 绘图辅助功能，讲不同的图形组合在一起成为图表
library(gridExtra) 
# lattice: 建立在核心绘图能力上的格子框架图形
library(lattice)
# imputeMissings: 填补缺失值
library(imputeMissings)
# RANN: 应用k邻近算法
library(RANN)
# corrplot: 相关矩阵的高级可视化
library(corrplot)
# nnet: 拟合单个潜层级的神经网络模型
library(nnet)
# car: 回归模型解释和可视化工具，其它附加功能； 其中包括some()和scatterplotMatrix()函数
library(car)
# gpairs: 广义散点图；对混合类别和连续变量产生散点图矩阵
library(gpairs)
# reshape2: 灵活重构和整合数据，主要有两个函数melt()和dcast()
library(reshape2)
# psych: 心理计量学方法和抽样调查分析，尤其是因子分析和项目反应模型；
# 我们会使用包中的describe()函数
library(psych)
# plyr: 可以将数据分割成更小的数据，然后对分割后的数据进行些操作，最后把操作的结果汇总
library(plyr)
library(tidyr)

sim.dat<-read.csv("https://raw.githubusercontent.com/happyrabbit/DataScientistR/master/Data/SegData.csv")
## sim.dat<-read.csv("/Users/happyrabbit/Documents/GitHub/DataScientistR/Data/SegData.csv")
(mdat <- melt(sdat, measure.vars=c("store_exp","online_exp")))
tidyr::gather(sdat,"variable","value",store_exp,online_exp)



