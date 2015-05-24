#Question 6:Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County
#Motor Vehicles taken here are as defined in http://www.justice.gov/usam/criminal-resource-manual-1303-definitions-motor-vehicle-aircraft-security
#Motor vehicle includes road vehicles, such as automobiles, vans, motorcycles, and trucks, as well as off-road vehicles such as self-propelled construction and farming equipment. 

#Loading necessary packages
library("ggplot2")
library("sqldf")

#Reading data from the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Renaming Column name by replacing . with _ for sql query to work
names(SCC)[names(SCC)=="EI.Sector"] <- "EI_Sector"

#Joining data between the 2 data frames by using column SCC 
NEI_6 <- sqldf("select NEI.fips, NEI.SCC, NEI.Emissions, NEI.type, NEI.year from NEI inner join SCC on NEI.SCC=SCC.SCC where SCC.EI_Sector like '%vehicle%' ")

#Converting variable fips as a factor and creating 2 data frames for Baltimore and Los Angeles cities
NEI_6$fips <- as.factor(NEI_6$fips)
NEI_6_baltimore <- NEI_6[NEI_6$fips==c("24510"),]
NEI_6_la <- NEI_5[NEI_6$fips==c("06037"),]

#Calculating sum of emissions by year for Baltimore city
bsum99 <- 0
bsum02 <- 0
bsum05 <- 0
bsum08 <- 0

for(i in 1:nrow(NEI_6_baltimore) ){
  if(NEI_6_baltimore$year[i] ==c("1999")){
    bsum99 <- bsum99 + NEI_6_baltimore$Emissions[i]
  }
  else if(NEI_6_baltimore$year[i] ==c("2002")){
    bsum02 <- bsum02 + NEI_6_baltimore$Emissions[i]
  }
  else if(NEI_6_baltimore$year[i] ==c("2005")){
    bsum05 <- bsum05 + NEI_6_baltimore$Emissions[i]
  }
  else if(NEI_6_baltimore$year[i] ==c("2008")){
    bsum08 <- bsum08 + NEI_6_baltimore$Emissions[i]
  }
}

#Calculating sum of emissions by year for Los Angeles city
lasum99 <- 0
lasum02 <- 0
lasum05 <- 0
lasum08 <- 0

for(i in 1:nrow(NEI_6_la) ){
  if(NEI_6_la$year[i] ==c("1999")){
    lasum99 <- lasum99 + NEI_6_la$Emissions[i]
  }
  else if(NEI_6_la$year[i] ==c("2002")){
    lasum02 <- lasum02 + NEI_6_la$Emissions[i]
  }
  else if(NEI_6_la$year[i] ==c("2005")){
    lasum05 <- lasum05 + NEI_6_la$Emissions[i]
  }
  else if(NEI_6_la$year[i] ==c("2008")){
    lasum08 <- lasum08 + NEI_6_la$Emissions[i]
  }
}

#Creating a new data frame based on the above calculated values
emissions <- data.frame(x=rep(c("1999","2002","2005","2008"), each=2),y=c(bsum99, lasum99, bsum02, lasum02, bsum05, lasum05, bsum08, lasum08), Location=rep(c("Baltimore", "Los Angeles"), 4))

#Converting variables type to create readable and accurate plots 
emissions$x<-as.Date(emissions$x, "%Y")
emissions$z<-as.factor(emissions$Location)

#Saving the plot as png
png(filename = "plot6.png", width = 480, height = 480)

#Creating the plot
qplot(x, y, data=emissions, color=Location, geom=c("point", "line"), ylab="Total PM2.5 Emission", xlab="Year", main="Motor Vehicle Emissions by City and Year")

#Changing the graphics device back to screen
dev.off()