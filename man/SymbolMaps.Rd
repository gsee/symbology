% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/ExchSymbolMaps.R
\name{ArcaSymbolMap}
\alias{ArcaEdgeSymbolMap}
\alias{ArcaSymbolMap}
\alias{BatsSymbolMap}
\alias{NYSEHolidays}
\alias{NyseGroupSymbols}
\alias{NyseSymbolMap}
\alias{OpenBookSymbolMap}
\alias{mpidlist}
\alias{nasdaqlisted}
\alias{nasdaqtraded}
\alias{otcbb}
\alias{otclist}
\alias{otherlisted}
\alias{shortSaleRuleStocks}
\title{Symbol Maps}
\usage{
ArcaSymbolMap(cache.ok = TRUE)

OpenBookSymbolMap(cache.ok = TRUE)

ArcaEdgeSymbolMap(cache.ok = TRUE)

BatsSymbolMap(cache.ok = TRUE)

NyseSymbolMap(cache.ok = TRUE)

NyseGroupSymbols(cache.ok = TRUE)

shortSaleRuleStocks(...)

NYSEHolidays(...)

otclist(...)

mpidlist(...)

otherlisted(...)

nasdaqlisted(...)

nasdaqtraded(...)

otcbb(...)
}
\arguments{
\item{cache.ok}{TRUE by default. if FALSE, file will be redownloaded even if
it is already cached.}

\item{...}{introduced by \code{memoize()} only.  There are no dots in the
actual anonymous functions.}
}
\value{
data.table
}
\description{
fetch symbol mapping files from the ftps of various exchanges.  Currently
only U.S. equity exchanges.
}
\details{
The functions cache results.  Currently a few functions use
"standard" memoization and the rest use the memoise package.
I might remove that dependency one day.
}
\author{
Garrett See
}
\references{
\url{ftp://ftp.nysedata.com}
\url{http://www.batstrading.com/market_data/symbol_listing/csv/}
\url{ftp://ftp.nasdaqtrader.com}
\url{http://www.otcmarkets.com/reports/symbol_info.csv}
}
\seealso{
\code{TTR::stockSymbols}
}

