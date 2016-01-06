# question 1

setwd("H:/Documents/GitHub/Coursera/Getting and Cleaning Data/Week3")
library(downloader)

fileUrl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download(fileUrl1, destfile = "housing.csv")

housing <- read.csv("housing.csv")

str(housing)

agricultureLogical <- (housing$ACR == 3 & housing$AGS == 6)
which(agricultureLogical == TRUE)

# question 2
library("jpeg")

fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download(fileUrl2, destfile = "image.jpg")

image <- readJPEG("getdata_jeff.jpg", native = TRUE)

resulting_quantiles <- quantile(image, probs = c(0.3, 0.8))
resulting_quantiles

# question 3
library(dplyr)
fileUrl3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
fileUrl4 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

download(fileUrl3, destfile = "Country_GDP.csv")
download(fileUrl4, destfile = "Country_education.csv")

country_1 <- read.csv("Country_GDP.csv")
country_GDP <- read.csv("Country_GDP.csv", nrow = 194, stringsAsFactors = FALSE)
names(country_GDP) <- c("Country_code", "GDP_ranking", "",
                        "Economy", "GDP_dollars")
country_education <- read.csv("Country_education.csv")

mergedData <- merge(country_GDP, country_education, by.x = "Country_code", 
                    by.y = "CountryCode")

sortedMergedData <- mergedData[order(desc(as.numeric(mergedData$GDP_ranking))),]

arrange(mergedData, GDP_rank)

# question 4 

GDPdata <- mergedData[, c("Country_code", "GDP_ranking", "Income.Group")]
GDPdata <- mutate(GDPdata, GDP_ranking_numeric = as.numeric(GDP_ranking))

tapply(GDPdata$GDP_ranking_numeric, GDPdata$Income.Group, mean)

GDPrankingQuantiles <- cut(GDPdata$GDP_ranking_numeric, breaks = 
                               quantile(GDPdata$GDP_ranking_numeric, probs = 
                                            c(0, 0.2, 0.4, 0.6, 0.8, 1.0))) 

table(GDPdata$Income.Group, GDPrankingQuantiles)
