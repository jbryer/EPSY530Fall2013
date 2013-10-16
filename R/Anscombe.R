require(ggplot2)
require(reshape2)

data(anscombe)
View(anscombe)

data1 <- anscombe[,c(1,5)]
data2 <- anscombe[,c(2,6)]
data3 <- anscombe[,c(3,7)]
data4 <- anscombe[,c(4,8)]
names(data1) <- names(data2) <- names(data3) <- names(data4) <- c('x','y')

save(data1, data2, data3, data4, file='Data/MidtermTakehome.Rda')
load('Data/MidtermTakehome.Rda')

plot(data1$x, data1$y)
plot(data2$x, data2$y)
plot(data3$x, data3$y)
plot(data4$x, data4$y)

mean(data1$x); mean(data2$x); mean(data3$x); mean(data4$x)
mean(data1$y); mean(data2$y); mean(data3$y); mean(data4$y)

sd(data1$x); sd(data2$x); sd(data3$x); sd(data4$x)
sd(data1$y); sd(data2$y); sd(data3$y); sd(data4$y)

summary(data1$x); summary(data2$x); summary(data3$x); summary(data4$x)
summary(data1$y); summary(data2$y); summary(data3$y); summary(data4$y)

cor(anscombe$x1, anscombe$y1)
cor(anscombe$x2, anscombe$y2)
cor(anscombe$x3, anscombe$y3)
cor(anscombe$x4, anscombe$y4)

stats <- data.frame(Mean=c(mean(data1$x), mean(data2$x), mean(data3$x), mean(data4$x)),
					Correlation=c(cor(anscombe$x1, anscombe$y1),
								  cor(anscombe$x2, anscombe$y2),
								  cor(anscombe$x3, anscombe$y3),
								  cor(anscombe$x4, anscombe$y4)))
x <- xtable(stats)
print(x, type='html')

lm.out1 <- lm(y ~ x, data=data1)
lm.out2 <- lm(y ~ x, data=data2)
lm.out3 <- lm(y ~ x, data=data3)
lm.out4 <- lm(y ~ x, data=data4)

# Scatter plots
par(mfrow=c(2,2))
for(i in 1:4) {
	thedata <- anscombe[,c(paste0('x',i), paste0('y',i))]
	names(thedata) <- c('x','y')
	plot(thedata$x, thedata$y, xlab='x', ylab='y', xlim=c(0,20), ylim=c(0,14))
	lm.out <- lm(y ~ x, data=thedata)
	abline(a=lm.out$coefficients[1], b=lm.out$coefficients[2])
}

# Residual plots
par(mfrow=c(2,2))
for(i in 1:4) {
	thedata <- anscombe[,c(paste0('x',i), paste0('y',i))]
	names(thedata) <- c('x','y')
	lm.out <- lm(y ~ x, data=thedata)
	plot(thedata$x, residuals(lm.out), xlab='x', ylab='y', xlim=c(0,20), ylim=c(-3.1,3.1))
	abline(a=0, b=0)
}

# Using ggplot2
x <- melt(anscombe[,1:4])
y <- melt(anscombe[,5:8])
names(x) <- c('group', 'x')
names(y) <- c('group', 'y')
x$group <- substr(x$group, 2,2)
y$group <- substr(y$group, 2,2)
anscombe2 <- cbind(x, y=y[,2])
head(anscombe2)

ggplot(anscombe2, aes(x=x, y=y)) + geom_point() + facet_wrap(~ group) + 
	geom_abline(intercept=lm.out1$coefficients[1], slope=lm.out1$coefficients[2])
	