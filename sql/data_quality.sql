-- ============================================================
-- OLIST E-COMMERCE DATA ANALYSIS
-- Data Quality and Validation
-- ============================================================
--
-- Este arquivo reúne as principais consultas utilizadas para
-- validar a importação, integridade, unicidade e qualidade dos
-- dados antes da etapa de análise.
--
-- Google BigQuery
-- ============================================================


-- ============================================================
-- 1. CONTAGEM DE REGISTROS POR TABELA
-- ============================================================

SELECT 'orders' AS table_name, COUNT(*) AS total_rows
FROM `olist-data-analysis-506523.olist_raw.orders`

UNION ALL

SELECT 'customers', COUNT(*)
FROM `olist-data-analysis-506523.olist_raw.customers`

UNION ALL

SELECT 'order_items', COUNT(*)
FROM `olist-data-analysis-506523.olist_raw.order_items`

UNION ALL

SELECT 'order_reviews', COUNT(*)
FROM `olist-data-analysis-506523.olist_raw.order_reviews`

UNION ALL

SELECT 'products', COUNT(*)
FROM `olist-data-analysis-506523.olist_raw.products`

UNION ALL

SELECT 'sellers', COUNT(*)
FROM `olist-data-analysis-506523.olist_raw.sellers`

ORDER BY table_name;


-- ============================================================
-- 2. VERIFICAÇÃO DE UNICIDADE DAS PRINCIPAIS CHAVES
-- ============================================================

SELECT
  'orders' AS table_name,
  COUNT(*) AS total_rows,
  COUNT(DISTINCT order_id) AS distinct_keys,
  COUNT(*) - COUNT(DISTINCT order_id) AS duplicate_rows
FROM `olist-data-analysis-506523.olist_raw.orders`

UNION ALL

SELECT
  'customers',
  COUNT(*),
  COUNT(DISTINCT customer_id),
  COUNT(*) - COUNT(DISTINCT customer_id)
FROM `olist-data-analysis-506523.olist_raw.customers`

UNION ALL

SELECT
  'products',
  COUNT(*),
  COUNT(DISTINCT product_id),
  COUNT(*) - COUNT(DISTINCT product_id)
FROM `olist-data-analysis-506523.olist_raw.products`

UNION ALL

SELECT
  'sellers',
  COUNT(*),
  COUNT(DISTINCT seller_id),
  COUNT(*) - COUNT(DISTINCT seller_id)
FROM `olist-data-analysis-506523.olist_raw.sellers`

UNION ALL

SELECT
  'order_items',
  COUNT(*),
  COUNT(
    DISTINCT CONCAT(
      order_id,
      '#',
      CAST(order_item_id AS STRING)
    )
  ),
  COUNT(*) -
  COUNT(
    DISTINCT CONCAT(
      order_id,
      '#',
      CAST(order_item_id AS STRING)
    )
  )
FROM `olist-data-analysis-506523.olist_raw.order_items`

UNION ALL

SELECT
  'order_reviews_by_order',
  COUNT(*),
  COUNT(DISTINCT order_id),
  COUNT(*) - COUNT(DISTINCT order_id)
FROM `olist-data-analysis-506523.olist_raw.order_reviews`;


-- ============================================================
-- 3. VALORES AUSENTES NA TABELA DE PEDIDOS
-- ============================================================

SELECT
  COUNT(*) AS total_rows,
  COUNTIF(order_id IS NULL) AS null_order_id,
  COUNTIF(customer_id IS NULL) AS null_customer_id,
  COUNTIF(order_status IS NULL) AS null_order_status,
  COUNTIF(order_purchase_timestamp IS NULL) AS null_purchase_date,
  COUNTIF(order_approved_at IS NULL) AS null_approved_date,
  COUNTIF(order_delivered_carrier_date IS NULL) AS null_carrier_date,
  COUNTIF(order_delivered_customer_date IS NULL)
    AS null_customer_delivery_date,
  COUNTIF(order_estimated_delivery_date IS NULL)
    AS null_estimated_delivery_date
