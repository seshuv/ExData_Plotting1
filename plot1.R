powerConsumptionData <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", stringsAsFactors=FALSE)

library(dplyr)

powerConsumptionData$DateTime <- strptime(paste(powerConsumptionData$Date, powerConsumptionData$Time), format="%d/%m/%Y %H:%M:%S")

powerConsumptionData$DateTime <- as.Date(powerConsumptionData$DateTime, format = "%d/%m/%Y %H:%M:%S")
data <- filter(powerConsumptionData, DateTime >= as.Date("2007-02-01 00:00:00"), DateTime < as.Date("2007-02-03 00:00:00"))

rm(powerConsumptionData)

#plot 1
hist(data$Global_active_power, col= "red", xlab = "Global Active Power (kilowatts)")

dev.copy(png,'plot1.png', height=480, width=480)
dev.off()
