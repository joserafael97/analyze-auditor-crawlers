read_avaliacoes <- function(municipio_nome=''){
    library(dplyr)
    data = readr::read_csv(here::here("data/resultados_avaliacoes.csv"))
    if(municipio_nome == ''){
        data
    } else {
        data %>% filter(municipio == municipio_nome)
    }
}


read_gabaritos <- function(municipio_nome=''){
    library(dplyr)
    data = readr::read_csv(here::here("data/gabaritos/Gabaritos - todos.csv"))
    
    if(municipio_nome == ''){
        data
    } else {
        data %>% filter(municipio == municipio_nome)
    }
}
