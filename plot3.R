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

# Select the subset to plot
toplot <- plotData[plotData$Date == "1/2/2007" | plotData$Date == "2/2/2007",]
toplot$Sub_metering_1 <- as.numeric(toplot$Sub_metering_1)
toplot$Sub_metering_2 <- as.numeric(toplot$Sub_metering_2)
toplot$Sub_metering_3 <- as.numeric(toplot$Sub_metering_3)
# Concatenate $Date and $Time and convert to a Posix Date format
toplot$DateTime <- as.POSIXlt(paste(as.Date(toplot$Date, format="%d/%m/%Y"), 
                                    toplot$Time, sep=" "))
# Open png file
png(file="plot3.png", width=480, height=480)
# Plot
with(toplot, {
  plot(DateTime, Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")      
  lines(DateTime, Sub_metering_1, col="black")
  lines(DateTime, Sub_metering_2, col="red")
  lines(DateTime, Sub_metering_3, col="blue")
  legend("topright", col=c("black", "red", "blue"), 
         xjust = 1,
         yjust = 0,
         lty=1, 
         lwd=2,
         #cex=0.5,
         bty="o", 
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))  
  
}
)
# Close file
dev.off()
