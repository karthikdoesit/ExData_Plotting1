#Reading the file into R
pwr <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

#Storing the necessary data into a separate data frame
pwr2 <- pwr[pwr$Date==c("1/2/2007")|pwr$Date==c("2/2/2007"),]

#Combining Date and Time columns into one column
pwr2$DateTime<-paste(as.character(pwr2$Date), as.character(pwr2$Time))

#Converting the created variable into DateTime format
pwr2$DateTimeFormat <- strptime(pwr2$DateTime, format="%d/%m/%Y %H:%M:%S") 

#Converting the necessary variables into Numeric Format
pwr2$Sub_metering_1 <- as.numeric(as.character(pwr2$Sub_metering_1))
pwr2$Sub_metering_2 <- as.numeric(as.character(pwr2$Sub_metering_2))
pwr2$Sub_metering_3 <- as.numeric(as.character(pwr2$Sub_metering_3))

#Plot with sub_metering_1 in y axis
with(pwr2, plot(DateTimeFormat, Sub_metering_1, type="l", col="black", ylab="", xlab=""))

#including sub_metering_2 in y axis in the previous plot as red color
par(new=T)
with(pwr2, plot(DateTimeFormat, Sub_metering_2, type="l", ylim=c(0,max(Sub_metering_1)), col="red", ylab="", xlab=""))

#including sub_metering_3 in y axis in the previous plot as blue color
par(new=T)
with(pwr2, plot(DateTimeFormat, Sub_metering_3, type="l", ylim=c(0,max(Sub_metering_1)), col="blue", ylab="Energy sub metering", xlab=""))

#Providing legend for the plot
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red","blue"), lty=c(1,1,1))

#Saving the plot
dev.copy(png, file="plot3.png")

#Changing the graphics device back to screen
dev.off()