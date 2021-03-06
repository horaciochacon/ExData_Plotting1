# Script: plot3.R
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

png("plot3.png", units = "px", width = 480, height = 480) 
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
       lty = 1, col = c("black","red","blue"))
dev.off()
