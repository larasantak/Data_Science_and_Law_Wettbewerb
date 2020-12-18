rm(list=ls()) 

library(tidyverse)


# Datenbank einlesen
data <- read.csv("Datenbank.csv")[,-1] %>%
  as_tibble() %>% 
  select( -doknr, -vorinstanz, -ident) 

# erstelle eine Spalte mit Jahreszahlen
library(lubridate)

data <- data %>% 
  mutate(date= as_date(ents_datum),
         year = year(date)) %>% 
  select( -ents_datum, -date) %>% 
  mutate(year = as.factor(year)) %>% 
  mutate(year = as.numeric(year))

# Alle interessanten Variablen in einer variable zusammenfassen
data$text <- paste( data$titel, data$grund, data$norm, data$kammer, sep = " ")


data_2  <- data %>% 
  select(text, year)

write.csv(data_2, "DatenA2.csv")
