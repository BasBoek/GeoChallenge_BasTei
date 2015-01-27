# Geo-Challenge: Land use & Migration in the Tropics
# Team Bastei
# January, 2015

rm(list=ls(all=TRUE))

# Load required packages
library(raster)
library(rgdal)
library(R.utils)

# Load input data into memory
source('R/LoadData.R')
Load_LU(link2001, 2001)
Load_LU(link2010, 2010)

lu_2001 <- raster('data/LC_5min_global_2001.tif')
lu_2010 <- raster("data/LC_5min_global_2010.tif")
lu_stack <- stack(lu_2001, lu_2010)

migr <- raster('data/netmigration_2000_2010_1km_crop.tif')

# Crop to desired extent
Countryname = 'Indonesia'
source('R/MaskCountry.R')


# Data exploration LAND USE
print("Information about land use data per country per year")
print("summary")
country_lu
spplot(country_lu)

# Make plots showing the prevalence of the land use types of the country
lu_class <- read.csv("lu_classes.csv") # Names
Freq2001 <- as.data.frame(freq(Indo_lu_2001))   # Freq table (unique classes)
Classfreq2001 <- merge(Freq2001, lu_class, by.x = names(Freq2001[1]), by.y = names(lu_class[1])) # Merge 

Freq2010 <- as.data.frame(freq(Indo_lu_2010))   # Freq table (unique classes)
Classfreq2010 <- merge(Freq2010, lu_class, by.x = names(Freq2010[1]), by.y = names(lu_class[1])) # Merge 
opar <- par(mfrow=c(1,2))
barplot(Classfreq2001$count, names.arg = Classfreq2001$Label, srt=45, cex.names = 0.5)
barplot(Classfreq2010$count, names.arg = Classfreq2010$Label, srt=45, cex.names = 0.5)
par(opar)

Freq_both <- merge(Classfreq2001, Classfreq2010, by.x = names(Classfreq2001[1]), by.y = names(Classfreq2010[1]))
Freq_both <- Freq_both[,1:4]
Freq_both
names(Freq_both) <-c("Class", "Count2001", "Name", "Count2010")
Freq_both$difference <- Freq_both$Count2010 - Freq_both$Count2001
Freq_both

Classfreq2001
Classfreq2010
# Reclass land use data 2001 & 2010
Simplify(2001)
Simplify(2010)


# Link data 2001 to 2010 and create 9 unique land use change classes
ChangeClasses(2001,2010)

# Reclass to & visualize urban, forest and agricultural change.

#Forest change:

# Urban change:

# Agricultural change:

# DATA exploration Migration
# (!!!! improve visualisation with raster vis? spplot?)
plot(migr)
hist(migr)
plot(migr,zlim = c(-100,200))
brk <- c( -100, -50, 0, 100, 500, 1000, 5000, 10000, 50000, 100000)
cols <- colorRampPalette(c("red", "pink", "orange", "yellow",  "green", "darkgreen", "blue", "darkblue", "purple"))( 9 )
plot(migr,breaks=brk, col=cols)

#cols <- colorRampPalette(c("red", "yellow", "orange", "green", "darkgreen"))( 255 )
plot(migr, col=cols)

# request basic statistic values
print("statistic values: mean, max and min")
cellStats(migr, stat='mean', na.rm=TRUE)
cellStats(migr, stat='max', na.rm=TRUE)
cellStats(migr, stat='min', na.rm=TRUE)

dev.off()

# extract mean migration per subnational level


