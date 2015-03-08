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

png("plot2.png", width=480, height=480)

plot(householdData$DateTime, householdData$Global_active_power, type="l",
     xlab="", ylab="Global Active Power (kilowatts)")

dev.off()