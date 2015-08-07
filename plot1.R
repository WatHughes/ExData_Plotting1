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

# Produce the required PNG file.
png(filename = "plot1.png",width=480,height=480,units='px')
par(mfcol=c(1,1))
hist(ProjData$Global_active_power,col='red',main='Global Active Power', xlab='Global Active Power (kilowatts)')
dev.off()
