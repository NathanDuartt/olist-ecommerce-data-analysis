# Olist E-commerce Data Analysis

## Análise de desempenho logístico e experiência do cliente

Estudo de caso de análise de dados desenvolvido a partir do **Brazilian E-Commerce Public Dataset by Olist**, com foco na relação entre desempenho das entregas, satisfação dos clientes e características operacionais dos pedidos.

O projeto aplica técnicas de exploração, tratamento, modelagem e visualização de dados utilizando **SQL e Power BI**, seguindo uma abordagem orientada a problemas de negócio.

---

## Contexto

A experiência de compra em um marketplace não depende apenas do produto adquirido. Prazo de entrega, cumprimento da data estimada e desempenho operacional dos vendedores podem afetar diretamente a percepção do cliente sobre o serviço.

Este estudo busca identificar padrões associados a atrasos de entrega e avaliações negativas, permitindo localizar segmentos da operação que apresentam maior concentração de problemas.

---

## Problema de negócio

**Quais fatores estão associados a atrasos de entrega e avaliações negativas, e quais regiões, categorias de produtos ou vendedores concentram os principais pontos de atenção?**

A análise busca fornecer evidências que possam apoiar decisões relacionadas a:

* desempenho logístico;
* satisfação do cliente;
* acompanhamento de vendedores;
* definição de prioridades operacionais;
* monitoramento de indicadores de experiência do cliente.

---

## Objetivos

O projeto tem como objetivos:

1. Avaliar o desempenho das entregas em relação aos prazos estimados.
2. Investigar a relação entre atrasos e avaliações dos clientes.
3. Identificar diferenças de desempenho entre regiões.
4. Analisar possíveis variações entre categorias de produtos.
5. Identificar vendedores ou segmentos com maior concentração de ocorrências críticas.
6. Desenvolver indicadores que auxiliem no acompanhamento da operação.
7. Apresentar os resultados por meio de um dashboard no Power BI.

---

## Fonte dos dados

Os dados utilizados pertencem ao **Brazilian E-Commerce Public Dataset by Olist**, disponibilizado publicamente no Kaggle.

O conjunto reúne informações anonimizadas sobre pedidos realizados em um marketplace brasileiro e contém diferentes tabelas relacionadas a:

* pedidos;
* clientes;
* itens dos pedidos;
* produtos;
* vendedores;
* pagamentos;
* avaliações;
* localização geográfica.

Os arquivos originais serão preservados separadamente dos dados tratados utilizados na análise.

**Fonte:** Olist — Brazilian E-Commerce Public Dataset
**Plataforma:** Kaggle

---

## Metodologia

A análise está organizada de acordo com as principais etapas do processo de análise de dados.

### 1. Ask

Definição da tarefa de negócio, perguntas analíticas, stakeholders e métricas necessárias para avaliar o problema.

### 2. Prepare

Avaliação da estrutura das bases, relacionamentos entre tabelas, origem dos dados, qualidade, integridade e limitações.

### 3. Process

Limpeza, padronização, tratamento de valores ausentes, validação de campos e preparação das tabelas para análise.

### 4. Analyze

Exploração dos dados utilizando SQL, construção de métricas, agregações e análise de tendências e relacionamentos relevantes para a tarefa de negócio.

### 5. Share

Construção de visualizações e desenvolvimento de dashboard no Power BI para comunicar os resultados aos stakeholders.

### 6. Act

Consolidação dos principais achados e elaboração de recomendações orientadas pelos resultados da análise.

---

## Tecnologias utilizadas

| Tecnologia  | Aplicação                                              |
| ----------- | ------------------------------------------------------ |
| SQL         | Exploração, tratamento, integração e análise dos dados |
| Power BI    | Modelagem, criação de métricas e visualização          |
| Power Query | Transformação e preparação de dados                    |
| GitHub      | Versionamento, documentação e publicação do projeto    |

---

## Indicadores analisados

Entre os indicadores considerados no estudo estão:

* número total de pedidos;
* percentual de entregas realizadas com atraso;
* tempo médio de entrega;
* diferença entre prazo estimado e prazo realizado;
* avaliação média dos pedidos;
* percentual de avaliações negativas;
* valor médio dos pedidos;
* volume de pedidos por estado;
* desempenho por categoria de produto;
* desempenho por vendedor.

Outras métricas poderão ser incorporadas conforme o avanço da análise exploratória.

---

## Estrutura do repositório

```text
olist-ecommerce-data-analysis/
│
├── data/
│   ├── raw/
│   └── processed/
│
├── sql/
│   ├── data_quality.sql
│   ├── exploratory_analysis.sql
│   └── business_analysis.sql
│
├── power-bi/
│
├── images/
│
├── documentation/
│   ├── ask.md
│   ├── prepare.md
│   ├── process.md
│   ├── analyze.md
│   ├── share.md
│   └── act.md
│
└── README.md
```

---

## Entregáveis

Ao final do projeto, o repositório apresentará:

* definição da tarefa de negócio;
* documentação das fontes utilizadas;
* documentação do processo de limpeza e transformação;
* consultas SQL utilizadas na análise;
* principais métricas e resultados;
* dashboard desenvolvido no Power BI;
* principais conclusões;
* recomendações de negócio;
* limitações e possibilidades de análises futuras.

---

## Resultados

Os resultados desta seção serão consolidados após a conclusão da etapa de análise dos dados.

O objetivo será apresentar apenas os achados diretamente sustentados pelos dados, evitando conclusões que não possam ser verificadas pela análise.

---

## Dashboard

O dashboard será desenvolvido no Power BI para apresentar os principais indicadores e permitir a análise do desempenho logístico e da experiência do cliente sob diferentes perspectivas.

A versão final e suas respectivas visualizações serão adicionadas ao repositório após a conclusão da modelagem.

---

## Limitações

O conjunto de dados representa um período histórico específico e não deve ser interpretado como representação atual do mercado brasileiro de comércio eletrônico.

As conclusões deste estudo estarão restritas às informações disponíveis na base e às relações observadas durante a análise.

---

## Sobre o projeto

Este estudo de caso foi desenvolvido como parte do **Google Data Analytics Professional Certificate**, com o objetivo de aplicar o processo completo de análise de dados a um conjunto de dados público e documentar as decisões tomadas ao longo do projeto.
