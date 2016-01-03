


if ((Sys.info()["nodename"]) == "jerrison-Think-ubuntu") {
    setwd(paste("/home/jerrison/Documents/Github/Coursera",
          "/Getting and Cleaning Data/Week4", sep = ""))
} else print("unknown machine being used")


library(dplyr)
library(downloader)

install.packages("dplyr")

fileUrl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download(fileUrl1, "housingData.csv")
housingData <- read.csv("housingData.csv")
housingData <- tbl_df(housingData)


housingData
head(housingData)

housingData$WGTP
housingDataNames <- names(housingData)
str(housingDataNames)
temp1 <- strsplit(housingDataNames, "wgtp")
temp1[[123]]
