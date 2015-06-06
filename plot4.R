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
toplot$Global_active_power <- as.numeric(toplot$Global_active_power)
toplot$Global_reactive_power <- as.numeric(toplot$Global_reactive_power)
toplot$Voltage <- as.numeric(toplot$Voltage)
toplot$Sub_metering_1 <- as.numeric(toplot$Sub_metering_1)
toplot$Sub_metering_2 <- as.numeric(toplot$Sub_metering_2)
toplot$Sub_metering_3 <- as.numeric(toplot$Sub_metering_3)
# Concatenate $Date and $Time and convert to a Posix Date format
toplot$DateTime <- as.POSIXlt(paste(as.Date(toplot$Date, format="%d/%m/%Y"), 
                                    toplot$Time, sep=" "))
# Open png file
png(file="plot4.png", width=480, height=480)
# Plot
par(mfrow=c(2,2))
with(toplot, {
  plot(DateTime, Global_active_power, type="l", ylab="Global active power (kilowatts)", xlab="")      
  plot(DateTime, Voltage, type="l", ylab="Voltage", xlab="datetime")      
  plot(DateTime, Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")      
  lines(DateTime, Sub_metering_1, col="black")
  lines(DateTime, Sub_metering_2, col="red")
  lines(DateTime, Sub_metering_3, col="blue")
  legend("topright", col=c("black", "red", "blue"), 
         xjust = 1,
         yjust = 0,
         #y.intersp=1,
         lty=1, 
         lwd=1,
         bty="n",
         cex=0.5,
         #text.width=15,
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))  
  
  plot(DateTime, Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")      
}
)
# Close file
dev.off()
