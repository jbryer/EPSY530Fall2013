# What version of R?
R.version
R.version$version.string

# R is a big calculator!
2 + 2
1 + sin(42)
23.76 * log(8)/(23 + atan(9))
pi
exp(1i * pi)

# Installing packages
install.packages(c("ggplot2", "foreign", "psych", "gdata"))

# Updating packages
update.packages(ask=FALSE)

require(ggplot2)
require(psych)
require(gdata)
require(foreign)

# What packages are loaded?
search()

# What packages are installed?
library()

# Working directory
getwd()
#setwd("C:/")
setwd("~/Dropbox/School/Teaching/EPSY530 2013 Fall")

# What functions are in the foreign package?
ls("package:foreign")

ls()

data()
data(package = "ggplot2")

vignette()
vignette(package = "psych")

help.search("cross tabs")
?describe

# Read a CSV file
titanic <- read.csv("Data/titanic.csv")

# Some useful functions for a data frame
head(titanic)
tail(titanic)
names(titanic)
nrow(titanic)
ncol(titanic)
str(titanic)

# Subsetting a data frame (or matrix). First element is row, second is column
titanic[1,] # Print the first row
titanic[,1] # Print the first column
titanic[1,3] # Print the cell at row 1, column 3
titanic[1,'home.dest']
