source("data cleaning strawb.R")


#Remove all the NAs in the first column
presti <- presti[rowSums(is.na(presti)) != ncol(presti),] 

#Remove all the rows that full of NAs
presti <- presti[rowSums(is.na(presti[,2:6])) != 5, ]

presti$Pesticide <- toupper(presti$Pesticide) 


#Combine two dataset. There is some missing Chemicatype for presti. 

full_list <- full_join(strawb_sub,presti,by=c("Chemicaltype"="Pesticide"))

full_list <- full_list[!(is.na(full_list$Year) | full_list$Year=="NA"), ]




