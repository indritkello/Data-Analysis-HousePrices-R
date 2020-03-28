#IMPORT DATASET
read.csv("C:/Users/User/Documents/R-Studies/Housing.csv")->houses
str(houses)
summary(houses)

#Install "dplyr" package and use it
library(dplyr)

### DATA CLEANING (pipeline operation)
houses %>% select(c(-1))->houses
houses %>% select(-driveway)->houses

##Install "ggplot2" package and use it
library(ggplot2)

### DATA VISUALIZATION
#simple plots
ggplot(data=houses, aes(x=price))+geom_histogram(bins=40)
ggplot(data=houses, aes(x=price))+geom_histogram(bins=40, fill="lightblue", col="blue")

#yes/no records for driveway column
ggplot(data=houses, aes(y=price, x=driveway, fill=driveway))+geom_boxplot()

#lotsize with price correlation
ggplot(houses, aes(x=lotsize, y=price))+geom_point(col="purple")+geom_smooth(method="lm", se=F)

#3 factor plot
ggplot(houses, aes(x=lotsize, y=price, col=factor(bedrooms)))+geom_point()+geom_smooth(method="lm", se=F)

### SPLITTING DATA (Training & Testing set)
library(caTools)


houses<-subset(houses, select = c(-recroom))
houses<-subset(houses, select = c(-fullbase))
houses<-subset(houses, select = c(-gashw))
houses<-subset(houses, select = c(-airco))
houses<-subset(houses, select = c(-prefarea))

sample.split(houses$price, SplitRatio=0.65)->split_index
train<-subset(houses, split_index==T)
test<-subset(houses, split_index==F)
nrow(train)
nrow(test)

### MODEL BUILDING (LINEAR REGRESSION)
lm(price~.,data=train)->mod1
predict(mod1, test)->result
cbind(actual=test$price, predicted=result)->compare_result
as.data.frame(compare_result)->compare_result
compare_result$actual-compare_result$predicted->error

#investigate the impact (look at the stars)
summary(mod1)

#calculate the error
cbind(compare_result, error)
sqrt(mean(compare_result$error^2))->rmse1

