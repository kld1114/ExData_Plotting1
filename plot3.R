#Plot 3

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
png(filename = "plot3.png",width = 480, height = 480, units = "px", 
    pointsize = 12)

#Create an empty plot with required x and y axis labels
plot(subElectric$date_time, subElectric$Sub_metering_1, type="n", 
     ylab="Energy sub metering", xlab="")

#Add the data to the plot as a line graph with diferent colours for each variable
lines(subElectric$date_time, subElectric$Sub_metering_1, col="black", lwd=1)
lines(subElectric$date_time, subElectric$Sub_metering_2, col="red", lwd=1)
lines(subElectric$date_time, subElectric$Sub_metering_3, col="blue", lwd=1)

#Add a legend to the top right corner of the plot
legend("topright", legend=colnames(subElectric)[6:8], col=c("black", "red", "blue"), lwd=2)

#Close the graphics device
dev.off()

#The plot3.png file is now in your working directory