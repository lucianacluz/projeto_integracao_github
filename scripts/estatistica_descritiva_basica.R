### Estatística Descritiva com R

#Baixando o banco
USArrests

## Tabela de frequência absoluta da variável Assault da base USArrests
table(USArrests$Assault)


## Tabela de frequência relativa da variável Assault da base USArrests
prop.table(table(USArrests$Assault))

## Média da variável Assault da base USArrests
mean(USArrests$Assault)

## Mediana da variável Assault da base USArrests
median(USArrests$Assault)

## Separatrizes da variável Assault da base USArrests
quantile(USArrests$Assault, probs=0.25)
quantile(USArrests$Assault, probs=0.50)
quantile(USArrests$Assault, probs=0.85)

# boxplot - gráfico que resume as sepatrizes
boxplot(USArrests$Assault) 

## Desvio-padrão da variável Assault da base USArrests
sd(USArrests$Assault)
plot(USArrests$Assault)

## Sumário descritivo básico das variáveis
summary(USArrests)

## Sumário descritivo completo das variáveis usando o pacote fBasics
pacman::p_load(fBasics)
basicStats(USArrests[ , c(1:4)])

# histograma - gráfico que permite conhecer a curva dos dados
hist(USArrests$Assault) 



