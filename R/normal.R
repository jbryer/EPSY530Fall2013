bell <- function(x, mean=0, sd=1) {
	e <- exp(1)
	y <- ( 1 / (sd * sqrt(2 * pi)) ) * 
		e^(-1 * (x - mean)^2 / (2*sd^2))
	return(y)
}

if(FALSE) {
	min <- -4
	max <- 4
	tmp <- data.frame(x=seq(min,max,by=.01), y=bell(seq(min,max,by=.01)))
	ggplot(tmp, aes(x=x, y=y)) + geom_point()
	integrate(bell, -1, 1) 
	integrate(bell, 0, 1)
	integrate(bell, -2, 2)
	integrate(bell, -3, 3)
}
