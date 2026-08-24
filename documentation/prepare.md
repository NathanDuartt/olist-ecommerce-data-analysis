# Prepare — Preparação e avaliação dos dados

## Fonte dos dados

Este projeto utiliza o **Brazilian E-Commerce Public Dataset by Olist**, disponibilizado publicamente por meio da plataforma Kaggle.

O conjunto contém dados históricos anonimizados de pedidos realizados em um marketplace brasileiro e está distribuído em nove arquivos CSV relacionados entre si.

Os arquivos originais foram preservados sem alterações em uma pasta local `data/raw`. Qualquer transformação realizada durante o projeto será armazenada separadamente, preservando a fonte original.

---

## Período dos dados

Os registros de pedidos disponíveis abrangem principalmente o período entre **setembro de 2016 e outubro de 2018**.

Por se tratar de uma base histórica, os resultados deste estudo devem ser interpretados dentro do período disponível e não como representação do cenário atual do comércio eletrônico brasileiro.

---

## Estrutura do conjunto de dados

| Arquivo | Registros | Finalidade |
|---|---:|---|
| `olist_orders_dataset.csv` | 99.441 | Informações sobre pedidos, status e datas de entrega |
| `olist_customers_dataset.csv` | 99.441 | Identificação e localização dos clientes |
| `olist_order_items_dataset.csv` | 112.650 | Produtos e vendedores associados aos pedidos |
| `olist_order_payments_dataset.csv` | 103.886 | Informações sobre pagamentos |
| `olist_order_reviews_dataset.csv` | 99.224 | Avaliações realizadas pelos clientes |
| `olist_products_dataset.csv` | 32.951 | Características e categorias dos produtos |
| `olist_sellers_dataset.csv` | 3.095 | Informações de localização dos vendedores |
| `olist_geolocation_dataset.csv` | 1.000.163 | Coordenadas e informações geográficas por CEP |
| `product_category_name_translation.csv` | 71 | Tradução das categorias de produtos para inglês |

---

## Relacionamento entre as tabelas

A tabela `olist_orders_dataset` funciona como elemento central para grande parte da análise.

Os principais relacionamentos são:

```text
customers
    |
    | customer_id
    v
orders
    |
    | order_id
    |
    +-------- reviews
    |
    +-------- payments
    |
    v
order_items
    |
    +-------- products
    |
    +-------- sellers
