source("data_cleaning_strawb.R")
source("dataclean_for_whole_df.R")

#Remove all the NAs in the first column
presti <- presti[rowSums(is.na(presti)) != ncol(presti),] 
#create a presti data frame for subsets
presti_chemical_sub <- presti
#Remove all the rows that full of NAs
presti <- presti[rowSums(is.na(presti[,2:6])) != 5, ]

#Capitalize all the characters in the column of Pesticide
presti$Pesticide <- toupper(presti$Pesticide)
presti_chemical_sub$Pesticide <- toupper(presti_chemical_sub$Pesticide)

#Combine two dataset. There is some missing Chemicatype for presti. 

full_list <- full_join(strawb_sub,presti, by = c("Chemicaltype" = "Pesticide"))


full_list <- full_list[!(is.na(full_list$Year) | full_list$Year=="NA"), ]

#Combine two dataset for chemical subset
full_list_chemical_sub <- full_join(chemical_sub,presti_chemical_sub, by = c("Chemicaltype" = "Pesticide"))
full_list_chemical_sub <- full_list_chemical_sub[!(is.na(full_list_chemical_sub$Year) | full_list_chemical_sub$Year=="NA"), ]




