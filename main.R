# Geo-Challenge: Land use & Migration in the Tropics
# Team Bastei
# January, 2015

rm(list=ls(all=TRUE))

############################### LOAD ALL DATA ###################################

# Load required packages
library(raster)
library(rgdal)
library(R.utils)
library(caret)
library(e1071)
library(ggplot2)
library(googleVis)
library(rasterVis)
library(ISOcodes)

# Load input data into memory
source('R/LoadData.R')
Load_LU(link2001, 2001)
Load_LU(link2010, 2010)

lu_2001 <- raster('data/LC_5min_global_2001.tif')
lu_2010 <- raster("data/LC_5min_global_2010.tif")
lu_stack <- stack(lu_2001, lu_2010)

migr <- raster('data/netmigration_2000_2010_1km_crop.tif')

# Crop to desired extent
Countryname = 'Malaysia'
source('R/MaskingCountry.R')

####################################### LANDUSE #####################################

# Data exploration LAND USE
country_lu

# Make barplots showing the prevalence of all the present land use types of the country in both years
lu_class <- read.csv("data/lu_classes.csv") # Names
Freq2001 <- as.data.frame(freq(country_lu$LC_5min_global_2001))   # Freq table (unique classes)
Classfreq2001 <- merge(Freq2001, lu_class, by.x = names(Freq2001[1]), by.y = names(lu_class[1])) # Merge 

Freq2010 <- as.data.frame(freq(country_lu$LC_5min_global_2010))   # Freq table (unique classes)
Classfreq2010 <- merge(Freq2010, lu_class, by.x = names(Freq2010[1]), by.y = names(lu_class[1])) # Merge 
opar <- par(mfrow=c(1,2))
barplot(Classfreq2001$count, names.arg = Classfreq2001$Label, srt=45, cex.names = 0.5)
barplot(Classfreq2010$count, names.arg = Classfreq2010$Label, srt=45, cex.names = 0.5)
par(opar)

# Table showing netto change land use classes
Freq_both <- merge(Classfreq2001, Classfreq2010, by.x = names(Classfreq2001[1]), by.y = names(Classfreq2010[1]))
Freq_both <- Freq_both[,1:4]
names(Freq_both) <-c("Class", "Count2001", "Name", "Count2010")
Freq_both$difference <- Freq_both$Count2010 - Freq_both$Count2001
Freq_both <- Freq_both[c("Name", "Count2001", "Count2010", "difference")]
Freq_both

# Reduce to 4 landuse classes
source('R/Simplify.R')

# Barplots of the simplified land use counts for both years and difference
opar <- par(mfrow=c(1,3))
barplot(LU_Ras_Simple$LU_2001, names.arg = c("Forest", "Other_Veg", "Agriculture", "Urban"), srt=45, cex.names = 0.9, col = c("darkgreen", "green", "orange", "red"), ylab = "Count cells", cex.lab = 2, las=2)
barplot(LU_Ras_Simple$LU_2010, names.arg = c("Forest", "Other_Veg", "Agriculture", "Urban"), srt=45, cex.names = 0.9, col = c("darkgreen", "green", "orange", "red"), las=2)
barplot(Count_dif$netdif, names.arg = c("Forest", "Other_Veg", "Agriculture", "Urban", NA), srt=45, cex.names = 0.9, col = c("darkgreen", "green", "orange", "red", "black"), las=2)
par(opar)
dev.off()

# Plotting Simplified land use maps for both years
opar <- par(mfrow=c(2,1))
cols = c('darkgreen', 'green', 'orange', 'red')
plot(Countrypoly, bg = "lightblue", main = paste('Landuse', Countryname, "2001", sep = " "), lwd = 1)
plot(LU_Ras_Simple$LU_2001,  add=T, col = cols, legend = FALSE, main = '2001')
legend("bottomright", legend=c("Forest", "Other_Veg", "Agriculture", "Urban"), fill=cols, bg="white", text.font=9, text.width = 4, cex = 0.5)
plot(Countrypoly, bg = "lightblue", main = paste('Landuse', Countryname, "2010", sep = " ") , lwd = 1)
plot(LU_Ras_Simple$LU_2010,  add=T, col = cols, legend = FALSE)
legend("bottomright", legend=c("Forest", "Other_Veg", "Agriculture", "Urban"), fill=cols, bg="white", text.font=9, text.width = 4, cex = 0.5)
par(opar)
dev.off()

# Create confusion matrix showing all land use change types
LUasVec_2001 <- as.vector(LU_Ras_Simple$LU_2001)
LUasVec_2010 <- as.vector(LU_Ras_Simple$LU_2010)
CF_mat <- confusionMatrix(LUasVec_2001, LUasVec_2010) 
CF_mat <- CF_mat$table
row.names(CF_mat) <- (c("Forest2001", 'Other veg2001', 'Agriculture2001','Urban2001'))
colnames(CF_mat) <- (c('Forest2010', 'Other veg2010', 'Agriculture2010','Urban2010'))

# Confusion matrix:
CF_mat

# Link data 2001 to 2010 and create 16 unique land use change classes
source('R/ChangeClasses.R')

# Plot forest change, urban change and agricultural change maps:
PlotChange(Forest_Change)
PlotChange(Agriculture_Change)
PlotChange(Urban_Change)
dev.off()

####################################### MIGRATION #####################################

# Data exploration Migration
res(migr_bigcell)
plot(migr_bigcell)
hist(migr_bigcell)

plot(migr_bigcell,zlim = c(-100,200))
brk <- c( -100, -15, 0, 100, 1000, 5000)
cols <- colorRampPalette(c("red", "pink", "orange", "yellow",  "green", "darkgreen"))( 6 )
plot(migr_bigcell,breaks=brk, col=cols)
dev.off()

# request basic statistic values and inspect differences in statistics due to resampling
print("statistic values: mean, max and min")
cellStats(migr_bigcell, stat='mean', na.rm=TRUE)
cellStats(migr_bigcell, stat='max', na.rm=TRUE)
cellStats(migr_bigcell, stat='min', na.rm=TRUE)

# Information about non-resampled croppped area
print("statistic values: mean, max and min")
cellStats(migr_crop, stat='mean', na.rm=TRUE)
cellStats(migr_crop, stat='max', na.rm=TRUE)
cellStats(migr_crop, stat='min', na.rm=TRUE)


# extract mean migration per subnational level
source('R/MigrationSub.R')

# Create GoogleVis Map
source('R/MigrVis.R')

# Open the link to the map
browseURL(paste('file://', getwd(),'data', 'MigrationWebmap.html',  sep='/'))
