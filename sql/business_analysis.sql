-- ============================================================
-- OLIST E-COMMERCE DATA ANALYSIS
-- Business Analysis
-- ============================================================
--
-- Consultas utilizadas para investigar a relação entre
-- desempenho logístico e satisfação dos clientes.
--
-- Principais dimensões analisadas:
-- - atraso de entrega;
-- - intensidade do atraso;
-- - estado do cliente;
-- - categoria do produto;
-- - vendedor.
--
-- Google BigQuery
-- ============================================================


-- ============================================================
-- 1. ENTREGA NO PRAZO VS. ENTREGA ATRASADA
-- ============================================================
--
-- Objetivo:
-- comparar a satisfação dos clientes entre pedidos entregues
-- no prazo e pedidos entregues após a data estimada.
-- ============================================================

SELECT
  CASE
    WHEN o.is_late THEN 'late'
    ELSE 'on_time'
  END AS delivery_status,

  COUNT(*) AS orders_with_review,

  ROUND(
    AVG(r.review_score),
    2
  ) AS avg_review_score,

  COUNTIF(
    r.review_category = 'negative'
  ) AS negative_reviews,

  ROUND(
    COUNTIF(r.review_category = 'negative')
    * 100.0 / COUNT(*),
    2
  ) AS negative_rate_pct,

  COUNTIF(
    r.review_category = 'positive'
  ) AS positive_reviews,

  ROUND(
    COUNTIF(r.review_category = 'positive')
    * 100.0 / COUNT(*),
    2
  ) AS positive_rate_pct

FROM
  `olist-data-analysis-506523.olist_analytics.orders_clean` o

INNER JOIN
  `olist-data-analysis-506523.olist_analytics.reviews_clean` r
  ON o.order_id = r.order_id

GROUP BY
  delivery_status

ORDER BY
  delivery_status;


-- ============================================================
-- RESULTADOS OBSERVADOS
-- ============================================================
--
-- on_time:
-- 89.443 pedidos com avaliação
-- nota média: 4,29
-- avaliações negativas: 9,27%
-- avaliações positivas: 82,66%
--
-- late:
-- 6.381 pedidos com avaliação
-- nota média: 2,27
-- avaliações negativas: 62,42%
-- avaliações positivas: 26,70%
--
-- Os resultados mostram uma forte associação entre atraso
-- de entrega e pior avaliação do cliente.
-- ============================================================



-- ============================================================
-- 2. SATISFAÇÃO POR INTENSIDADE DO ATRASO
-- ============================================================
--
-- Objetivo:
-- verificar se atrasos mais longos estão associados a uma
-- deterioração ainda maior da satisfação dos clientes.
-- ============================================================

SELECT
  CASE
    WHEN o.delay_days <= 0 THEN 'On time'
    WHEN o.delay_days BETWEEN 1 AND 3 THEN '1-3 days late'
    WHEN o.delay_days BETWEEN 4 AND 7 THEN '4-7 days late'
    WHEN o.delay_days BETWEEN 8 AND 14 THEN '8-14 days late'
    ELSE '15+ days late'
  END AS delay_group,

  COUNT(*) AS total_orders,

  ROUND(
    AVG(r.review_score),
    2
  ) AS avg_review_score,

  COUNTIF(
    r.review_category = 'negative'
  ) AS negative_reviews,

  ROUND(
    COUNTIF(r.review_category = 'negative')
    * 100.0 / COUNT(*),
    2
  ) AS negative_rate_pct

FROM
  `olist-data-analysis-506523.olist_analytics.orders_clean` o

INNER JOIN
  `olist-data-analysis-506523.olist_analytics.reviews_clean` r
  ON o.order_id = r.order_id

GROUP BY
  delay_group

ORDER BY
  CASE delay_group
    WHEN 'On time' THEN 1
    WHEN '1-3 days late' THEN 2
    WHEN '4-7 days late' THEN 3
    WHEN '8-14 days late' THEN 4
    WHEN '15+ days late' THEN 5
  END;


-- ============================================================
-- RESULTADOS OBSERVADOS
-- ============================================================
--
-- On time:
-- 89.443 pedidos
-- nota média: 4,29
-- avaliações negativas: 9,27%
--
-- 1-3 days late:
-- 1.852 pedidos
-- nota média: 3,29
-- avaliações negativas: 32,13%
--
-- 4-7 days late:
-- 1.748 pedidos
-- nota média: 2,10
-- avaliações negativas: 67,68%
--
-- 8-14 days late:
-- 1.446 pedidos
-- nota média: 1,67
-- avaliações negativas: 80,15%
--
-- 15+ days late:
-- 1.335 pedidos
-- nota média: 1,72
-- avaliações negativas: 78,35%
--
-- A deterioração da avaliação é especialmente forte à medida
-- que o atraso aumenta até a faixa de 8 a 14 dias.
-- ============================================================



