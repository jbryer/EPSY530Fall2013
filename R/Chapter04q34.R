getwd()
vine = read.csv('Data/Textbook/Chapter_4/Vineyards.csv')
names(vine)
head(vine)
hist(vine$Acres)
require(ggplot2)
ggplot(vine, aes(x=Acres)) + geom_histogram()
qqnorm(vine$Acres)
qqnorm(log(vine$Acres))
qqnorm(vine$Acres^2)
qqnorm(sqrt(vine$Acres))

### Log transform example
log(0)
log(1)
log(2)
log(10)
log(100)
log(1000)

11 - 1
log(11) - log(1)
21 - 11
log(21) - log(11)
temp = data.frame(x=1:10000, y=log(1:10000))
plot(temp$x, temp$y)
