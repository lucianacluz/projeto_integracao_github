# distribuição normal simulada
simulaDistNormal <- rnorm(200) # a função rnorm cria uma distribuição normal, indicando o total de casos
simulaDistNormal

simulaDistNormal[29] #acessa o 29 elemento

simulaDistNormal[c(22, 55:60)] #acessa os elementos 22 e de 55 a 60. 


#baixando o banco
LAhomes <- read.csv("https://assets.datacamp.com/production/course_3623/datasets/LAhomes.csv")
LAhomes

# funcao para recuperar dados com utilizacao de indexacao

regressao <- lm(price ~ bed, LAhomes)
regressao

regressao$coefficients
regressao$coefficients[1]

#utilizando operadores lógicos

which(LAhomes$city == 'Long Beach') # a função which mostra a posição (as linhas) em que a condição é atendida. Posicao da coluna `city` e igual a Long Beach.
match(LAhomes$city, 'Long Beach Condo/Twh') # também é possível usar a função match para encontrar a correspondência entre dados ou objetos
