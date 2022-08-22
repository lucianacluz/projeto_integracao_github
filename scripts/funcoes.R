#instalando o pacote
install.packages('eeptools')

#carregando o pacote
library(eeptools)

#criando a funcao para calcular a idade em anos
calculaIdade <- function(data){
  resultado <- round(age_calc(as.Date(data), units = 'years'))
  return(resultado)  
}

#chamando a funcao
calculaIdade("1982-06-19")
calculaIdade("1981-04-07")