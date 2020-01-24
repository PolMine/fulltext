#' R-Package 'fulltext'.
#'
#' Leightweight fulltext display htmlwidget and corresponding functionality.
#'
#' @aliases fulltext-package fulltext
#' @docType package
#' @name fulltext
#' @rdname fulltext
#' @author Andreas Blaette
NULL



#' Fulltext output htmlwidget.
#' 
#' @param data The data that is passed to the JavaScript that generates the output. Expected to be
#' a list of lists that provide data on sections of text. Each of the sub-lists is to be a named
#' list of a character vector with the HTML element the section will be wrapped into, and 
#' a \code{data.frame} (or a list) with a column "token", and a column "id".
#' @param width The width of the widget.
#' @param height The height of the widget.
#' @param dialog The dialog.
#' @param box Logical, whether to put text into a box.
#' @importFrom htmlwidgets createWidget sizingPolicy
#' @importFrom crosstalk is.SharedData
#' @export fulltext
fulltext <- function(data, width = NULL, height = NULL, dialog = NULL, box = TRUE) {

  # If data is a named list, JavaScript will receive an object, and not an array, as required.
  if (!is.null(names(data[["paragraphs"]]))) data[["paragraphs"]] <- unname(data[["paragraphs"]])
                           
  if (is.SharedData(data)) {
    # Using Crosstalk
    key <- data$key()
    group <- data$groupName()
    data <- data$origData()
  } else if (is.data.frame(data)){
    # Not using Crosstalk
    key <- NULL
    group <- NULL
  } else {
    stop("Argument 'data' needs to be either a data.frame or a SharedData object.")
  }
  
  
  
  createWidget(
    "fulltext",
    package = "fulltext",
    x = list(
      data = data,
      settings = list(
        dialog = if (is.null(dialog)) FALSE else TRUE,
        box = box,
        crosstalk_key = key,
        crosstalk_group = group,
        codeSelection = if (!is.null(dialog)) if ("choices" %in% names(dialog)) dialog[["choices"]],
        callbackFunction = if (!is.null(dialog)) if ("callback" %in% names(dialog)) htmlwidgets::JS(dialog[["callback"]])
      )
    ),
    width = width,
    height = height,
    dependencies = crosstalk::crosstalkLibs(),
    sizingPolicy(browser.fill = TRUE,
                 viewer.defaultHeight = 800L,
                 browser.defaultHeight = 800L,
                 viewer.fill = TRUE,
                 knitr.figure = FALSE,
                 knitr.defaultWidth = 800L,
                 knitr.defaultHeight = 400L
                 )
    )
}


#' Render and show fulltext output in shiny apps.
#' 
#' @param outputId Output variable to read the value from.
#' @param width The width of the widget.
#' @param height The height of the widget.
#' @param expr An expression (...).
#' @param env The environment in which to evaluate expr.
#' @param quoted Is expr a quoted expression (with quote())? This is useful if
#'   you want to save an expression in a variable.
#' @export fulltextOutput
#' @importFrom htmlwidgets shinyWidgetOutput
#' @rdname shiny
fulltextOutput <- function(outputId, width = "100%", height = "100%") {
  shinyWidgetOutput(outputId, "fulltext", width, height, package = "fulltext")
}
#' @export renderFulltext
#' @importFrom htmlwidgets shinyRenderWidget
#' @rdname shiny
renderFulltext <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, fulltextOutput, env, quoted = TRUE)
}
