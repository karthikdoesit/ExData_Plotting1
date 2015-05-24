#Question 3:Of the four types of sources indicated by the type variable, which of these sources have seen decreases/increases in emissions from 1999–2008 for Baltimore City? 

#Loading necessary packages
library("ggplot2")

#Reading data from the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subsetting the data with only the required variables
NEI_3 <- NEI[,c("fips","Emissions", "type", "year")]

#Converting variable fips as a factor and creating a data frame for Baltimore city
NEI_3$fips <- as.factor(NEI_3$fips)
NEI_3_baltimore <- NEI_3[NEI_3$fips==c("24510"),]
NEI_3_baltimore$type <- as.factor(NEI_3_baltimore$type)

#Calculating sum of emissions by year and type for Baltimore city
bsum99p <- 0
bsum02p <- 0
bsum05p <- 0
bsum08p <- 0

bsum99np <- 0
bsum02np <- 0
bsum05np <- 0
bsum08np <- 0

bsum99or <- 0
bsum02or <- 0
bsum05or <- 0
bsum08or <- 0

bsum99nr <- 0
bsum02nr <- 0
bsum05nr <- 0
bsum08nr <- 0

for(i in 1:nrow(NEI_3_baltimore) ){
  if(NEI_3_baltimore$year[i] ==c("1999")){
    if(NEI_3_baltimore$type[i] ==c("POINT")){
      bsum99p <- bsum99p + NEI_3_baltimore$Emissions[i]}
    else if(NEI_3_baltimore$type[i] ==c("NONPOINT")){
      bsum99np <- bsum99np + NEI_3_baltimore$Emissions[i]}
    else if(NEI_3_baltimore$type[i] ==c("ON-ROAD")){
      bsum99or <- bsum99or + NEI_3_baltimore$Emissions[i]}
    else if(NEI_3_baltimore$type[i] ==c("NON-ROAD")){
      bsum99nr <- bsum99nr + NEI_3_baltimore$Emissions[i]}
  }
  else if(NEI_3_baltimore$year[i] ==c("2002")){
    if(NEI_3_baltimore$type[i] ==c("POINT")){
      bsum02p <- bsum02p + NEI_3_baltimore$Emissions[i]}
    else if(NEI_3_baltimore$type[i] ==c("NONPOINT")){
      bsum02np <- bsum02np + NEI_3_baltimore$Emissions[i]}
    else if(NEI_3_baltimore$type[i] ==c("ON-ROAD")){
      bsum02or <- bsum02or + NEI_3_baltimore$Emissions[i]}
    else if(NEI_3_baltimore$type[i] ==c("NON-ROAD")){
      bsum02nr <- bsum02nr + NEI_3_baltimore$Emissions[i]}
  }
  else if(NEI_3_baltimore$year[i] ==c("2005")){
    if(NEI_3_baltimore$type[i] ==c("POINT")){
      bsum05p <- bsum05p + NEI_3_baltimore$Emissions[i]}
    else if(NEI_3_baltimore$type[i] ==c("NONPOINT")){
      bsum05np <- bsum05np + NEI_3_baltimore$Emissions[i]}
    else if(NEI_3_baltimore$type[i] ==c("ON-ROAD")){
      bsum05or <- bsum05or + NEI_3_baltimore$Emissions[i]}
    else if(NEI_3_baltimore$type[i] ==c("NON-ROAD")){
      bsum05nr <- bsum05nr + NEI_3_baltimore$Emissions[i]}
  }
  else if(NEI_3_baltimore$year[i] ==c("2008")){
    if(NEI_3_baltimore$type[i] ==c("POINT")){
      bsum08p <- bsum08p + NEI_3_baltimore$Emissions[i]}
    else if(NEI_3_baltimore$type[i] ==c("NONPOINT")){
      bsum08np <- bsum08np + NEI_3_baltimore$Emissions[i]}
    else if(NEI_3_baltimore$type[i] ==c("ON-ROAD")){
      bsum08or <- bsum08or + NEI_3_baltimore$Emissions[i]}
    else if(NEI_3_baltimore$type[i] ==c("NON-ROAD")){  
      bsum08nr <- bsum08nr + NEI_3_baltimore$Emissions[i]}
  }
}

#Creating a new data frame based on the above calculated values
emissions <- data.frame(x=rep(c("1999","2002","2005","2008"), each=4),y=c(bsum99p, bsum99np, bsum99or, bsum99nr, bsum02p, bsum02np, bsum02or, bsum02nr, bsum05p, bsum05np, bsum05or, bsum05nr, bsum08p, bsum08np, bsum08or, bsum08nr), z=rep(c("POINT", "NONPOINT", "ON-ROAD", "NON-ROAD"), 4))

#Converting variables type to create readable and accurate plots 
emissions$x<-as.Date(emissions$x, "%Y")
emissions$z<-as.factor(emissions$z)

#Saving the plot as png
png(filename = "plot3.png", width = 480, height = 480)

#Creating the plot
qplot(emissions$x, emissions$y, data=emissions, color=emissions$z, geom=c("point", "line"), ylab="Total PM2.5 Emission", xlab="Year", main="Baltimore Emissions by Type and Year")

#Changing the graphics device back to screen
dev.off()
