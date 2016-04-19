# Initialization
install.packages("ggmap")
install.packages("mapproj")
install.packages("Rmisc")
library(gridBase)
library(ggplot2)
library(Rmisc)
library(ggmap) 
library(mapproj) 
devtools::install_github("adletaw/craigr")

# Data Acquisition from Craiglist 
CHIrentals <- craigr::rentals(location = "Chicago", area = "all", 
                           max_results = 2500)
# Data Cleansing
CHIrentalsClean <- CHIrentals[CHIrentals$Price<50000 & CHIrentals$Price>=100,]

# Obtain Chicago Map from Google
Chicagomap <- get_map(location = 'Chicago', zoom = 11)

# Decode Location into Latitude and Longitude
GeoLocation <- geocode(names(table(CHIrentalsClean$Location)))

# Data Analysis
PriceByLocation <- aggregate(CHIrentalsClean$Price, by = list(CHIrentalsClean$Location), FUN = "mean", na.rm = TRUE)
PriceByRoom <- aggregate(CHIrentalsClean$Price, by = list(CHIrentalsClean$Bedrooms), FUN = "mean", na.rm = TRUE)
RoomNHfactor <- with(CHIrentalsClean, interaction(CHIrentalsClean$Bedrooms,  CHIrentalsClean$Location), drop = TRUE)
PriceByRoomNH <- aggregate(CHIrentalsClean$Price, by = list(RoomNHfactor), FUN = "mean", na.rm = TRUE)
GeoLocationPrice <- geocode(as.character(PriceByLocation$Group.1))
GeoLocationPrice["Price"] = PriceByLocation$x
GeoLocationPrice <- GeoLocationPrice[complete.cases(GeoLocationPrice),]
NumOfRentals<- data.frame(table(CHIrentalsClean$Location))

# Data Visualization 
# plot 1A: number of rentals in listed neighborhoods
mapPointsChicago <- ggmap(Chicagomap) +
        geom_point(aes(x = lon, y = lat, size = sqrt(NumOfRentals$Freq)), data = GeoLocation, 
                   col = "orange", alpha = .5, size = NumOfRentals$Freq/2) +
        scale_size_continuous(range = NumOfRentals$Freq) +
        scale_fill_discrete(breaks = sqrt(c(1,50,100,200,300)), labels=c(1,50,100,200,300))

# plot 1B: barplot of the number of available rentals
x <- NumOfRentals[order(NumOfRentals$Freq, decreasing = T),]
par(mfrow=c(1,2))
barplot(x$Freq[c(1:7)], col = rainbow(7), ylab = "Number of available rentals", las = 2,
        names.arg = x$Var1[1:7])
plot.new()              
vps <- baseViewports()
pushViewport(vps$figure) 
vp1 <-plotViewport(c(0,0,0,0))
print(mapPointsChicago, vp = vp1)
title("\n \n \n Number and Distribution of Available Rentals \n in the Chicago Metropolitan Area (as of Apr-18-2016)",
      outer = T)

# plot 2A: price of rentals in listed neighborhoods
mapHeatChicago <- ggmap(Chicagomap, extent = "device") +
        geom_density2d(data = x, aes(x = lon, y = lat), size = 0.7) +
        stat_density2d(data = x, aes(x = lon, y = lat, fill = ..level.., alpha = ..level..), size = 0.01, 
                       geom = "polygon") + 
        scale_fill_gradient(low = "green", high = "red") +
        scale_alpha(range = c(0,0.3), guide = FALSE)

# plot 2B: price of rentals 
Neighborhood <- x$Var1[1:7]
NeighborhoodCode <- c(2, 3, 1, 5, 6, 7, 4)
y <- PriceByLocation[(PriceByLocation$Group.1 %in% Neighborhood),]
par(mfrow=c(1,2))
barplot(y$x[NeighborhoodCode], col = rainbow(7), las = 2, names.arg = y$Group.1[NeighborhoodCode], 
        ylab = "Price of available rentals in whole dollars")
plot.new()              
vps <- baseViewports()
pushViewport(vps$figure)
vp1 <-plotViewport(c(0,0,0,0))
print(mapHeatChicago, vp = vp1)
title("\n \n \n Price and Heatmap of Available Rentals \n in the Chicago Metropolitan Area (as of Apr-18-2016)",
      outer = T)
