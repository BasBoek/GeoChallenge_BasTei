library(raster)
library(rgdal)

#Load administrative boundaries
Malay_poly <- getData('GADM', country='MYS', level=1, path= 'D:/proj_poly_test')

#Load migration data
migr <- raster("F:/Data/CIESIN/net_migration_1km/netmigration_2000_2010_1km.tif")
#write shapefile
shapefile(Malay_poly, filename='D:/proj_poly_test/Malaypoly.shp', overwrite=TRUE)

#set extent
plot(migr)
extent <- drawExtent(show=TRUE, col="red")
extent
plot(extent, add=T)


migr_crop <- crop(migr, extent)

plot(migr_crop)
plot(Malay_poly, add = TRUE)

writeRaster(migr_crop, 'D:/geoscripting/GeoChallenge/GeoChallenge_LU_MIG/data/netmigration_2000_2010_1km_crop.tif')
