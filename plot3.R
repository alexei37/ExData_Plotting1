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
png("plot3.png") # the required dimensions (480x480) are the default ones, thus not specified

# Make a line plot of the three sub-metering measures:
# (a) Initialize the plot; make it not shown (type = "n") just for the sake of symmetry below
with(power_consumption, plot(Timestamp, Sub_metering_1, type = "n", xlab = "", ylab = "Energy Sub Metering"))
# (b) Add the 3 measures to the plot one by one
with(power_consumption, lines(Timestamp, Sub_metering_1)) # use the default color, par("col") = "black", for this one
with(power_consumption, lines(Timestamp, Sub_metering_2, col = "red"))
with(power_consumption, lines(Timestamp, Sub_metering_3, col = "blue"))
# (c) Finally, add the legend:
legend("topright", names(power_consumption)[6:8], lty = par("lty"), col = c(par("col"), "red", "blue"))

# Close the device
dev.off()