print("get ISO3 data")
iso3codes <- getData('ISO3')
print("Landpos shit")
Landpos <- which(iso3codes ==  Countryname, arr.ind = T) # Search location country in matrix
Landpos[1,2] <- Landpos[1,2] - 1 # search location code from country
Countrycode <- iso3codes[Landpos] # create countrycode
print("Create countrypoly")
Countrypoly <- getData('GADM', country=Countrycode, level=0)
print("get extent")
new_ext <- extent(Countrypoly)
print("crop")
lu_crop <- crop(lu_stack, new_ext)
print("mask lu")
country_lu <- mask(lu_crop, Countrypoly)
print("mask migr")
#country_migr <- mask(migr, Countrypoly)
print("end")