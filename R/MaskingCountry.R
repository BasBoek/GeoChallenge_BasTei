# Get Administrative Boundaries polygons of the Country
# Open the table with all the codes of all Countries to extract the code for the country of choice
iso3codes <- getData('ISO3')
Landpos <- which(iso3codes ==  Countryname, arr.ind = T) # Search location country in matrix
Landpos[1,2] <- Landpos[1,2] - 1 # search location code from country
Countrycode <- iso3codes[Landpos] # create countrycode
# Get country adminitratieve boundaries polygon
Countrypoly <- getData('GADM', country=Countrycode, level=0, path = 'data/')

# Load Administrative boundaries for all countries in the world
Worldpoly <- getData('countries')
# Load Administrative boundaries for Continent
Continentpoly_df <- (Worldpoly[Worldpoly$CONTINENT=="Asia" & Worldpoly$COUNTRY != "Russia",])
Continentpoly <- as.SpatialPolygons.PolygonsList(Continentpoly_df@polygons,proj4string = CRS(proj4string(Countrypoly)))


#Crop data
lu_crop <- crop(lu_stack, Countrypoly)
migr_crop <- crop(migr, lu_crop)
extent(migr_crop) <- extent(lu_crop) # set to exact same extent to make resample possible

extent <- extent(migr_crop)
x_extent <- c(extent[1], extent[2])
y_extent <- c(extent[3], extent[4])

# Convert SpatialPolygons to class 'PolySet'
Continentpoly.ps <- SpatialPolygons2PolySet(Continentpoly) # this takes some time
# Clip 'PolySet' by given extent
Continent.ps.clipped <- clipPolys(Continentpoly.ps, xlim = x_extent, ylim = y_extent) # this also
# Convert clipped 'PolySet' back to SpatialPolygons
Continentpoly_clipped <- PolySet2SpatialPolygons(Continent.ps.clipped, close_polys=TRUE)

#Set cellsize migration raster to the same cellsize as the landuse raster
migr_bigcell <- raster::resample(migr_crop, lu_crop, method="bilinear") # used raster::resample because R.utils hides it

#Mask data
print("mask lu")
country_lu <- mask(lu_crop, Countrypoly)

#Mask migration has long computation time because of higher resolution
print("mask migr")
migr_bigcell <- mask(migr_bigcell, Countrypoly)

print("end")


