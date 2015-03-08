filePath <- 'household_power_consumption.txt'

# helps in the development.
if( !exists("rawData") ) {
  rawData <- read.table(filePath, sep=";", header=TRUE, na.strings="?")
}

# Add in a date/time row and subset to get the data that we are interested in
fromDate = as.Date('2007/02/01', format='%Y/%m/%d')
toDate = as.Date('2007/02/02', format='%Y/%m/%d')
householdData <- subset(rawData, as.Date(rawData$Date, format='%d/%m/%Y') >= fromDate &
                          as.Date(rawData$Date, format='%d/%m/%Y') <= toDate)
householdData$DateTime <- strptime(paste(householdData$Date, householdData$Time), '%d/%m/%Y %H:%M')

png("plot3.png", width=480, height=480)

plot(householdData$DateTime, householdData$Sub_metering_1, type="l",
     xlab="", ylab="Energy sub metering")
points(householdData$DateTime, householdData$Sub_metering_2, type="l", col="red")
points(householdData$DateTime, householdData$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1,1), lwd=c(2.5,2.5,2.5), col=c("black", "red", "blue"))

dev.off()