pacman::p_load(data.table, dplyr, tidyverse, validate)

general_data <- fread("https://covid.ourworldindata.org/data/owid-covid-data.csv") # carrega dados de covid19 no mundo

north_america_countries<-c("Anguilla","Bahamas","Bermuda","Canada","Curacao","Dominica","Mexico", "Guatemala", "Honduras", "Nicaragua", "Costa Rica", "Panama","Saint Lucia")

# filtra casos apenas no vetor

north_america<- general_data %>% filter(location %in% north_america_countries)

north_america <- north_america %>% select(location, total_cases_per_million, new_cases_per_million)

regras_north_america <- validator(total_cases_per_million >= 0, new_cases_per_million >= 0)

validacao_north_america <- confront(north_america, regras_north_america)

summary(validacao_north_america)

plot(validacao_north_america)