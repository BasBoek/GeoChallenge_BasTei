
LU_ChangeClass <- LU_Ras_Simple$LU_2001 * 10 + LU_Ras_Simple$LU_2010
ChangeTable <- freq(LU_ChangeClass)

descriptiontable <- read.csv('data/descriptiontablechange.csv', header = TRUE)

ChangeTable_des <- merge(x = ChangeTable,y = descriptiontable,by.x = 'value',by.y = 'number' )
ChangeTable_des


