

require(ggplot2)
require(gdata)
options(digits=4, width=95)
opts_chunk$set(fig.path='Figures/Class10-')
opts_chunk$set(comment=NA)

sampledf <- data.frame(Variable=c(
	'Mean Age (yr)', 'White (%)', 'Female (%)', 'Mean # of Children', 'Mean Income (1-7)',
	'Mean Wealth Bracket (1-9)', 'Homeowner (% yes)'),
					   Sample1=c(61.4,85.12,56.2,1.54,3.91,5.29,71.36),
					   Sample2=c(61.2,84.44,56.4,1.51,3.88,5.33,73.30))



print(sampledf, row.names=FALSE)


