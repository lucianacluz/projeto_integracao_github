#checando se existe pacote, caso não, instala e carrega
if(require(microbenchmark) == F) install.packages('microbenchmark'); require(microbenchmark)

# ------------------------------------------------------
#Aproveitando parte do codigo do exercicio "etl na pratica" 
# ------------------------------------------------------
# carrega a base de sinistros de transito do site da PCR
sinistrosRecife2019Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/3531bafe-d47d-415e-b154-a881081ac76c/download/acidentes-2019.csv', sep = ';', encoding = 'UTF-8')
sinistrosRecife2020Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/fc1c8460-0406-4fff-b51a-e79205d1f1ab/download/acidentes_2020-novo.csv', sep = ';', encoding = 'UTF-8')
sinistrosRecife2021Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/2caa8f41-ccd9-4ea5-906d-f66017d6e107/download/acidentes_2021-jan.csv', sep = ';', encoding = 'UTF-8')

#garantindo que todas as colunas estao em minusculo
names(sinistrosRecife2019Raw) <- tolower(names(sinistrosRecife2019Raw))
names(sinistrosRecife2020Raw) <- tolower(names(sinistrosRecife2020Raw))
names(sinistrosRecife2021Raw) <- tolower(names(sinistrosRecife2021Raw))


# junta as bases de dados com comando rbind (juntas por linhas)
colunas_iguais_parte_1 <- names(sinistrosRecife2020Raw[
  intersect(
    names(sinistrosRecife2019Raw),
    names(sinistrosRecife2020Raw)
  )])

colunas_iguais_parte_2 <- names(sinistrosRecife2020Raw[
  intersect(
    names(sinistrosRecife2020Raw), 
    names(sinistrosRecife2021Raw))])

colunas_iguais_parte_3 <- names(sinistrosRecife2021Raw[
  intersect(
    names(sinistrosRecife2019Raw), 
    names(sinistrosRecife2021Raw))])

# garantindo que estou levando apenas as colunas que possuem intersecao entre todos os anos
colunas_iguais <- intersect(colunas_iguais_parte_1,colunas_iguais_parte_2)
colunas_iguais <- intersect(colunas_iguais,colunas_iguais_parte_3)

# filtrando as colunas em cada ano
sinistrosRecife2019Raw <- sinistrosRecife2019Raw %>% select(all_of(colunas_iguais))
sinistrosRecife2020Raw <- sinistrosRecife2020Raw %>% select(all_of(colunas_iguais))
sinistrosRecife2021Raw <- sinistrosRecife2021Raw %>% select(all_of(colunas_iguais))

sinistrosRecifeRaw <- rbind(sinistrosRecife2019Raw, sinistrosRecife2020Raw, sinistrosRecife2021Raw)

# observa a estrutura dos dados
str(sinistrosRecifeRaw)

# modifca a data para formato date
sinistrosRecifeRaw$data <- as.Date(sinistrosRecifeRaw$data, format = "%Y-%m-%d")

# modifica natureza do sinistro de texto para fator
sinistrosRecifeRaw$natureza_acidente <- as.factor(sinistrosRecifeRaw$natureza_acidente)
sinistrosRecifeRaw$tipo  <- as.factor(sinistrosRecifeRaw$tipo)

# cria função para substituir not available (na) por 0
naZero <- function(x) {
  x <- ifelse(is.na(x), 0, x)
}

# aplica a função naZero a todas as colunas de contagem
sinistrosRecifeRaw[, 14:24] <- sapply(sinistrosRecifeRaw[, 14:24], naZero)

# exporta em formato nativo do R
saveRDS(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.rds")

# ------------------------------------------------------------------
# fim da parte do codigo aproveitado do exercicio "etl na pratica" 
# ------------------------------------------------------------------


# -------------------------------------
# Respondendo ao exercicio de leitura
# -------------------------------------
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

