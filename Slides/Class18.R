

require(ggplot2)
require(gdata)
require(psych)
options(digits=4, width=95)
opts_chunk$set(fig.path='Figures/Class18-')
opts_chunk$set(comment=NA)
load('../Project/Data/pisa.USA.Rda')



describeBy(pisa.USA$reading, 
group=pisa.USA$PUBPRIV, mat=TRUE, 
skew=FALSE)[,2:6]



ggplot(pisa.USA, aes(x=PUBPRIV, 
y=reading)) + geom_boxplot()



t.test(reading ~ PUBPRIV, data=pisa.USA)


