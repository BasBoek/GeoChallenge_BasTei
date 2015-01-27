iso3codes <- getData('ISO3')
Landpos <- which(iso3codes ==  Countryname, arr.ind = T) # Search location country in matrix
Landpos[1,2] <- Landpos[1,2] - 1 # search location code from country
Countrycode <- iso3codes[Landpos] # create countrycode
Countrypoly <- getData('GADM', country=Countrycode, level=0)
lu_crop <- crop(lu_stack, Countrypoly)
country_lu <- mask(lu_crop, Countrypoly)
country_migr <- mask(migr,Countrypoly )





