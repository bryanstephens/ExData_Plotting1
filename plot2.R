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
februaryData$Global_active_power <- as.numeric(februaryData$Global_active_power)

# Open png device
png(file.path("plot2.png"), width = 480, height = 480)
# Plot a line graph
with(februaryData, plot(datetime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
# Flush and close png device
dev.off()