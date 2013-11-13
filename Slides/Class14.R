

require(ggplot2)
require(gdata)
options(digits=4, width=95)
opts_chunk$set(fig.path='Figures/Class14-')
opts_chunk$set(comment=NA)

insurance <- data.frame(Outcome=c('Death','Disability','Neither'),
						Payout=c(10000,5000,0),
						Probability=c(1/1000, 2/1000, 997/1000))




print(insurance, row.names=FALSE)



m <- sum(insurance$Payout * 
		 	insurance$Probability)
m
sqrt(sum( (insurance$Payout - m)^2  * 
		  	insurance$Probability))



dbinom(x=2, size=5, prob=0.2)
cards <- data.frame(Card=c('Walt',
		'Jesse','Hank'),
		Prob=c(.2,.3,.5))
dbinom(2, 5, prob=cards$Prob)



dbinom(1, 25, 0.09) + dbinom(2, 25, 0.09)


