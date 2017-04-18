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
png("plot2.png", width=480, height=480)

#Plotting
plot(x = df.sub[, fulldate]
     , y = df.sub[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

#Close device
dev.off()