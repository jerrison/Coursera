if ((Sys.info()["nodename"]) == "jerrison-Think-ubuntu") {
    setwd(paste("/home/jerrison/Documents/Github/Coursera",
          "/Getting and Cleaning Data/Week4", sep = ""))
} else print("unknown machine being used")


library(dplyr)
library(downloader)

# question 1

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


###############################################################################

#question 2

fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download(fileUrl2, "GDP_data.csv")

GDPData <- read.csv("GDP_data.csv", skip = 4, nrows = 190, stringsAsFactors = 
                        FALSE)
GDPData <- tbl_df(GDPData)    

GDP <- data.frame(GDPData[, "X.4"])
GDP <- GDP[GDP != ""]
GDP <- as.numeric(gsub(",", "", GDP))

mean(GDP, na.rm = TRUE)

###############################################################################

# question 3

countryNames <- data.frame(GDPData[, "X.3"])
countryNames <- countryNames[,1]
grep("^United", countryNames)
countryNames[grep("^United", countryNames)]



###############################################################################

# question 4

fileUrl3 <- paste0("https://d396qusza40orc.cloudfront.net/",
                  "getdata%2Fdata%2FEDSTATS_Country.csv")
download(fileUrl3, "EducationalData.csv")                  
                  
EducationalData <- read.csv("EducationalData.csv")
EducationalData <- tbl_df(EducationalData)



mergedData <- merge(GDPData, EducationalData, by.x = "X", by.y = "CountryCode")
mergedData <- tbl_df(mergedData)

sum(grepl("Fiscal year end: June", mergedData$Special.Notes))

###############################################################################

# question 5

library(quantmod)
amzn <- getSymbols("AMZN",auto.assign = FALSE)
sampleTimes <- index(amzn)

sum(grepl("2012", sampleTimes))
Times2012 <- sampleTimes[grepl("2012", sampleTimes)]

sum(grepl("Monday", weekdays(Times2012)))

