# Download subnational level polygon data
Countrysub <- getData('GADM', country=Countrycode, level=1, path = 'data/')

plot(migr_crop)
plot(Countrysub, add=TRUE)

# extract mean migration values per subnational level polygon
Migr_sub <- raster::extract(migr_crop, Countrysub, method='simple', buffer=NULL, small=FALSE, cellnumbers=FALSE, 
        df=T, factors=FALSE, sp=FALSE)
str(Migr_sub)

Migr_sub[[1]]

str(Countrysub@data$NAME_1)
#Migr_sub_big <- raster::extract(country_migr_bigcell, Countrysub, method='simple', buffer=NULL, small=FALSE, cellnumbers=FALSE,fun=mean, na.rm=TRUE, df=FALSE, factors=FALSE, sp=TRUE)

#Migr_sub_big_df <- raster::extract(country_migr_bigcell, Countrysub, method='simple', buffer=NULL, small=FALSE, cellnumbers=FALSE,fun=mean, na.rm=TRUE, df=TRUE, factors=FALSE, sp=FALSE)
head(Migr_sub)

class(Migr_sub)
Migr_sub$netmigration_2000_2010_1km_crop
str(Migr_sub$netmigration_2000_2010_1km_crop)
spplot(Migr_sub, zcol = 'netmigration_2000_2010_1km_crop')
Migr_sub$netmigration_2000_2010_1km_crop
