# semente aleatória de geração de dados
# usando a função addTaskCallback deixamos a set.seed fixa, rodando no back

setandoSemente <- addTaskCallback(function(...) {set.seed(123);TRUE}) # atribui a tarefa à variável definindoSemente
setandoSemente # imprime 

# distribuição normal simulada
simulaDistNormal <- rnorm(100) # a função rnorm cria uma distribuição normal, indicando o total de casos
simulaDistNormal

# apresenta sumário do objeto simulaDistNormal
summary(simulaDistNormal) 

# distribuição binomial simulada
simulaDistBinominal <- rbinom(100, 1, 0.7) # rbinom para criar distribuição binominal, indicando casos, tamanho e probabilidade
simulaDistBinominal

# repetições
generoSimulacao <- c(rep("Homem", length(simulaDistBinominal)/2), rep("Mulher", length(simulaDistBinominal)/2)) # vetor repetindo a classe Homem e Mulher
generoSimulacao

# sequências
indexSimulacao <- seq(1, length(simulaDistNormal)) # criacao de vetor com sequencial de 1 a 100 (total de casos), usando a função length para pegar o total de casos
indexSimulacao

# a função removeTaskCallback pode ser usada para remover a tarefa criada lá em cima
removeTaskCallback(setandoSemente)