# Question 1
library(dplyr)
if (!file.exists("properties.csv")) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
    download.file(url = fileUrl, destfile = "properties.csv")
}

properties <- read.csv("properties.csv", header = TRUE)
properties <- tbl_df(properties)

ValBigThan1M <- filter(properties, VAL >= 24)

dim(ValBigThan1M)
