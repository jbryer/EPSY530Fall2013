require(ggplot2)
require(pisa)
data(pisa.catalog.student)
data(pisa.student)
data(pisa.school)
data(pisa.countries)
school <- pisa.school[,c('COUNTRY', "CNT", "SCHOOLID",
						 "SC02Q01" #Public (1) or private (2)
)]
names(school) <- c('COUNTRY', 'CNT', 'SCHOOLID', 'PUBPRIV')
school$SCHOOLID <- as.integer(school$SCHOOLID)
school$CNT <- as.character(school$CNT)

pisa.catalog.student

pisa <- pisa.student[,c('CNT',
						'SCHOOLID',
						'ST04Q01', # Sex
						'ST06Q01', # Age
						'ST10Q01', # Mother highest schooling
						'ST14Q01', # Father highest schooling
						'ST21Q01', # How many cellular phones
						'ST21Q02', # How many televisions
						'ST21Q03', # How many computers
						'ST21Q04', # How many cars
						'ST22Q01', # How many books at home
						'ST23Q01', # Reading enjoyment time
						'ST28Q01', # Minutes in class for reading (test language)
						'ST28Q02', # Minutes in class for math
						'ST28Q03', # Minutes in class for science
						'ST25Q01', # Reading Magazines
						'ST25Q02', # Reading Comic Books
						'ST25Q03', # Reading Fiction
						'ST25Q04', # Reading non-fiction
						'ST25Q05', # Reading newspapers
						'PV1MATH','PV2MATH','PV3MATH','PV4MATH','PV5MATH',
						'PV1READ','PV2READ','PV3READ','PV4READ','PV5READ',
						'PV1SCIE','PV2SCIE','PV3SCIE','PV4SCIE','PV5SCIE'
						)]
pisa$CNT <- as.character(pisa$CNT)
pisa$SCHOOLID <- as.integer(pisa$SCHOOLID)

pisa <- merge(pisa, school, by=c('CNT', 'SCHOOLID'), all.x=TRUE)
pisa <- pisa[!is.na(pisa$PUBPRIV),] #Remove rows with missing PUBPRRIV



# How much missingness?
table(pisa$CNT, complete.cases(pisa))
prop.table(table(pisa$CNT, complete.cases(pisa)), 1) * 100

pisa <- pisa[complete.cases(pisa),]
#nrow(pisa)

# Sum the scores
pisa$math <- apply(pisa[,paste0('PV', 1:5, 'MATH')], 1, sum)
pisa$reading <- apply(pisa[,paste0('PV', 1:5, 'READ')], 1, sum)
pisa$science <- apply(pisa[,paste0('PV', 1:5, 'SCIE')], 1, sum)

pisa <- pisa[,!(substr(names(pisa), 1,2) == 'PV')]

# From likert
title <- "How often do you read these materials because you want to?"
items29 <- pisaitems[,substr(names(pisaitems), 1,5) == 'ST25Q']
head(items29); ncol(items29)
names(items29) <- c("Magazines", "Comic books", "Fiction", "Non-fiction books", "Newspapers")

tmp <- pisa[,substr(names(pisa), 1,5) == 'ST25Q']
for(i in 1:ncol(tmp)) { tmp[,i] <- as.integer(tmp[,i]) }
pisa$ReadingTime <- apply(tmp, 1, sum)
summary(pisa$ReadingTime)

ggplot(pisa, aes(x=ReadingTime, y=reading)) + geom_point(alpha=.1) + facet_wrap(~ CNT)

table(pisa$ST10Q01, useNA='ifany')
nlevels(pisa$ST10Q01)
pisa$MotherEd <- nlevels(pisa$ST10Q01) - as.integer(pisa$ST10Q01)
pisa$FatherEd <- nlevels(pisa$ST14Q01) - as.integer(pisa$ST14Q01)
pisa$ParentEd <- pisa$MotherEd + pisa$FatherEd

ggplot(pisa, aes(x=ParentEd, y=math)) + geom_point(alpha=.1) + facet_wrap(~ CNT)


# Save individual data files
for(i in unique(pisa$CNT)) {
	cnt <- pisa.countries[pisa.countries$Country == i,]$CNT3
	assign(paste0('pisa.', cnt), value=pisa[pisa$CNT == i,])
	save(list=paste0('pisa.', cnt), file=paste0('Project/Data/pisa.', cnt, '.Rda'))
	rm(list=paste0('pisa.', cnt))
}

write.csv(pisa.countries[pisa.countries$Country %in% pisa$CNT,], 
		  file='Project/Countries.csv', row.names=FALSE)


pisa.usa <- pisa[pisa$CNT == 'United States',]
lm.out <- lm(PV1MATH ~ ParentEd, data=pisa.usa)
summary(lm.out)
lm.out$coefficients
hist(pisa.usa$ParentEd)
ggplot(pisa.usa, aes(x=ParentEd, y=PV1MATH)) + geom_point(alpha=.05) +
	geom_abline(intercept=lm.out$coefficients[1], slop=lm.out$coefficients[2])

pisa.usa$Books <- as.integer(pisa.usa$ST22Q01)
ggplot(pisa.usa, aes(x=Books, y=PV1READ)) + geom_point(alpha=.05)

ggplot(pisa.usa, aes(x=ReadingTime, y=PV1READ)) + geom_jitter(alhpa=.05)



