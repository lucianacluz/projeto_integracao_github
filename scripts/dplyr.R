#checando se existe pacote, caso não, instala e carrega
if(require(tidyverse) == F) install.packages('tidyverse'); require(tidyverse)
if(require(dplyr) == F) install.packages('dplyr'); require(dplyr)


# carregando base pronta do tidyverse 
salarios <- carData::Salaries
str(salarios)

# sumários
count(salarios, yrs.service) 

# sumários com agrupamentos
salarios %>% group_by(rank) %>% summarise(avg = mean(yrs.service))


### Transformação de Casos

# seleção de casos
salarios %>%  filter(sex != "male") %>% summarise(salary_mean = mean(salary))
salarios %>%  
  filter(sex != "female") %>% 
  group_by(sex, rank) %>% 
  summarise(year_service_mean = mean(yrs.service)) %>% 
  arrange(desc(year_service_mean), rank)

# ordenar casos
arrange(salarios, yrs.service) # ascendente

arrange(salarios, desc(yrs.since.phd)) # descendente

### Transformação de Variáveis

# seleção de colunas
salarios %>% select(salary, rank, sex) %>% arrange(salary)

# novas colunas
salarios<- salarios %>% mutate(salary_yrs_service = salary/yrs.service)

# renomear
salarios %>% rename(salary_years_service = salary_yrs_service)




