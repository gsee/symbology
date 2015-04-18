#' Symbol Maps
#' 
#' fetch symbol mapping files from the ftps of various exchanges.  Currently 
#' only U.S. equity exchanges.
#' 
#' The functions cache results.  Currently a few functions use
#' "standard" memoization and the rest use the memoise package.
#' I might remove that dependency one day.
#'
#' @param cache.ok TRUE by default. if FALSE, file will be redownloaded even if
#'   it is already cached.
#' @param ... introduced by \code{memoize()} only.  There are no dots in the
#'   actual anonymous functions.
#' @return data.table
#' @author Garrett See
#' @seealso \code{TTR::stockSymbols}
#' @references 
#' \url{ftp://ftp.nysedata.com}
#' \url{http://www.batstrading.com/market_data/symbol_listing/csv/}
#' \url{ftp://ftp.nasdaqtrader.com}
#' \url{http://www.otcmarkets.com/reports/symbol_info.csv}
#' @export
#' @rdname SymbolMaps
ArcaSymbolMap <- local({
  dat <- NULL
  function(cache.ok=TRUE) {
    if (isTRUE(cache.ok) & !is.null(dat)) return(dat)
    tmpfile <- tempfile()
    download.file("ftp://ftp.nysedata.com/ARCASymbolMapping/ARCASymbolMapping.txt", 
                  destfile=tmpfile, quiet=TRUE)
    x <- fread(tmpfile)
    s <- c("Symbol", "CQS_Symbol", "SymbolIndexNumber", "NYSEMarket", 
           "ListedMarket", "TickerDesignation", "UOT", "PriceScaleCode", 
           "NYSE_SystemID", "BBG_BSID", "BBG_GlobalID")
    setnames(x, seq_along(s), s)
    dat <<- x
    dat
  }
})

# @examples 
# \dontrun{ 
#   OpenBookSymbolMap(cache.ok=FALSE)
#   OpenBookSymbolMap()  # fast; returns cached data
# }
#' @export
#' @rdname SymbolMaps
OpenBookSymbolMap <- local({
  dat <- NULL
  function(cache.ok=TRUE) {
    if (isTRUE(cache.ok) & !is.null(dat)) return(dat)
    L <- xmlToList("ftp://ftp.nysedata.com/OpenBook/SymbolMapping/SymbolMap.xml")
    dat <<- rbindlist(L)
    dat
  }
})

# Get Arca Edge symbol mapping (GlobalOTC)
#' @export
#' @rdname SymbolMaps
ArcaEdgeSymbolMap <- local({
  dat <- NULL
  function(cache.ok=TRUE) {
    if (isTRUE(cache.ok) & !is.null(dat)) return(dat)
    tmpfile <- tempfile()
    download.file("ftp://ftp.nysedata.com/ARCAEdgeSymbolMapping/GlobalOTCSymbolMapping.txt", 
                  destfile=tmpfile, quiet=TRUE)
    x <- fread(tmpfile)
    s <- c("Symbol", "CQS_Symbol", "SymbolIndexNumber", "NYSEMarket", 
           "ListedMarket", "TickerDesignation", "UOT", "PriceScaleCode", 
           "NYSE_SystemID", "BBG_BSID", "BBG_GlobalID")
    setnames(x, seq_along(s), s)
    dat <<- x
    dat
  }
})

#' @export
#' @rdname SymbolMaps
BatsSymbolMap <- local({
  dat <- NULL
  function(cache.ok=TRUE) {
    if (isTRUE(cache.ok) & !is.null(dat)) return(dat)
    tmpfile <- tempfile()
    download.file("http://www.batstrading.com/market_data/symbol_listing/csv/",
                  destfile=tmpfile, quiet=TRUE)
    dat <<- fread(tmpfile)
    dat
  }
})

#' @export
#' @rdname SymbolMaps
NyseSymbolMap <- local({
  dat <- NULL
  function(cache.ok=TRUE) {
    if (isTRUE(cache.ok) & !is.null(dat)) return(dat)
    # Get NYSE symbol mapping
    tmpfile <- tempfile()
    download.file("ftp://ftp.nysedata.com/NYSESymbolMapping/NYSESymbolMapping_NMS.txt",
                  destfile=tmpfile, quiet=TRUE)
    x <- fread(tmpfile, colClasses="character")
    s <- c("Symbol", "CQS_Symbol", "SymbolIndexNumber", "NYSEMarket", 
           "ListedMarket", "TickerDesignation", "UOT", "PriceScaleCode", 
           "NYSE_SystemID", "BBG_BSID", "BBG_GlobalID")
    setnames(x, seq_along(s), s)
    dat <<- x
    dat
  }
})

