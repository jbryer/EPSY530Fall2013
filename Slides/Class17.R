

require(ggplot2)
require(gdata)
options(digits=4, width=95)
opts_chunk$set(fig.path='Figures/Class17-')
opts_chunk$set(comment=NA)




x <- seq(-4, 4, length=100)
hx <- dnorm(x)

degf <- c(1, 3, 8, 30)
colors <- c("red", "blue", "darkgreen", "gold", "black")
labels <- c("df=1", "df=3", "df=8", "df=30", "normal")

plot(x, hx, type="l", lty=2, xlab="x value",
  ylab="Density", main="Comparison of t Distributions")

for (i in 1:4){
  lines(x, dt(x,degf[i]), lwd=2, col=colors[i])
}

legend("topright", inset=.05, title="Distributions",
  labels, lwd=2, lty=c(1, 1, 1, 1, 2), col=colors)



qt(.975, 149)



qt(.95, 24)



1 - pt(2.825, 149)



pt(-1.67, 24)


