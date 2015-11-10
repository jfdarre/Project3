library(lattice)
library(dplyr)
library(reshape)

setwd('/Users/jfdarre/Documents/NYCDS/Project3/NYCREx/nycrex/app/data')
my_data = read.csv('listings.csv')
head(my_data)
names(my_data)

#### part 1
set.seed(0)
train = sample(1:nrow(my_data), 7*nrow(my_data)/10)
test = (-train)


logit.overall = lm(price ~ nabe + new_bed + new_bath + sqft, data = my_data[train, ])


par(mfrow = c(1,1))
scatter.smooth(logit.overall$fit,
               residuals(logit.overall, type = "deviance"),
               lpars = list(col = "red"),
               xlab = "Fitted Probabilities",
               ylab = "Deviance Residual Values",
               main = "Residual Plot for\nLogistic Regression of Lung Cancer Data")
abline(h = 0, lty = 2)


library(car)
influencePlot(logit.overall)
plot(logit.overall)


temp = predict(logit.overall, my_data[test, ], type = "response")
cbind(my_data[test, c('nabe', 'new_bed', 'new_bath', 'sqft', 'price')], pred = round(temp))



#### part 2
my_data2 = filter(my_data, sqft !=0, price < 8000, bed <= 5)
my_data2[my_data2[,'new_bed']==0,'new_bed']=0.8
nrow(my_data2)
set.seed(0)
train = sample(1:nrow(my_data2), 7*nrow(my_data2)/10)
test = (-train)


logit.overall2 = lm(price ~ boro + new_bed + new_bath + sqft, data = my_data2[train, ])


par(mfrow = c(1,1))
scatter.smooth(logit.overall$fit,
               residuals(logit.overall, type = "deviance"),
               lpars = list(col = "red"),
               xlab = "Fitted Probabilities",
               ylab = "Deviance Residual Values",
               main = "Residual Plot for\nLogistic Regression of Lung Cancer Data")
abline(h = 0, lty = 2)


library(car)
influencePlot(logit.overall)
plot(logit.overall)


temp = predict(logit.overall2, my_data2[test, ], type = "response")
temp2 = cbind(my_data2[test, c('boro', 'new_bed', 'new_bath', 'sqft', 'price')], pred = round(temp))
names(temp2)
sum(    (temp2[,'price']-temp2[,'pred'])^2    )  /   (sd(temp2[,'price'])^2)


temp2$diff = (temp2[,'price']-temp2[,'pred'])^2
filter(temp2, diff > 1e6)


t(filter(my_data2, new_bed == 0.8, price == 7000))















