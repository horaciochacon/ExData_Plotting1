# Script: plot1.R
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

hist(consumption$Global_active_power, col = "red", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency",
     main = "Global Active Power")




