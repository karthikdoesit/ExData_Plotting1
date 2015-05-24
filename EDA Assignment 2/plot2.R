#Question 2:Have total emissions from PM2.5 decreased in the Baltimore City from 1999 to 2008?

#Reading data from the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subsetting the data with only the required variables
NEI_2 <- NEI[,c("fips","Emissions", "year")]

#Converting variable fips as a factor and creating a data frame for Baltimore city
NEI_2$fips <- as.factor(NEI_2$fips)
NEI_2_baltimore <- NEI_2[NEI_2$fips==c("24510"),]

#Calculating sum of emissions by year for Baltimore city
bsum99 <- 0
bsum02 <- 0
bsum05 <- 0
bsum08 <- 0
for(i in 1:nrow(NEI_2_baltimore) ){
  if(NEI_2_baltimore$year[i] ==c("1999")){
    bsum99 <- bsum99 + NEI_2_baltimore$Emissions[i]
  }
  else if(NEI_2_baltimore$year[i] ==c("2002")){
    bsum02 <- bsum02 + NEI_2_baltimore$Emissions[i]
  }
  else if(NEI_2_baltimore$year[i] ==c("2005")){
    bsum05 <- bsum05 + NEI_2_baltimore$Emissions[i]
  }
  else if(NEI_2_baltimore$year[i] ==c("2008")){
    bsum08 <- bsum08 + NEI_2_baltimore$Emissions[i]
  }
}

#Creating a new data frame based on the above calculated values
emissions <- data.frame(x=c("1999","2002","2005","2008"),y=c(bsum99,bsum02,bsum05,bsum08))

#Converting variables type to create readable and accurate plots 
emissions$x<-as.Date(emissions$x, "%Y")

#Saving the plot as png
png(filename = "plot2.png", width = 480, height = 480)

#Creating the plot
plot(emissions$x,emissions$y, type="b", pch=20, col="red", xlab="Year", ylab="Total PM2.5 Emission", main="Baltimore Emissions by Year")

#Changing the graphics device back to screen
dev.off()
