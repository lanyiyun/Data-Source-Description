# Introduction
# Script was writen using RStudio and answers to the challanges are stored in Q variables (e.g. Q1 for question 1)
# 
# By Yiyun L (4-16-2016) @ Northwestern U
#
# Download and read data
Data2011url <- "https://data.nola.gov/api/views/28ec-c8d6/rows.csv?accessType=DOWNLOAD"
Data2012url <- "https://data.nola.gov/api/views/rv3g-ypg7/rows.csv?accessType=DOWNLOAD"
Data2013url <- "https://data.nola.gov/api/views/5fn8-vtui/rows.csv?accessType=DOWNLOAD"
Data2014url <- "https://data.nola.gov/api/views/jsyu-nz5r/rows.csv?accessType=DOWNLOAD"
Data2015url <- "https://data.nola.gov/api/views/w68y-xmk6/rows.csv?accessType=DOWNLOAD"
Data2011FileName <- "Data2011.csv"
Data2012FileName <- "Data2012.csv"
Data2013FileName <- "Data2013.csv"
Data2014FileName <- "Data2014.csv"
Data2015FileName <- "Data2015.csv"
DataFolder <- "./New Orleans Open Data/"
dir.create(DataFolder)
download.file(url = Data2011url, destfile = paste(DataFolder, Data2011FileName, sep = ""))
download.file(url = Data2012url, destfile = paste(DataFolder, Data2012FileName, sep = ""))
download.file(url = Data2013url, destfile = paste(DataFolder, Data2013FileName, sep = ""))
download.file(url = Data2014url, destfile = paste(DataFolder, Data2014FileName, sep = ""))
download.file(url = Data2015url, destfile = paste(DataFolder, Data2015FileName, sep = ""))
Data2011 <- read.csv(paste(DataFolder, Data2011FileName, sep = ""))
Data2012 <- read.csv(paste(DataFolder, Data2012FileName, sep = ""))
Data2013 <- read.csv(paste(DataFolder, Data2013FileName, sep = ""))
Data2014 <- read.csv(paste(DataFolder, Data2014FileName, sep = ""))
Data2015 <- read.csv(paste(DataFolder, Data2015FileName, sep = ""))
DataAll <- rbind(Data2011, Data2012, Data2013, Data2014, Data2015)
options(digits=10) # decimal precision: 10

# Q1: fraction of calls: most common type
Q1 <- summary(DataAll, maxsum = 10)

# Q2: median response time in seconds
DispatchTime <- strptime(DataAll$TimeDispatch, format = "%m/%d/%Y %I:%M:%S %p") 
ArrivalTime <- strptime(DataAll$TimeArrive, format = "%m/%d/%Y %I:%M:%S %p") 
ResponseTime <- ArrivalTime - DispatchTime
Q2 <- as.numeric(median(ResponseTime, na.rm = TRUE))

# Q3: difference between average response times of the longest and shortest among districts
ResponseTimeInDistrict <- aggregate(ResponseTime, by = list(DataAll$PoliceDistrict), FUN = "mean", na.rm = TRUE)
Q3 <- max(as.numeric(ResponseTimeInDistrict$x)) - min(as.numeric(ResponseTimeInDistrict$x))

# Q4: the largest ratio of the conditional probability of an event type to the unconditional probability
ConditionalEvent <- table(DataAll$TypeText, DataAll$PoliceDistrict)
ConditionalEvent <- ConditionalEvent[,2:9] # ignore district 0 event
TotalEvent <- margin.table(ConditionalEvent,1)
ConditionalEvent100 <- ConditionalEvent[TotalEvent>100,] # ignore events < 100
UnconditionalFreq <- prop.table(ConditionalEvent100)
DistrictFreq <- prop.table(ConditionalEvent100,2)
Ratio <- DistrictFreq/UnconditionalFreq
Q4 <- Ratio[which.max(Ratio)]

