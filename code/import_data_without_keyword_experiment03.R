library(tidyverse) # 
library(jsonlite) # Ler dados json
library(dplyr) # 
library(here)
library(tidyr)
library(readr)
library(lubridate)

avaliacoes_dataset <- readr::read_csv(here::here("data/resultados_avaliacoes_exp03.csv"))
    
avaliacoes <- data.frame(fromJSON("http://localhost:5000/api/v1/evaluation", flatten = TRUE))

avaliacoes$duration <- NULL
avaliacoes$durationMin <- NULL

avaliacoes <- avaliacoes %>% 
    unnest(criterions)

avaliacoes$`__v` <- NULL
avaliacoes$`_id` <- NULL

avaliacoes <- avaliacoes %>% 
    rename(criterio = name) %>% 
    unnest(itens) %>%
    group_by(id = `_id`, item = name, municipio = county, criterio, aproach, date = as.POSIXct(gsub('Z', ' ', gsub('T', ' ', date)))) %>% 
    summarise(
        valid,
        contNodeNumberAccess,
        found,
        pathSought,
        durationMin = as.numeric(durationMin),
        duration = as.numeric(duration)
    )

avaliacoes <- avaliacoes %>% 
    group_by(municipio, aproach, date) %>% 
    mutate(tipo_exp = ifelse( n() <= 48, "less_itens", 'all_itens')) %>%
    ungroup()

avaliacoes<-full_join(avaliacoes, avaliacoes_dataset, by=c("id","municipio", "item", "criterio", "aproach", 
                                                           "date", "valid", "contNodeNumberAccess",
                                                           "found", "pathSought", "durationMin", "duration", 'tipo_exp'))

avaliacoes <- avaliacoes %>% 
    distinct(id, .keep_all = TRUE)

avaliacoes %>% 
    write_csv(here::here("data/resultados_avaliacoes_exp03.csv"))


