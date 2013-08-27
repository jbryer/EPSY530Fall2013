# Downloaded from biostat.mc.vanderbilt.edu/twiki/bin/view/Main/DataSets
# Documentation: biostat.mc.vanderbilt.edu/wiki/pub/Main/DataSets/Ctitanic3.html

# Read the data
titanic <- read.csv('Data/titanic.csv', stringsAsFactors=FALSE)

# Get some information about the dataset
names(titanic)
nrow(titanic)
ncol(titanic)
str(titanic)

# Convert the survived variable to a factor. The data came in as 0 and 1 where
# 0 = did not survive, 1 = survived. We'll code this as "Yes" and "No", respectively.
titanic$survived <- factor(titanic$survived, levels=c(0,1), labels=c('No','Yes'))
titanic$pclass <- factor(titanic$pclass, levels=1:3, 
						 labels=c('First','Second','Third'), ordered=TRUE)
save(titanic, file='Data/titanic.Rda')

# Frequency Tables
table(titanic$survived)
table(titanic$pclass)
table(titanic$survived, titanic$pclass)

# Proportion Tables
prop.table(table(titanic$survived)) * 100
prop.table(table(titanic$pclass)) * 100
prop.table(table(titanic$survived, titanic$pclass)) * 100
prop.table(table(titanic$survived, titanic$pclass), 1) * 100
prop.table(table(titanic$survived, titanic$pclass), 2) * 100

