library(tidyverse) # 
library(jsonlite) # Ler dados json
library(dplyr) # 
library(here)
library(tidyr)

avaliacoes <- fromJSON("http://localhost:5000/api/v1/evaluation/Esperan%C3%A7a", flatten = TRUE)[[1]][[1]]

d = avaliacoes %>% 
    unnest(itens)    

avaliacoes = avaliacoes %>% 
    group_by(item = item_abreviado, municipio, criterio) %>% 
    summarise(
        encontrado_turmalina = encontrado, 
        local_encontrado_turmalina = onde_foi_encontrado
        )


avaliacoes %>% 
    write_csv(here::here("data/resultados_avaliacoes.csv"))
