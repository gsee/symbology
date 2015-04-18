#' MIC
#' 
#' Market Identifier Codes
#' 
#' Download a spreadsheet with Market Identifier Codes and coerce to data.table.
#' This is actually a closure.  The results are cached, so that if you call this
#' funciton twice, it will return the cached values the second time instead of
#' redownloading the file.
#' @param cache.ok TRUE by default. If FALSE, the file will be redownloaded
#' @param verbose FALSE by default. Do you want to see messages telling you
#'   whether the cached values were used or not?
#' @return data.table
#' @author gsee
#' @examples
#' \dontrun{
#' MIC() # downloads file
#' MIC() # recalls cached data.table
#' }
#' @export
MIC <- local({
  dat <- NULL
  f <- function(cache.ok=TRUE, verbose=FALSE) {
    if (!is.null(dat) && isTRUE(cache.ok)) {
      if (verbose) message("Using cached MIC")
      return(dat)
    }
    if (verbose) message("Building MIC")
    xls <- tempfile()
    download.file("http://www.swift.com/customforms/downloads/ISO10383_MIC.xls",
                  destfile=xls, quiet=TRUE, mode="wb")
    dat <<- as.data.table(read.xls(xls=xls, sheet=3, stringsAsFactors=FALSE, 
                           check.names=FALSE))
    dat
  }
})
