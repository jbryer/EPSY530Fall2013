![R](http://www.r-project.org/Rlogo.jpg)

[R](http://www.r-project.org/) Is a free and open source statistical program and language. It is quickly becoming the [*de facto* standard](http://r4stats.com/articles/popularity/) for data analysis.

### Downloading and Install R

I have provided access to running R in a Google Chrome browser at [rstudio.bryer.org](http://rstudio.bryer.org) so that you do not need to install any software. [Contact me](mailto:jason@bryer.org) if you have any trouble logging in. However, if you wish to install R and [RStudio](http://rstudio.com) on your own computer, you can following the [instructions here](Installation/Install.md).


### Resources

* [Quick-R](http://statmethods.net/) - by Robert I. Kabacoff. This is, IMHO, perhaps the single most useful resource for working with R. His book, *R in Action* is also highly recommended. A link to purchase his book with a discount is available on the [statmethods.net](http://statmethods.net) website.

* [simpleR - Using R for Introductory Statistics](http://www.math.csi.cuny.edu/Statistics/R/simpleR/printable/simpleR.pdf) by John Verzani

* [Google R Programming Video Lectures](http://gettinggeneticsdone.blogspot.com/2013/08/google-developers-r-programming-video.html)

* [Introduction to R](http://www.biostat.wisc.edu/~kbroman/Rintro/) - A nice collection of notes and links by Karl Broman.


### Overcoming the blank R command (Useful commands to get started)

* `str` - This is perhaps the single most useful function in R. It can take virtually any paramter and provies the structure of the object.   
* `require(ggplot2)` loads an installed package.
* `ls()`
* `ls('package:ggplot2')` (replace `ggplot2` with any loaded package name)
* `search()`
* `library()`
* `Sys.info()`
* `R.version`
* `.libPaths()`
* `install.packages(c('ggplot2'), repos='http://cran.r-project.org')`

#### Working directory

* `getwd()`
* `setwd()`

#### Getting Help

* `help(topic)`
* `?topic`
* `help.start()`

#### Reading and writing data ##

* `file.choose()`
* `read.csv`
* `read.table`
* `save`
* `load`

#### Creating Data

* `c(...)` concatenates elements into a vector by default.
* `seq(along=x)`
* `seq(from, to)`
* `rep(times)`
* `rnorm()`
* `list()`
* `cbind(...)` 
* `rbind(…)`

#### Working with data frames (and matrices) ##

* `str`
* `head` and `tail`
* `nrow` and `ncol`
* `names`
* `row.names`
* `which`

#### Vectors ##
R has six basic (i.e. atomic) vectors, they are:

* `character`
* `numeric`
* `integer`
* `logical`
* `complex`
* `raw`

Functions that are useful when working vectors include:

* `class`
* `length`
* `names`
* `unique`

There are a number of `as.xxx` functions that convert one type of vector to another. For example:

* `as.character`
* `as.numeric`
* `as.integer`
* `as.integer`
* `as.logical`
* `as.complex`
* `as.raw`

Similarly, you can test if a vector is of a particular type using a `is.xxx` function, namely:

* `is.character`
* `is.numeric`
* `is.integer`
* `is.integer`
* `is.logical`
* `is.complex`
* `is.raw`

#### Factors ##
There is another type, `factor`, that behaves like vectors but is only used within data frames. A `factor` is like a `integer` vector where each value corresponds to a level.

    > f <- factor(letters[1:6], levels=letters[1:12], labels=toupper(letters[1:12]))
    
    > f
    [1] A B C D E F
    Levels: A B C D E F G H I J K L
    
    > as.integer(f)
    [1] 1 2 3 4 5 6
    
    > as.character(f)
    [1] "A" "B" "C" "D" "E" "F"
    
    > table(f, useNA='ifany')
    f
    A B C D E F G H I J K L 
    1 1 1 1 1 1 0 0 0 0 0 0 


#### Descriptive Statistics ##

* `summary()`
* `min()`
* `max()`
* `mean()`
* `weighted.mean(x, w)` mean of x with weights w.
* `median()`
* `sd()`
* `sum()`
* `range()`
* `quantile(x)` sample quantiles corresponding to the given probabilities.
* `table()`
* `prop.table()`
* `var(x)` variance of x.
* `cov(x)` covariances of x.
* `cor(x)` correlation matrix of x.

#### Dates and Times

Dates without time are of class type `Date`, dates with time are of class `POSIXct`. The default string format for dates is `2012-01-01`, or `%Y-%m-%d`. Typical formats for dates and time include:

* `%a` Abbreviated weekday name.
* `%A` Full weekday name.
* `%b` Abbreviated month name.
* `%B` Full month name.
* `%d` Day of the month as an integer between 1 and 31.
* `%H` Hours between 00 and 23.
* `%I` Hours between 1 and 12.
* `%j` Day of the year between 1 and 366.
* `%m` Month between 1 and 12.
* `%M` Minute between 0 and 59.
* `%p` AM/PM indicator.
* `%S` Second as a decimal number.
* `%U` Week between 0 and 53. The first Sunday as day 1 of week 1.
* `%w` Weekday between 0 and 6 (0 is Sunday).
* `%W` Week between 0 and 53. The first Monday as day 1 of week 1.
* `%y` The year without century (e.g. 12).
* `%Y` The year with century (e.g. 2012).
* `%z` Offset from Greenwich time.
* `%Z` Timezone as a character string.

Functions to work with dates and times:

* `as.Date`
* `format`
* `as.POSIXct`

The [`lubridate`](http://www.jstatsoft.org/v40/i03/paper) package has been written to simply working with dates and times including functions to perform various calculations.

##### Working with Strings ##

* `paste`
* `nchar`
* `tolower`
* `toupper`
* `substr`
* `strsplit`

#### Misc

* `cut()`
* `sort()`
* `sample(x, size)`
* `round(x, n)` round x to n digits
* `ceiling(x)` round x up to the next integer.
* `floor(x)` round x down to the next integer.
