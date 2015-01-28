# Get Countrycode for Countryname and the polygon of Country
print("get ISO3 data")
iso3codes <- getData('ISO3')
print("Landpos shit")
Landpos <- which(iso3codes ==  Countryname, arr.ind = T) # Search location country in matrix
Landpos[1,2] <- Landpos[1,2] - 1 # search location code from country
Countrycode <- iso3codes[Landpos] # create countrycode
print("Create countrypoly")
Countrypoly <- getData('GADM', country=Countrycode, level=0, path = 'data/')
print("get extent")
new_ext <- extent(Countrypoly)

#Crop data
print("crop")
lu_crop <- crop(lu_stack, new_ext)
migr_crop <- crop(migr, lu_crop)
extent(migr_crop) <- extent(lu_crop) # set to exact same extent to make resample possible

#Set cellsize migration raster to the same cellsize as the landuse raster
print("Resample")
migr_bigcell <- raster::resample(migr_crop, lu_crop, method="bilinear") # used raster::resample because R.utils hides it
plot(migr_bigcell)

#Mask data
print("mask lu")
country_lu <- mask(lu_crop, Countrypoly)

#Mask migration has long computation time because of higher resolution
#country_migr <- mask(migr_crop, Countrypoly)

print("mask migr")
country_migr_bigcell <- mask(migr_bigcell, Countrypoly)

print("end")


