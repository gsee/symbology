Contains functions that download symbol map files from various equity venues  

````
ArcaSymbolMap()
ArcaEdgeSymbolMap()
NyseSymbolMap()
NyseGroupSymbols()
OpenBookSymbolMap()

BatsSymbolMap()

nasdaqtraded()
nasdaqlisted()
otherlisted()
otclist()
otcbb()

shortSaleRuleStocks()

mpidlist()
MIC()

NYSEHolidays()
````

These functions use memoization to cache results so that the next time they are
called the results can be returned from memory.  Some of the functions (the
ones that begin with a lowercase letter for the most part) accomplish this using 
the [memoise](https://github.com/hadley/memoise) package.  You can view the 
source code of those functions like this, for example: 
`environment(nasdaqlisted)$f`.  To force a download of the data, use 
`memoise::forget`.  For example, `memoise::forget(nasdaqlisted)` would force 
`nasdaqlisted()` to re-download the data the next time it is called.  The other
functions have a `cache.ok` argument.  For example, 
`ArcaSymbolMap(cache.ok=FALSE)` will force a download of the file.

References:  
[ftp://ftp.nysedata.com](ftp://ftp.nysedata.com)  
[http://www.batstrading.com/market_data/symbol_listing/csv/](http://www.batstrading.com/market_data/symbol_listing/csv/)  
[ftp://ftp.nasdaqtrader.com](ftp://ftp.nasdaqtrader.com)  
[http://www.otcmarkets.com/reports/symbol_info.csv](http://www.otcmarkets.com/reports/symbol_info.csv)  

<a href="http://www.wtfpl.net/"><img
       src="http://www.wtfpl.net/wp-content/uploads/2012/12/wtfpl-badge-4.png"
       width="80" height="15" alt="WTFPL" /></a>
