#Reading the file into R
pwr <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

#Storing the necessary data into a separate data frame
pwr2 <- pwr[pwr$Date==c("1/2/2007")|pwr$Date==c("2/2/2007"),]

#Converting Date vector to Date Format
pwr2$Date <- as.Date(pwr2$Date, "%d/%m/%Y")

#Converting the necessary variable into Numeric Format
pwr2$Global_active_power <- as.numeric(as.character(pwr2$Global_active_power))

#Plotting the histogram with necessary attributes
hist(pwr2$Global_active_power, main="Global Active  Power", xlab="Global Active Power (kilowatts)", col="red")

#Saving the plot generated in to a .png format
dev.copy(png, file="plot1.png")

#Changing the graphics device back to screen
dev.off()