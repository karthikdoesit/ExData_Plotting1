#Reading the file into R
pwr <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

#Storing the necessary data into a separate data frame
pwr2 <- pwr[pwr$Date==c("1/2/2007")|pwr$Date==c("2/2/2007"),]

#Converting the necessary variable into Numeric Format
pwr2$Global_active_power <- as.numeric(as.character(pwr2$Global_active_power))

#Combining Date and Time columns into one column
pwr2$DateTime<-paste(as.character(pwr2$Date), as.character(pwr2$Time))

#Converting the created variable into DateTime format
pwr2$DateTimeFormat <- strptime(pwr2$DateTime, format="%d/%m/%Y %H:%M:%S") 

#Creating a plot with necessary attributes
plot(pwr2$DateTimeFormat,pwr2$Global_active_power, type="l", ylab = "Global Active Power (kilowatts)", xlab="")

#Saving the plot
dev.copy(png, file="plot2.png")

#Changing the graphics device back to screen
dev.off()