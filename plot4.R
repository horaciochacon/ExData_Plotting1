# Script: plot4.R
# Author: Horacio Chacón Torrico

## Getting and Cleaning de data

library(tidyverse)
library(lubridate)

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile() ; tempdir <- tempdir()
download.file(url, temp)

consumption <- read_delim(unzip(temp,exdir = tempdir), delim = ";", na = '?')

consumption <- consumption %>% 
    mutate(Date = dmy(Date)) %>% 
    filter(between(Date, as.Date("2007-02-01"), as.Date("2007-02-02")))

## Making the plot

png("plot4.png", units = "px", width = 480, height = 480) 
par(mfrow = c(2,2))

plot(ymd_hms(paste(consumption$Date,consumption$Time)), 
     consumption$Global_active_power, type = 'n', 
     ylab = "Global Active Power (kilowatts)", xlab = NA)
lines(ymd_hms(paste(consumption$Date,consumption$Time)), 
      consumption$Global_active_power)

plot(ymd_hms(paste(consumption$Date,consumption$Time)), 
     consumption$Voltage, type = 'n', 
     ylab = "Voltage", xlab = "datetime")
lines(ymd_hms(paste(consumption$Date,consumption$Time)), 
      consumption$Voltage)


plot(ymd_hms(paste(consumption$Date,consumption$Time)), 
     consumption$Sub_metering_1, type = 'n', 
     ylab = "Energy sub metering", xlab = NA)
lines(ymd_hms(paste(consumption$Date,consumption$Time)), 
      consumption$Sub_metering_1)
lines(ymd_hms(paste(consumption$Date,consumption$Time)), 
      consumption$Sub_metering_2, col = "red")
lines(ymd_hms(paste(consumption$Date,consumption$Time)), 
      consumption$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = 1, col = c("black","red","blue"), bty = "n")

plot(ymd_hms(paste(consumption$Date,consumption$Time)), 
     consumption$Global_reactive_power, type = 'n', 
     ylab = "Global_reactive_power", xlab = "datetime")
lines(ymd_hms(paste(consumption$Date,consumption$Time)), 
      consumption$Global_reactive_power)

dev.off()
