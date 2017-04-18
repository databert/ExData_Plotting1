library("data.table")

#load data
df <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Conversion from factor to numeric
df[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Merging Date and Time feature
df[, fulldate := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Subsetting dataframe for 2007-02-01 and 2007-02-02
df.sub <- df[(fulldate >= "2007-02-01") & (fulldate < "2007-02-03")]

# Open plotting device
png("plot3.png", width=480, height=480)

# Plot 3
plot(df.sub[, fulldate], df.sub[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(df.sub[, fulldate], df.sub[, Sub_metering_2],col="red")
lines(df.sub[, fulldate], df.sub[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

#Close device
dev.off()