-- ============================================================
-- 3. DESEMPENHO POR ESTADO DO CLIENTE
-- ============================================================
--
-- Objetivo:
-- identificar estados que concentram maiores taxas ou maiores
-- volumes de pedidos atrasados e avaliações negativas.
-- ============================================================

SELECT
  c.customer_state,

  COUNT(*) AS orders_with_review,

  COUNTIF(
    o.is_late
  ) AS late_orders,

  ROUND(
    COUNTIF(o.is_late)
    * 100.0 / COUNT(*),
    2
  ) AS late_rate_pct,

  ROUND(
    AVG(r.review_score),
    2
  ) AS avg_review_score,

  COUNTIF(
    r.review_category = 'negative'
  ) AS negative_reviews,

  ROUND(
    COUNTIF(r.review_category = 'negative')
    * 100.0 / COUNT(*),
    2
  ) AS negative_rate_pct

FROM
  `olist-data-analysis-506523.olist_analytics.orders_clean` o

INNER JOIN
  `olist-data-analysis-506523.olist_analytics.reviews_clean` r
  ON o.order_id = r.order_id

INNER JOIN
  `olist-data-analysis-506523.olist_raw.customers` c
  ON o.customer_id = c.customer_id

GROUP BY
  c.customer_state

ORDER BY
  late_rate_pct DESC;


-- ============================================================
-- PRINCIPAIS OBSERVAÇÕES
-- ============================================================
--
-- Estados com maiores taxas de atraso:
--
-- AL: 20,81%
-- MA: 17,13%
-- SE: 14,97%
-- PI: 13,80%
-- CE: 13,67%
--
-- O Rio de Janeiro apresentou:
-- 12.211 pedidos
-- 1.456 atrasos
-- taxa de atraso: 11,92%
--
-- São Paulo apresentou:
-- 40.266 pedidos
-- 1.786 atrasos
-- taxa de atraso: 4,44%
--
-- A análise mostra que taxa e volume devem ser considerados
-- conjuntamente para definição de prioridades.
-- ============================================================



-- ============================================================
-- 4. DESEMPENHO POR CATEGORIA DE PRODUTO
-- ============================================================
--
-- Um mesmo pedido pode possuir vários itens.
--
-- Para evitar a contagem repetida do mesmo pedido dentro da
-- mesma categoria, é utilizada uma combinação distinta entre
-- order_id e product_category_name.
--
-- Apenas categorias com pelo menos 200 pedidos são exibidas.
-- ============================================================

WITH order_categories AS (

  SELECT DISTINCT
    oi.order_id,
    p.product_category_name

  FROM
    `olist-data-analysis-506523.olist_raw.order_items` oi

  INNER JOIN
    `olist-data-analysis-506523.olist_raw.products` p
    ON oi.product_id = p.product_id

  WHERE
    p.product_category_name IS NOT NULL
)

SELECT
  oc.product_category_name,

  COUNT(*) AS orders_with_review,

  COUNTIF(
    o.is_late
  ) AS late_orders,

  ROUND(
    COUNTIF(o.is_late)
    * 100.0 / COUNT(*),
    2
  ) AS late_rate_pct,

  ROUND(
    AVG(r.review_score),
    2
  ) AS avg_review_score,

  COUNTIF(
    r.review_category = 'negative'
  ) AS negative_reviews,

  ROUND(
    COUNTIF(r.review_category = 'negative')
    * 100.0 / COUNT(*),
    2
  ) AS negative_rate_pct

FROM
  order_categories oc

INNER JOIN
  `olist-data-analysis-506523.olist_analytics.orders_clean` o
  ON oc.order_id = o.order_id

INNER JOIN
  `olist-data-analysis-506523.olist_analytics.reviews_clean` r
  ON oc.order_id = r.order_id

GROUP BY
  oc.product_category_name

HAVING
  COUNT(*) >= 200

ORDER BY
  late_rate_pct DESC;


-- ============================================================
-- PRINCIPAIS OBSERVAÇÕES
-- ============================================================
--
-- audio:
-- taxa de atraso: 11,59%
-- avaliações negativas: 21,74%
--
-- moveis_escritorio:
-- taxa de atraso: 7,96%
-- nota média: 3,64
-- avaliações negativas: 21,95%
--
-- cama_mesa_banho:
-- 9.177 pedidos
-- 668 atrasos
-- taxa de atraso: 7,28%
-- avaliações negativas: 16,03%
--
-- beleza_saude:
-- 8.601 pedidos
-- 633 atrasos
-- taxa de atraso: 7,36%
--
-- moveis_decoracao:
-- 6.260 pedidos
-- 440 atrasos
-- avaliações negativas: 15,35%
--
-- Categorias com maior taxa de atraso não são necessariamente
-- as que representam maior impacto operacional.
-- ============================================================



