library(tidyverse) # 
library(jsonlite) # Ler dados json
library(dplyr) # 
library(here)
library(tidyr)
library(readr)


avaliacoes <- data.frame(fromJSON("http://localhost:5000/api/v1/evaluation/bandit/last", flatten = TRUE))
avaliacoes$duration <- NULL
avaliacoes$durationMin <- NULL

avaliacoes <- avaliacoes %>% 
    unnest(criterions)

avaliacoes$`__v` <- NULL
avaliacoes$`_id` <- NULL

avaliacoes <- avaliacoes %>% 
    rename(criterio = name) %>% 
    unnest(itens) %>%
    group_by(item = name, municipio = county, criterio) %>% 
    summarise(
        valid, 
        found,
        pathSought,
        durationMin,
        duration
    )
    

avaliacoes %>% 
    write_csv(here::here("data/resultados_avaliacoes.csv"))
