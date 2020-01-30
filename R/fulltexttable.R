#' Fulltexttable class and methods
#' 
#' @name fulltexttable
NULL

setOldClass("fulltexttable")

#' @param x A \code{fulltexttable} object.
#' @param column The column to look up.
#' @param regex A regular expression.
#' @rdname fulltexttable
setMethod("split", "fulltexttable", function(x, column = "tag_before", regex){
  breaks <- cut(1:nrow(x), unique(c(grep(regex, x[[column]]), nrow(x))),right = FALSE)
  y <- split(as.data.frame(x), breaks)
  lapply(y, function(y){ class(y) <- c("fulltexttable", class(y)); y})
})
