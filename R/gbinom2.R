gbinom2 <- function(n, p, low=0, high=n,
					scale = T, 
					a=NA,
					b=NA,
					calcProb=!all(is.na(c(a,b))),
					quantile=NA,
					calcQuant=!is.na(quantile)) {
		sd = sqrt(n * p * (1 - p))
		if(scale && (n > 10)) {
			low = max(0, round(n * p - 4 * sd))
			high = min(n, round(n * p + 4 * sd))
		}
		values = low:high
		probs = dbinom(values, n, p)
		plot(c(low,high), c(0,max(probs)), type = "n", xlab = "Number of Successes",
			 ylab = "Probability",
			 main = paste("Binomial Distribution \n", "n =", n, ", p =", p))
		lines(values, probs, type = "h", cex=1.75, col = "firebrick3",lwd=4)
		abline(h=0,col="grey70")
		if(calcProb) {
			if(is.na(a))
				a = 0
			if(is.na(b))
				b = n
			if(a > b) {
				d = a
				a = b
				b = d
			}
			a = round(a)
			b = round(b)
			prob = pbinom(b,n,p) - pbinom(a-1,n,p)
			title(paste("P(",a," <= X <= ",b,") = ",round(prob,6),sep=""),line=0,col.main="steelblue4")
			u = seq(max(c(a,low)),min(c(b,high)),by=1)
			v = dbinom(u,n,p)
			lines(u,v,type="h", cex=1.75,col="steelblue4",lwd=4)
		}
		else if(calcQuant==T) {
			if(quantile < 0 || quantile > 1)
				stop("quantile must be between 0 and 1")
			x = qbinom(quantile,n,p)
			title(paste("The ",quantile," quantile = ",x,sep=""),line=0,col.main="steelblue4")
			u = 0:x
			v = dbinom(u,n,p)
			lines(u,v,type="h", cex=1.75,col="steelblue4",lwd=4)
		}
		return(invisible())
	}
