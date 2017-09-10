#checks for required packages
if(!require(tidyverse)){
        install.packages("tidyverse")
        library(tidyverse)
}

if(!require(lubridate)){
        install.packages("lubridate")
        library(lubridate)
}

#Reads file and prepares it
read.csv("household_power_consumption.txt", sep = ";", na.strings = c("?")) %>%
        tbl_df() %>%
        mutate(., Date = dmy(as.character(.$Date))) %>%
        filter(Date >= "2007-02-01" & Date <= "2007-02-02") %>%
        mutate(datetime = paste(Date, Time)) %>%
        mutate(datetime = ymd_hms(.$datetime)) -> raw_data

#produces png output
png(filename = 'plot3.png', width = 480, height = 480, bg = "transparent")

        with(raw_data, plot(datetime, Sub_metering_1,
                    type = "l",
                    xlab = "",
                    ylab = "Energy sub meetering"))
        with(raw_data, lines(datetime, raw_data$Sub_metering_2, col = "red"))
        with(raw_data, lines(datetime, Sub_metering_3, col = "blue"))
        legend("topright", 
                legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                col = c("black", "red", "blue"),
                lty = 1,
                bg = "transparent")

dev.off()
