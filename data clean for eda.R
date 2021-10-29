source("dataclean_for_whole_df.R")
source("data_cleaning_presti.R")

chemical <- full_list_chemical_sub

chemical$Carcinogen[is.na(chemical$Carcinogen)] <- "unknown"
chemical$Hormone.Disruptor[is.na(chemical$Hormone.Disruptor)] <- "unknown"
chemical$Neurotoxins[is.na(chemical$Neurotoxins)] <- "unknown"
chemical$Developmental.or.Reproductive.Toxins[is.na(chemical$Developmental.or.Reproductive.Toxins)] <- "unknown"
chemical$Bee.Toxins[is.na(chemical$Bee.Toxins)] <- "unknown"

#Give the toxins variable levels
chemical$Carcinogen <- factor(chemical$Carcinogen, levels = c("known","probable","possible","unknown"))
chemical$Carcinogen <- factor(chemical$Carcinogen, levels = rev(levels(chemical$Carcinogen)))

chemical$Hormone.Disruptor <- factor(chemical$Hormone.Disruptor, labels = c("suspected","unknown"))
chemical$Hormone.Disruptor <- factor(chemical$Hormone.Disruptor, levels = rev(levels(chemical$Hormone.Disruptor)))

chemical$Neurotoxins <- factor(chemical$Neurotoxins, labels = c("present","unknown"))
chemical$Neurotoxins <- factor(chemical$Neurotoxins, levels = rev(levels(chemical$Neurotoxins)))

chemical$Developmental.or.Reproductive.Toxins <- factor(chemical$Developmental.or.Reproductive.Toxins,labels = c("present","unknown"))
chemical$Developmental.or.Reproductive.Toxins <- factor(chemical$Developmental.or.Reproductive.Toxins, levels = rev(levels(chemical$Developmental.or.Reproductive.Toxins)))

chemical$Bee.Toxins <- factor(chemical$Bee.Toxins, labels = c("high","moderate","slight","unknown"))
chemical$Bee.Toxins <- factor(chemical$Bee.Toxins, levels = rev(levels(chemical$Bee.Toxins)))


#Create toxicity-level column for bee
chemical$toxicitylevelbee <- as.numeric(chemical$Bee.Toxins)

for (i in 1:length(chemical$Year)) {
  chemical$toxicitylevelhuman[i] = sum(as.numeric(chemical$Carcinogen[i]),as.numeric(chemical$Hormone.Disruptor[i]), as.numeric(chemical$Neurotoxins[i]), as.numeric(chemical$Developmental.or.Reproductive.Toxins[i]))
}


chemical <- subset(chemical, select = c(Year,State,Chemical,Chemicaltype,Value,measurement,Carcinogen,Hormone.Disruptor,Neurotoxins,Developmental.or.Reproductive.Toxins,toxicitylevelhuman,Bee.Toxins,toxicitylevelbee))





