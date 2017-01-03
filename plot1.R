# Homework for Week 1 of Exploratory Data for Coursera

#The dataset has 2,075,259 rows and 9 columns. 
#calculate memory
GBmemory <- (2 * ((2075259 * 9 * 8)/2^20))/1000
#about 0.50 GB including "overhead" - no problems

#makes a folder called 'data' if none exists
if (!file.exists("data")){
  dir.create("data")
}

#download and upzip
setwd("C:/Users/Reed/Dropbox/Dani life/2016 Coursera/Course 4 - Exploratory Data/data")
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "data.zip")
list.files("./")
unzip(zipfile="./data.zip", exdir="./expanded")

setwd("C:/Users/Reed/Dropbox/Dani life/2016 Coursera/Course 4 - Exploratory Data/data/expanded")
#this code to read the table is from:
#https://rstudio-pubs-static.s3.amazonaws.com/39904_05628d89d4a345b8a41f37d3bcabf958.html
#However, I added the na.strings command so that ? read as NA (I hope)
fh <- file("household_power_consumption.txt")
#Limits the import of data to the two months we need
ba <- read.table(text = grep("^[1,2]/2/2007", readLines(fh), value = TRUE), col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep = ";", na.strings = "?", header = TRUE)
#chucks out incomplete cases
ba <- ba[complete.cases(ba),]
#convert to proper date, concatenate and turns into POSIXct for graphing
ba$Date <- as.Date(ba$Date, "%d/%m/%Y")
ba$dateTime <- paste(ba$Date, ba$Time)
ba$dateTime <- as.POSIXct(ba$dateTime)

#Plot 1 
hist(ba$Global_active_power, col = "red", main = paste("Global Active Power"), xlab = "Global Active Power, kilowatts", ylab = "Frequency")
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()

