
#criando um vetor simples
vetor_frutas <- c("maca", "banana","laranja")
vetor_frutas

#objeto complexo
LAhomes <- read.csv("https://assets.datacamp.com/production/course_3623/datasets/LAhomes.csv")
laHomes <- lm(price ~ bed, LAhomes)
laHomes

#verificando a complexidade
str(laHomes)
