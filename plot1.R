# Read the data in
rawData <- read.table(file.path("household_power_consumption.txt"), header = TRUE, sep = ";")

# Convert Date column to Date
rawData$Date <- as.Date(rawData$Date, "%d/%m/%Y")

# Get the data subset we care about
februaryData <- subset(rawData, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# Make the Global_active_power column usable by the plotting system
februaryData$Global_active_power <- as.character(februaryData$Global_active_power)
februaryData$Global_active_power <- as.numeric(februaryData$Global_active_power)

# Create png device
png(file.path("plot1.png"), width = 480, height = 480)
# Plot histogram
hist(februaryData$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
# Close and flush device
dev.off()