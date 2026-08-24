# Process — Limpeza, transformação e validação dos dados

## Objetivo

A etapa de processamento teve como objetivo verificar a integridade dos dados, identificar problemas de qualidade e preparar estruturas adequadas para a análise.

Os arquivos CSV originais foram preservados sem alterações. No BigQuery, as tabelas importadas foram mantidas no conjunto de dados `olist_raw`, enquanto as estruturas tratadas utilizadas nas análises foram criadas separadamente em `olist_analytics`.

Essa separação permite preservar os dados de origem e manter as transformações de forma reproduzível.

---

## Ferramentas utilizadas

### Google BigQuery

O BigQuery foi utilizado para:

* importar os arquivos CSV;
* validar a quantidade de registros;
* verificar tipos de dados;
* identificar valores ausentes;
* verificar duplicidades;
* analisar a unicidade das principais chaves;
* realizar transformações;
* criar views analíticas;
* executar consultas SQL.

### GitHub

O GitHub foi utilizado para documentar o processo, armazenar as consultas SQL e registrar as decisões metodológicas adotadas durante o estudo de caso.

---

## Estrutura dos dados no BigQuery

Foram criados dois datasets:

### `olist_raw`

Contém as tabelas importadas diretamente dos arquivos CSV originais.

### `olist_analytics`

Contém views e estruturas tratadas utilizadas durante a análise.

A estrutura adotada foi:

```text
olist-data-analysis
│
├── olist_raw
│   ├── customers
│   ├── order_items
│   ├── order_reviews
│   ├── orders
│   ├── products
│   └── sellers
│
└── olist_analytics
    ├── orders_clean
    └── reviews_clean
```

---

## Importação dos dados

Seis tabelas consideradas prioritárias para o problema de negócio foram inicialmente importadas para o BigQuery:

| Tabela          | Registros |
| --------------- | --------: |
| `customers`     |    99.441 |
| `order_items`   |   112.650 |
| `order_reviews` |    99.224 |
| `orders`        |    99.441 |
| `products`      |    32.951 |
| `sellers`       |     3.095 |

Após a importação, a quantidade de registros foi comparada com os arquivos de origem para verificar se houve perda de dados.

Nenhuma diferença foi identificada.

### Particularidade da tabela de avaliações

Durante a importação de `olist_order_reviews_dataset.csv`, foi necessário habilitar a opção que permite novas linhas dentro de campos entre aspas.

Alguns comentários dos clientes contêm quebras de linha dentro do próprio texto. Sem essa configuração, o BigQuery interpretava essas quebras como novos registros do arquivo CSV.

---

## Verificação das principais chaves

Foi analisada a unicidade das principais chaves do conjunto de dados.

Não foram identificadas duplicidades nas seguintes estruturas:

* `orders.order_id`;
* `customers.customer_id`;
* `products.product_id`;
* `sellers.seller_id`;
* combinação entre `order_id` e `order_item_id` na tabela de itens.

Os resultados confirmaram:

| Tabela        | Registros | Chaves distintas | Registros excedentes |
| ------------- | --------: | ---------------: | -------------------: |
| `orders`      |    99.441 |           99.441 |                    0 |
| `customers`   |    99.441 |           99.441 |                    0 |
| `products`    |    32.951 |           32.951 |                    0 |
| `sellers`     |     3.095 |            3.095 |                    0 |
| `order_items` |   112.650 |          112.650 |                    0 |

---

## Avaliações múltiplas por pedido

A tabela `order_reviews` apresentou:

* 99.224 registros;
* 98.673 pedidos distintos;
* 551 registros adicionais em relação ao número de `order_id` únicos.

Uma investigação mais detalhada mostrou que esses registros não representavam simplesmente linhas duplicadas.

Foram encontrados 547 pedidos com mais de uma avaliação:

* 543 pedidos possuem duas avaliações;
* 4 pedidos possuem três avaliações.

Os registros possuem diferentes `review_id` e, em alguns casos, diferentes notas.

Por esse motivo, não foi utilizado apenas `DISTINCT` para remover os registros excedentes.

---

## Criação da view `reviews_clean`

Para garantir uma única avaliação por pedido durante as análises, foi criada a view:

```text
olist_analytics.reviews_clean
```

Quando existiam várias avaliações associadas ao mesmo pedido, foi mantida a avaliação mais recente.

A prioridade utilizada foi:

1. `review_answer_timestamp`;
2. `review_creation_date`;
3. `review_id`.

A lógica utilizada foi:

