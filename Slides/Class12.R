

require(ggplot2)
require(gdata)
options(digits=4, width=95)
opts_chunk$set(fig.path='Figures/Class12-')
opts_chunk$set(comment=NA)




flips <- sample(c(0,1,0), 100, replace=TRUE)
df <- data.frame(day=1:100, 
	PercentGreen=cumsum(flips) / 1:100)
ggplot(df, aes(x=day, y=PercentGreen)) + 
	geom_path() + ylim(c(0,1))



flips <- sample(c(0,1,0), 100, replace=TRUE)
df <- data.frame(day=1:100, 
	PercentGreen=cumsum(flips) / 1:100)
ggplot(df, aes(x=day, y=PercentGreen)) + 
	geom_path() + ylim(c(0,1))



flips <- sample(c(0,1,0), 500, replace=TRUE)
df <- data.frame(day=1:500, 
	PercentGreen=cumsum(flips) / 1:500)
ggplot(df, aes(x=day, y=PercentGreen)) + 
	geom_path() + ylim(c(0,1))


