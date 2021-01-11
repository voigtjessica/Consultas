# Scrap de uma tabela da Wikipedia com Rvest:
#install.packages("rvest")

library(xml2) # tá sempre pedindo esse pacote pra rodar o rvest
library(rvest)
library(dplyr)
library(janitor)
library(stringr)
library(ggplot2)

url <- "https://pt.wikipedia.org/wiki/Lista_de_munic%C3%ADpios_do_Brasil_por_população_(2020)"

sample = url %>%
  read_html() %>%
  html_node(xpath = '//*[@id="mw-content-text"]/div[1]/table') %>%
  html_table(fill = TRUE)

#São Paulo 	pop :12 325 232

# Montando uma nova coluna com os valores numéricos da pop:

df <- sample %>%
  clean_names() %>%
mutate(pop_num = gsub("[[:space:]]", "", populacao),
       pop_num = as.numeric(pop_num),
       pop_mil = pop_num/1000,
       codigo_ibge = as.character(codigo_ibge))

glimpse(df)
summary(df)
