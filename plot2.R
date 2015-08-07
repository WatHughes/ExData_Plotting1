# JHU Coursera Exploratory Data Analysis
# Course Project 1

# Note the unzipped data file has been cached in the project directory.

library(data.table) # Faster than base data.frame.

colClasses=c('chr') # Used to read all values as charater data so that missing data can be handled correctly
hpc = fread('household_power_consumption.txt',na.strings=c('?'),colClasses=colClasses)

# We will only be using data from the dates 2007-02-01 and 2007-02-02.
ProjData = subset(hpc, Date %in% c('1/2/2007', '2/2/2007'))
str(ProjData)
# Classes ‘data.table’ and 'data.frame':	2880 obs. of  9 variables:

ProjData[,Global_active_power:=as.numeric(Global_active_power)] # Need to plot numbers, not strings
ProjData[,dt:=paste(Date, Time)]
ProjData=(as.data.frame(ProjData)) # Strip data.table because of issues with strptime()
ProjData$dt=strptime(ProjData$dt,format='%d/%m/%Y %H:%M:%S')

png(filename = "plot2.png",width=480,height=480,units='px')
with(ProjData,plot(dt,Global_active_power,type='l',ylab='Global Active Power (kilowatts)'))
dev.off()
