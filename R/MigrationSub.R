# Download subnational level polygon data
Countrysub <- getData('GADM', country=Countrycode, level=1, path = 'data/')

plot(migr_crop)
plot(Countrysub, add=TRUE)
names(Countrysub)
# extract mean migration values per subnational level polygon
names(Countrysub)
str(Countrysub)

# Extract mean migration values per subnational level in a dataframe
Migr_sub_big <- raster::extract(migr_bigcell, Countrysub, method='simple', fun=mean, na.rm=TRUE, df=TRUE)

# merge tables
SubcountryNames <- Migr_sub$NAME_1
SubcountryNames
Migr_sub_big$names <- SubcountryNames
class(Migr_sub_big)
Migr_sub_final <- merge(Countrysub, Migr_sub_big, by.x = 'NAME_1', by.y = 'names')


