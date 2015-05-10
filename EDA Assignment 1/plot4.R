#Reading the file into R
pwr <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

#Storing the necessary data into a separate data frame
pwr2 <- pwr[pwr$Date==c("1/2/2007")|pwr$Date==c("2/2/2007"),]

#Combining Date and Time columns into one column
pwr2$DateTime<-paste(as.character(pwr2$Date), as.character(pwr2$Time))

#Converting the created variable into DateTime format
pwr2$DateTimeFormat <- strptime(pwr2$DateTime, format="%d/%m/%Y %H:%M:%S") 

#Converting the necessary variables into Numeric Format
pwr2$Voltage <- as.numeric(as.character(pwr2$Voltage))
pwr2$Global_reactive_power <- as.numeric(as.character(pwr2$Global_reactive_power))
pwr2$Global_active_power <- as.numeric(as.character(pwr2$Global_active_power))
pwr2$Sub_metering_1 <- as.numeric(as.character(pwr2$Sub_metering_1))
pwr2$Sub_metering_2 <- as.numeric(as.character(pwr2$Sub_metering_2))
pwr2$Sub_metering_3 <- as.numeric(as.character(pwr2$Sub_metering_3))

#Dividing the plot area into 4 regions and setting the margins
par(mfrow=c(2,2), mar=c(4,4,2,2))

#1st Plot
plot(pwr2$DateTimeFormat,pwr2$Global_active_power, type="l", ylab = "Global Active Power (kilowatts)", xlab="")

#2nd Plot
with(pwr2, plot(DateTimeFormat, Voltage, xlab="datetime", ylab="Voltage", type="l"))

#3rd Plot
with(pwr2, plot(DateTimeFormat, Sub_metering_1, type="l", col="black", ylab="", xlab=""))
par(new=T)
with(pwr2, plot(DateTimeFormat, Sub_metering_2, type="l", ylim=c(0,max(Sub_metering_1)), col="red", ylab="", xlab=""))
par(new=T)
with(pwr2, plot(DateTimeFormat, Sub_metering_3, type="l", ylim=c(0,max(Sub_metering_1)), col="blue", ylab="Energy sub metering", xlab=""))

legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red","blue"), lty=c(1,1,1))

#4th Plot
with(pwr2, plot(DateTimeFormat, Global_reactive_power, xlab="datetime", ylab="Global Reactive Power", type="l"))

#Saving the plot
dev.copy(png, file="plot4.png")

#Changing the graphics device back to screen
dev.off()