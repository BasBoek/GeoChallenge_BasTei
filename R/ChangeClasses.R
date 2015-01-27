
LU_ChangeClass <- LU_Ras_Simple$LU_2001 * 10 + LU_Ras_Simple$LU_2010
ChangeTable <- freq(LU_ChangeClass)

descriptiontable <- read.csv('data/descriptiontablechange.csv', header = TRUE)

ChangeTable_des <- merge(x = ChangeTable,y = descriptiontable,by.x = 'value',by.y = 'number' )


RCL_Forest <- matrix(data = NA, nrow = 16, ncol = 2)
RCL_Forest[,1] <- c(11,12,13,14,21,22,23,24,31,32,33,34,41,42,43,44)
RCL_Forest[,2] <- c(0,-1,-1,-1,1,NA,NA,NA,1,NA,NA,NA,1,NA,NA,NA)

RCL_Agri <- matrix(data = NA, nrow = 16, ncol = 2)
RCL_Agri[,1] <- c(11,12,13,14,21,22,23,24,31,32,33,34,41,42,43,44)
RCL_Agri[,2] <- c(NA,NA,1,NA,NA,NA,1,NA,-1,-1,0,-1,NA,NA,1,NA)

RCL_Urban <- matrix(data = NA, nrow = 16, ncol = 2)
RCL_Urban[,1] <- c(11,12,13,14,21,22,23,24,31,32,33,34,41,42,43,44)
RCL_Urban[,2] <- c(NA,NA,NA,1,NA,NA,NA,1,NA,NA,NA,1,-1,-1,-1,0)

Reclass_Change <- function(reftable){
  reclassify(LU_ChangeClass, reftable)
}

Forest_Change <- Reclass_Change(RCL_Forest)
head(Forest_Change)
Agri_Change <- Reclass_Change(RCL_Agri)
Urban_Change <- Reclass_Change(RCL_Urban)
plot(Forest_Change)
plot(Agri_Change, col = c('red', 'yellow', 'green'))
plot(Urban_Change, col = c('red', 'yellow', 'green'))


