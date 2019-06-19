library(tidyverse) # 
library(jsonlite) # Ler dados json
library(dplyr) # 
library(here)
library(tidyr)
library(readr)


avaliacoes <- fromJSON("http://localhost:5000/api/v1/evaluation", flatten = TRUE)

avaliacoes <- avaliacoes %>% 
    unnest(criterions) %>%
    unnest(itens) %>%
    group_by(item = name1, municipio = county, criterio = name) %>% 
    summarise(
        valid, 
        found,
        pathSought
    )
    

avaliacoes %>% 
    write_csv(here::here("data/resultados_avaliacoes.csv"))
