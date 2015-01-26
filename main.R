# Geo-Challenge: Land use & Migration in the Tropics
# Team Bastei
# January, 2015


# Load required packages
library(raster)
library(rgdal)

# Load input data into memory
Load_LU(URL)
Load_mig()

# Crop to desired extent



# Data exploration LAND USE
print("Information about land use data per country per year")
print("summary")
Indo_lu_2001
Indo_lu_2010

# Make plots showing the prevalence of the land use types of the country
lu_class <- read.csv("lu_classes.csv")
Freq <- as.data.frame(freq(Indo_lu_2001))   # Freq table (unique classes)
Classfreq <- merge(Freq, lu_class, by.x = names(Freq[1]), by.y = names(lu_class[1])) # Merge for class names 
barplot(Classfreq$count, names.arg = Classfreq$Label, srt=45, cex.names = 0.5)                   


# Reclass land use data 2001 & 2010
Simplify(2001)
Simplify(2010)


# Link data 2001 to 2010 and create 9 unique land use change classes
ChangeClasses(2001,2010)

# Reclass to & visualize urban, forest and agricultural change.

#Forest change:

# Urban change:

# Agricultural change:

# DATA exploration Migration



# extract mean migration per subnational level


