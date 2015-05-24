#Question 1:Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?

#Reading data from the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subsetting the data with only the required variables
NEI_1 <- NEI[,c("Emissions", "year")]

#Calculating sum of emissions by year
sum99 <- 0
sum02 <- 0
sum05 <- 0
sum08 <- 0
for(i in 1:nrow(NEI_1) ){
  if(NEI_1$year[i] ==c("1999")){
    sum99 <- sum99 + NEI_1$Emissions[i]
  }
  else if(NEI_1$year[i] ==c("2002")){
    sum02 <- sum02 + NEI_1$Emissions[i]
  }
  else if(NEI_1$year[i] ==c("2005")){
    sum05 <- sum05 + NEI_1$Emissions[i]
  }
  else if(NEI_1$year[i] ==c("2008")){
    sum08 <- sum08 + NEI_1$Emissions[i]
  }
}

#Creating a new data frame based on the above calculated values
emissions <- data.frame(x=c("1999","2002","2005","2008"),y=c(sum99,sum02,sum05,sum08))

#Converting variables type to create readable and accurate plots 
emissions$x<-as.Date(emissions$x, "%Y")

#Saving the plot as png
png(filename = "plot1.png", width = 480, height = 480)

#Creating the plot
plot(emissions$x,emissions$y, type="b", pch=20, col="red", xlab="Year", ylab="Total PM2.5 Emission", main="Emissions by Year")

#Changing the graphics device back to screen
dev.off()
