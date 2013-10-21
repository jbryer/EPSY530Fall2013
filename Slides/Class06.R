

require(ggplot2)
require(gdata)
require(likert)
data(pisana)
pisausa <- pisana[pisana$CNT == 'USA',]
pisausa$Math <- pisausa$PV1MATH

options(digits=4, width=95)
opts_chunk$set(fig.path='Figures/Class06-')
opts_chunk$set(comment=NA)
source('../R/contingency.table.R')


load('../Data/titanic.Rda')
movies <- read.csv('../Data/Textbook/Chapter_3/movie_lengths_2010.csv', stringsAsFactors=FALSE)
ozone <- read.csv('../Data/Textbook/Chapter_4/Ozone.csv', stringsAsFactors=FALSE)
ozone$Ozone <- as.numeric(ozone$Ozone)
ozone <- ozone[!is.na(ozone$Ozone),]

# See http://data.giss.nasa.gov/gistemp/tabledata_v3/GLB.Ts+dSST.txt
temp <- read.table('../Data/GlobalTemp.txt', header=TRUE, strip.white=TRUE)
temp$means <- rowMeans(aggregate(temp[,c("DJF","MAM","JJA","SON")], by=list(temp$Year), FUN="mean")[,2:5])
temp$meansF <- temp$means / 100 * 1.8

# temp2 <- melt(temp[,1:13], id='Year')
# temp2$value <- temp2$value / 100 * 1.8
# ggplot(temp2, aes(x=variable, y=value)) + geom_boxplot()

# World data
# countries = read.csv('../Data/WDI_GDF_Country.csv', strip.white=TRUE)
# worldData = read.csv('../Data/WDI_GDF_Data.csv', strip.white=TRUE)
# worldData2 = worldData[which(worldData$Series.Code %in% c('NY.GDP.MKTP.KD', 'SE.XPD.TOTL.GD.ZS', 'SP.DYN.LE00.IN', 'SP.POP.TOTL')), c('Series.Code', 'Series.Name', 'Country.Name', 'Country.Code', 'X2008')]
# worldData2 = merge(worldData2, countries[,c('Country.Code', 'Region')], by='Country.Code')
# worldData2 = worldData2[which(worldData2$Region != 'Aggregates'),]
# worldData2$Series.Name = as.factor(as.character(worldData2$Series.Name))
# worldData2$Region = as.factor(as.character(worldData2$Region))
# worldData3 = cast(worldData2, Country.Name + Region ~ Series.Name, mean, value='X2008')
# names(worldData3) = c('Country', 'Region', 'GDP', 'Life.Expectancy', 'Population', 'Education')
# worldData3$GDP.log = log(worldData3$GDP)
# worldData3$GDP = worldData3$GDP / 1000000000 #Billions
# worldData3$Population = worldData3$Population / 1000000 #Millions
load('../Data/WorldData.Rda')
worldData3 <- worldData3[!is.nan(worldData3$GDP),]



ggplot(pisausa, aes(x=Math)) + 
geom_histogram(binwidth=20)



ggplot(pisausa, aes(x=Math - 500)) + 
geom_histogram(binwidth=20)



data(cars)
names(cars) <- c('mph','dist')
cars$kph <- cars$mph / 1.609
speeds <- melt(cars[,c('mph','kph')])



ggplot(speeds, aes(x=variable, y=value)) + 
geom_boxplot()



ggplot(speeds, aes(x=value)) + 
geom_histogram() + 
facet_wrap(~ variable, ncol=1)



## require(multilevelPSA)
## pisausa <- pisana[pisana$CNT == 'USA',c('CNT','ST04Q01','PV1MATH')]
## names(pisausa) <- c('CNT','Gender','Math')
## pisausa <- pisausa[complete.cases(pisausa),]



ggplot(pisausa, aes(x=Math)) + geom_histogram()



qqnorm(pisausa$Math)



hist(worldData3$GDP)



hist(worldData3$GDP.log)



qqnorm(worldData3$GDP)



qqnorm(worldData3$GDP.log)


