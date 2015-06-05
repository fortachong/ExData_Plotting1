
setwd("E:/Coursera/Data")

plotData <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, 
                       colClasses = c("character","character","character",
                                      "character","character","character",
                                      "character","character","character"))
toplot <- plotData[plotData$Date == "1/2/2007" | plotData$Date == "2/2/2007",]
toplot$Global_active_power <- as.numeric(toplot$Global_active_power)

hist(toplot$Global_active_power, 
     main = "Global Active Power", 
     col = "red", 
     xlab = "Global Active Power (kilowatts)")
