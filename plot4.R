read.csv("household_power_consumption.txt", sep = ";", na.strings = c("?")) %>%
        tbl_df() %>%
        mutate(., Date = dmy(as.character(.$Date))) %>%
        filter(Date >= "2007-02-01" & Date <= "2007-02-02") %>%
        mutate(datetime = paste(Date, Time)) %>%
        mutate(datetime = ymd_hms(.$datetime)) -> raw_data

png(filename = 'plot4.png', width = 480, height = 480, bg = "transparent")

par(mfrow = c(2,2))

with(raw_data, plot(datetime, Global_active_power, 
                    type = "l",
                    xlab = "",
                    ylab = "Global Active Power",
                    bg = "transparent"))

with(raw_data, plot(datetime, Voltage, 
                    type = "l",
                    ylab = "Voltage",
                    bg = "transparent"))

with(raw_data, plot(datetime, Sub_metering_1,
                    type = "l",
                    xlab = "",
                    ylab = "Energy sub meetering",
                    bg = "transparent"))
with(raw_data, lines(datetime, raw_data$Sub_metering_2, col = "red"))
with(raw_data, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n",
       col = c("black", "red", "blue"),
       lty = 1,
       bg = "transparent")

with(raw_data, plot(datetime, Global_reactive_power, 
                    type = "l",
                    bg = "transparent"))

dev.off()