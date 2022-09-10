#USArrests
# imputação de valores em outliers ou missing
pacman::p_load(data.table, dplyr, Hmisc, VIM) # carrega pacotes


## imputação numérica
# preparação da base, colocando NA aleatórios

#copiando base USArrests, usando a data.table
USArrestsDT <- USArrests %>% setDT() - #NAO RODA
(USArrestsNASeed <- round(runif(10, 20, 40))) #criando 10 valores aleatórios

#imputando NA nos valores aleatórios
(USArrestsDT$Murder[USArrestsNASeed] <- NA) #NAO RODA
USArrestsDT

# tendência central
USArrestsDT$Murder <- impute(USArrestsDT$Murder, fun = mean) # média
USArrestsDT$Murder <- impute(USArrestsDT$Murder, fun = median) # mediana

is.imputed(USArrestsDT$Murder) # teste se o valor foi imputado
table(is.imputed(USArrestsDT$Murder)) # tabela de imputação por sim / não

# predição
USArrestsDT$Murder[USArrestsNAseed] <- NA # recolocamos os NA

regUSArrests <- lm(Murder ~ ., data = USArrestsDT) # criamos a regressão
USArrestsNAIndex <- is.na(USArrestsDT$Murder) # localizamos os NA
USArrestsDT$Murder[USArrestsNAIndex] <- predict(regUSArrests, newdata = USArrestsDT[USArrestsNAIndex, ]) # imputamos os valores preditos

## Hot deck
# imputação aleatória
USArrestsDT$Murder[USArrestsNAseed] <- NA # recolocamos os NA

(USArrestsDT$Murder <- impute(USArrestsDT$Murder, "random")) # fazemos a imputação aleatória

# imputação por instâncias /semelhança
USArrestsDT$Murder[USArrestsNASeed] <- NA # recolocamos os NA
USArrestsDT2 <- kNN(USArrestsDT)
