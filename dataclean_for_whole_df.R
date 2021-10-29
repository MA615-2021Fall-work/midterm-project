library(shiny)
library(tidyverse)
library(dplyr)
library(magrittr)
presti <- read.csv("Pesticides.csv",header = T, na.strings = c("", "NA"))
strawbwhole <- read.csv("Strawberries.csv")
#Drop empty columns
strawbwhole <- strawbwhole[-c(4,8:15)]
#Separate Data.Item to 4 columns
strawbwhole <- strawbwhole %<>% separate(col=Data.Item,
                                       into = c("Strawberries", "items", "discription",  "units"),
                                       sep = ",",
                                       fill = "right")
#Separate Domian to 2 columns
strawbwhole <- strawbwhole %<>% separate(col = Domain,
                                       into = c("Domain", "Chemical"),
                                       sep = ",",
                                       fill = "right")
#Subsetting by domain
organic_sub <- subset(strawbwhole, Domain == "ORGANIC STATUS")
chemical_sub <- subset(strawbwhole, Domain == "CHEMICAL")
fert_sub <- subset(strawbwhole, Domain == "FERTILIZER")
total_sub <- subset(strawbwhole, Domain == "TOTAL")


#Clean chemical subset
#Replace NAs in units with blanks
chemical_sub$units[is.na(chemical_sub$units)] <- " "
#Join the column discription and units
chemical_sub$units <- paste(chemical_sub$discription, chemical_sub$units)
#Create a new column for measurement
chemical_sub$measurement <- chemical_sub$units

chemical_sub$Domain.Category <- gsub("[()]", "", chemical_sub$Domain.Category)
chemical_sub$Domain.Category <- gsub(".*:", "", chemical_sub$Domain.Category) 

chemical_sub<- subset(chemical_sub, Domain.Category != " TOTAL")

chemical_sub <- chemical_sub %<>% separate(col = Domain.Category,
                                       into = c("Chemicaltype", "Code"),
                                       sep = "=",
                                       fill = "right")


chemical_sub <- chemical_sub[complete.cases(chemical_sub$Code),]

for (i in 1:length(chemical_sub$Year)) {
  chemical_sub$Chemicaltype[i] <- trimws(chemical_sub$Chemicaltype[i])
}





