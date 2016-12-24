################################################################################
# Author: Jerrison Li
# Date: Friday, December 23, 2016 6:14:42 PM PST
# Filename:
# Version: 1.0
# Description:
################################################################################

library(dplyr)
library(tidyr)

################################################################################
# 
################################################################################

library(kernlab)
data(spam)

set.seed(3435)
trainingIndicator <- rbinom(4601, size = 1, prob = 0.5)
table(trainingIndicator)

################################################################################

trainSpam <- spam[trainingIndicator == 1, ]
testSpam <- spam[trainingIndicator == 0, ]

head(names(trainSpam), 20)

head(trainSpam[, 1:10])

str(trainSpam)

table(trainSpam$type)

boxplot(capitalAve ~ type, data = trainSpam)

boxplot(log10(capitalAve + 1) ~ type, data = trainSpam)

# let's take a look at the relationship between the first 4 variables of the 
# trainSpam data (logtransformed)
pairs(log10(trainSpam[, 1:4] + 1))

# plot Dendogram to see what predictors or what words or characteristics tend to
# cluster together

hCluster <- hclust(dist(t(trainSpam[, 1:57])))
plot(hCluster)

# redo clustering after transforming the predictors to log10

hClusterUpdated <- hclust(dist(t(log10(trainSpam[, 1:55] +1 ))))
plot(hClusterUpdated)

# build a GLM based on logistic regression.  Univariate predictor to determine
# whether an email is spam or not.  We will cycle through all the predictors and
# subsquently calculate the cross validated error rate of predicting spam emails
# from a single variable