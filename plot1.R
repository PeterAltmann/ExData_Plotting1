if(!require(tidyverse)){
        install.packages("tidyverse")
        library(tidyverse)
}

read.csv("household_power_consumption.txt", sep = ";", na.strings = c("?")) %>%
        tbl_df() %>%
        mutate(., Date = dmy(as.character(.$Date))) %>%
        filter(Date >= "2007-02-01" & Date <= "2007-02-02") %>%
        mutate(Time = hms(.$Time)) -> raw_data

png(filename = 'plot1.png', width = 480, height = 480, bg = "transparent")
with(raw_data, hist(Global_active_power, 
                    col = "red", 
                    xlab = "Global Active Power (kilowatts)",
                    main = "Global Active Power"))
dev.off()
