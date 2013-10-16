

require(ggplot2)
require(gdata)
options(digits=4, width=95)
opts_chunk$set(fig.path='Figures/Class09-')
opts_chunk$set(comment=NA)



sample(1:4, size=1)
sample(1:4, size=10, replace=TRUE)



cards <- c(rep('Walt', 2),
		   rep('Jesse', 3),
		   rep('Hank', 5))
cards



sample(cards, 8)



sample(cards, 8)



nboxes <- integer()
for(i in 1:100) {
	test <- rep(FALSE, length(unique(cards)))
	names(test) <- unique(cards)
	counter <- 0
	while(any(!test)) {
		counter <- counter + 1
		test[sample(cards, 1)] <- TRUE
	}
	nboxes[i] <- counter
}
summary(nboxes)



boxplot(nboxes)


