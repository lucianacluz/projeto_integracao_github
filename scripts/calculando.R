# Centralizando uma base de dados

#criando distribuicoes simples
binomialnegSimula <- rnbinom(350, mu = 4, size = 10) #distribuicao binomial negativa (casos, medida de dispersao e tamanho)
binomialnegSimula


poissonSimula <- rpois(350, 4) #distribuicao de poisson- e uma distribuicao de probabilidade discreta. Permite que um evento ocorra um certo numero de vezes.  
poissonSimula

hist(binomialnegSimula)
hist(poissonSimula)


# Centralizando a simulação binomial negativa
binomialnegSimulaCentral <- binomialnegSimula - median(binomialnegSimula)
binomialnegSimulaCentral

hist(binomialnegSimula)
hist(binomialnegSimulaCentral)



#Centralizando uma base nativa do R - The Effect of Vitamin C on Tooth Growth in Guinea Pigs
ToothGrowth[,1]
hist(ToothGrowth[,1])
ToothGrowthCentral <- ToothGrowth[,1] - mean(ToothGrowth[,1]) 
hist(ToothGrowthCentral)



