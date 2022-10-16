#Aproveitando o codigo da questao anterior

# carrega as bibliotecas
pacman::p_load(ade4, arules, car, mboost, caret, corrplot, data.table, dplyr, e1071, forcats, funModeling, ggplot2, mlbench, mltools, randomForest, rattle, tidyverse)



# carregando base pronta do tidyverse 
salarios <- carData::Salaries

salarios_D <- acm.disjonctif(as.data.frame(salarios$sex))
names(salarios_D) <- c('Female','Male')

salarios <- cbind(salarios, salarios_D)

# Discretização
salarios$salary <- discretize(salarios$salary, method = "frequency", breaks = 2, labels = c("baixo", "alto"))

# AED 
status(salarios) # explorar a qualidade das variáveis
freq(salarios) # explorar os fatores
plot_num(salarios) # exploração das variáveis numéricas
profiling_num(salarios) # estatísticas das variáveis numéricas

corrplot(cor(salarios[ , c(6,3:4)])) # correlação entre as variáveis

# Treino e Teste: Pré-processamento
particao_salarios = createDataPartition(salarios$salary, p=.7, list = F) # cria a partição 70-30
treino_salarios = salarios[particao_salarios, ] # treino
teste_salarios = salarios[-particao_salarios, ] # - treino = teste

# Validação Cruzada: Pré-processamento
# Controle de treinamento
train.control <- trainControl(method = "cv", number = 10, verboseIter = T) # controle de treino

# Treinamentos:
## Regressão Linear
# salarios_LM <- train(salary ~ yrs.since.phd + yrs.service + Female + Male, data = treino_salarios, method = "lm", trControl = train.control)
# summary(salarios_LM) # sumário do modelo linear

## Árvore de Decisão
salarios_RPART <- train(salary ~ yrs.since.phd + yrs.service + Female + Male, data = treino_salarios, method = "rpart", trControl = train.control)
summary(salarios_RPART)
fancyRpartPlot(salarios_RPART$finalModel) # desenho da árvore
plot(varImp(salarios_RPART)) # importância das variáveis

# Bagging com Floresta Aleatória
salarios_RF <- train(salary ~ yrs.since.phd + yrs.service + Female + Male, data = treino_salarios, method = "cforest", trControl = train.control)

plot(salarios_RF) # evolução do modelo
plot(varImp(salarios_RF)) # plot de importância


#TESTE HUGO
salarios_KNN <- train(salary ~ yrs.since.phd + yrs.service + Female + Male, data = treino_salarios, method = "knn", trControl = train.control)
summary(salarios_KNN) # sumário do modelo de vizinhança

# Boosting com Boosted Generalized Linear Model
salarios_ADA <- train(salary ~ yrs.since.phd + yrs.service + Female + Male, data = treino_salarios, method = "glmboost", trControl = train.control)

plot(salarios_ADA) # evolução do modelo
print(salarios_ADA) # modelo
summary(salarios_ADA) # sumário

melhor_modelo <- resamples(list(RF = salarios_RF, KNN = salarios_KNN, RPART = salarios_RPART,  ADABOOST = salarios_ADA))
#melhor_modelo <- resamples(list(KNN = salarios_KNN, RPART = salarios_RPART,  ADABOOST = salarios_ADA))
melhor_modelo

summary(melhor_modelo)

predVals <- extractPrediction(list(salarios_KNN), testX = teste_salarios[, c(3, 4, 7, 8)], testY = teste_salarios$salary) 
plotObsVsPred(predVals)

#############
# teste_salarios$rank <- cut(teste_salarios$rank, 3, labels=c('AsstProf', 'AssocProf', 'Prof'))
# teste_salarios$discipline <- cut(teste_salarios$discipline, 2, labels=c('A','B'))
# teste_salarios$sex <- cut(teste_salarios$sex, 2, labels=c('Female','Male'))

predicao_salarios_KNN <- predict(salarios_KNN, teste_salarios) # criar predição
cm_salarios_KNN <- confusionMatrix(predicao_salarios_KNN, teste_salarios$salary)
cm_salarios_KNN
cm_salarios_KNN$table

# Expected Accuracy (AccE) = Acuidade Esperada = estimativa de acuidade "esperada", ou seja, uma acuidade mínima que poderia ser conseguida simplesmente "chutando" a classe de forma aleatória. 

gtBaixa <- cm_salarios_KNN$table[1]+cm_salarios_KNN$table[2]
gtAlta <- cm_salarios_KNN$table[3]+cm_salarios_KNN$table[4]
pdBaixa <- cm_salarios_KNN$table[1]+cm_salarios_KNN$table[2]
pdAlta <- cm_salarios_KNN$table[3]+cm_salarios_KNN$table[4]
gtTotal <- gtAlta + gtBaixa
estAcc <- (gtBaixa*pdBaixa/gtTotal^2)+(gtAlta*pdAlta/gtTotal^2)
estAcc



