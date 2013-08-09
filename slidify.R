if(!require(slidify) | !require(slidifyLibraries)) {
	if(!require(devtools)) {
		install.packages('devtools')
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
#' @param dir path to new slide directory.
#' @param git whether git repository should be created.
#' @param jekyll whether to include a \code{.nojekyll} file.
author <- function(dir, git=FALSE, jekyll=FALSE) {
	slidify::author(dir)
	if(!git) {
		# Delete the git files and directories
		todel <- list.files(dir, pattern='.git*', recursive=TRUE, all.files=TRUE)
		if(length(todel) > 0) {
			todel <- paste0(dir, '/', todel)
			unlink(todel)
		}
	}
	if(!jekyll) {
		unlink(paste0(dir, '/.nojekyll'), recursive=TRUE)
	}
}

#' Wrapper to \link{slidify} function that uses a directory. It assumes that
#' the source is index.Rmd and output is index.html.
#' 
#' @param dir path to slide directory.
#' @param ... other parameters passed to \link{slidify}.
slidify <- function(dir, ...) {
	if(missing(dir)) {
		slidify::slidify(...)
	} else {
		slidify::slidify(inputFile=paste0(dir, '/index.Rmd'),
						 outputFile=paste0(dir, '/index.html'))
	}
}
