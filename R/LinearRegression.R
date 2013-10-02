# Data setup
sat <- read.csv('Data/Textbook/Chapter_7/SAT_scores.csv', stringsAsFactors=FALSE)
names(sat) <- c('Verbal','Math','Sex')
sat$Verbal <- as.integer(sat$Verbal)
sat$Math <- as.integer(sat$Math)
sat <- sat[complete.cases(sat),]

# Scatter plot
ggplot(sat, aes(x=Verbal, y=Math)) + geom_point(color='black', size=2.5)

# Calculate the means and standard deviations
( verbalMean <- mean(sat$Verbal) )
( mathMean <- mean(sat$Math) )
( verbalSD <- sd(sat$Verbal) )
( mathSD <- sd(sat$Math) )
( n <- nrow(sat) )

# Calcualte z-scores (standard scores) for the verbal and math scores.
sat$Verbal.z <- (sat$Verbal - verbalMean) / verbalSD
sat$Math.z <- (sat$Math - mathMean) / mathSD

head(sat)

# Scatter plot of z-scores. Note that the pattern is the same but the scales
# on the x- and y-axes are different.
ggplot(sat, aes(x=Verbal.z, y=Math.z)) + geom_point(color='black', size=2.5)

# Calculate the correlation manually using the z-score formula
r <- sum( sat$Verbal.z * sat$Math.z ) / ( n - 1 )
r
# Or the cor function in R is probably simplier.
cor(sat$Verbal, sat$Math)
# And to show that the units don't matter, calculate the correlation with the z-scores
cor(sat$Verbal.z, sat$Math.z)

ggplot(sat, aes(x=Verbal, y=Math)) + geom_point(color='black', size=2.5) +
	geom_vline(xintercept=verbalMean, color='darkmagenta') +
	geom_hline(yintercept=mathMean, color='darkmagenta')

# Calculate the slope
m <- r * (mathSD / verbalSD)
m

# Calculate the intercept (recall that the point where the mean of x and mean of y
# intercept will be on the line of best fit)
b <-  mathMean - m * verbalMean
b

# Add the regression line to the scatter plot. The vertical and horizontal lines
# represent the mean Verbal and Math SAT scores, respectively.
ggplot(sat, aes(x=Verbal, y=Math)) + geom_point(color='black', size=2.5) +
	geom_vline(xintercept=verbalMean, color='darkmagenta') +
	geom_hline(yintercept=mathMean, color='darkmagenta') +
	geom_abline(intercept=b, slope=m, color='red', size=2, alpha=.5) +
	xlim(c(0,800)) + ylim(c(0,800)) + geom_vline(xintercept=0)

# Calculate the predicted values of y (Math scores in this example)
sat$Math.predicted <- m * sat$Verbal + b
head(sat)

# Calculate the residuals (observed - predicted)
sat$residual <- sat$Math - sat$Math.predicted
head(sat)

# Plot our regression line with residuals. The line of best fit minimizes the residuals.
ggplot(sat, aes(x=Verbal, y=Math)) + geom_point(color='black', size=2.5) +
	geom_abline(intercept=b, slope=m, color='red', size=2, alpha=.5) +
	geom_segment(aes(xend=Verbal, yend=Math.predicted, color=abs(residual))) +
	scale_color_gradient(low='white', high='blue')

# To show that m <- r * (SD_y / SD_x) minimizes the sum of squared residuals, this
# loop will calculate the sum of squared residuals for varying values of r above
# and below the calculated value.
results <- data.frame(r=seq(r - .2, r + .2, by=.01), sumsquares=as.numeric(NA))
for(i in 1:nrow(results)) {
	i.r <- results[i,]$r
	i.m <- i.r * (mathSD / verbalSD)
	i.b <-  mathMean - i.m * verbalMean
	predicted <- i.m * sat$Verbal + i.b
	residual <- sat$Math - predicted
	sumsquares <- sum(residual^2)
	results[i,]$sumsquares <- sum(residual^2)
}
# Plot the sum of squared residuals for different slopes (i.e. r's). The vertical
# line corresponds the r (slope) calcluated above and the horizontal line 
# corresponds the sum of squared residuals for that r. This should have the 
# smallest sum of squared residuals.
ggplot(results, aes(x=r, y=sumsquares)) + geom_point(size=2.5) + 
	geom_vline(xintercept=r, color='blue') +
	geom_hline(yintercept=sum(sat$residual^2), color='magenta')

# Residual plot
ggplot(sat, aes(x=Verbal, y=residual)) + geom_point(size=2.5)

# Plot the residuals and Math scores. 
ggplot(sat, aes(x=Verbal, y=Math)) + geom_point(color='black', size=2.5) +
	geom_point(aes(x=Verbal, y=residual), color='blue', size=2.5) +
	geom_abline(intercept=b, slope=m, color='red', size=2, alpha=.5) +
	geom_segment(aes(xend=Verbal, yend=residual), alpha=.1) +
	geom_hline(yintercept=0) + geom_rug(aes(y=residual), color='blue', sides='rb')

# Histogram of residuals
ggplot(sat, aes(x=residual)) + geom_histogram(alpha=.5, binwidth=25)

# Calculate R^2
r ^ 2

# Now we can predict Math scores from new Verbal.
newX <- 550
(newY <- newX * m + b)
ggplot(sat, aes(x=Verbal, y=Math)) + geom_point(color='black', size=2.5) +
	geom_abline(intercept=b, slope=m, color='red', size=2, alpha=.5) +
	geom_segment(aes(xend=Verbal, yend=Math.predicted, color=abs(residual))) +
	scale_color_gradient(low='white', high='blue') +
	geom_point(x=newX, y=newY, shape=17, color='darkgreen', size=8)


