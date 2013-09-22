if(!require(slidify) | !require(slidifyLibraries) | !require(knitr)) {
	if(!require(devtools)) {
		install.packages('devtools','knitr')
		require(devtools)
	}
	install_github("slidify", "ramnathv")
	install_github("slidifyLibraries", "ramnathv")	
	require(slidify)
	require(slidifyLibraries)
}

#' Wrapper for \link{author} function in \code{slidify} package that will remove
#' git repository files.
#' 
#' @param deckdir path to new slide directory.
#' @param file filename of the new Rmd file.
#' @param git whether git repository should be created.
#' @param jekyll whether to include a \code{.nojekyll} file.
author <- function(deckdir, file, git=FALSE, jekyll=FALSE) {
	if(missing(file)) {
		slidify::author(deckdir)
	} else {
		dir <- tempdir()
		#slidify::author(dir)
		scaffold = system.file('skeleton', package = 'slidify')
		slidify:::copy_dir(scaffold, dir)
		file.copy(paste0(dir, '/index.Rmd'), paste0(deckdir, '/', file, '.Rmd'))
		unlink(paste0(dir, '/index.Rmd'))
		for(i in list.files(dir, include.dirs=FALSE)) {
			file.copy(paste0(dir, i), paste0(deckdir, i), overwrite=TRUE)			
		}
		for(i in dir(dir)) {
			slidify:::copy_dir(paste0(dir, '/', i), paste0(deckdir, '/', i))			
		}
		unlink(dir, recursive=TRUE)
	}
	if(!git) {
		# Delete the git files and directories
		todel <- list.files(deckdir, pattern='.git*', recursive=TRUE, all.files=TRUE)
		if(length(todel) > 0) {
			todel <- paste0(deckdir, '/', todel)
			unlink(todel, recursive=TRUE)
		}
	}
	if(!jekyll) {
		todel <- paste0(deckdir, '/.nojekyll')
		if(file.exists(todel)) {
			unlink(todel)
		}
	}
}

#' Wrapper to \link{slidify} function that uses a directory. It assumes that
#' the source is index.Rmd and output is index.html.
#' 
#' @param dir path to slide directory.
#' @param ... other parameters passed to \link{slidify}.
slidify <- function(dir, file, ...) {
	if(missing(dir)) {
		slidify::slidify(...)
	} else {
		oldwd <- setwd(dir)
		tryCatch({
			knit(input=paste0(file, '.Rmd'),
				 output=paste0(file, '.R'),
				 tangle=TRUE)
			slidify::slidify(inputFile=paste0(file, '.Rmd'), 
							 outputFile=paste0(file, '.html'))
			unlink(paste0(file, '.md'))
		}, finally={ setwd(oldwd) })
	}
}
