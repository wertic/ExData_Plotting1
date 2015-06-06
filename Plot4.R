DrawPlot4 <- function(path){
    
    if (!file.exists("household_power_consumption.txt")){
        library(sqldf)
        setwd(path)
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip", method='curl');
        unzip("household_power_consumption.zip");
    }
    
    DataSet1  <- read.csv.sql("household_power_consumption.txt", sql = 'select * from file where Date = "2/2/2007" or Date = "1/2/2007"', sep = ';')
    
    png(filename="plot4.png", width = 480, height = 480)
    
    DataSet1$days <- strptime(paste(DataSet1$Date,DataSet1$Time, sep = " "), "%d/%m/%Y %H:%M:%S") 
    
    
    par(mfrow=c(2,2))
    attach(DataSet1) 
    
    plot(days,Global_active_power, 
         xlab="",
         ylab="Global Active Power (kilowatts)", 
         type="l")
    
    plot(days,Voltage, 
         xlab="datetime",
         ylab="Voltage", 
         type="l")
    
    plot(days, Sub_metering_1, type="l", ylab="Energy sub metering")
    
    lines(days,Sub_metering_2,col="red")
    
    lines(days,Sub_metering_3,col="blue")
    
    legend("topright", 
           col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           lwd=2, 
           lty=c(1,1,1), 
           bty = "n")
    
    plot(days,Global_reactive_power, 
         xlab="datetime",
         ylab="Global_reactive_power", 
         type="l")
    dev.off()
}