# Q5: the largest percentage decrease in volume between 2011 and 2015
EventOccur2011 <- as.data.frame(table(Data2011$TypeText))
EventOccur2015 <- as.data.frame(table(Data2015$TypeText))
SharedEvent <- merge(x=EventOccur2011, y=EventOccur2015, by.x = 'Var1', by.y = 'Var1')
SharedEvent['2011 Percentage'] <- SharedEvent$Freq.x/sum(EventOccur2011$Freq)
SharedEvent['2015 Percentage'] <- SharedEvent$Freq.y/sum(EventOccur2015$Freq)
SharedEvent['Decrease from 2011 to 2015'] <- SharedEvent$`2011 Percentage` - SharedEvent$`2015 Percentage`
SharedEvent['fraction of 2011'] <- SharedEvent$`Decrease from 2011 to 2015`/SharedEvent$`2011 Percentage`
Q5 <- SharedEvent$`fraction of 2011`[which.max(SharedEvent$`Decrease from 2011 to 2015`)]

# Q6: Find the disposition whose fraction of that hour's disposition varies the most over a typical day. 
CreateTime <- strptime(DataAll$TimeCreate, format = "%m/%d/%Y %I:%M:%S %p")
DispositionTable <- prop.table(table(CreateTime$h, DataAll$Disposition),1)
DispositionMax <- apply(DispositionTable, 2, max)
DispositionMin <- apply(DispositionTable, 2, min)
Q6 <- max(DispositionMax - DispositionMin)

# Q7: the largest district measured as an ellipse
DataAll$Location[DataAll$PoliceDistrict==0]
temp <- as.data.frame.factor(DataAll$Location)
test <- as.character(temp[,1])
unknow <- lapply(strsplit(gsub("[(*)]",'',test),","), as.numeric)
list1 <- mapply(append, unknow, DataAll$PoliceDistrict)
vec <- as.data.frame(list1)
DistrictLocation <- data.frame(t(vec))
rownames(DistrictLocation) = c(1:length(list1))
colnames(DistrictLocation) = c("Latitude", "Longitude", "District")
# clear non-sense location
LatitudeSD <- aggregate(DistrictLocation$Latitude, by = list(DistrictLocation$District), FUN = "sd", na.rm = TRUE)
CleanData <- DistrictLocation[(DistrictLocation$Latitude > 1) & (DistrictLocation$Longitude < -70),]
LatitudeSD <- aggregate(CleanData$Latitude, by = list(CleanData$District), FUN = "sd", na.rm = TRUE)
LongitudeSD <- aggregate(CleanData$Longitude, by = list(CleanData$District), FUN = "sd", na.rm = TRUE)
LatitudePerDegree <- 111
LongitudePerDegree <- 96
EllipseArea <- pi*LatitudeSD$x*LatitudePerDegree*LongitudeSD$x*LongitudePerDegree
Q7 <- max(EllipseArea[c(2:9)]) # ignore district 0

# Q8: find the type of call whose most common priority is the smallest fraction of all calls of that type
PriorityTable <- table(DataAll$TypeText, DataAll$Priority)
PriorityProp1 <- prop.table(PriorityTable,1)
temp <- levels(DataAll$Priority)
PriorityCommon <- temp[max.col(PriorityTable)]
PriorityProp1 <- prop.table(PriorityTable,1)
PriorityProp2 <- prop.table(PriorityTable,2)
CallTotal <- margin.table(PriorityTable,2)

# The Percentage of Most Common Call Type among all calls of that type
MostCommonPercentage <- apply(PriorityTable, 1, max)/CallTotal[apply(PriorityTable, 1, which.max)]

# Is it the smallest?
CallArray <- which(PriorityProp2[,]>0, arr.ind = T)
CallDataFrame <- as.data.frame(cbind(PriorityProp2[CallArray],CallArray[,2]))
colnames(CallDataFrame) <- c("percentage", "priority type")
MinOfAllCalls <- aggregate(CallDataFrame$percentage, by = list(CallDataFrame$`priority type`), FUN = "min", na.rm = TRUE)
x <- as.data.frame(cbind(MostCommonPercentage, rownames(MostCommonPercentage)))
Minx <- aggregate(as.numeric(as.character(x$MostCommonPercentage)), by = list(x$V2), FUN = "min", na.rm = TRUE)
Q8 <- min(Minx$x)
