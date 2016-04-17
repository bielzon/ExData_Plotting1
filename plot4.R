## Common header: getting and cleaning data
library(httr)
setwd("./data-science/ExData_Plotting1")
zip <- "household_power_consumption.zip"
file <- "household_power_consumption.txt"
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists(zip)){download.file(url, zip, mode = "wb")}
if(!file.exists(file)){unzip(zip, list = FALSE, overwrite = FALSE)}
dataraw <- read.csv(file, header = TRUE, sep = ";", na.strings = "?",
                    nrows = 2075259, check.names = FALSE, stringsAsFactors = FALSE,
                    comment.char = "", quote = '\"')
dataraw$Date <- as.Date(dataraw$Date, "%d/%m/%Y")
data <- subset(dataraw, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)
rm(dataraw, zip, file, url)
## End of header

png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))	
plot(data$Global_active_power ~ data$Datetime, type = "l", xlab = "",
     ylab = "Global Active Power (kilowatts)")
plot(data$Voltage ~ data$Datetime, type = "l", xlab = "datetime",
     ylab = "Voltage (volt)")
plot(data$Sub_metering_1 ~ data$Datetime, type = "l", col = "black",
     xlab = "", ylab = "Global Active Power (kilowatts)")
lines(data$Sub_metering_2 ~ data$Datetime, col = "red")
lines(data$Sub_metering_3 ~ data$Datetime, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, lwd = 2, bty = "n", col = c("black", "red", "blue"))
plot(data$Global_reactive_power ~ data$Datetime, type = "l",
     xlab = "datetime", ylab = "Global Reactive Power (kilowatts)")
dev.off()