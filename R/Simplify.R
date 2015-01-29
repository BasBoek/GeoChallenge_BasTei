# Creating matrix for class conversion
rcl <- matrix(data = NA, nrow = 19, ncol = 2)
rcl[,1] <- c(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,254,255)
rcl[,2] <- c(NA,1,1,1,1,1,2,2,2,2,2,2,3,4,3,NA,2,NA,NA)

# Function that replaces original classes by new, aggregated classes
Simplify <- function(raster){
  reclassify(raster, rcl)
}

# Execute function
LU_Ras_Simple <- Simplify(country_lu)
names(LU_Ras_Simple) <- c("LU_2001","LU_2010")

# Creating difference table
df2001 <- as.data.frame(freq(LU_Ras_Simple$LU_2010))
names(df2001) <- c('value','count2001')
df2010 <- as.data.frame(freq(LU_Ras_Simple$LU_2001))
names(df2010) <- c('value','count2010')
Count_dif <- merge(df2010, df2001, x.by = 'value', y.by = 'value')
Count_dif$netdif <- Count_dif$count2010 - Count_dif$count2001