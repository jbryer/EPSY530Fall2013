

require(ggplot2)
require(gdata)
options(digits=4, width=95)
opts_chunk$set(fig.path='Figures/Class03-')
opts_chunk$set(comment=NA)
source('../R/contingency.table.R')



R.version$version.string



2+2
1 + sin(9)
23.76 * log(8)/(23+atan(9))



## install.packages(c('ggplot2', 'foreign', 'psych'))



## update.packages(ask=FALSE)



## library()



require(ggplot2)
require(foreign)



search()



ls('package:foreign')



## data(package='ggplot2')



## vignette(package='psych')



## help.search('cross tabs')



require(gdata)
mathAnxiety <- read.xls('../Data/MathAnxiety.xls', sheet=1)
names(mathAnxiety)
nrow(mathAnxiety)
ncol(mathAnxiety)



shy = read.spss("../Data/Exercise2.sav", use.value.labels=FALSE, to.data.frame=TRUE)
names(shy)



titanic <- read.csv('../Data/titanic.csv')



## titanic <- read.table('../Data/titanic.csv', header=TRUE, sep=',', quote='\"')



class(titanic)
head(titanic, n=3)



str(titanic)


