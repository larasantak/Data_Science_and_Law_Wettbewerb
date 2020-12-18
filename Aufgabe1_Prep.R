rm(list=ls()) 

library(tidyverse)


# Datenbank einlesen
data <- read.csv("Datenbank.csv")[,-1] %>% as_tibble()

#drop empty obs for kammer
data <-  data[data$kammer!="",]


# ändere die kammern in numerische Werte um:
data <- data %>% 
  mutate(kammer = str_replace_all(kammer, c("1. Senat" = "1", "2. Senat"= "2", "3. Senat"= "3", "4. Senat" = "4", "5. Senat" = "5", "6. Senat" = "6",
                                            "7. Senat" = "7", "8. Senat" = "8", "9. Senat" = "9", "10. Senat" = "10", "11. Senat" = "11", "Großer Senat" = "12"))) %>% 
  mutate(kammer = as.numeric(kammer))

# Alle interessanten Variablen in einer variable zusammenfassen
data$text <- paste( data$titel, data$grund, data$norm, data$doknr, data$kammer, data$ents_datum, data$vorinstanz, sep = " ")


data_1  <- data %>% 
  select(text, kammer)

write.csv(data_1, "DatenA1.csv")
