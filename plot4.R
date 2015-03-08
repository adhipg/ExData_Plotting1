# Plot 4.
# Download the file and unzip it if `rawData` doesn't exist in our env.
filePath <- 'household_power_consumption.txt'
zipPath <- 'exdata-data-household_power_consumption.zip'
fileUrl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'

# helps in the development if we are sourcing multiple files together - we don't
# have to import this dataset multiple times across plots.
if( !exists("rawData") ) {
    if( !file.exists(filePath) ) {
        download.file(fileUrl, dest=zipPath, method="curl")
        unzip(zipPath)
    }
    rawData <- read.table(filePath, sep=";", header=TRUE, na.strings="?")
}

# Add in a date/time row and subset to get the data that we are interested in
fromDate = as.Date('2007/02/01', format='%Y/%m/%d')
toDate = as.Date('2007/02/02', format='%Y/%m/%d')
householdData <- subset(rawData,
                  as.Date(rawData$Date, format='%d/%m/%Y') >= fromDate &
                  as.Date(rawData$Date, format='%d/%m/%Y') <= toDate)

householdData$DateTime <- strptime(paste(householdData$Date, householdData$Time),
                                   '%d/%m/%Y %H:%M')

# Write output to PNG
png("plot4.png", width=480, height=480)

# Create the canvas that can contain 2 * 2 plots
par(mfrow=c(2,2), mar=c(5.1, 4.1, 4.1, 2.1))
cexSize <- 1 # text size

# Plot 1
plot(householdData$DateTime, householdData$Global_active_power, type="l",
     xlab="", ylab="Global Active Power", cex.axis=cexSize, cex.lab=cexSize)

# Plot 2
plot(householdData$DateTime, householdData$Voltage, type="l",
     xlab="datetime", ylab="Voltage", cex.axis=cexSize, cex.lab=cexSize)

# Plot 3
plot(householdData$DateTime, householdData$Sub_metering_1, type="l",
     xlab="", ylab="Energy sub metering", cex.axis=cexSize, cex.lab=cexSize)
points(householdData$DateTime, householdData$Sub_metering_2, type="l", col="red")
points(householdData$DateTime, householdData$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1,1), lwd=c(2.5,2.5,2.5), col=c("black", "red", "blue"), bty="n",
       cex=cexSize)

# Plot 4
plot(householdData$DateTime, householdData$Global_reactive_power, type="l",
     xlab="datetime", ylab="Global_reactive_power", cex.axis=cexSize, cex.lab=cexSize)

# Close the PNG
dev.off()
