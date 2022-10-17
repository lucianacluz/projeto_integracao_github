pacman::p_load(dplyr, ggplot2, data.table, gridExtra)

# carregar dados de sinistros em Recife em 2021
sinistrosRec <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/2caa8f41-ccd9-4ea5-906d-f66017d6e107/download/acidentes_2021-jan.csv', sep = ';', encoding = 'UTF-8')

# agrupar casos por município ajustando variáveis
sinistrosRecBairros <- sinistrosRec %>% count(bairro, sort = T, name = 'acidentes_bairro') %>% mutate(acidentes_bairro2 = sqrt(acidentes_bairro), acidentes_bairro_log = log10(acidentes_bairro))

# criar loop para os diferentes gráficoss
nomeVar <- names(sinistrosRecBairros)[2:4] # passar nomes das vars para vetor
listaPlots <- NULL

for(i in nomeVar) {
  plot <- sinistrosRecBairros %>% ggplot(aes_string(x = 'bairro', y=i)) + geom_bar(stat = "identity") + labs(x = "Bairro")
  listaPlots[[length(listaPlots) + 1]] <-plot
} # criar lista com os plots

# printar todos os plots, lado a lado
grid.arrange(listaPlots[[1]], listaPlots[[2]], listaPlots[[3]], ncol=3)

