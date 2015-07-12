# Read the data in
rawData <- read.table(file.path("household_power_consumption.txt"), header = TRUE, sep = ";")

# Convert Date column to Date
rawData$Date <- as.Date(rawData$Date, "%d/%m/%Y")

# Get the data subset we care about
februaryData <- subset(rawData, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# Combine Date and Time columns into a single datetime column
februaryData$datetime <- as.POSIXct(paste(februaryData$Date, februaryData$Time), format="%Y-%m-%d %H:%M:%S")

# Convert the data we care about so the plot system will use it
februaryData$Global_active_power <- as.character(februaryData$Global_active_power)
februaryData$Voltage <- as.character(februaryData$Voltage)
februaryData$Sub_metering_1 <- as.character(februaryData$Sub_metering_1)
februaryData$Sub_metering_2 <- as.character(februaryData$Sub_metering_2)
februaryData$Sub_metering_3 <- as.character(februaryData$Sub_metering_3)
februaryData$Global_reactive_power <- as.character(februaryData$Global_reactive_power)

# Open png device
png(file.path("plot4.png"), width = 480, height = 480)
# Set it so there are 2 rows and 2 columns of plots
par(mfrow = c(2,2))

# Plot graph 1
with(februaryData, plot(datetime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))

# Plot graph 2
with(februaryData, plot(datetime, Voltage, type = "l"))

# Plot graph 3
with(februaryData, plot(datetime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black"))
with(februaryData, lines(datetime, Sub_metering_2, type = "l", xlab = "", col = "red"))
with(februaryData, lines(datetime, Sub_metering_3, type = "l", xlab = "", col = "blue"))
legend("topright", lty = c(1,1), col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")

# Plot graph 4
with(februaryData, plot(datetime, Global_reactive_power, type = "l"))

# Flush and close the png device
dev.off()