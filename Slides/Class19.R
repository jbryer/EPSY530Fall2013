

require(ggplot2)
require(gdata)
require(psych)
options(digits=4, width=95)
opts_chunk$set(fig.path='Figures/Class19-')
opts_chunk$set(comment=NA)

require(granova)
data(anorexia.sub)



print(anorexia.sub, row.names=FALSE)



anorexia.sub$Diff <- anorexia.sub[,2] - anorexia.sub[,1]
print(anorexia.sub, row.names=FALSE)



granovagg.ds(anorexia.sub[,1:2], revc=TRUE)