-- ============================================================
-- 5. DESEMPENHO POR VENDEDOR
-- ============================================================
--
-- Um pedido pode possuir produtos de vários vendedores.
--
-- Para evitar atribuir o atraso de um mesmo pedido a diversos
-- vendedores, esta análise considera somente pedidos associados
-- a um único vendedor.
--
-- Também é utilizado um mínimo de 100 pedidos com avaliação.
-- ============================================================

WITH order_sellers AS (

  SELECT
    order_id,
    COUNT(DISTINCT seller_id) AS seller_count,
    ANY_VALUE(seller_id) AS seller_id

  FROM
    `olist-data-analysis-506523.olist_raw.order_items`

  GROUP BY
    order_id
),

single_seller_orders AS (

  SELECT
    order_id,
    seller_id

  FROM
    order_sellers

  WHERE
    seller_count = 1
)

SELECT
  sso.seller_id,

  COUNT(*) AS orders_with_review,

  COUNTIF(
    o.is_late
  ) AS late_orders,

  ROUND(
    COUNTIF(o.is_late)
    * 100.0 / COUNT(*),
    2
  ) AS late_rate_pct,

  ROUND(
    AVG(r.review_score),
    2
  ) AS avg_review_score,

  COUNTIF(
    r.review_category = 'negative'
  ) AS negative_reviews,

  ROUND(
    COUNTIF(r.review_category = 'negative')
    * 100.0 / COUNT(*),
    2
  ) AS negative_rate_pct

FROM
  single_seller_orders sso

INNER JOIN
  `olist-data-analysis-506523.olist_analytics.orders_clean` o
  ON sso.order_id = o.order_id

INNER JOIN
  `olist-data-analysis-506523.olist_analytics.reviews_clean` r
  ON sso.order_id = r.order_id

GROUP BY
  sso.seller_id

HAVING
  COUNT(*) >= 100

ORDER BY
  late_rate_pct DESC;


-- ============================================================
-- 6. VENDEDORES COM MAIOR VOLUME ABSOLUTO DE ATRASOS
-- ============================================================
--
-- Objetivo:
-- identificar vendedores que representam maior impacto
-- operacional em número absoluto de atrasos.
-- ============================================================

WITH order_sellers AS (

  SELECT
    order_id,
    COUNT(DISTINCT seller_id) AS seller_count,
    ANY_VALUE(seller_id) AS seller_id

  FROM
    `olist-data-analysis-506523.olist_raw.order_items`

  GROUP BY
    order_id
),

single_seller_orders AS (

  SELECT
    order_id,
    seller_id

  FROM
    order_sellers

  WHERE
    seller_count = 1
),

seller_metrics AS (

  SELECT
    sso.seller_id,
    s.seller_state,

    COUNT(*) AS orders_with_review,

    COUNTIF(
      o.is_late
    ) AS late_orders,

    ROUND(
      COUNTIF(o.is_late)
      * 100.0 / COUNT(*),
      2
    ) AS late_rate_pct,

    ROUND(
      AVG(r.review_score),
      2
    ) AS avg_review_score,

    COUNTIF(
      r.review_category = 'negative'
    ) AS negative_reviews,

    ROUND(
      COUNTIF(r.review_category = 'negative')
      * 100.0 / COUNT(*),
      2
    ) AS negative_rate_pct

  FROM
    single_seller_orders sso

  INNER JOIN
    `olist-data-analysis-506523.olist_analytics.orders_clean` o
    ON sso.order_id = o.order_id

  INNER JOIN
    `olist-data-analysis-506523.olist_analytics.reviews_clean` r
    ON sso.order_id = r.order_id

  INNER JOIN
    `olist-data-analysis-506523.olist_raw.sellers` s
    ON sso.seller_id = s.seller_id

  GROUP BY
    sso.seller_id,
    s.seller_state

  HAVING
    COUNT(*) >= 100
)

SELECT
  *

FROM
  seller_metrics

ORDER BY
  late_orders DESC

LIMIT 15;


-- ============================================================
-- PRINCIPAIS OBSERVAÇÕES
-- ============================================================
--
-- Maior volume de atrasos:
--
-- seller:
-- 4a3ca9315b744ce9f8e9374361493884
-- estado: SP
-- 1.655 pedidos
-- 166 atrasos
-- taxa de atraso: 10,03%
-- nota média: 3,91
-- avaliações negativas: 16,98%
--
--
-- Outro caso relevante:
--
-- seller:
-- 7c67e1448b00f6e969d365cea6b010ab
-- estado: SP
-- 957 pedidos
-- 87 atrasos
-- taxa de atraso: 9,09%
-- nota média: 3,51
-- avaliações negativas: 25,08%
--
--
-- Vendedor do Maranhão:
--
-- seller:
-- 06a2c3af7b3aee5d69171b0e14f0ee87
-- estado: MA
-- 384 pedidos
-- 71 atrasos
-- taxa de atraso: 18,49%
--
-- A análise de vendedores considera conjuntamente volume,
-- taxa de atraso e satisfação do cliente.
-- ============================================================
