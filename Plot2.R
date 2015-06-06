DrawPlot2 <- function(path){
    
    if (!file.exists("household_power_consumption.txt")){
        library(sqldf)
        setwd(path)
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip", method='curl');
        unzip("household_power_consumption.zip");
    }
    
    DataSet1  <- read.csv.sql("household_power_consumption.txt", sql = 'select * from file where Date = "2/2/2007" or Date = "1/2/2007"', sep = ';')
    
    png(filename="plot2.png", width = 480, height = 480)
    
    DataSet1$days <- strptime(paste(DataSet1$Date,DataSet1$Time, sep = " "), "%d/%m/%Y %H:%M:%S") 
    
    with(DataSet1, 
         plot(days,Global_active_power, 
              xlab="", 
              ylab="Global Active Power (kilowatts)", 
              type="l"))
    dev.off()
}