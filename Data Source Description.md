### Data-Source-Description
================================================
This is the description for incubator challange question 3 with regards to the data source
Data source: Craigslist Chicago Website (chicago.craigslist.org)
-------

##### A typical Craiglist rental post is usually listed similar to the following screensnap shot
![alt tag](https://github.com/lanyiyun/Data-Source-Description/blob/master/CraigslistChicago.png)
#####
##### Data were scraped from the above web page starting from the most recent posts in a decending order.
##### Rental information regarding Title, Post Date, Price, Number of Bedrooms, Square Foots, Location, URL 
##### are obtained and stored in the form of data frame in R for analysis. 
##### 
##### For example, scaped rental information will be aquired as follows


    ##                                                                               Title             Date Price Bedrooms SqFt
    ##1                                                           Spring Over To Westbrook 2016-04-19 09:45   620        2  750
    ##2             UNMATCHED URBAN EXPERIENCE... (architect designed 3BR live/work LOFTS) 2016-04-19 09:44  3475        3 1803
    ##3                     ~Brand NEW Spacious 2BD/2BA with Private Entrance Door ~Summer 2016-04-19 09:44  1090        2 1076
    ##4             BALCONY / WD / SS / HDWD / POOL / SPA / MODERN / WALK IN CLOSET / HUGE 2016-04-19 09:44  1899        1 <NA>
    ##5             HUGE LAYOUT / OPEN / LARGE WINDOWS / HARDWOOD / WASHER/DRYER / CLOSETS 2016-04-19 09:44  2249        1 <NA>
    ##6                 MAGNIFICIENT GOLD COAST LIVING / SS / 9' CEILING / WD / HDWD / NEW 2016-04-19 09:44  3589        2 <NA>

    ##                                     Location                                                    URL
    ##1                             Westbrook Apts. https://chicago.craigslist.org/nwi/apa/5546370949.html
    ##2                           downtown evanston https://chicago.craigslist.org/nch/apa/5501391025.html
    ##3                        Willow Creek Estates https://chicago.craigslist.org/nwi/apa/5502823490.html
    ##4       LAKESHORE EAST / LOOP / STREETERVILLE https://chicago.craigslist.org/chc/apa/5526457976.html
    ##5     STREETERVILLE / RIVERNORTH / GOLD COAST https://chicago.craigslist.org/chc/apa/5528228713.html
    ##6         GOLD COAST / RIVER NORTH / OLD TOWN https://chicago.craigslist.org/chc/apa/5528229330.html