#' @export
#' @rdname SymbolMaps
NyseGroupSymbols <- local({
  dat <- NULL
  function(cache.ok=TRUE) {
    if (cache.ok & !is.null(dat)) return(dat)
    tmpfile <- tempfile()
    download.file("ftp://ftp.nysedata.com/PublicData/NYSEGroupSymbols/NYSEGroupSymbols.txt", destfile=tmpfile, quiet=TRUE)
    fread(tmpfile, header=FALSE)
  }
})

#' @export
#' @rdname SymbolMaps
shortSaleRuleStocks <- memoise::memoise(function(trade.date=ptd(ntd())) {
  tt <- tempfile()
  on.exit(unlink(tt), add=TRUE)
  download.file(paste0("ftp://ftp.nasdaqtrader.com/SymbolDirectory/",
                       "shorthalts/shorthalts",
                       format(as.Date(trade.date), "%Y%m%d.txt")), tt, 
                quiet=TRUE)
  lines <- head(readLines(tt), -1)
  data.table(read.csv(text=lines, stringsAsFactors=FALSE), key="Symbol")
})  


#' @export
#' @rdname SymbolMaps
NYSEHolidays <- memoise::memoise(function() {
  read.delim(text=readLines("ftp://ftp.nysedata.com/PublicData/NYSEHolidays/NYSEHolidays.txt"), sep="|", header=FALSE, stringsAsFactors=FALSE)
})


#' @export
#' @rdname SymbolMaps
otclist <- memoise::memoise(function() {
  tt <- tempfile(tmpdir = "/dev/shm")
  on.exit(unlink(tt), add=TRUE)
  download.file("ftp://ftp.nasdaqtrader.com/SymbolDirectory/otclist.txt", tt,
                quiet=TRUE)
  dat <- fread(tt)
  dat[-nrow(dat)] # remove footer
})
# otclist()[, .N, by=`Market Category`]
# otclist()[`Market Category`=="BB"]

#' @export
#' @rdname SymbolMaps
mpidlist <- memoise::memoise(function() {
  tt <- tempfile(tmpdir = "/dev/shm")
  on.exit(unlink(tt), add=TRUE)
  download.file("ftp://ftp.nasdaqtrader.com/SymbolDirectory/mpidlist.txt", tt,
                quiet=TRUE)
  lines <- head(readLines(tt), -1)
  as.data.table(read.delim(text=lines, sep="|", stringsAsFactors=FALSE))
})

#' @export
#' @rdname SymbolMaps
otherlisted <- memoise::memoise(function() {
  tt <- tempfile(tmpdir = "/dev/shm")
  on.exit(unlink(tt), add=TRUE)
  download.file("ftp://ftp.nasdaqtrader.com/SymbolDirectory/otherlisted.txt", 
                tt, quiet=TRUE)
  lines <- head(readLines(tt), -1)
  as.data.table(read.delim(text=lines, sep="|", stringsAsFactors=FALSE))
})

#' @export
#' @rdname SymbolMaps
nasdaqlisted <- memoise::memoise(function() {
  tt <- tempfile(tmpdir = "/dev/shm")
  on.exit(unlink(tt), add=TRUE)
  download.file("ftp://ftp.nasdaqtrader.com/SymbolDirectory/nasdaqlisted.txt", 
                tt, quiet=TRUE)
  lines <- head(readLines(tt), -1)
  as.data.table(read.delim(text=lines, sep="|", stringsAsFactors=FALSE))
})

#' @export
#' @rdname SymbolMaps
nasdaqtraded <- memoise::memoise(function() {
  tt <- tempfile(tmpdir = "/dev/shm")
  on.exit(unlink(tt), add=TRUE)
  download.file("ftp://ftp.nasdaqtrader.com/SymbolDirectory/nasdaqtraded.txt", 
                tt, quiet=TRUE)
  lines <- head(readLines(tt), -1)
  as.data.table(read.delim(text=lines, sep="|", stringsAsFactors=FALSE))
})

#' @export
#' @rdname SymbolMaps
otcbb <- memoise::memoise(function() {
  fread("http://www.otcmarkets.com/reports/symbol_info.csv", showProgress=FALSE)
})
