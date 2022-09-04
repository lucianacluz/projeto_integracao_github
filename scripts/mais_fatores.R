library(ade4)
library(arules)
library(forcats)
library(tidyverse)


# carregando base pronta do tidyverse 
salarios <- carData::Salaries
str(salarios)

# conversão em fatores
for(i in c(1,2,5)) {
  salarios[,i] <- as.factor(salarios[,i]) } 
str(salarios)

# filtro por tipo de dado
factorsSalarios <- unlist(lapply(salarios, is.factor))  
salariosFactor <- salarios[ , factorsSalarios]
str(salariosFactor)

# One Hot Encoding
salariosDummy <- acm.disjonctif(salariosFactor)


# Discretização
inteirosSalarios <- unlist(lapply(salarios, is.integer))  
salariosInteiros <- salarios[, inteirosSalarios]
str(salariosInteiros)


salariosInteiros$salary.disc <- discretize(salariosInteiros$salary, method = "interval", breaks = 3, labels = c('junior', 'pleno', 'senior'))


# forcats - usando tidyverse para fatores
fct_count(salariosFactor$rank) # conta os fatores

fct_anon(salariosFactor$rank) # anonimiza os fatores

fct_lump(salariosFactor$rank, n = 1) # reclassifica os fatores em mais comum e outros
