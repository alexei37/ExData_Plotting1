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
png("plot4.png") # the required dimensions (480x480) are the default ones, thus not specified

# Make a 2x2 grid for the four plots we are about to draw (clockwise; could have used 'par(mfcol = c(2, 2))' to draw the counterclockwise)
par(mfrow = c(2, 2))
# The top left plot -- (almost) the same as in plot2.R (and plot2.png), with a minor modification to the y-label
with(power_consumption, plot(Timestamp, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))
# The top right plot -- very similar to plot2.R (and plot2.png), except that x-label ("datetime") is added
with(power_consumption, plot(Timestamp, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))
# The bottom left plot: almost identical to the one in plot3.R (and plot3.png) but we avoid drawing the box around the legend 
with(power_consumption, plot(Timestamp, Sub_metering_1, type = "n", xlab = "", ylab = "Energy Sub Metering"))
with(power_consumption, lines(Timestamp, Sub_metering_1))
with(power_consumption, lines(Timestamp, Sub_metering_2, col = "red"))
with(power_consumption, lines(Timestamp, Sub_metering_3, col = "blue"))
# Note that 'bty = "n"' is set in order to skip the box around the legend
legend("topright", names(power_consumption)[6:8], lty = par("lty"), col = c(par("col"), "red", "blue"), bty = "n")
# The last, bottom right one; once agian, it is similar to the top two plots, with only mior modifications
with(power_consumption, plot(Timestamp, Global_reactive_power, type = "l", xlab = "datetime"))
     
# Close the device
dev.off()