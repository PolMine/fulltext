#' @include fulltexttable.R
NULL

#' Highlight tokens in fulltexttable
#' 
#' @param .Object A \code{fulltexttable} object.
#' @param annotations A \code{data.frame} that needs to have columns "color",
#'   "start" and "end".
#' @param ... See examples.
#' @importMethodsFrom polmineR highlight
#' @export highlight
#' @rdname highlight_fulltexttable
#' @examples
#' \dontrun{
#' library(polmineR)
#' library(fulltext)
#' use("polmineR")
#' kau <- corpus("GERMAPARLMINI") %>%
#'   subset(speaker == "Volker Kauder") %>%
#'   subset(date == "2009-11-10")
#' f <- as.fulltexttable(kau, headline = "Volker Kauder (CDU)", display = "block")
#' f <- highlight(f, yellow = "Opposition")
#' 
#' fulltext(f, box = FALSE)
#' }
setMethod("highlight", "fulltexttable", function(.Object, annotations = NULL, ...){
  scheme <- list(...)
  if (!is.null(annotations)){
    for (i in 1L:nrow(annotations)){
      for (cpos in annotations[i, "start"]:annotations[i, "end"]){
        j <- which(.Object[["id"]] == cpos)
        .Object[j, "tag_before"] <- sprintf("%s<span style='background-color:%s'>", .Object[j, "tag_before"], annotations[i, "color"])
        .Object[j, "tag_after"] <- sprintf("</span>%s", .Object[j, "tag_after"])
      }
    }
  }
  
  for (color in names(scheme)){
    i <- unique(unlist(lapply(scheme[[color]], function(x) which(.Object[["token"]] == x))))
    .Object[i, "tag_before"] <- sprintf("%s<span style='background-color:%s'>", .Object[i, "tag_before"], color)
    .Object[i, "tag_after"] <- sprintf("</span>%s", .Object[i, "tag_after"])
  }
  .Object
})