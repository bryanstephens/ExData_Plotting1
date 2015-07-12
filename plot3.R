# Read the data in
rawData <- read.table(file.path("household_power_consumption.txt"), header = TRUE, sep = ";")

# Convert Date column to Date
rawData$Date <- as.Date(rawData$Date, "%d/%m/%Y")

# Get the data subset we care about
februaryData <- subset(rawData, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# Combine Date and Time columns into a single datetime column
februaryData$datetime <- as.POSIXct(paste(februaryData$Date, februaryData$Time), format="%Y-%m-%d %H:%M:%S")

# Convert the data we care about so the plot system will use it
februaryData$Sub_metering_1 <- as.character(februaryData$Sub_metering_1)
februaryData$Sub_metering_2 <- as.character(februaryData$Sub_metering_2)
februaryData$Sub_metering_3 <- as.character(februaryData$Sub_metering_3)

# Open png device
png(file.path("plot3.png"), width = 480, height = 480)

# Plot the 3 line graphs to the same plot
with(februaryData, plot(datetime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black"))
with(februaryData, lines(datetime, Sub_metering_2, type = "l", xlab = "", col = "red"))
with(februaryData, lines(datetime, Sub_metering_3, type = "l", xlab = "", col = "blue"))
# Add a nifty legend
legend("topright", lty = c(1,1), col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# Flush and close the png device
dev.off()