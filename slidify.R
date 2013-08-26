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
#' @param deckdir path to new slide directory.
#' @param file filename of the new Rmd file.
#' @param git whether git repository should be created.
#' @param jekyll whether to include a \code{.nojekyll} file.
author <- function(deckdir, file, git=FALSE, jekyll=FALSE) {
	if(missing(file)) {
		slidify::author(deckdir)
	} else {
		oldwd <- setwd(deckdir)
		slidify::author(deckdir)
		setwd(oldwd)		
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
			slidify::slidify(inputFile=paste0(file, '.Rmd'), 
							 outputFile=paste0(file, '.html'))
			unlink(paste0(file, '.md'))
		}, finally={ setwd(oldwd) })
	}
}
