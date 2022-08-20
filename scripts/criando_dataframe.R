#instalando o pacote
install.packages('eeptools')

#carregando o pacote
library(eeptools)

# vetor com nome dos servidores
nomeServidor <- c("Henrique", "Fernando", "Carlos", "Maria", "Eunice", "Amara")

# vetor com datas de nascimento
dataIngresso <- as.Date(c("2009-02-23", "2020-02-21", "2006-08-27", "1990-05-02", "2011-11-15", "2018-09-14"))

# vetor com tempo de serviço
tempoServico <- round( age_calc( dataIngresso, units = 'years'))

# data.frame com base nos vetores
dataframeServidores <- data.frame(
  nome = nomeServidor,       
  data_ingresso = dataIngresso, 
  tempo_servico = tempoServico  
) 

dataframeServidores

