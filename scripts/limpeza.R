#checando se existe pacote, caso não, instala e carrega
if(require(tidyverse) == F) install.packages('tidyverse'); require(tidyverse)
if(require(dplyr) == F) install.packages('dplyr'); require(dplyr)
if(require(funModeling) == F) install.packages('funModeling'); require(funModeling)
library(data.table)

general_data <- fread("https://covid.ourworldindata.org/data/owid-covid-data.csv") # carrega dados de covid19 no mundo

north_america_countries<-c("Anguilla","Bahamas","Bermuda","Canada","Curacao","Dominica","Mexico", "Guatemala", "Honduras", "Nicaragua", "Costa Rica", "Panama","Saint Lucia")

# filtra casos apenas no vetor

north_america<- general_data %>% filter(location %in% north_america_countries)

north_america <- north_america %>% select(location, new_cases, new_deaths)

status(north_america) # estrutura dos dados (missing etc)
freq(north_america) # frequência das variáveis fator
plot_num(north_america) # exploração das variáveis numéricas
profiling_num(north_america) # estatísticas das variáveis numéricas

north_america %>% filter(new_cases < 0)

north_america <- north_america %>% filter(new_cases>=0)

#aplicando a remocao de NA values 
north_america <- north_america %>% filter(!is.na(new_deaths))



