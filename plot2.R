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
BaltimoreCity <- SCC[which(SCC$fips=="24510"),c(4,6)]


## split the dataframe according to factor year and calling the plot
library(plyr)
plot(ddply(BaltimoreCity,"year",sum), type = "l", ylab="PM2.5 from all sources(tons)", main = "Three-yealy PM2.5 Emission in Baltimore City, Maryland", pch = 10)

## storing the resulting plot in png format
dev.copy(png, file = "plot2.png",width = 480, height = 480, units = "px")
dev.off()
