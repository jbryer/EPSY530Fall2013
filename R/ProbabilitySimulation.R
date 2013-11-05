require(ggplot2)
require(reshape)

#' 
#' 
probsim <- function(probabilities, 
					labels=letters[1:length(probabilities)],
					M=500) {
	if((all(probabilities < 1) & !identical(sum(probabilities), 1)) &
	   	!identical(sum(probabilities), 100) ) {
			stop("Sum of prababilities must equal 1 or 100")
	}
	df <- data.frame(index=1:M, sample=sample(labels, M, replace=TRUE, prob=probabilities))
	for(i in labels) {
		v <- ifelse(df$sample == i, 1, 0)
		df[,paste0('prob.', i)] <- cumsum(v) / 1:M
	}
	class(df) <- c('probsim', 'data.frame')
	return(df)
}

summary.probsim <- function(object, ...) {
	cat('Estimated sample probabilities:')
	print(prop.table(table(ps$sample)))
}

plot.probsim <- function(x, ...) {
	x.melted <- melt(x[,c(1,3:ncol(x))], id='index')
	p <- ggplot(x.melted, aes(x=index, y=value, color=variable, group=variable)) +
		geom_path() + ylim(c(0,1)) +
		ylab('Probability')
	return(p)
}

if(FALSE) {
	ps <- probsim(probabilities=c(.3, .6, .1), 
				  labels=c('red','green','yellow'),
				  M=2000)
	plot(ps) + scale_color_manual(values=c('red','green','yellow'))
	summary(ps)
	
	coins <- probsim(c(.4,.6), labels=c('Heads','Tails'), M=5000)
	plot(coins)
	
	dice <- probsim(c(1/6,1/6,1/6,1/6,1/6,1/6), M=50000)
	plot(dice)
}
