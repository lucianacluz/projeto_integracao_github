#checando se existe pacote, caso não, instala e carrega
if(require(microbenchmark) == F) install.packages('microbenchmark'); require(microbenchmark)

#Aproveitando as bases de dados do exercicio "etl na pratica" 

#1 - carrega base de dados em formato nativo do R para salvá-la em um novo formato
sinistrosRecife <- readRDS('bases_tratadas/sinistrosRecife.rds')

#2 - salvando no formato TXT
write.table(sinistrosRecife, file = "bases_tratadas/sinistrosRecife.txt", sep = "\t", row.names = TRUE, col.names = NA)

#3 - compara os três processos de leitura, usando a função microbenchmark
microbenchmark(
  a <- readRDS('bases_tratadas/sinistrosRecife.rds'), 
  b <- read.csv2('bases_tratadas/sinistrosRecife.csv', sep = ';'),
  c <- read.delim('bases_tratadas/sinistrosRecife.txt', sep = '\t')
  , times = 10L)


#4- compara os três processos de exportação, usando a função microbenchmark
microbenchmark(
  a <- saveRDS(sinistrosRecife, "bases_tratadas/sinistrosRecife.rds"), 
  b <- write.csv2(sinistrosRecife, "bases_tratadas/sinistrosRecife.csv"),
  c<- write.table(sinistrosRecife, file = "bases_tratadas/sinistrosRecife.txt", sep = "\t", row.names = TRUE, col.names = NA),
  times = 30L)

# E possível observar a partir do microbenchmark que a média de tempo para a leitura foi menor com o formato RDS. 
#Já para exportação, o menor tempo médio foi com o formato CSV. 
 

#Respondendo a pergunta:
#A principal vantagem dos arquivos em formatos como: CSV, TXT, JSON e XML é que podem ser lidos em 
#diversas tecnologias (o que garante a interoperabilidade), além do R. Até com um simples editor de texto 
#é possivel visualizar o conteudo. Neste exemplo, o CSV teve a maior média de 
#tempo de leitura e a menor média de tempo de exportação. O TXT teve um valor menor na média de tempo de exportação do que
#no tempo de leitura.  
#Já o .RDS é um formato nativo da linguagem R e seu conteudo não pode ser visualizado em qualquer editor. Neste exemplo 
#apresentou a menor média de tempo para leitura, mas a maior médio de tempo para exportação. 

