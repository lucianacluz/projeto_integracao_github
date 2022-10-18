# carrega as bibliotecas
pacman::p_load(ade4, arules, car, caret, corrplot, data.table, dplyr, DMwR, e1071, forcats, funModeling, ggplot2, mlbench, mltools, randomForest, rattle, tidyverse)

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

prop.table(table(treinoSalario$salaryDisc))

# Validação Cruzada: Pré-processamento
# Controle de treinamento
train.control <- trainControl(method = "cv", number = 10, verboseIter = T) # controle de treino


matrizCusto <- matrix(c(0,1,1000,0), ncol = 2)
rownames(matrizCusto) <- levels(treinoSalario$salaryDisc)
colnames(matrizCusto) <- levels(treinoSalario$salaryDisc)
matrizCusto

Salarios_RF_CLASS <- randomForest(salaryDisc ~ yrs.since.phd + yrs.service + Female + Male, data = treinoSalario, method = "cforest", parms = list(loss = matrizCusto))
Salarios_RF_CLASS

Salarios_C5_CLASS <- train(salaryDisc ~ yrs.since.phd + yrs.service + Female + Male, data = treinoSalario, method = "C5.0Cost", trControl = train.control)
Salarios_C5_CLASS


predicaoSalarios_RF_CLASS = predict(Salarios_RF_CLASS, testeSalario) # criar predição
cmSalarios_RF_CLASS <- confusionMatrix(predicaoSalarios_RF_CLASS, testeSalario$salaryDisc)
cmSalarios_RF_CLASS

predicaoSalarios_RF_CLASS = predict(Salarios_C5_CLASS, testeSalario) # criar predição
cmSalarios_C5_CLASS <- confusionMatrix(predicaoSalarios_RF_CLASS, testeSalario$salaryDisc)
cmSalarios_C5_CLASS