Sys.setlocale("LC_TIME", "en_US.UTF-8") 
library(dplyr)
###############Download data####################################################
if (!file.exists("data")){dir.create("data")}
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,"./data/data.zip",method="curl")
unzip("./data/data.zip",exdir="./data")
###############Read data#########################################
data<-read.table("./data/household_power_consumption.txt",nrows=100000,sep=";"
                 ,header=TRUE,na.strings="?")
data$Date<-as.Date(data$Date,format="%d/%m/%Y")
data<-mutate(data,Date2=paste(data$Date,data$Time,sep=" "))

data$Date2<-as.POSIXct(data$Date2)

data<-filter(data,Date>="2007-02-01"&Date<="2007-02-02")
################################################################################

#####################################Figure 4###################################
png(file="plot4.png",width=480, height=480, units="px")
par(mfrow=c(2,2))

plot(data$Date2,data$Global_active_power,type="l",xlab="",
     ylab="Global Active Power")

plot(data$Date2,data$Voltage,type="l",xlab="",ylab="Voltage")

plot(data$Date2,data$Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
lines(data$Date2,data$Sub_metering_2,col="red")
lines(data$Date2,data$Sub_metering_3,col="blue")
legend("topright",lty=1,col=c("black","red","blue"),legend=colnames(data[,7:9]))

plot(data$Date2,data$Global_reactive_power,type="l",xlab="datetime",
     ylab="Global_reactive_power")
dev.off()
################################################################################