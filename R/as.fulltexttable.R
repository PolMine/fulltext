#' Convert object to input for fulltext (table format).
#' 
#' @param x The object to be converted.
#' @param headline A headline to prepend.
#' @param name An id inserted into tags.
#' @export as.fulltexttable
#' @importFrom methods is
#' @examples
#' library(polmineR)
#' library(fulltext)
#' use("polmineR")
#' P <- partition("GERMAPARLMINI", speaker = "Volker Kauder", date = "2009-11-10")
#' D <- as.fulltexttable(P, headline = "Volker Kauder (CDU)")
#' fulltext(D)
#' 
#' sd <- crosstalk::SharedData$new(D)
#' fulltext::fulltext(sd)
#' @importFrom polmineR get_token_stream as.utf8
#' @importFrom RcppCWB cl_struc2str cl_cpos2struc
as.fulltexttable <- function(x, headline = NULL, name = ""){
  if (!"slice" %in% is(x))stop("The function is implemented only for partition/subcorpus objects.")
  paragraphs <- lapply(
    seq_len(nrow(x@cpos)),
    function(i){
      ts <- get_token_stream(x@cpos[i,1]:x@cpos[i,2], p_attribute = "word", cpos = TRUE, corpus = x@corpus)
      df <- data.frame(
        id = as.integer(names(ts)),
        token = as.utf8(unname(ts), from = "latin1"),
        tag_before = " ",
        tag_after = "",
        stringsAsFactors = FALSE
      )
      whitespace <- grep("^[\\.;,:!?\\)\\(]$", df[["token"]], perl = TRUE)
      if (length(whitespace) > 0L) df[whitespace, "tag_before"] <- ""
      df[1,"tag_before"] <- ""
      
      s_attr <- RcppCWB::cl_struc2str(RcppCWB::cl_cpos2struc(x@cpos[i,1], corpus = x@corpus, s_attribute = "interjection"), corpus = x@corpus, s_attribute ="interjection")
      if (s_attr %in% c("speech", "FALSE")){
        df[1,"tag_before"] <- paste(df[1,"tag_before"], sprintf("<p style='display:none' name='%s'>", name), sep = "")
        df[nrow(df), "tag_after"] <- paste(df[nrow(df), "tag_after"], "</p>", sep = "")
      } else {
        df[1,"tag_before"] <- paste(df[1,"tag_before"], sprintf("<blockquote style='display:none' name ='%s'>", name), sep = "")
        df[nrow(df), "tag_after"] <- paste(df[nrow(df), "tag_after"], "</blockquote>", sep = "")
      }
      df
    }
  )
  y <- do.call(rbind, paragraphs)
  
  if (!is.null(headline)){
    headline_df <- data.frame(id = "", token = headline, tag_before = "", tag_after = "", stringsAsFactors = FALSE)
    headline_df[1, "tag_before"] <- sprintf("<h2 style='display:none' name='%s'>", name) 
    headline_df[nrow(headline_df), "tag_after"] <- "</h2>"
    y <- rbind(headline_df, y)
  }
  y
}

