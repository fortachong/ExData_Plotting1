# Author: Jorge Chong
# Set Language to English
Sys.setlocale("LC_TIME", "English")
# Download the file from the official URL
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
              method="auto", destfile = "data.zip")

# Import to data frame plotData, using unzip to decompress file
plotData <- read.table(unzip("data.zip", "household_power_consumption.txt"), sep = ";", header = TRUE, 
                       colClasses = c("character","character","character",
                                      "character","character","character",
                                      "character","character","character"))


# Open png file
png(file="plot1.png", width=480, height=480)

toplot <- plotData[plotData$Date == "1/2/2007" | plotData$Date == "2/2/2007",]
toplot$Global_active_power <- as.numeric(toplot$Global_active_power)

hist(toplot$Global_active_power, 
     main = "Global Active Power", 
     col = "red", 
     xlab = "Global Active Power (kilowatts)")
# Close file
dev.off()
