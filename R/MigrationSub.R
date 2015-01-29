# Download subnational level polygon data
Countrysub <- getData('GADM', country=Countrycode, level=1, path = 'data/')

# Extract mean migration values per subnational level in a dataframe
Migr_sub_big <- raster::extract(migr_bigcell, Countrysub, method='simple', fun=mean, na.rm=TRUE, df=TRUE)


# merge tables to make spatial again
SubcountryNames <- Countrysub$NAME_1
Migr_sub_big$names <- SubcountryNames
Migr_sub_final <- merge(Countrysub, Migr_sub_big, by.x = 'NAME_1', by.y = 'names')
Migr_sub_final$netmigration_2000_2010_1km_crop
