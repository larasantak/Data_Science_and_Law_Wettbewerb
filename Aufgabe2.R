rm(list=ls()) 
library(tidyverse)
library(keras)

# Daten für A3 einlesen
data <- read.csv("DatenA2.csv")[,-1] %>% as_tibble()

#maximaler Indice für Wortvorkommen
num_words = 20000


# Indizierung der Wörter mit keras
token <- text_tokenizer(num_words = num_words) %>% 
  fit_text_tokenizer(data$text)

# Umwandlung der Wörter in Indizes
data$sequences <-  texts_to_sequences(token, data$text)


# Erstellung des Trainings- und Testdatensatz

x <- texts_to_matrix(token, data$text, mode= "binary") # binary nur Wortvorkommen wird indiziert
y <- to_categorical(as.matrix(data$year))[,-1]


train_indices <-  sample(1:nrow(data), 0.6 * nrow(data))

x_train <- x[train_indices,]
x_test <- x[-train_indices,]

y_train <- y[train_indices,]
y_test <- y[-train_indices,]


# Model
model <- keras_model_sequential()


# Layers:
model %>% 
  layer_dense(units = 1000, activation = 'relu', input_shape = c(num_words))%>%
  layer_dropout(0.97) %>%
  
  #layer_dense(units = 9, activation = 'relu') %>%  
  #layer_dropout(0.7) %>%
  
  layer_dense(units = 9, activation = 'softmax')

#Optimizer
adam <- optimizer_adam(lr = 0.0001)

#compile
model %>% compile(
  loss = 'categorical_crossentropy',
  optimizer = adam,
  metrics = 'accuracy'
)

# Train
history <- model %>% fit(
  x_train,
  y_train,
  epochs= 100,
  batch_size = 512,
  validation_split = 0.2
)



plot(history)


#Evaluate

model %>% 
  evaluate(x_test, y_test)
