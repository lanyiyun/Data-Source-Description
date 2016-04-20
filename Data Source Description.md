Data-Source-Description
================================================
This is the description for the incubator challange question 3 with regards to the data source
*(By Yiyun L, 4-18-2016)*


Data Source: Craigslist Chicago Website 
----------------------------------------------------------------

A typical Craiglist [(chicago.craigslist.org)](https://chicago.craigslist.org) rental post is usually listed similar to the following screen snapshot

![alt tag](https://github.com/lanyiyun/Data-Source-Description/blob/master/ChicagoCraigslist.png)

Data Acquisition
-----------
Data were scraped from the above web page (Install: `devtools::install_github("adletaw/craigr")`) starting from the most recent posts in a decending order of post date (as shown below). Rental information regarding `Title`, `Post Date`, `Price`, `Number of Bedrooms`, `Square Foots`, `Location`, `URL` are obtained and stored in the form of data frame in R for analysis. 
 
The first record corresponds data from the screen snapshot shown above.


    ##                                                                               Title             Date Price 
    ##1                                                           Spring Over To Westbrook 2016-04-19 09:45   620       
    ##2             UNMATCHED URBAN EXPERIENCE... (architect designed 3BR live/work LOFTS) 2016-04-19 09:44  3475       
    ##3                     ~Brand NEW Spacious 2BD/2BA with Private Entrance Door ~Summer 2016-04-19 09:44  1090       
    ##4             BALCONY / WD / SS / HDWD / POOL / SPA / MODERN / WALK IN CLOSET / HUGE 2016-04-19 09:44  1899      
    ##5             HUGE LAYOUT / OPEN / LARGE WINDOWS / HARDWOOD / WASHER/DRYER / CLOSETS 2016-04-19 09:44  2249      
    ##6                 MAGNIFICIENT GOLD COAST LIVING / SS / 9' CEILING / WD / HDWD / NEW 2016-04-19 09:44  3589      

    ##    Bedrooms SqFt                                Location                                                     URL
    ##1      2      750                          Westbrook Apts. https://chicago.craigslist.org/nwi/apa/5546370949.html
    ##2      3     1803                        downtown evanston https://chicago.craigslist.org/nch/apa/5501391025.html
    ##3      2     1076                     Willow Creek Estates https://chicago.craigslist.org/nwi/apa/5502823490.html
    ##4      1     <NA>    LAKESHORE EAST / LOOP / STREETERVILLE https://chicago.craigslist.org/chc/apa/5526457976.html
    ##5      1     <NA>  STREETERVILLE / RIVERNORTH / GOLD COAST https://chicago.craigslist.org/chc/apa/5528228713.html
    ##6      2     <NA>      GOLD COAST / RIVER NORTH / OLD TOWN https://chicago.craigslist.org/chc/apa/5528229330.html

`Location` information was used to acquire `latitude` and `longtitude` from Google API with JSON so that locations can be correctly pinned on a Google map of Chicago Metropolitan Area. 
