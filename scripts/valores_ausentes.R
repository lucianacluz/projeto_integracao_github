#Carregando os pacotes
pacman::p_load(data.table, funModeling, tidyverse) 

basededados <- read_csv2("bases_tratadas/cadastro_base.csv")

## identificando e removendo valores ausentes
status(basededados)

# Variação de Complete-case analysis – listwise deletion
dim(basededados_completo <- basededados %>% filter(!is.na(credit_card)))

## estimando se o NA é MCAR, MAR ou MANR
## Shadow Matrix do livro R in Action

data(sleep, package = "VIM") # importa a base sleep

head(sleep) # observa a base

x <- as.data.frame(abs(is.na(sleep))) # cria a matrix sombra
head(x) # observa a matriz sombra

y <- x[which(sapply(x, sd) > 0)] # mantém apenas variáveis que possuem NA
cor(y) # observa a correlação entre variáveis

cor(sleep, y, use="pairwise.complete.obs") # busca padrões entre os valores específicos das variáveis e os NA

## Shadow Matrix da base
basededadosNA <- as.data.frame(abs(is.na(basededados))) # cria a matriz sombra da base
basededadosNA <- basededadosNA[which(sapply(basededadosNA, sd) > 0)] # mantém variáveis com NA

round(cor(basededadosNA), 3) # calcula correlações


# trazendo uma variável de interesse (good_payer) de volta pro frame
basededadosNA <- cbind(basededadosNA, good_payer = basededados$good_payer) 

# sumarizando e observando se os NA se concentram nos registros de bons ou maus pagadores(good_payer)
basededadosNAgood_payer<- basededadosNA %>% group_by(good_payer) %>% summarise(across(everything(), list(sum)))


