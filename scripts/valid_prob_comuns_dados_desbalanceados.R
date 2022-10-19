# carrega as bibliotecas
pacman::p_load(ade4, arules, car, caret, corrplot, data.table, dplyr, e1071, forcats, funModeling, ggplot2, mlbench, mltools, randomForest, rattle, tidyverse)

# carregando base pronta do tidyverse 
salarios <- carData::Salaries

# Dummies
salarios_D <- acm.disjonctif(as.data.frame(salarios$sex))
names(salarios_D) <- c('Female','Male')

salarios <- cbind(salarios, salarios_D)

# Discretização
salarios$salaryDisc <- discretize(salarios$salary, method = "interval", breaks = 2, labels = c("baixo", "alto"))

table(salarios$salaryDisc)

# Treino e Teste: Pré-processamento
particaoSalario = createDataPartition(salarios$salary, p=.7, list = F) # cria a partição 70-30
treinoSalario = salarios[particaoSalario, ] # treino
testeSalario = salarios[-particaoSalario, ] # - treino = teste
table(treinoSalario$salaryDisc)

# down / under
treinoSalarioDs <- downSample(x = treinoSalario[, -ncol(treinoSalario)], y = treinoSalario$salaryDisc)
table(treinoSalarioDs$Class) 

# up
treinoSalarioUs <- upSample(x = treinoSalario[, -ncol(treinoSalario)], y = treinoSalario$salaryDisc)
table(treinoSalarioUs$Class)