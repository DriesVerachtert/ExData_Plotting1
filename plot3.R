# Change the next line: current working directory should be the git directory
setwd("~/git/ExData_Plotting1")
# Change the next line: path to the power consumption data
inputFile <- '~/git/exData_Plotting1/household_power_consumption.txt'

#source("base-plotting-assignment.R")
# Instead of the include file, the full code without any reuse as requested:

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

loadData()
saveplot3()
