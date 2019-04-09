library(tidyverse) # 
library(jsonlite) # Ler dados json
library(dplyr) # 
library(here)

avaliacoes <- fromJSON("http://127.0.0.1:5000/avaliacao/ultima/detalhe/item")


avaliacoes = avaliacoes %>% 
    group_by(item = item_abreviado, municipio, criterio) %>% 
    summarise(
        encontrado_turmalina = encontrado, 
        local_encontrado_turmalina = onde_foi_encontrado
        )


avaliacoes %>% 
    write_csv(here::here("data/resultados_avaliacoes.csv"))
