#' @include as.fulltexttable.R
NULL

#' Assign new name
#' 
#' @param x Input object.
#' @param name New name to assign.
#' @param ... Further arguments.
#' @rdname rename
setGeneric("rename", function(x, ...) standardGeneric("rename"))

#' @export rename
#' @rdname rename
setMethod("rename", "fulltexttable", function(x, name){
  x <- as.data.frame(x)
  i <- grep("name='.*?'", x[["tag_before"]])
  x[i, "tag_before"] <- gsub("name='.*?'", sprintf("name='%s'", name), x[i,"tag_before"])
  x
})


#' @export rename
#' @rdname rename
setMethod("rename", "list", function(x, name){
  y <- lapply(1:length(x), function(i) rename(x[[i]], name = name[[i]]))
  names(y) <- name
  y
})