```sql
QUALIFY ROW_NUMBER() OVER (
  PARTITION BY order_id
  ORDER BY
    review_answer_timestamp DESC,
    review_creation_date DESC,
    review_id DESC
) = 1
```

Após o tratamento, a view apresentou:

* 98.673 registros;
* 98.673 `order_id` distintos.

Isso confirmou que passou a existir somente uma avaliação por pedido.

---

## Distribuição das avaliações

Antes de classificar as avaliações, foi analisada a distribuição das notas.

| Nota | Avaliações | Participação |
| ---- | ---------: | -----------: |
| 1    |     11.424 |       11,51% |
| 2    |      3.151 |        3,18% |
| 3    |      8.179 |        8,24% |
| 4    |     19.142 |       19,29% |
| 5    |     57.328 |       57,78% |

A partir dessa distribuição, foi criada uma classificação de satisfação:

```sql
CASE
  WHEN review_score IN (1, 2) THEN 'negative'
  WHEN review_score = 3 THEN 'neutral'
  WHEN review_score IN (4, 5) THEN 'positive'
END
```

As avaliações foram classificadas da seguinte maneira:

* `negative`: notas 1 e 2;
* `neutral`: nota 3;
* `positive`: notas 4 e 5.

A classificação foi incorporada à view `reviews_clean`.

---

## Valores ausentes na tabela de pedidos

A tabela `orders` apresentou valores ausentes em alguns campos relacionados ao processamento e à entrega:

* 160 registros sem `order_approved_at`;
* 1.783 registros sem `order_delivered_carrier_date`;
* 2.965 registros sem `order_delivered_customer_date`.

Esses valores não foram automaticamente tratados como erros.

Foi analisada a distribuição das ausências de acordo com `order_status`.

Grande parte dos valores ausentes corresponde a pedidos:

* cancelados;
* indisponíveis;
* em processamento;
* faturados;
* enviados, mas ainda não entregues.

Portanto, a ausência de uma data de entrega pode ser coerente com o estado do pedido.

---

## Seleção dos pedidos válidos para análise logística

Como o objetivo do estudo envolve desempenho de entrega, foram utilizados apenas pedidos efetivamente entregues e que possuem data de entrega registrada.

Os critérios adotados foram:

```sql
order_status = 'delivered'
AND order_delivered_customer_date IS NOT NULL
```

Após esse filtro, foram obtidos:

* 96.470 pedidos;
* 96.470 `order_id` distintos.

Esses registros foram utilizados para criar a view:

```text
olist_analytics.orders_clean
```

---

## Cálculo do tempo de entrega

Foi criado o indicador `delivery_days`, representando o número de dias entre a compra e a entrega ao cliente.

```sql
DATE_DIFF(
  DATE(order_delivered_customer_date),
  DATE(order_purchase_timestamp),
  DAY
)
```

Esse indicador permite avaliar o tempo total transcorrido entre a realização do pedido e seu recebimento.

---

## Cálculo dos dias de atraso

Também foi criado o indicador `delay_days`, calculado pela diferença entre a data real de entrega e a data estimada.

```sql
DATE_DIFF(
  DATE(order_delivered_customer_date),
  DATE(order_estimated_delivery_date),
  DAY
)
```

Valores positivos indicam entrega posterior à data prevista.

Valores iguais ou inferiores a zero indicam entrega realizada no prazo ou antes da previsão.

---

## Definição de entrega atrasada

Inicialmente, a comparação entre a entrega real e a estimada utilizava os timestamps completos.

Durante a validação foi identificado que essa abordagem poderia classificar incorretamente como atrasado um pedido entregue no mesmo dia previsto, mas em horário posterior ao timestamp da data estimada.

Por esse motivo, a regra foi ajustada para comparar apenas as datas.

A definição final utilizada foi:

```sql
CASE
  WHEN DATE(order_delivered_customer_date) >
       DATE(order_estimated_delivery_date)
  THEN TRUE
  ELSE FALSE
END
```

Com essa regra, foram encontrados:

* 96.470 pedidos entregues analisáveis;
* 6.534 pedidos atrasados;
* taxa de atraso de 6,77%.

Essa passou a ser a definição oficial de atraso utilizada no estudo.

---

## Valores ausentes na tabela de produtos

A tabela `products` apresentou:

* 610 registros sem categoria;
* 610 registros sem informações de comprimento do nome;
* 610 registros sem comprimento da descrição;
* 610 registros sem quantidade de fotos;
* 2 registros sem peso;
* 2 registros sem dimensões físicas.

