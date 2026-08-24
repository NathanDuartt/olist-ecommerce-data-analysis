-- ============================================================
-- OLIST E-COMMERCE DATA ANALYSIS
-- Data Cleaning and Transformation
-- ============================================================
--
-- Este arquivo contém as transformações utilizadas para criar
-- as principais views analíticas do projeto.
--
-- As tabelas originais permanecem preservadas em olist_raw.
-- As estruturas tratadas são criadas em olist_analytics.
--
-- Google BigQuery
-- ============================================================


-- ============================================================
-- 1. CRIAÇÃO DA VIEW reviews_clean
-- ============================================================
--
-- Objetivos:
-- - manter somente uma avaliação por pedido;
-- - priorizar a avaliação mais recente;
-- - classificar as notas em negative, neutral e positive.
--
-- Em pedidos com múltiplas avaliações, a prioridade é:
-- 1. review_answer_timestamp mais recente;
-- 2. review_creation_date mais recente;
-- 3. review_id como critério final de desempate.
-- ============================================================

CREATE OR REPLACE VIEW
  `olist-data-analysis-506523.olist_analytics.reviews_clean` AS

SELECT
  review_id,
  order_id,
  review_score,

  CASE
    WHEN review_score IN (1, 2) THEN 'negative'
    WHEN review_score = 3 THEN 'neutral'
    WHEN review_score IN (4, 5) THEN 'positive'
  END AS review_category,

  review_comment_title,
  review_comment_message,
  review_creation_date,
  review_answer_timestamp

FROM `olist-data-analysis-506523.olist_raw.order_reviews`

QUALIFY ROW_NUMBER() OVER (
  PARTITION BY order_id
  ORDER BY
    review_answer_timestamp DESC,
    review_creation_date DESC,
    review_id DESC
) = 1;


-- ============================================================
-- 2. CRIAÇÃO DA VIEW orders_clean
-- ============================================================
--
-- Objetivos:
-- - manter somente pedidos efetivamente entregues;
-- - excluir pedidos entregues sem data real de entrega;
-- - calcular tempo total de entrega;
-- - calcular diferença entre entrega real e estimada;
-- - identificar pedidos entregues após a data prevista.
--
-- A definição de atraso utiliza DATE, e não TIMESTAMP completo,
-- para evitar classificar como atrasado um pedido entregue
-- no mesmo dia previsto.
-- ============================================================

CREATE OR REPLACE VIEW
  `olist-data-analysis-506523.olist_analytics.orders_clean` AS

SELECT
  order_id,
  customer_id,
  order_purchase_timestamp,
  order_approved_at,
  order_delivered_carrier_date,
  order_delivered_customer_date,
  order_estimated_delivery_date,

  DATE_DIFF(
    DATE(order_delivered_customer_date),
    DATE(order_purchase_timestamp),
    DAY
  ) AS delivery_days,

  DATE_DIFF(
    DATE(order_delivered_customer_date),
    DATE(order_estimated_delivery_date),
    DAY
  ) AS delay_days,

  CASE
    WHEN DATE(order_delivered_customer_date) >
         DATE(order_estimated_delivery_date)
      THEN TRUE
    ELSE FALSE
  END AS is_late

FROM `olist-data-analysis-506523.olist_raw.orders`

WHERE
  order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL;
