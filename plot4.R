library(dplyr)
library(datasets)
powerConsumptionData <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", stringsAsFactors=FALSE)

## Need to convert the DateTime to POSIXct to get the proper plot with week days
## Had to change the way of filtering the data from plot1 to do it as POSIXct
## Note to self: Look at lubridate later
powerConsumptionData$Date <- as.Date(powerConsumptionData$Date, format="%d/%m/%Y")
data <- subset(powerConsumptionData, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
datetime <- paste(as.Date(data$Date), data$Time)
data$DateTime <- as.POSIXct(datetime)
rm(powerConsumptionData)

#plot 4 combines 4 plots 
par(mfrow = c(2, 2), oma = c(0,0,2,0))

# plot2 (upper-left)
plot(data$Global_active_power~data$DateTime, xlab="",ylab="Global Active Power (kilowatts)", type="l")

# upper-right
plot(data$Voltage~data$DateTime, xlab="datetime", ylab = "Voltage", type="l")

# plot3 (lower-left)
with(data, { plot (data$Sub_metering_1~data$DateTime,xlab="", ylab= "Energy Sub Meeting", type="l")
             lines(Sub_metering_2~DateTime,col='Red')
             lines(Sub_metering_3~DateTime,col='Blue')})
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_meeting_1", "Sub_meeting_2", "Sub_meeting_3"),  
       bty = "n", lty=1, lwd=2, cex=0.5, pt.cex=1)
#       cex=0.5, pt.cex = 1, pch = 1)

# lower-right
plot(data$Global_reactive_power~data$DateTime, xlab="datetime", ylab="Global_reactive_power", type="l")

dev.copy(png,'plot4.png', height=480, width=480)
dev.off()
