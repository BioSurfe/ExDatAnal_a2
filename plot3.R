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
x <- SCC[which(SCC$fips=="24510"),c(4,5,6)]
x$type <- as.factor(x$type)
levels(x$type) <- c("NON-ROAD", "NONPOINT", "ON-ROAD",  "POINT")
x$type <- as.numeric(unclass(x$type))

## create summary table
library(plyr)
summaryTable<-ddply(x, c("type","year"), sum)
names(summaryTable) <- c("type", "year", "Emmission")
summaryTable$type <- as.factor(summaryTable$type)
levels(summaryTable$type) <- c("NON-ROAD", "NONPOINT", "ON-ROAD",  "POINT")

## plot using ggplot2
library(ggplot2)
qplot(year, Emmission ,data=summaryTable, 
      geom =  c("point","line"), facets = .~type)+labs(y ="PM2.5 Emisssion (tons)" , title="Three-Yearly PM2.5 in Baltimore, from different types of sources")

## storing the resulting plot in png format
dev.copy(png, file = "plot3.png",width = 480, height = 480, units = "px")
dev.off()
