### Data-Source-Description
####---------------------------------------------------------------
####
#### This is the description for incubator challange question 3 with regards to the data source
#### By Yiyun L (4-18-2016) at Northwestern U
####
####----------------------------------------------------------------
###### Data source: Craigslist Chicago Website (chicago.craigslist.org)

###### A typical Craiglist rental post is usually listed similar to the following screensnap shot
![alt tag](https://github.com/lanyiyun/Data-Source-Description/blob/master/CraigslistChicago.png)

###### Data were scraped from the above web page starting from the most recent posts in a decending order.
###### Rental information regarding Title, Post Date, Price, Number of Bedrooms, Square Foots, Location, URL are obtained and stored in ###### the form of data frame in R for analysis. 
###### 
###### For example, scaped rental information will be aquired as follows
######-----------------------------------------------------------------------
| Title  | Date | Price | Bedrooms | SqFt | Location | URL |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| Spring Over To Westbrook  | 2016-04-19 09:45  | 620  | 2  | 750  | Westbrook Apts.  | https://chicago.craigslist.org/nwi/apa/5546370949.html  |
| ~Brand NEW Spacious 2BD/2BA with Private Entrance Door ~Summer  | 2016-04-19 09:44  | 1090 | 2  | 1076  | downtown evanston   | https://chicago.craigslist.org/nch/apa/5501391025.html  |
