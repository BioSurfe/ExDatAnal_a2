setwd("E:/coursera/01LRS/01RSAD/mywd/data")

##Download the data form website

#fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
#download.file(fileurl, destfile = "E:/coursera/01LRS/01RSAD/mywd/data/exdata-data-NEI_data.zip")
#dateDownloaded <- date()##"Fri Aug 22 20:40:33 2014"

##unzip the data
unzip("E:/coursera/01LRS/01RSAD/mywd/data/exdata-data-NEI_data.zip", 
      exdir = ".")

setwd("E:/coursera/01LRS/01RSAD/mywd/data/exdata-data-NEI_data")

## Loading the dataset into R
SCC <- readRDS("summarySCC_PM25.rds")
NEI <- readRDS("Source_Classification_Code.rds")

## Extracting out the informative columns from the data
soureceSCC <- grep("coal", NEI[,4], ignore.case=T)
listOfSCC <- NEI[soureceSCC,1]
tab <- SCC[SCC$SCC %in%listOfSCC, c(4,6)]

## split the dataframe according to factor year and calling the plot
library(plyr)
plot(ddply(tab,"year",sum), type = "l", ylab="PM2.5 from coal combustion(tons)", main = "Three-yearly PM2.5 Emission from Coal sources in US", pch = 10)

## storing the resulting plot in png format
dev.copy(png, file = "plot4.png",width = 480, height = 480, units = "px")
dev.off()
