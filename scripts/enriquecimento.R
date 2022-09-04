#### CARREGANDO PACOTES ####
pacman::p_load(dplyr, tidyverse, readxl, geobr)

#### LENDO AS BASES PARA O R ####

# Carrega os dados geograficos(arquivos de shapes) dos estados do Brasil
estados_br_by_geobr <- read_state(code_state = "all", year=2018)

# Carrega a base eleitas_por_estado
eleitas_por_estado <- read_excel("bases_tratadas/eleitas_por_estado_2018.xlsx", sheet = 1)


# Junta os dados das duas fontes acima a partir das colunas ["code_state" e "CD_GEOCODU"] existentes em cada uma
eleitas_por_estado_enriquecida <- left_join(estados_br_by_geobr, eleitas_por_estado, by = c("code_state" = "CD_GEOCODU")) 
