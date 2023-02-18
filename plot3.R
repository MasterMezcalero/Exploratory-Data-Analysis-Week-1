## Downloading the data set and unzipping it into the working folder

url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, dest="dataset.zip", mode="wb") 
unzip ("dataset.zip", exdir = "./")

## Reading the data set, filtering on relevant dates, removing lines with missing data
## Lastly reformatting the Date column as a date

data <- fread("household_power_consumption.txt")
data <- subset(data, Date %in% c("1/2/2007","2/2/2007"))
data <- data[complete.cases(data),]
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

## Combining date and time to a DateTime field to create the required x-axis
## DateTime field then added to the data frame and formatted as POSIXct

DateTime <- paste(data$Date, data$Time)
data <- cbind(DateTime, data)
data$DateTime <- as.POSIXct(DateTime)

## Creating the graph; first the three lines are added and colored as required
## Secondly adding the legend

with(data, {
  plot(Sub_metering_1~DateTime, type="l", ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~DateTime,col="Red")
  lines(Sub_metering_3~DateTime,col="Blue")
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.5)

## Creating the png file
## Weekday labels are in German as this is the system language

dev.copy(png, file = "plot3.png")
dev.off()
