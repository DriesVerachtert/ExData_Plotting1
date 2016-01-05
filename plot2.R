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

plot2 <- function() {
  plot(subsetTable$DateTime, subsetTable$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
}

saveplot2 <- function() {
  png(filename="plot2.png", height=480, width=480)
  plot2()
  dev.off()
}

loadData()
saveplot2()
