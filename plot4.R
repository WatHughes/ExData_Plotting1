# JHU Coursera Exploratory Data Analysis
# Course Project 1

# Note the unzipped data file has been cached in the project directory.

library(data.table) # Faster than base data.frame.

# Load the data.
colClasses=c('chr') # Used to read all values as charater data so that missing data can be handled correctly
hpc = fread('household_power_consumption.txt',na.strings=c('?'),colClasses=colClasses)

# We will only be using data from the dates 2007-02-01 and 2007-02-02.
ProjData = subset(hpc, Date %in% c('1/2/2007', '2/2/2007'))
str(ProjData)
# Classes ‘data.table’ and 'data.frame':	2880 obs. of  9 variables:

# Clean the data needed for this plot.
ProjData[,Global_active_power:=as.numeric(Global_active_power)] # hist() buckets numbers, not strings
ProjData[,`:=`(Sub_metering_1=as.numeric(Sub_metering_1),
               Sub_metering_2=as.numeric(Sub_metering_2),
               Sub_metering_3=as.numeric(Sub_metering_3))] # Need to plot numbers, not strings
ProjData[,Voltage:=as.numeric(Voltage)] # hist() buckets numbers, not strings
ProjData[,Global_reactive_power:=as.numeric(Global_reactive_power)] # hist() buckets numbers, not strings
ProjData[,dt:=paste(Date, Time)]
ProjData=(as.data.frame(ProjData)) # Strip data.table because POSIXlt is not supported as a column type
ProjData$dt=strptime(ProjData$dt,format='%d/%m/%Y %H:%M:%S')

# Produce the required PNG file.
png(filename = "plot4.png",width=480,height=480,units='px')
par(mfcol=c(2,2))
# Upper left plot
with(ProjData,plot(dt,Global_active_power,type='l',ylab='Global Active Power',xlab=''))
# Lower left plot
with(ProjData,plot(dt,Sub_metering_1,type='l',ylab='Energy sub metering',xlab=''))
with(ProjData,lines(dt,Sub_metering_2,col='red'))
with(ProjData,lines(dt,Sub_metering_3,col='blue'))
legend('topright',legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
       col=c('black','red','blue'),
       lwd=1)
# Upper right plot
with(ProjData,plot(dt,Voltage,type='l',ylab='Voltage',xlab='datetime'))
# Lower right plot
with(ProjData,plot(dt,Global_reactive_power,type='l',ylab='Global_reactive_power',xlab='datetime'))
dev.off()
