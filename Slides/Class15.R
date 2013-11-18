

require(ggplot2)
require(gdata)
options(digits=4, width=95)
opts_chunk$set(fig.path='Figures/Class15-')
opts_chunk$set(comment=NA)




set.seed(2112)
dice <- data.frame(roll=1:10000)
for(i in 1:20) {
	dice[,paste0('dice', i)] <- sample(1:6, nrow(dice), replace=TRUE)
}
dice$dice3.mean <- apply(dice[,2:4], 1, mean)
dice$dice20.mean <- apply(dice[,2:21], 1, mean)
ggplot(dice, aes(x=factor(dice1))) + geom_histogram()
ggplot(dice, aes(x=dice3.mean)) + geom_histogram() + xlim(c(1,6)) + xlab('3-Dice Average')
ggplot(dice, aes(x=dice20.mean)) + geom_histogram() + xlim(c(1,6)) + xlab('20-Dice Average')



