#Question 4:Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

#Loading necessary packages
library("ggplot2")
library("sqldf")

#Reading data from the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Renaming Column name by replacing . with _ for sql query to work
names(SCC)[names(SCC)=="EI.Sector"] <- "EI_Sector"

#Joining data between the 2 data frames by using column SCC 
NEI_4 <- sqldf("select NEI.SCC, NEI.Emissions, NEI.type, NEI.year from NEI inner join SCC on NEI.SCC=SCC.SCC where SCC.EI_Sector like '%coal%' ")

#Calculating sum of emissions by year
sum99 <- 0
sum02 <- 0
sum05 <- 0
sum08 <- 0
for(i in 1:nrow(NEI_4) ){
  if(NEI_4$year[i] ==c("1999")){
    sum99 <- sum99 + NEI_4$Emissions[i]
  }
  else if(NEI_4$year[i] ==c("2002")){
    sum02 <- sum02 + NEI_4$Emissions[i]
  }
  else if(NEI_4$year[i] ==c("2005")){
    sum05 <- sum05 + NEI_4$Emissions[i]
  }
  else if(NEI_4$year[i] ==c("2008")){
    sum08 <- sum08 + NEI_4$Emissions[i]
  }
}

#Creating a new data frame based on the above calculated values
emissions <- data.frame(x=c("1999","2002","2005","2008"),y=c(sum99,sum02,sum05,sum08))

#Converting variables type to create readable and accurate plots 
emissions$x<-as.Date(emissions$x, "%Y")

#Saving the plot as png
png(filename = "plot4.png", width = 480, height = 480)

#Creating the plot
g <- ggplot(emissions, aes(x,y))
g + geom_line(color="red") + geom_point(color="blue") + labs(x="Year") + labs(y="Total PM2.5 Emission") + labs(title="Coal Combustion Emissions by Year")

#Changing the graphics device back to screen
dev.off()