Esses valores não foram preenchidos artificialmente.

Quando uma análise depende diretamente da categoria do produto, os registros sem categoria são excluídos apenas daquela análise específica.

Os demais registros permanecem disponíveis para análises em que esses campos não são necessários.

---

## Valores ausentes nas avaliações

Na tabela de avaliações foram identificados:

* 87.656 registros sem título do comentário;
* 58.247 registros sem mensagem de comentário.

O campo `review_score`, utilizado como principal indicador de satisfação do cliente, não apresenta valores ausentes.

Por esse motivo, avaliações sem conteúdo textual foram mantidas.

A ausência de texto não impede a utilização da nota na análise de satisfação.

---

## Granularidade das tabelas

Um dos principais cuidados durante o processamento foi considerar que as tabelas possuem diferentes níveis de granularidade.

A tabela `orders` apresenta uma linha por pedido.

Já `order_items` pode apresentar várias linhas para o mesmo pedido, porque um pedido pode possuir:

* vários itens;
* diferentes produtos;
* diferentes categorias;
* mais de um vendedor.

Realizar JOINs sem considerar essa característica poderia aumentar artificialmente o número de pedidos e distorcer métricas.

---

## Tratamento da análise por categoria

Para evitar contagem repetida do mesmo pedido dentro da mesma categoria, foi utilizada uma combinação distinta de:

```text
order_id + product_category_name
```

A estrutura utilizada foi:

```sql
SELECT DISTINCT
  oi.order_id,
  p.product_category_name
```

Um pedido que contenha produtos pertencentes a categorias diferentes pode aparecer em mais de uma categoria.

Por esse motivo, resultados agregados por categoria não devem ser somados como se representassem pedidos exclusivos.

---

## Tratamento da análise por vendedor

Um único pedido também pode possuir produtos fornecidos por vendedores diferentes.

Nesse cenário, atribuir o atraso total do pedido a todos os vendedores envolvidos poderia gerar interpretações incorretas.

Para a análise inicial de desempenho por vendedor, foram considerados apenas pedidos associados a um único vendedor.

A quantidade de vendedores por pedido foi calculada utilizando:

```sql
COUNT(DISTINCT seller_id)
```

Foram selecionados para essa análise apenas os registros em que:

```sql
seller_count = 1
```

Também foi utilizado um limite mínimo de 100 pedidos com avaliação por vendedor nas comparações de desempenho, reduzindo o destaque de taxas extremas baseadas em volumes muito pequenos.

---

## Validações realizadas durante o processamento

Durante a etapa de processamento foram verificadas:

* quantidade total de registros;
* unicidade das principais chaves;
* presença de valores ausentes;
* distribuição dos status dos pedidos;
* coerência dos valores ausentes com o status;
* multiplicidade das avaliações;
* distribuição das notas;
* granularidade das tabelas;
* consistência das datas;
* quantidade de registros após as transformações;
* unicidade das views tratadas;
* impacto das regras utilizadas para definir atraso.

As transformações foram realizadas sem alterar as tabelas originais.

---

## Estruturas finais utilizadas na análise

### `olist_analytics.reviews_clean`

Contém uma avaliação por pedido e inclui:

* `review_id`;
* `order_id`;
* `review_score`;
* classificação da avaliação;
* título do comentário;
* mensagem do comentário;
* data de criação;
* timestamp da resposta.

### `olist_analytics.orders_clean`

Contém somente pedidos entregues com data de entrega válida e inclui:

* `order_id`;
* `customer_id`;
* data da compra;
* data de aprovação;
* data de envio;
* data de entrega;
* data estimada;
* tempo de entrega;
* dias de atraso;
* indicador de atraso.

---

## Resultado da etapa

Ao final da etapa de processamento, os dados necessários para responder à pergunta de negócio foram preparados e validados.

As principais decisões metodológicas foram:

1. preservar os arquivos e tabelas de origem;
2. criar estruturas analíticas separadas;
3. manter apenas uma avaliação por pedido;
4. classificar as avaliações em negativas, neutras e positivas;
5. analisar desempenho logístico apenas em pedidos efetivamente entregues;
6. comparar datas, e não timestamps completos, para determinar atraso;
7. respeitar a granularidade das tabelas durante os JOINs;
8. evitar imputação artificial de valores ausentes;
9. restringir a análise de vendedores a pedidos de um único vendedor quando necessário.

As views `orders_clean` e `reviews_clean` passaram a servir como base principal para as análises seguintes.
