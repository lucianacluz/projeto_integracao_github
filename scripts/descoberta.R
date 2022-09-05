pacman::p_load(funModeling, tidyverse) 


#Baixando o banco de dados
ToothGrowth

# verificando dados
glimpse(ToothGrowth) 

# estrutura dos dados (missing, etc)
status(ToothGrowth)

# frequência das variáveis fator
freq(ToothGrowth) 

# exploração das variáveis numéricas
plot_num(ToothGrowth) 

# estatísticas das variáveis numéricas
profiling_num(ToothGrowth) 