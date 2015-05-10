# Loading the data --------------------------------------------------------
#reading the data as a data.frame
#create a temp file
temp <- tempfile()
#download the file in the temp file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
              ,destfile = temp)
#unzip the file and read it as a table
data <- read.table(unz(temp, filename="household_power_consumption.txt"),
                   sep    = ";",
                   header = TRUE,
                   colClasses = c(rep("character",2),
                                  rep("numeric",7)),
                   na.strings = "?",
                   stringsAsFactors = FALSE)
#delete the temp file
unlink(temp); rm(temp)


# Filtering the data ------------------------------------------------------
#filter the date for only the required days
data <- subset(data, Date %in% c("1/2/2007","2/2/2007"))

#format the columns Date and Time as POSIXlt
data$Date <- strptime(paste(data$Date, data$Time, sep = "-"),"%d/%m/%Y-%T")
data$Time <- NULL

# Plot4 -------------------------------------------------------------------
png("plot4.png", width = 480, height = 480)
windows()
par(mfcol=c(2,2))
with(data,{
  #plot1
  plot(data$Date,data$Global_active_power,
       ylab  = "Global Active Power (Kilowatts)",
       xlab  = "",
       type  = "l")
  #plot2
  plot(Date,
       Sub_metering_1,
       ylab  = "Energy sub metering",
       xlab  = "",
       type  = "l")
  lines(Date,
        Sub_metering_2,
        col = "red")
  lines(Date,
        Sub_metering_3,
        col = "blue")
  legend("topright",
         c("Sub metering 1", "Sub metering 2", "Sub metering 3"),
         lty = c(1,1,1),
         col = c("black","red","blue"))
  #plot3
  plot(Date,
       Voltage,
       ylab  = "Voltage",
       type  = "l")
  #plot4
  plot(Date,
       Global_reactive_power,
       ylab  = "Global Reactive Power (Kilowatts)",
       type  = "l")
})
dev.off()
