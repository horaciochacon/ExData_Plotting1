# Script: plot2.R
# Author: Horacio Chacón Torrico

library(tidyverse)
library(lubridate)

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile() ; 
download.file(url, temp)

consumption <- read_delim(unzip(temp), delim = ";", na = '?')

consumption <- consumption %>% 
    mutate(Date = dmy(Date)) %>% 
    filter(between(Date, as.Date("2007-02-01"), as.Date("2007-02-02")))


plot(ymd_hms(paste(consumption$Date,consumption$Time)), 
     consumption$Global_active_power, type = 'n', 
     ylab = "Global Active Power (kilowatts)", xlab = NA)
lines(ymd_hms(paste(consumption$Date,consumption$Time)), 
      consumption$Global_active_power)
