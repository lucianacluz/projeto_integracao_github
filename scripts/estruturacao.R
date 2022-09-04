#checando se existe pacote, caso não, instala e carrega
if(require(tidyverse) == F) install.packages('tidyverse'); require(tidyverse)
if(require(dplyr) == F) install.packages('dplyr'); require(dplyr)
library(data.table)


general_data<-fread("https://covid.ourworldindata.org/data/owid-covid-data.csv") # carrega dados de covid19 no mundo

north_america_countries<-c("Anguilla","Bahamas","Bermuda","Canada","Curacao","Dominica","Mexico", "Guatemala", "Honduras", "Nicaragua", "Costa Rica", "Panama","Saint Lucia")

# filtra casos apenas no vetor
north_america<- general_data %>% 
  filter(location %in% north_america_countries)


# cria matriz dos países, agrupando por local, criando uma nova linha com index e selecionando apenas algumas variáveis
n_america <- north_america %>% 
  group_by(location) %>% 
  mutate(row = row_number()) %>%
  select(location, new_cases, row) 

# filtra dados para garantir que todos os países tenham mesmo nro de casos
result <- n_america %>% group_by(location) %>% filter(row == max(row))
n_america <- n_america %>% filter(row<=min(result$row)) 


# pivota o data frame de long para wide
n_americaw <- n_america %>% pivot_wider(names_from = row, values_from = new_cases) %>% remove_rownames %>% column_to_rownames(var="location") 
