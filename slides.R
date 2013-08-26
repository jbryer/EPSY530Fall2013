# http://slidify.org/
setwd("~/Dropbox/School/Teaching/EPSY530 2013 Fall")
source('slidify.R')

slideOptions <- list(framework='deck.js', theme='swiss', transition='horizontal-slide')

author('Slides/Class01') # Only once!

slidify(dir='Slides', file='Class01', options=slideOptions)

setwd('Slides')
slidify(dir='Slides', file='Class01')


