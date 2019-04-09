# EDA de dados Investidores em Tesouro direto


Análise exploratória dos perfis de investidores em Tesouro Direto. Os dados originais vem do  [Portal brasileiro de dados abertos](http://dados.gov.br/dataset/investidores-do-tesouro-direto/resource/0fd2ac86-4673-46c0-a889-b46224ade563)
 
Este conjunto de dados contém a lista de investidores cadastrados no programa Tesouro Direto. Quando um investidor possui cadastro em mais de uma instituição financeira, esse outro cadastro é registrado em uma nova linha com o mesmo código de investidor. Frequência: Atualização mensal, até o quinto dia útil de cada mês.

Em qualquer trabalho derivado deste, por favor cite a fonte original. 

## Dependências

```
deps = c("tidyverse", "lubridate", "ggplot2", "here")
install.packages(deps)

```

## Organização

* `code` - Scripts para ingerir e transformar os dados brutos, e funções fatoradas de relatórios
* `data` - Dados depois de obtidos, organizados e transformados a partir da fonte original
* `reports` - Notebooks com análises

# analyze-auditor-crawlers
