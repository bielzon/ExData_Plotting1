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

png("plot3.png", width = 480, height = 480)
plot(data$Sub_metering_1 ~ data$Datetime, type = "l",
     col = "black", xlab = "", ylab = "Energy sub metering")
lines(data$Sub_metering_2 ~ data$Datetime, type="l", col="red")
lines(data$Sub_metering_3 ~ data$Datetime, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, lwd=2, col=c("black", "red", "blue"))
dev.off()