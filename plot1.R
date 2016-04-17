## Common header: getting and cleaning data
library(httr)
setwd("./data-science/ExData_Plotting1")
zip <- "household_power_consumption.zip"
file <- "household_power_consumption.txt"
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists(zip)){
    download.file(url, zip, mode = "wb")
}
if(!file.exists(file)){
    unzip(zip, list = FALSE, overwrite = FALSE)
}
dataraw <- read.csv(file, header = TRUE, sep = ";", na.strings = "?",
                 nrows = 2075259, check.names = FALSE, stringsAsFactors = FALSE,
                 comment.char = "", quote = '\"')
dataraw$Date <- as.Date(dataraw$Date, "%d/%m/%Y")
data <- subset(dataraw, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)
rm(dataraw, zip, file, url)
## End of header

png("plot1.png", height = 480, width = 480)
hist(data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency", col = "red")
dev.off()