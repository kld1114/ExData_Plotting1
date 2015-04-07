#Plot 1

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

#Set the png file save parameters for the graphics device
png(filename = "plot1.png",width = 480, height = 480, units = "px", 
    pointsize = 12)

#Create a histogram for Global Active Power with x-axis label and main title and
#set histogram colour to orangered. 
hist(subElectric$Global_active_power, xlab="Global Active Power (kilowatts)", 
     main = "Global Active Power", col="orangered1")

#Close the graphics device
dev.off()

#The plot1.png file is now in your working directory