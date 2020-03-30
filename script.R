#IMPORT DATASET
read.csv("C:/Users/User/Documents/R-Studies/Housing.csv")->houses
str(houses) # Display the content of the file
summary(houses) #Data Statistics

#Install "dplyr" package and use it
library(dplyr) # Library for Data Manipulation

### DATA CLEANING (pipeline operation)
houses %>% select(c(-1))->houses
str(houses)
houses %>% select(-driveway)->houses

##Install "ggplot2" package and use it
library(ggplot2) # Library for DATA VISUALIZATION

### DATA VISUALIZATION
#simple plots
ggplot(data=houses, aes(x=price))+geom_histogram(bins=40)
ggplot(data=houses, aes(x=price))+geom_histogram(bins=40, fill="lightblue", col="blue")

#yes/no records for driveway column
ggplot(data=houses, aes(y=price, x=driveway, fill=driveway))+geom_boxplot()


#lotsize with price correlation
ggplot(houses, aes(x=lotsize, y=price))+geom_point(col="purple")+geom_smooth(method="lm", se = F)
# lm -> Linear Model se -> square root of variance/ no of observations (T/F)

#3 factor plot
ggplot(houses, aes(x=lotsize, y=price, col=factor(bedrooms)))+geom_point()+geom_smooth(method="lm", se=F)

### SPLITTING DATA (Training & Testing set)
library(caTools) # Library for window statistic functions

#skip columns you dont want to be part of the model, or lease the set as it is
houses<-subset(houses, select = c(-prefarea))

sample.split(houses$price, SplitRatio=0.7)->split_index # 75% of the records (random) will have the splitIndex = T (true)
train<-subset(houses, split_index==T) # Those with index = T are moved to subset of training
test<-subset(houses, split_index==F)
nrow(train)
nrow(test)
summary(train)

### MODEL BUILDING (LINEAR REGRESSION)
lm(price~.,data=train)->mod1 #linear model of price towards all other attributes
predict(mod1, test)->result #The first attribute should be a model
cbind(actual=test$price, predicted=result)->compare_result #Compares actual price values from test subset agains predicted ones
as.data.frame(compare_result)->compare_result #Set of functions/pattern which can be enhanced

compare_result$actual-compare_result$predicted->error

#investigate the impact (look at the stars)
summary(mod1)

#calculate the error
cbind(compare_result, error)->compare_result# binds the error column in compare_result set

# **Root Mean Square Error (RMSE) is the standard deviation of the residuals (prediction errors). 
# **Residuals are a measure of how far from the regression line data points are;
sqrt(mean(compare_result$error^2))->rmse1
str(rmse1)

#predicted-actual correlation
ggplot(compare_result, aes(x=actual, y=predicted))+geom_point(col="purple")+geom_smooth(method="lm", se = T)
