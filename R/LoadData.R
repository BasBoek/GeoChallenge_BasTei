
function Load_LU(lu_link, year):
download.file(url = lu_link, destfile = 'data/LU_%s2001.gz' % year, method = 'auto')


# manualy cropping a peace of the tropics
#lu_2001 <- raster('data/LU_2001/LC_5min_global_2001.tif')
# manualy cropping a peace of the tropics
#e <- drawExtent(show=TRUE)
#croplu2001 <- crop(lu_2001, extent)
#plot(croplu2001)
# writeRaster(x = croplu2001,filename = "data/croplu2001.tif")

#lu_2010 <- raster('data/LU_2010/LC_5min_global_2010.tif')
# e <- drawExtent(show=TRUE)
#croplu2010 <- crop(lu_2010, extent)
#plot(croplu2001)
# writeRaster(x = croplu2010,filename = "data/croplu2010.tif")

# resolution = 5 arc minutes = +- 10 km

# loading land use data
lu_2001 <- raster('data/croplu2001.tif')
plot(lu_2001)
lu_2010 <- raster("data/croplu2010.tif")
plot(lu_2010)
res(lu_2001)
# Get country borders
# get country codes -> ccodes()
Indo <- getData('GADM', country='IDN', level=0)
plot(Indo)

# mask land use data in Country
Indo_lu_2001 <- mask(lu_2001, Indo)
Indo_lu_2010 <- mask(lu_2010, Indo)
plot(Indo_lu_2010)







function Load_Mig():
  blabla2 


lu_links
# 2001 -> ftp://ftp.glcf.umd.edu/glcf/Global_LNDCVR/Global_5min_Rev1/GeoTIFF/LC_5min_global_2001.tif.gz
# 2010 -> ftp://ftp.glcf.umd.edu/glcf/Global_LNDCVR/Global_5min_Rev1/GeoTIFF/LC_5min_global_2010.tif.gz