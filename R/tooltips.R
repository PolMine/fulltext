#' @include fulltexttable.R
NULL


#' Add tooltips to fulltexttable
#' 
#' @param tooltips A named list or character vector with the tooltips to be
#'   displayed. The names of the list/vector are expected to be tokens.
#' @param .Object A \code{fulltexttable} object.
#' @param ... What comes in via the three dots will be turned into a list and
#'   merged with the tooltips argument.
#' @importMethodsFrom polmineR tooltips
#' @examples
#' \dontrun{
#' library(polmineR)
#' library(fulltext)
#' use("polmineR")
#' 
#' k <- corpus("GERMAPARLMINI") %>%
#'   subset(speaker == "Volker Kauder") %>%
#'   subset(date == "2009-11-10") %>%
#'   as.fulltexttable(headline = "Volker Kauder (CDU)", display = "block")
#'   
#' k <- tooltips(
#'   k,
#'   Opposition = "Dauerlooser",
#'   Regierung = "Vollchecker",
#'   Regierungserklärung = "Gewinnerprogramm"
#' )
#' fulltext(k, box = FALSE)
#' }
#' @rdname tooltips
setMethod("tooltips", "fulltexttable", function(.Object, tooltips = list(), ...){
  ttips <- list(...)
  ttips <- c(ttips, as.list(tooltips))
  for (x in names(ttips)){
    i <- which(.Object[["token"]] == x)
    .Object[i,"tag_before"] <- sprintf('%s<span class="tooltip">', .Object[i,"tag_before"])
    .Object[i,"tag_after"] <- sprintf('<span class="tooltiptext">%s</span></span>%s', ttips[[x]], .Object[i,"tag_after"])
  }
  .Object
})