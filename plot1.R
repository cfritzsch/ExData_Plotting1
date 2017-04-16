rm(list = ls())

#########################
# Download File and unzip

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename <- "household_power_consumption.zip"

if (!file.exists(filename)){
      download.file(fileURL, filename)
}
if (!file.exists("household_power_consumption.txt")){
      unzip(filename)
}

#########################
# read file
powerData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                   na.strings = "?", stringsAsFactors = FALSE)

# what did we load?
summary(powerData)

# convert date and time
powerData$Time = strptime(paste(powerData$Date, powerData$Time), "%d/%m/%Y %H:%M:%S")
powerData$Date = as.Date(powerData$Date, "%d/%m/%Y")

# only keep entries from 2007-02-01 and 2007-02-02
powerData <- powerData[powerData$Time < strptime("2007-02-03 00:00:00", "%Y-%m-%d %H:%M:%S"),]
powerData <- powerData[powerData$Time >= strptime("2007-02-01 00:00:00", "%Y-%m-%d %H:%M:%S"),]
powerData <- powerData[!is.na(powerData$Time),]


# plot histogram of active power to png file
png("plot1.png")
hist(powerData$Global_active_power, xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power", col = "red")
dev.off()



