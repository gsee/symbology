#' @importFrom data.table fread setnames rbindlist as.data.table
#' @importFrom XML xmlToList
#' @importFrom memoise memoize
#' @importFrom gdata read.xls
NULL


#' symbology package: \R functions to access symbol mapping files available on
#' the internet.
#' 
#' @name symbology
#' @aliases symbology symbology-package
#' @docType package
#' @author Garrett See \email{gsee000@@gmail.com}
#' @references 
#' \url{ftp://ftp.nysedata.com}
#' \url{http://www.batstrading.com/market_data/symbol_listing/csv/}
#' \url{ftp://ftp.nasdaqtrader.com}
#' \url{http://www.otcmarkets.com/reports/symbol_info.csv}
#' @keywords package IO
#' @examples
#' \dontrun{
#' ArcaSymbolMap() # downloads from internet
#' ArcaSymbolMap() # fast. retrieves from memory
#' ArcaSymbolMap(cache.ok=FALSE) # re-downloads
#' 
#' ArcaEdgeSymbolMap()
#' NyseSymbolMap()
#' NyseGroupSymbols()
#' OpenBookSymbolMap()
#' 
#' BatsSymbolMap()
#' 
#' nasdaqtraded()
#' nasdaqlisted()
#' otherlisted()
#' otclist()
#' otcbb()
#' 
#' shortSaleRuleStocks()
#' 
#' mpidlist()
#' MIC()
#' 
#' NYSEHolidays()
#' }
NA
