source("data cleaning strawb.R")


#Remove all the NAs in the first column
presti <- presti[rowSums(is.na(presti)) != ncol(presti),] 

#Remove all the rows that full of NAs
presti <- presti[rowSums(is.na(presti[,2:6])) != 5, ]

presti$Pesticide <- toupper(presti$Pesticide) 





