# extrair / carregar arquivos texto

#arquivos csv
genero_por_nome <- read.csv2('https://archive.ics.uci.edu/ml/machine-learning-databases/00591/name_gender_dataset.csv', sep = ',', encoding = 'UTF-8')
genero_por_nome

# arquivos json
# install.packages('rjson')
library(rjson)
pesagensResiduos <- fromJSON(file= "http://dados.recife.pe.gov.br/dataset/2bc56ecf-4716-449e-9c72-1241f090c6d9/resource/e3e648af-9a9f-4429-b696-a71adf461557/download/metadados-pesagens.json" )
pesagensResiduosMetadados <- as.data.frame(pesagensResiduos)

# arquivos xml
# install.packages('XML')
library(XML)
region <- xmlToDataFrame("http://aiweb.cs.washington.edu/research/projects/xmltk/xmldata/data/tpc-h/region.xml")
region


