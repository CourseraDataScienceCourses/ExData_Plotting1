###############################################################################
## Exploratory Data Analysis on Coursera - Course Project 1
###############################################################################


###############################################################################
## This script performs the following steps, in order:
##
## 1. Loads the data.  If needed, downloads and unzips the data set.
## 2. Transforms and subset the data.
## 3. Creates a plot matching the original one.
###############################################################################


# Set default locale for date & time

Sys.setlocale("LC_TIME", "C")

# The data set URL

dataset.url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"


# Step 1 - Load the data set
###############################################################################

# Download and unzip the data set (if not already done)

dataset.zipped <- "exdata-data-household_power_consumption.zip"
dataset.raw <- "household_power_consumption.txt"

if (!file.exists(dataset.raw)) {
  if (!file.exists(dataset.zipped)) {
    download.file(dataset.url, dataset.zipped, method = "curl", quiet = TRUE)
  }  
  unzip(dataset.zipped)
}

# Load the data set into a table

df <- read.table(dataset.raw, header = TRUE,
                 sep = ";",
                 na.strings = "?",
                 colClasses = c(rep("character", 2), rep("numeric", 7)))


# Step 2 - Transform and subset the data
###############################################################################

# Convert Date and Time variables to Date/Time classes

df$Time <- strptime(paste(df$Date, df$Time, sep = " "),
                    "%d/%m/%Y %H:%M:%S")
df$Date <- as.Date(df$Date , "%d/%m/%Y")

# Only records between 2007-02-01 and 2007-02-02 are of interest

df <- subset(df,
             df$Date >= as.Date("2007-02-01") &
               df$Date <= as.Date("2007-02-02"))


# Step 3 - Create the plot
###############################################################################

# Open PNG device

png(filename = "plot3.png", width = 480, height = 480)

# Plot the sub_metering_1 line

plot(df$Time, df$Sub_metering_1, type = "l",
     xlab = "", ylab = "Energy sub metering")

# Plot the sub_metering_2 line

lines(df$Time, df$Sub_metering_2, col = "red")

# Plot the sub_metering_3 line

lines(df$Time, df$Sub_metering_3, col = "blue")

# Add a legend

legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = "solid")

# Close PNG device

dev.off()
