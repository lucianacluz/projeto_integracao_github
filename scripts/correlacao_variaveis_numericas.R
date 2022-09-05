## CORRELAÇÃO COM R ##
# CARREGANDO OS PACOTES
pacman::p_load(corrplot, dplyr, ggplot2)

USArrests

# TABELA DE CORRELAÇÃO COM TODAS AS VARIÁVEIS #
cor(USArrests)

# GRÁFICOS DE DISPERSÃO PAREADOS DAS VARIÁVEIS #
pairs(USArrests)

# CORRPLOT DAS VARIÁVEIS #
USArrestsCor <- cor(USArrests)
USArrestsCor

corrplot(USArrestsCor, method = "number", order = 'alphabet')
corrplot(USArrestsCor, order = 'alphabet') 