library(tidyverse) # 
library(jsonlite) # Ler dados json
library(dplyr) # 
library(here)
library(tidyr)
library(readr)
library(lubridate)

avaliacoes_dataset <- readr::read_csv(here::here("data/resultados_avaliacoes.csv"))
    
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
    group_by(item = name, municipio = county, criterio, aproach, date = as.POSIXct(gsub('Z', ' ', gsub('T', ' ', date)))) %>% 
    summarise(
        valid,
        contNodeNumberAccess,
        found,
        pathSought,
        durationMin = as.numeric(durationMin),
        duration = as.numeric(duration)
    )


avaliacoes<-full_join(avaliacoes, avaliacoes_dataset, by=c("municipio", "item", "criterio", "aproach", 
                                                           "date", "valid", "contNodeNumberAccess",
                                                           "found", "pathSought", "durationMin", "duration"))

avaliacoes %>% 
    write_csv(here::here("data/resultados_avaliacoes.csv"))


