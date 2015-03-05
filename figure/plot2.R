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

##########################Figure 2##############################################
png(file="plot2.png",width=480, height=480, units="px")
plot(data$Date2,data$Global_active_power,type="l",xlab="",
     ylab="Global Active Power (kilowatts)")
dev.off()
################################################################################