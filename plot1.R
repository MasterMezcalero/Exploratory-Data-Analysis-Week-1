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

## Creation of the histogram

hist(ActivePower, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

# Copying to png file; 480x480 pixel is the default setting

dev.copy(png, file = "plot1.png")
dev.off()
