#' @include as.fulltexttable.R
NULL


#' Retag fulltexttable
#' 
#' @param x A \code{fulltexttable} object of a list of \code{fulltexttable} objects.
#' @param regex A regular expression to detect whether a tag should be changed.
#' @param old The old tag.
#' @param ... Further arguments.
#' @param new A new tag.
#' @export retag
#' @rdname retag
setGeneric("retag", function(x, ...) standardGeneric("retag"))


#' @rdname retag
setMethod("retag", "fulltexttable", function(x, regex, old, new){
  if (grepl(regex, x$token[1])){
    x[1,"tag_before"] <- gsub(sprintf("<%s\\s+(.*?)>", old), sprintf("<%s \\1>", new), x[1,"tag_before"])
    x[nrow(x),"tag_after"] <- gsub(sprintf("</%s>", old), sprintf("</%s>", new), x[nrow(x),"tag_after"])
  }
  x
})

#' @rdname retag
setMethod("retag", "list", function(x, regex, old, new){
  lapply(x, retag, regex = regex, old = old, new = new)
})


