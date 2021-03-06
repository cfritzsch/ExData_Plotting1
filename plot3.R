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


# plot traces of submeterings to png file
png("plot3.png")
Sys.setlocale("LC_TIME", "English")
plot(powerData$Time, powerData$Sub_metering_1,
     ylab = "Energy sub metering", main = "", xlab = "", type = "l")
lines(powerData$Time, powerData$Sub_metering_2, col = "red")
lines(powerData$Time, powerData$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, col = c("black", "red", "blue"))
dev.off()



