

require(ggplot2)
require(gdata)
options(digits=4, width=95)
opts_chunk$set(fig.path='Figures/Class06-')
opts_chunk$set(comment=NA)
source('../R/contingency.table.R')

sat <- read.csv('../Data/Textbook/Chapter_7/SAT_scores.csv', stringsAsFactors=FALSE)
sat$Verbal.SAT <- as.integer(sat$Verbal.SAT)
sat$Math.SAT <- as.integer(sat$Math.SAT)
sat <- sat[complete.cases(sat),]



cor(sat$Math.SAT, sat$Verbal.SAT)



sat.lm <- lm(Math.SAT ~ Verbal.SAT, data=sat)
summary(sat.lm)
ggplot(sat, aes(x=Verbal.SAT, y=Math.SAT)) + 
	geom_point(color='black') + 
	geom_abline(slope=sat.lm$coefficients[2], intercept=sat.lm$coefficients[1],
				color='red', size=2) +
	geom_hline(yintercept=mean(sat$Math.SAT), color='blue', size=1) +
	geom_vline(xintercept=mean(sat$Verbal.SAT), color='blue', size=1)



(sat.lm = lm(Math.SAT ~ Verbal.SAT, data=sat))



sat.residual = resid(sat.lm)
plot(sat$Verbal.SAT, sat.residual)



hist(sat.residual)



cor(sat$Verbal.SAT, sat$Math.SAT) ^ 2



require(reshape2)
sat$residuals = sat.residual + mean(sat$Math.SAT)
sat$Verbal.SAT.z = (sat$Verbal.SAT - mean(sat$Verbal.SAT)) / sd(sat$Verbal.SAT)
sat$Math.SAT.z = (sat$Math.SAT - mean(sat$Math.SAT)) / sd(sat$Math.SAT)
sat.melted = melt(sat[,c('Math.SAT', 'residuals')])
ggplot(sat.melted, aes(x=variable, y=value)) + geom_boxplot()


