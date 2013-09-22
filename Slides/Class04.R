

require(ggplot2)
require(gdata)
options(digits=4, width=95)
opts_chunk$set(fig.path='Figures/Class03-')
opts_chunk$set(comment=NA)
source('../R/contingency.table.R')


load('../Data/titanic.Rda')
movies <- read.csv('../Data/Textbook/Chapter_3/movie_lengths_2010.csv', stringsAsFactors=FALSE)



hist(movies$Running.Time)



ggplot(movies, aes(x=Running.Time)) + geom_histogram()



ggplot(movies, aes(x=Running.Time)) + 
	geom_histogram(binwidth=15)



movies[movies$Running.Time < 50, ]



stem(movies$Running.Time)



(mediantime <- median(movies$Running.Time))
ggplot(movies, aes(x=Running.Time, y='Length')) + geom_point() + 
	geom_vline(xintercept=mediantime, color='blue')



(meantime <- mean(movies$Running.Time))
ggplot(movies, aes(x=Running.Time, y='Length')) + geom_point() + 
	geom_vline(xintercept=mediantime, color='blue') + geom_vline(xintercept=meantime, color='red')



summary(movies$Running.Time)



boxplot(movies$Running.Time)



ggplot(movies, aes(x='Movie', y=Running.Time)) + geom_boxplot()



ggplot(titanic, aes(x=survived, y=age)) + geom_boxplot()


