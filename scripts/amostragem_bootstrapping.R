# distribuição normal simulada
simulaDistNormal <- rnorm(100) # a função rnorm cria uma distribuição normal, indicando o total de casos
simulaDistNormal

# usando a função sample para amostragem sem reposição  
sample(simulaDistNormal, 15, replace = FALSE) # pegando uma amostra de tamanho 15 

# usando função sample para amostragem com reposição 
sample(simulaDistNormal, 15, replace = TRUE)

# utilizando a  função replicate com bootstraping

set.seed(412) # mantem as amostras iguais agora com execução ponto a ponto

bootsDistNormal10 <- replicate(10, sample(simulaDistNormal, 10, replace = TRUE)) # replica 10x a amostra, criando um bootstrapping
bootsDistNormal10

# calculando uma estatística com bootstrapping (10 amostras)
medianaBootsNormal10 <- replicate(10, median(sample(simulaDistNormal, 10, replace = TRUE))) # calculando a média de 10 amostras de 10 casos
medianaBootsNormal10

# calculando a mediana de 60 amostras de 10 casos
medianaBootsNormal60 <- replicate(60, median(sample(simulaDistNormal, 10, replace = TRUE)))
medianaBootsNormal60

# calculando a mediana de 150 amostras de 10 casos
medianaBootsNormal150 <- replicate(150, median(sample(simulaDistNormal, 10, replace = TRUE))) 
medianaBootsNormal150 

# comparando as medianas
median(medianaBootsNormal10) # mediana do boostraping 10
median(medianaBootsNormal60) # mediana do boostraping 60
median(medianaBootsNormal150) # mediana do boostraping 150
median(distNormalSimulacao) # mediana dos dados originais

# partições
install.packages('caret', dependencies = T) # instalando pacotes - utilizado para treinamento de modelos /classificacao e regressao 
library(caret)

# criando as partições de dados
particaoDistNormal <- createDataPartition(1:length(simulaDistNormal), p=.7) # passando o tamanho do vetor e o parâmetro de divisão
particaoDistNormal

# criando uma partição para treinar os dados, usando a partição anterior. O comando unlist é muito usado para transformar uma lista num vetor
treinoDistNormal <- simulaDistNormal[unlist(particaoDistNormal)] 
treinoDistNormal

#partição para testar os dados, usando a partição anterior.O comando unlist é muito usado para transformar uma lista num vetor.
testeDistNormal <- simulaDistNormal[- unlist(particaoDistNormal)] 
testeDistNormal
