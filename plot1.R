# Read the data set
power_consumption <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

# Tidy up the data:
# (a) Combine the Date and Time columns into a Timestamp column (of class 'POSIXlt')
power_consumption$Timestamp <- strptime(paste(power_consumption$Date, power_consumption$Time), "%d/%m/%Y %T", tz = "GMT")
# (b) Drop the two original columns (Date and Time) and rearrange so that Timestamp is the first column
power_consumption <- power_consumption[, c(10, 3:9)]

# Extract the required subset
start_date <- as.Date("2007-02-01")
end_date   <- as.Date("2007-02-02")
power_consumption = subset(power_consumption, start_date <= as.Date(Timestamp) & as.Date(Timestamp) <= end_date)

# Open the PNG device:
png("plot1.png") # the required dimensions (480x480) are the default ones, thus not specified
# Make a histogram of Global Active Power
hist(power_consumption$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
# Close the device
dev.off()