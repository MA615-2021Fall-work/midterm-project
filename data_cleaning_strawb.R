strawb <- read.csv("Strawberries.csv")

#Split the Domain.Category column for the Dataset: strawb:
#Create a subset containing Year, State, Domain and Domian.Category:
strawb_sub <- subset(strawb, select =c(Year,Data.Item, State,Domain,Domain.Category, Value))

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


strawb_sub$Domain.Category <- gsub("[()]", "", strawb_sub$Domain.Category)

#Separate Domain.Category into two columns: Chemicaltype and Code
strawb_sub <- strawb_sub %<>% separate(col = Domain.Category,
                                       into = c("Chemicaltype", "Code"),
                                       sep = "=",
                                       fill = "right")

#Remove rows contain only NAs
strawb_sub <- strawb_sub[complete.cases(strawb_sub$Code),]

#Remove the space in Chemicaltype in order to match with Pesticide from presti
for (i in 1:length(strawb_sub$Year)) {
  strawb_sub$Chemicaltype[i] <- trimws(strawb_sub$Chemicaltype[i])
}



