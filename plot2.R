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

## Creation of plot and png
## Weekday labels are in German as this is the system language

with(data, plot(Global_active_power~DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab=""))
dev.copy(png, file = "plot2.png")
dev.off()

