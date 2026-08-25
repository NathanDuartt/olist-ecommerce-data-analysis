# Share — Comunicação dos resultados

## Objetivo

A etapa Share teve como objetivo transformar os principais resultados da análise em visualizações claras e acessíveis, facilitando a interpretação dos dados e a comunicação dos principais insights do estudo.

Foi desenvolvido um dashboard no Power BI com foco em desempenho logístico e experiência do cliente.

O dashboard foi mantido propositalmente simples e objetivo, priorizando os indicadores diretamente relacionados à pergunta de negócio.

---

## Dashboard

![Dashboard Olist E-commerce](../assets/dashboard-overview.png)

O dashboard apresenta uma visão consolidada dos principais resultados encontrados durante a análise.

A estrutura foi organizada em:

1. indicadores gerais;
2. destaque para o principal insight;
3. relação entre atraso e satisfação;
4. severidade dos atrasos;
5. análise geográfica;
6. filtro interativo por estado.

---

## Indicadores principais

Foram destacados quatro indicadores.

### Pedidos entregues

**96.470**

Representa o total de pedidos com status de entrega concluído e data de entrega válida utilizados na análise logística.

### Taxa de atraso

**6,77%**

Representa a proporção de pedidos entregues após a data estimada.

### Nota média dos pedidos entregues no prazo

**4,29**

Pedidos entregues dentro do prazo apresentaram avaliações médias elevadas.

### Nota média dos pedidos atrasados

**2,27**

Pedidos entregues após a data estimada apresentaram uma redução expressiva na avaliação média.

---

## Principal insight

Um dos principais resultados encontrados foi a diferença na incidência de avaliações negativas entre pedidos entregues no prazo e pedidos atrasados.

Pedidos atrasados apresentaram:

**62,42% de avaliações negativas**

Enquanto pedidos entregues no prazo apresentaram:

**9,27% de avaliações negativas**

Isso significa que os pedidos atrasados apresentam aproximadamente:

**6,7 vezes mais avaliações negativas**

do que os pedidos entregues no prazo.

O resultado indica uma forte associação entre desempenho logístico e satisfação dos clientes.

---

## Visualização 1 — Impacto do atraso na satisfação

O primeiro gráfico compara diretamente a taxa de avaliações negativas entre pedidos atrasados e pedidos entregues no prazo.

| Status da entrega | Avaliações negativas |
|---|---:|
| Atrasado | 62,42% |
| No prazo | 9,27% |

A diferença entre os grupos evidencia que pedidos entregues após a data prevista estão associados a uma experiência significativamente pior para os clientes.

---

## Visualização 2 — Severidade do atraso

O segundo gráfico mostra a taxa de avaliações negativas de acordo com a quantidade de dias de atraso.

| Faixa de atraso | Avaliações negativas |
|---|---:|
| No prazo | 9,27% |
| 1–3 dias | 32,13% |
| 4–7 dias | 67,68% |
| 8–14 dias | 80,15% |
| 15+ dias | 78,35% |

Mesmo atrasos relativamente curtos apresentam associação relevante com a insatisfação.

Pedidos com atraso entre 1 e 3 dias apresentaram 32,13% de avaliações negativas.

A partir de quatro dias de atraso, mais da metade dos pedidos analisados recebeu avaliações negativas.

Os piores resultados foram observados nas faixas de 8 a 14 dias e de 15 dias ou mais.

---

## Visualização 3 — Estados com maior taxa de atraso

O terceiro gráfico apresenta os cinco estados com maior taxa de atraso entre pedidos que também possuem uma avaliação associada.

| Estado | Taxa de atraso |
|---|---:|
| AL | 20,81% |
| MA | 17,13% |
| SE | 14,97% |
| PI | 13,80% |
| CE | 13,67% |

Os resultados mostram que o desempenho logístico não está distribuído igualmente entre os estados.

Entretanto, taxas percentuais devem ser interpretadas juntamente com o volume de pedidos, pois estados com taxas menores podem concentrar um número absoluto maior de atrasos.

---

## Interatividade

Foi incluído um filtro por estado no dashboard.

O filtro permite selecionar uma unidade federativa e atualizar os principais indicadores e visualizações de acordo com o estado escolhido.

Essa funcionalidade permite explorar diferenças regionais sem adicionar complexidade excessiva ao relatório.

---

## Decisões de design

O dashboard foi desenvolvido priorizando clareza, legibilidade e consistência visual.

Foram utilizados:

- fundo claro;
- cartões para os principais indicadores;
- paleta de cores limitada;
- vermelho discreto para destacar problemas relacionados a atraso e insatisfação;
- verde-petróleo para comparações e análises geográficas;
- títulos e subtítulos explicativos;
- rótulos de dados;
- espaçamento consistente;
- filtro simples por estado;
- destaque visual para o principal insight.

A quantidade de visualizações foi limitada para evitar excesso de informação e manter o foco nos resultados mais importantes para a pergunta de negócio.

---

## Resultado da etapa

As visualizações reforçam três conclusões principais:

1. pedidos atrasados apresentam avaliações significativamente piores;
2. a insatisfação aumenta conforme o atraso se torna mais severo;
3. determinadas regiões apresentam taxas de atraso consideravelmente superiores à média.

Esses resultados servem como base para as recomendações e próximos passos apresentados na etapa Act.
