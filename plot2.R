library(dplyr)
powerConsumptionData <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", stringsAsFactors=FALSE)

## Need to convert the DateTime to POSIXct to get the proper plot with week days
## Had to change the way of filtering the data from plot1 to do it as POSIXct
## Note to self: Look at lubridate later
powerConsumptionData$Date <- as.Date(powerConsumptionData$Date, format="%d/%m/%Y")
data <- subset(powerConsumptionData, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
datetime <- paste(as.Date(data$Date), data$Time)
data$DateTime <- as.POSIXct(datetime)
rm(powerConsumptionData)

#plot 2
plot(data$Global_active_power~data$DateTime, xlab="",ylab="Global Active Power (kilowatts)", type="l")

dev.copy(png,'plot2.png', height=480, width=480)
dev.off()
