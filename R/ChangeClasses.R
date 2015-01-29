
# Create 16 unique land use change classes
LU_ChangeClass <- LU_Ras_Simple$LU_2001 * 10 + LU_Ras_Simple$LU_2010
ChangeTable <- freq(LU_ChangeClass)
descriptiontable <- read.csv('data/descriptiontablechange.csv', header = TRUE)
ChangeTable_des <- merge(x = ChangeTable,y = descriptiontable,by.x = 'value',by.y = 'number' )
# Make reclassify tables
RCL_Forest <- matrix(data = NA, nrow = 16, ncol = 2)
RCL_Forest[,1] <- c(11,12,13,14,21,22,23,24,31,32,33,34,41,42,43,44)
RCL_Forest[,2] <- c(0,-1,-1,-1,1,NA,NA,NA,1,NA,NA,NA,1,NA,NA,NA)

RCL_Agri <- matrix(data = NA, nrow = 16, ncol = 2)
RCL_Agri[,1] <- c(11,12,13,14,21,22,23,24,31,32,33,34,41,42,43,44)
RCL_Agri[,2] <- c(NA,NA,1,NA,NA,NA,1,NA,-1,-1,0,-1,NA,NA,1,NA)

RCL_Urban <- matrix(data = NA, nrow = 16, ncol = 2)
RCL_Urban[,1] <- c(11,12,13,14,21,22,23,24,31,32,33,34,41,42,43,44)
RCL_Urban[,2] <- c(NA,NA,NA,1,NA,NA,NA,1,NA,NA,NA,1,-1,-1,-1,0)

# Make function for reclass on land use change data
Reclass_Change <- function(reftable){
  reclassify(LU_ChangeClass, reftable)
}
# Execution of reclass function for each land use type
Forest_Change <- Reclass_Change(RCL_Forest)
Agriculture_Change <- Reclass_Change(RCL_Agri)
Urban_Change <- Reclass_Change(RCL_Urban)

# make function for plotting of maps for type of land use change
PlotChange <- function(LandUseType){
  cols = c('red', 'darkgrey', 'green')
  plot(Countrypoly, col='lightyellow', bg = "lightblue", main = paste(deparse(substitute(LandUseType)) ,'Map 2001-2010: ', Countryname, sep = " "), lwd = 1)
  plot(LandUseType,  add=T, col = cols, legend = FALSE)
  legend("bottomright", legend=c("Loss", "No Change", "Gain"), fill=cols, bg="white", text.font=9, text.width = 4, cex = 0.7)
  plot(Countrypoly, add=T, lwd = 1)  
}
