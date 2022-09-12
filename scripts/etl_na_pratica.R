pacman::p_load(dplyr)

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

# exporta em formato tabular (.csv) - padrão para interoperabilidade
write.csv2(sinistrosRecifeRaw, "bases_tratadas/sinistrosRecife.csv")