
# expects a variable inputFile with the path to the power consumption data
loadData <- function() {
  myColClasses <- c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric")
  fullTable <- read.csv(inputFile, colClasses = myColClasses, na.strings = "?", sep = ";", 
                      header = TRUE, dec = ".", stringsAsFactors = FALSE)

  # clean up data: correct date and combine date & time to timestamp
  fullTable$Date = as.Date(fullTable$Date, "%d/%m/%Y")
  fullTable$DateTime = strptime(paste(fullTable$Date, fullTable$Time), "%Y-%m-%d %H:%M:%S")

  # take the subset of two days that we need for the graphs
  subsetTable = subset(fullTable, Date>="2007-2-1" & Date <= "2007-2-2")
  assign("subsetTable", subsetTable, envir = .GlobalEnv)

  # avoid translated abbreviations of the days
  Sys.setlocale("LC_ALL", "en_GB.UTF-8")
}

# all the following methods expect that loadData was executed

plot1 <- function() {
  hist(subsetTable$Global_active_power, col = "red", xlab="Global Active Power (kilowatts)",
       main="Global Active Power")
}
saveplot1 <- function() {
  png(filename="plot1.png", height=480, width=480)
  plot1()
  dev.off()
}

plot2 <- function() {
  plot(subsetTable$DateTime, subsetTable$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
}

saveplot2 <- function() {
  png(filename="plot2.png", height=480, width=480)
  plot2()
  dev.off()
}

plot3 <- function() {
  plot(subsetTable$DateTime, subsetTable$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(subsetTable$DateTime, subsetTable$Sub_metering_2, type="l", col="red")
  lines(subsetTable$DateTime, subsetTable$Sub_metering_3, type="l", col="blue")
  myLegendColors <- c("black","red","blue")
  myLegendText <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  legend("topright", myLegendText, col=myLegendColors, lty=c(1,1,1))
}

saveplot3 <- function() {
  png(filename="plot3.png", height=480, width=480)
  plot3()
  dev.off()
}

plot4 <- function() {
  par(mfcol=c(2,2))
  plot2()
  plot3()
  plot(subsetTable$DateTime, subsetTable$Voltage, type="l", xlab="datetime", ylab="Voltage")
  plot(subsetTable$DateTime, subsetTable$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
}

saveplot4 <- function() {
  png(filename="plot4.png", height=480, width=480)
  plot4()
  dev.off()
}
