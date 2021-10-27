library(shiny)
library(tidyverse)
library(dplyr)
library(magrittr)
presti <- read.csv("Pesticides.csv",header = T, na.strings = c("", "NA"))
strawb <- read.csv("Strawberries.csv")

#Remove all the NAs in the first column
presti <- presti[rowSums(is.na(presti)) != ncol(presti),]

#Split the Domain.Category column for the Dataset: strawb:
#Create a subset containing Year, State, Domain and Domian.Category:
strawb_sub <- subset(strawb, select =c(Year,Data.Item, State,Domain,Domain.Category))

strawb_sub <- strawb_sub %>% filter(Data.Item == "STRAWBERRIES, BEARING - TREATED, MEASURED IN PCT OF AREA BEARING, AVG")


strawb_sub <- strawb_sub %<>% separate(col=Data.Item,
                     into = c("Strawberries", "items", "discription",  "units"),
                     sep = ",",
                     fill = "right")


strawb_sub$units <- paste(strawb_sub$discription, strawb_sub$units)


strawb_sub <- strawb_sub %>% filter(str_detect(Domain, "INSECTICIDE"))

strawb_sub <- strawb_sub %<>% separate(col = Domain,
                                       into = c("Domain", "Chemical"),
                                       sep = ",",
                                       fill = "right")



strawb_sub$Domain.Category <- gsub("CHEMICAL, INSECTICIDE: ", "", strawb_sub$Domain.Category)
