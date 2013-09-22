

require(ggplot2)
require(gdata)
options(digits=4)
opts_chunk$set(fig.path='Figures/Class02-')
opts_chunk$set(comment=NA)
source('../R/contingency.table.R')



load('../Data/titanic.Rda')
head(titanic, n=3)



table(titanic$pclass)



prop.table(table(titanic$pclass)) * 100



contingency.table(titanic$pclass, titanic$survived)



prop.table(table(titanic$pclass, titanic$survived)) * 100



prop.table(table(titanic$pclass, titanic$survived), 1) * 100



plot(titanic$pclass)



suppressMessages(mass <- read.xls('../Data/MathAnxiety.xls'))

items <- c('I find math interesting.',
	'I get uptight during math tests.',
	'I think that I will use math in the future.',
	'Mind goes blank and I am unable to think clearly when doing my math test.',
	'Math relates to my life.',
	'I worry about my ability to solve math problems.',
	'I get a sinking feeling when I try to do math problems.',
	'I find math challenging.',
	'Mathematics makes me feel nervous.',
	'I would like to take more math classes.',
	'Mathematics makes me feel uneasy.',
	'Math is one of my favorite subjects.',
	'I enjoy learning with mathematics.',
	'Mathematics makes me feel confused.')

for(i in 2:ncol(mass)) {
	mass[,i] <- factor(mass[,i], levels=1:5, labels=c('Strongly Disagree', 
							'Disagree', 'Neutral', 'Agree', 'Strongly Agree'),
					   ordered=TRUE)
}

names(mass) <- c('Gender', items)



require(likert)
l <- likert(mass[,2:ncol(mass)])
plot(l, wrap=30)



lg <- likert(mass[,2:ncol(mass)], grouping=mass$Gender)
plot(lg)



# http://sas-and-r.blogspot.com/2012/02/example-920-visualizing-simpsons.html?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+SASandR+%28SAS+and+R%29
require(mosaic); trellis.par.set(theme=col.mosaic())
SAT$fracgrp = cut(SAT$frac, breaks=c(0, 22, 49, 81), labels=c("low", "medium", "high"))
#SAT$fracgrp = cut(SAT$frac, breaks=c(0, 50, 100), labels=c("low", "high"))
SAT$fraccount = 1 + as.numeric(SAT$fracgrp=="medium") + 2*as.numeric(SAT$fracgrp=="high")
ggplot(SAT, aes(x=salary, y=sat, label=state)) + geom_point() + 
	geom_text(size=3, vjust=0.5, hjust=-0.1)



ggplot(SAT, aes(x=salary, y=sat, label=state, color=frac)) + geom_point() + 
	geom_text(size=3, vjust=0.5, hjust=-0.1)



ggplot(SAT, aes(x=salary, y=sat, label=state, color=fracgrp)) + geom_point() + 
	geom_text(size=3, vjust=0.5, hjust=-0.1)


