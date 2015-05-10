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


# Plot1 -------------------------------------------------------------------
png("plot1.png", width = 480, height = 480)
hist(data$Global_active_power,
     col  = "red",
     xlab = "Global Active Power (Kilowatts)",
     main = "Global Active Power")
dev.off()
