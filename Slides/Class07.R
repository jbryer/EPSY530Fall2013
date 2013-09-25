

require(ggplot2)
require(gdata)
options(digits=4, width=95)
opts_chunk$set(fig.path='Figures/Class06-')
opts_chunk$set(comment=NA)
source('../R/contingency.table.R')

load('../Data/titanic.Rda')
movies <- read.csv('../Data/Textbook/Chapter_3/movie_lengths_2010.csv', stringsAsFactors=FALSE)
ozone <- read.csv('../Data/Textbook/Chapter_4/Ozone.csv', stringsAsFactors=FALSE)
ozone$Ozone <- as.numeric(ozone$Ozone)
ozone <- ozone[!is.na(ozone$Ozone),]

load('../Data/WorldData.Rda')
worldData3 <- worldData3[!is.nan(worldData3$GDP),]

# See http://data.giss.nasa.gov/gistemp/tabledata_v3/GLB.Ts+dSST.txt
temp <- read.table('../Data/GlobalTemp.txt', header=TRUE, strip.white=TRUE)
temp$means <- rowMeans(aggregate(temp[,c("DJF","MAM","JJA","SON")], by=list(temp$Year), FUN="mean")[,2:5])
temp$meansF <- temp$means / 100 * 1.8

fuel <- read.csv('../Data/Textbook/Chapter_6/Fuel_economy_2010.csv')
housing <- read.csv('../Data/Textbook/Chapter_6/Income_and_Housing.csv')

load('../Data/ipedsSAT.Rda')
ipedsSAT <- ipedsSAT[,c('SATMath','SATWriting','SATTotal','AcceptanceTotal','FullTimeRetentionRate')]
names(ipedsSAT)[5] <- 'Retention'
ipedsSAT <- ipedsSAT[complete.cases(ipedsSAT),]



ggplot(temp, aes(x=Year, y=means)) + geom_point()



ggplot(fuel, aes(x=hp, y=mpg)) + geom_point()



ggplot(housing, aes(x=Median.income, y=Housing.Cost)) + geom_point()



meanSAT = mean(ipedsSAT$SATTotal)
meanRetention = mean(ipedsSAT$Retention)



ipedsSAT$Association = ifelse((ipedsSAT$SATTotal > meanSAT & ipedsSAT$Retention > meanRetention) | (ipedsSAT$SATTotal < meanSAT & ipedsSAT$Retention < meanRetention), '+', '-')



ggplot(ipedsSAT, aes(x=SATTotal, 
	y=Retention, color=Association)) + 
	geom_vline(xintercept=meanSAT) +
	geom_hline(yintercept=meanRetention) +
	geom_point()



cor(ipedsSAT$SATTotal, ipedsSAT$Retention)