# The lm function in R will calculate everything above for us in one command
sat.lm <- lm(Math ~ Verbal, data=sat)
sat.lm
summary(sat.lm) # Even more information about the model

# We can get the predicted values and residuals from the lm function
sat.lm.predicted <- predict(sat.lm)
sat.lm.residuals <- resid(sat.lm)

# Confirm that they are the same as what we calculated above.
View(cbind(sat.lm.predicted, sat$Math.predicted))
View(cbind(sat.lm.residuals, sat$residual))

##### Examine the differences between genders
# First, let's look at the scatter plot but with gender separated out.
ggplot(sat, aes(x=Verbal, y=Math, color=Sex, shape=Sex)) + 
	geom_point(size=2.5) + 
	scale_color_manual(limits=c('M','F'), values=c('blue','maroon')) +
	scale_shape_manual(limits=c('M','F'), values=c(16, 17))

# Similar to above but with the residual plot
ggplot(sat) + 
	geom_point(aes(x=Verbal, y=residual, color=Sex, shape=Sex), size=2.5) + 
	scale_color_manual(limits=c('M','F'), values=c('blue','maroon')) +
	scale_shape_manual(limits=c('M','F'), values=c(16, 17)) + 
	geom_rug(data=subset(sat, Sex=='M'), aes(y=residual, color=Sex), sides='tr') +
	geom_rug(data=subset(sat, Sex=='F'), aes(y=residual, color=Sex), sides='lb')

ggplot(sat, aes(x=residual)) + geom_histogram(binwidth=25, alpha=.5) + facet_wrap(~ Sex, ncol=1)

sat.male <- sat[sat$Sex == 'M',]
sat.female <- sat[sat$Sex == 'F',]

(male.verbal.mean <- mean(sat.male$Verbal))
(male.math.mean <- mean(sat.male$Math))
(female.verbal.mean <- mean(sat.female$Verbal))
(female.math.mean <- mean(sat.female$Math))

sat.male.lm <- lm(Math ~ Verbal, data=sat.male)
sat.female.lm <- lm(Math ~ Verbal, data=sat.female)

sat.male.lm
sat.female.lm

summary(sat.male.lm)
summary(sat.female.lm)

ggplot(sat, aes(x=Verbal, y=Math, color=Sex)) + 
	geom_point(size=2.5) +
	geom_vline(xintercept=male.verbal.mean, color='blue') +
	geom_hline(yintercept=male.math.mean, color='blue') +
	geom_vline(xintercept=female.verbal.mean, color='maroon') +
	geom_hline(yintercept=female.math.mean, color='maroon') +
	geom_abline(slope=sat.male.lm$coefficients[2], 
				intercept=sat.male.lm$coefficients[1], color='blue', size=2, alpha=.5) +
	geom_abline(slope=sat.female.lm$coefficients[2], 
				intercept=sat.female.lm$coefficients[1], color='maroon', size=2, alpha=.5) +
	geom_abline(intercept=b, slope=m, color='red', size=1, alpha=.5) +
	scale_color_manual(limits=c('M','F'), values=c('blue','maroon'))

## Outliers

# Histogram of residuals
ggplot(sat, aes(x=residual, fill=residual > 200)) + 
	geom_histogram(alpha=.5, binwidth=25) +
	scale_fill_manual(limits=c(TRUE, FALSE), values=c('red','black'))

sat.outlier <- sat[sat$residual > 200,]
sat.outlier

ggplot(sat, aes(x=Verbal, y=Math)) + 
	geom_point(size=2.5) +
	geom_point(x=sat.outlier$Verbal, y=sat.outlier$Math, color='red', size=2.5, shape=17) +
	geom_abline(intercept=b, slope=m, color='red', size=2, alpha=.5)

# Let's compare the models with and without the possible outlier.
(sat.lm <- lm(Math ~ Verbal, data=sat))
(sat.lm2 <- lm(Math ~ Verbal, data=sat[sat$residual < 200,]))

# And the R^2
unname(sat.lm$coefficients[2] ^ 2)
unname(sat.lm2$coefficients[2] ^ 2)


# More outliers
outX <- 1200
outY <- 1150
sat.outlier <- rbind(sat[,c('Verbal','Math')], c(Verbal=outX, Math=outY))
(sat.lm <- lm(Math ~ Verbal, data=sat))
(sat.lm2 <- lm(Math ~ Verbal, data=sat.outlier))
ggplot(sat.outlier, aes(x=Verbal, y=Math)) + 
	geom_point(size=2.5) +
	geom_point(x=outX, y=outY, color='red', size=2.5, shape=17) +
	geom_abline(intercept=b, slope=m, color='red', size=2, alpha=.5) +
	geom_abline(intercept=sat.lm2$coefficients[1], slope=sat.lm2$coefficients[2], 
				size=2, alpha=.5)
unname(sat.lm$coefficients[2] ^ 2)
unname(sat.lm2$coefficients[2] ^ 2)

# Even more outliers
outX <- 300
outY <- 1150
sat.outlier <- rbind(sat[,c('Verbal','Math')], c(Verbal=outX, Math=outY))
(sat.lm <- lm(Math ~ Verbal, data=sat))
(sat.lm2 <- lm(Math ~ Verbal, data=sat.outlier))
ggplot(sat.outlier, aes(x=Verbal, y=Math)) + 
	geom_point(size=2.5) +
	geom_point(x=outX, y=outY, color='red', size=2.5, shape=17) +
	geom_abline(intercept=b, slope=m, color='red', size=2, alpha=.5) +
	geom_abline(intercept=sat.lm2$coefficients[1], slope=sat.lm2$coefficients[2], 
				size=2, alpha=.5)
unname(sat.lm$coefficients[2] ^ 2)
unname(sat.lm2$coefficients[2] ^ 2)
