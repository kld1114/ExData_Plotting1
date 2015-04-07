#Plot 4

#Load package tidyr - required for unite() function
library(tidyr)

#Create a new directory for the project using the following code:
if(!file.exists("ExploratoryDataAnalysisProject")){dir.create("ExploratoryDataAnalysisProject")}

#Set the new directory as the working directory using the following code:
setwd("ExploratoryDataAnalysisProject")

#Use the following code to download the data set.  The argument, method="curl", may have to be 
#passed to download.file(), depending on the operating system:

fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, dest="electric.zip") 
downloadDate<-Sys.time()

#Unzip the file to the current directory
unzip("electric.zip")

#Read the data from the unzipped file into R
electric<-read.table("household_power_consumption.txt", header=TRUE, sep=";", 
                     na.strings="?", stringsAsFactors=FALSE)

#Subset the data for the desired dates of 1/2/2007 and 2/2/2007
#head(which(electric$Date=="1/2/2007")) #find first entry for 1/2/2007
#tail(which(electric$Date=="2/2/2007")) #find last entry for 2/2/2007
subElectric<-electric[66637:69516,]

#Merge date and time columns and convert from class "Character" to class "POSIXlt"
subElectric<-unite(subElectric, date_time, Date, Time, sep=" ")
subElectric$date_time<-strptime(subElectric$date_time, format="%d/%m/%Y %H:%M:%S")

#Set the png file save parameters for the graphics device
png(filename = "plot4.png", width = 480, height = 480, units = "px", 
    pointsize = 12)

#Change the global parameters so all four plots are added to a single graphics 
#device in a 2-by-2 arrangement 
par(mfrow= c(2,2))

#Plot 4A (top left)
#Create an empty plot with required axis labels
plot(subElectric$date_time, subElectric$Global_active_power, type="n", 
     ylab="Global Active Power", xlab="")

#Add the data to the plot as a line graph
lines(subElectric$date_time, subElectric$Global_active_power)

#plot 4B (top right)

#Create an empty plot with required axis labels
plot(subElectric$date_time, subElectric$Voltage, type="n", 
     ylab="Voltage", xlab="datetime")

#Add the data to the plot as a line graph
lines(subElectric$date_time, subElectric$Voltage)

#Plot 4C (bottom left)

#Create an empty plot with required x and y axis labels
plot(subElectric$date_time, subElectric$Sub_metering_1, type="n", 
     ylab="Energy sub metering", xlab="")

#Add the data to the plot as a line graph with diferent colours for each variable
lines(subElectric$date_time, subElectric$Sub_metering_1, col="black", lwd=1)
lines(subElectric$date_time, subElectric$Sub_metering_2, col="red", lwd=1)
lines(subElectric$date_time, subElectric$Sub_metering_3, col="blue", lwd=1)

#Add a legend with no border to the top right corner of the plot
legend("topright", legend=colnames(subElectric)[6:8], col=c("black", "red", "blue"), 
       bty="n", lwd=2)

#Plot 4D
#Create an empty plot with required axis labels
plot(subElectric$date_time, subElectric$Global_reactive_power, type="n", 
     ylab="Global_reactive_power", xlab="datetime")

#Add the global reactive power data to the plot as a line graph
lines(subElectric$date_time, subElectric$Global_reactive_power)

#Close the graphics device
dev.off()

#The plot4.png file is now in your working directory