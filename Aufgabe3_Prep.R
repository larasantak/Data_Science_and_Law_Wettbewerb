rm(list=ls()) 

library(tidyverse)


# Datenbank einlesen
data <- read.csv("Datenbank.csv")[,-1] %>% as_tibble()

# ändere die txpen in numerische Werte um:
data <- data %>% 
  mutate(typ = as.factor(typ),
         typ = str_replace_all(typ, c("Beschluss"  = "1",          "Ergänzungsurteil" = "2",               "EuGH-Vorlage" = "3", 
                                      "Kostenfestsetzungsbeschluss" = "4", "Urteil"  = "5", "Vorlagebeschluss" = "6",
                                      "Zwischenbeschluss" = "7", "Zwischenurteil" = "8")),
         typ =as.numeric(typ))

# Alle interessanten Variablen in einer variable zusammenfassen
data$text <- paste( data$titel, data$grund, data$norm, data$doknr, data$kammer, data$ents_datum, data$vorinstanz, sep = " ")


data_3  <- data %>% 
  select(text, typ)

write.csv(data_3, "DatenA3.csv")
