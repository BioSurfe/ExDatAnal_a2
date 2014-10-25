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
soureceSCC <- grep("motor", NEI[,3], ignore.case=T)
listOfSCC <- NEI[soureceSCC,1]
tab <- SCC[SCC$SCC %in%listOfSCC, c(1,4,6)]
x <- tab[tab$fips %in% c("24510", "06037"),]
x[,1]<- as.numeric(x[,1])


## split the dataframe according to factor year and calling the plot
library(plyr)
plotdata <- ddply(x,c("fips","year"),sum)

plotdata[,1]<- factor(plotdata[,1], labels = c("LosAngelescounty", "Baltimore"))

library(lattice)
xyplot(V1~year|fips, plotdata, ylab="PM2.5 from motor veichle (tons)",
       main="Emissions from motor Veichle sources in LosAngelescounty and Baltimore")

## storing the resulting plot in png format
dev.copy(png, file = "plot6.png",width = 480, height = 480, units = "px")
dev.off()
