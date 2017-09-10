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
        mutate(Date_Time = paste(Date, Time)) %>%
        mutate(Date_Time = ymd_hms(.$Date_Time)) -> raw_data

#produces png output
png(filename = 'plot2.png', width = 480, height = 480, bg = "transparent")
with(raw_data, plot(Date_Time, Global_active_power, 
                    type = "l",
                    xlab = "",
                    ylab = "Global Active Power (kilowatts)"))
dev.off()