FROM `olist-data-analysis-506523.olist_raw.orders`;


-- ============================================================
-- 4. DATAS AUSENTES POR STATUS DO PEDIDO
-- ============================================================

SELECT
  order_status,
  COUNT(*) AS total_orders,
  COUNTIF(order_approved_at IS NULL) AS null_approved_date,
  COUNTIF(order_delivered_carrier_date IS NULL) AS null_carrier_date,
  COUNTIF(order_delivered_customer_date IS NULL)
    AS null_customer_delivery_date
FROM `olist-data-analysis-506523.olist_raw.orders`
GROUP BY order_status
ORDER BY total_orders DESC;


-- ============================================================
-- 5. VALORES AUSENTES NA TABELA DE PRODUTOS
-- ============================================================

SELECT
  COUNT(*) AS total_rows,
  COUNTIF(product_id IS NULL) AS null_product_id,
  COUNTIF(product_category_name IS NULL) AS null_category,
  COUNTIF(product_name_lenght IS NULL) AS null_name_length,
  COUNTIF(product_description_lenght IS NULL)
    AS null_description_length,
  COUNTIF(product_photos_qty IS NULL) AS null_photos,
  COUNTIF(product_weight_g IS NULL) AS null_weight,
  COUNTIF(product_length_cm IS NULL) AS null_length,
  COUNTIF(product_height_cm IS NULL) AS null_height,
  COUNTIF(product_width_cm IS NULL) AS null_width
FROM `olist-data-analysis-506523.olist_raw.products`;


-- ============================================================
-- 6. VALORES AUSENTES NA TABELA DE AVALIAÇÕES
-- ============================================================

SELECT
  COUNT(*) AS total_rows,
  COUNTIF(review_id IS NULL) AS null_review_id,
  COUNTIF(order_id IS NULL) AS null_order_id,
  COUNTIF(review_score IS NULL) AS null_review_score,
  COUNTIF(review_comment_title IS NULL) AS null_comment_title,
  COUNTIF(review_comment_message IS NULL) AS null_comment_message,
  COUNTIF(review_creation_date IS NULL) AS null_creation_date,
  COUNTIF(review_answer_timestamp IS NULL) AS null_answer_timestamp
FROM `olist-data-analysis-506523.olist_raw.order_reviews`;


-- ============================================================
-- 7. INVESTIGAÇÃO DE PEDIDOS COM MÚLTIPLAS AVALIAÇÕES
-- ============================================================

SELECT
  order_id,
  COUNT(*) AS review_count,
  COUNT(DISTINCT review_id) AS distinct_review_ids,
  COUNT(DISTINCT review_score) AS distinct_scores,
  MIN(review_score) AS min_score,
  MAX(review_score) AS max_score
FROM `olist-data-analysis-506523.olist_raw.order_reviews`
GROUP BY order_id
HAVING COUNT(*) > 1
ORDER BY review_count DESC, order_id;


-- ============================================================
-- 8. DISTRIBUIÇÃO DAS NOTAS DE AVALIAÇÃO
-- ============================================================

SELECT
  review_score,
  COUNT(*) AS total_reviews,
  ROUND(
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
    2
  ) AS percentage
FROM `olist-data-analysis-506523.olist_raw.order_reviews`
GROUP BY review_score
ORDER BY review_score;


-- ============================================================
-- 9. VALIDAÇÃO DA VIEW reviews_clean
-- ============================================================

SELECT
  COUNT(*) AS total_rows,
  COUNT(DISTINCT order_id) AS distinct_orders
FROM `olist-data-analysis-506523.olist_analytics.reviews_clean`;


-- ============================================================
-- 10. VALIDAÇÃO DA VIEW orders_clean
-- ============================================================

SELECT
  COUNT(*) AS total_orders,
  COUNT(DISTINCT order_id) AS distinct_orders,
  COUNTIF(is_late) AS late_orders,
  ROUND(
    COUNTIF(is_late) * 100.0 / COUNT(*),
    2
  ) AS late_rate_pct
FROM `olist-data-analysis-506523.olist_analytics.orders_clean`;
