#Question 5:How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
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
NEI_5 <- sqldf("select NEI.fips, NEI.SCC, NEI.Emissions, NEI.type, NEI.year from NEI inner join SCC on NEI.SCC=SCC.SCC where SCC.EI_Sector like '%vehicle%' ")

#Converting variable fips as a factor and creating a data frame for Baltimore city based on fips value
NEI_5$fips <- as.factor(NEI_5$fips)
NEI_5_baltimore <- NEI_5[NEI_5$fips==c("24510"),]

#Calculating sum of emissions by year for Baltimore city
sum99 <- 0
sum02 <- 0
sum05 <- 0
sum08 <- 0
for(i in 1:nrow(NEI_5_baltimore) ){
  if(NEI_5_baltimore$year[i] ==c("1999")){
    sum99 <- sum99 + NEI_5_baltimore$Emissions[i]
  }
  else if(NEI_5_baltimore$year[i] ==c("2002")){
    sum02 <- sum02 + NEI_5_baltimore$Emissions[i]
  }
  else if(NEI_5_baltimore$year[i] ==c("2005")){
    sum05 <- sum05 + NEI_5_baltimore$Emissions[i]
  }
  else if(NEI_5_baltimore$year[i] ==c("2008")){
    sum08 <- sum08 + NEI_5_baltimore$Emissions[i]
  }
}

#Creating a new data frame based on the above calculated values
emissions <- data.frame(x=c("1999","2002","2005","2008"),y=c(sum99,sum02,sum05,sum08))

#Converting variables type to create readable and accurate plots 
emissions$x<-as.Date(emissions$x, "%Y")

#Saving the plot as png
png(filename = "plot5.png", width = 480, height = 480)

#Creating the plot
g <- ggplot(emissions, aes(x,y))
g + geom_line(color="red") + geom_point(color="blue") + labs(x="Year") + labs(y="Total PM2.5 Emission") + labs(title="Baltimore Motor Vehicle Emissions by Year")

#Changing the graphics device back to screen
dev.off()






