# carregar as bibliotecas
pacman::p_load(cluster, dplyr, factoextra, ggplot2)
USArrests


# pré-processamento
USArrests_cluster <- USArrests
str(USArrests_cluster)

# definir semente aleatória
set.seed(1)

# Método do Cotovelo
fviz_nbclust(USArrests_cluster, kmeans, method = "wss")

# Agrupamento com kmeans

# aprendizagem ns
cls <- kmeans(x = USArrests_cluster, centers = 3) 

# passamos os clusters para a base original
USArrests_cluster$cluster <- as.factor(cls$cluster)
head(USArrests_cluster)

# plot com função própria do pacote
clusplot(USArrests_cluster, cls$cluster, xlab = 'Fator1', ylab = 'Fator2', main = 'Agrupamento Estados', lines = 0, shade = F, color = TRUE, labels = 2)


