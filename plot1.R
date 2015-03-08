# Plot 1.
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

# Write output to a PNG
png("plot1.png", width=480, height=480)

hist(householdData$Global_active_power, col="red", xlab="Global Active Power (kilowatts)",
     main="Global Active Power")

# Close the file
dev.off()
