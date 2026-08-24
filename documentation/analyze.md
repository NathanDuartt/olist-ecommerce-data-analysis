# Analyze — Análise dos dados

## Objetivo da etapa

A etapa de análise teve como objetivo identificar padrões relacionados ao desempenho logístico e à experiência dos clientes no marketplace.

A pergunta principal do estudo foi:

> Quais fatores estão associados a atrasos de entrega e avaliações negativas, e quais regiões, categorias de produtos ou vendedores concentram os principais pontos de atenção?

As análises foram realizadas principalmente a partir das views tratadas:

- `olist_analytics.orders_clean`
- `olist_analytics.reviews_clean`

Também foram utilizadas as tabelas de clientes, itens, produtos e vendedores para análises segmentadas.

---

## Visão geral da base analisada

Após o tratamento dos dados, foram identificados:

- 96.470 pedidos entregues com data de entrega válida;
- 6.534 pedidos entregues após a data estimada;
- taxa geral de atraso de 6,77%.

Para as análises que relacionam entrega e satisfação, foram utilizados pedidos que também possuíam uma avaliação válida associada.

Foram encontrados:

- 95.824 pedidos entregues com avaliação;
- 89.443 entregues no prazo;
- 6.381 entregues com atraso.

A elevada quantidade de pedidos com avaliação permite analisar a relação entre desempenho logístico e satisfação utilizando praticamente toda a base de pedidos entregues.

---

# 1. Relação entre atraso e avaliação do cliente

A primeira análise comparou pedidos entregues no prazo com pedidos entregues após a data estimada.

| Status da entrega | Pedidos com avaliação | Nota média | Avaliações negativas | Avaliações positivas |
|---|---:|---:|---:|---:|
| No prazo | 89.443 | 4,29 | 9,27% | 82,66% |
| Atrasado | 6.381 | 2,27 | 62,42% | 26,70% |

Os resultados mostram uma diferença expressiva entre os dois grupos.

Pedidos entregues no prazo apresentaram nota média de 4,29, enquanto pedidos atrasados apresentaram média de apenas 2,27.

A taxa de avaliações negativas aumentou de 9,27% para 62,42%.

Isso representa uma incidência de avaliações negativas aproximadamente 6,7 vezes maior entre pedidos atrasados.

Ao mesmo tempo, a participação de avaliações positivas caiu de 82,66% para 26,70%.

### Insight

Existe uma forte associação entre atraso de entrega e pior experiência do cliente.

Os dados não permitem afirmar causalidade, pois outros fatores também podem influenciar as avaliações. Entretanto, a diferença observada entre os grupos indica que o desempenho logístico é um fator relevante para a satisfação.

---

# 2. Intensidade do atraso e satisfação

Para verificar se a duração do atraso também está associada à avaliação, os pedidos foram agrupados de acordo com a quantidade de dias de atraso.

| Faixa de atraso | Pedidos | Nota média | Avaliações negativas |
|---|---:|---:|---:|
| No prazo | 89.443 | 4,29 | 9,27% |
| 1–3 dias | 1.852 | 3,29 | 32,13% |
| 4–7 dias | 1.748 | 2,10 | 67,68% |
| 8–14 dias | 1.446 | 1,67 | 80,15% |
| 15+ dias | 1.335 | 1,72 | 78,35% |

O comportamento é consistente com uma deterioração da satisfação conforme o atraso se torna mais severo.

Mesmo atrasos de apenas 1 a 3 dias já estão associados a uma redução relevante na nota média e a um aumento expressivo das avaliações negativas.

A pior faixa observada foi de 8 a 14 dias, com nota média de 1,67 e 80,15% de avaliações negativas.

A faixa de 15 dias ou mais apresenta resultado semelhante, com 78,35% de avaliações negativas.

### Insight

A relação encontrada não se limita à existência do atraso.

A severidade do atraso também está associada à experiência do cliente, principalmente quando a entrega ultrapassa a previsão em quatro dias ou mais.

---

# 3. Análise geográfica

A análise por estado do cliente mostrou diferenças relevantes no desempenho logístico.

Os estados com maiores taxas de atraso foram:

| Estado | Pedidos | Pedidos atrasados | Taxa de atraso | Nota média | Avaliações negativas |
|---|---:|---:|---:|---:|---:|
| AL | 394 | 82 | 20,81% | 3,85 | 21,32% |
| MA | 712 | 122 | 17,13% | 3,83 | 19,94% |
| SE | 334 | 50 | 14,97% | 3,91 | 18,86% |
| PI | 471 | 65 | 13,80% | 3,99 | 16,14% |
| CE | 1.273 | 174 | 13,67% | 3,94 | 17,12% |

Esses estados apresentam taxas de atraso significativamente superiores à média geral da base.

Entretanto, a análise apenas da taxa pode ocultar o impacto operacional gerado por estados com volumes muito maiores.

## Rio de Janeiro

O Rio de Janeiro apresentou:

- 12.211 pedidos;
- 1.456 pedidos atrasados;
- taxa de atraso de 11,92%;
- nota média de 3,97;
- 18,33% de avaliações negativas.

O estado combina alto volume de pedidos com uma taxa de atraso elevada.

## São Paulo

São Paulo apresentou:

- 40.266 pedidos;
- 1.786 pedidos atrasados;
- taxa de atraso de 4,44%;
- nota média de 4,25;
- 10,69% de avaliações negativas.

Apesar de possuir uma taxa de atraso relativamente baixa, São Paulo concentra o maior número absoluto de atrasos devido ao grande volume de pedidos.

### Insight

A priorização de problemas logísticos deve considerar simultaneamente:

- taxa de atraso;
- volume total de pedidos;
- número absoluto de ocorrências.

Estados com elevada taxa indicam problemas proporcionais, enquanto estados com grande volume podem gerar maior impacto operacional mesmo com taxas menores.

---

# 4. Análise por categoria de produto

A análise por categoria considerou apenas categorias com pelo menos 200 pedidos.

Um pedido que possui produtos de diferentes categorias pode aparecer em mais de uma categoria. Portanto, os totais desta análise não devem ser somados como pedidos exclusivos.

Alguns segmentos apresentaram resultados relevantes.

## Audio

A categoria `audio` apresentou:

- 345 pedidos;
- 40 atrasos;
- taxa de atraso de 11,59%;
- nota média de 3,84;
- 21,74% de avaliações negativas.

Foi a maior taxa de atraso entre as categorias avaliadas, porém possui volume relativamente reduzido.

## Móveis de escritório

A categoria `moveis_escritorio` apresentou:

- 1.244 pedidos;
- 99 atrasos;
- taxa de atraso de 7,96%;
- nota média de 3,64;
- 21,95% de avaliações negativas.

A categoria chama atenção pela combinação de atraso e insatisfação.

A taxa de avaliações negativas é elevada mesmo quando comparada a categorias com taxas de atraso semelhantes.

Isso sugere que outros fatores além da entrega podem influenciar negativamente a experiência nesse segmento.

## Cama, mesa e banho

A categoria `cama_mesa_banho` apresentou:

- 9.177 pedidos;
- 668 atrasos;
- taxa de atraso de 7,28%;
- nota média de 4,00;
- 16,03% de avaliações negativas.

Foi uma das categorias de maior impacto operacional devido ao grande volume de pedidos e ao número absoluto de atrasos.

## Beleza e saúde

A categoria `beleza_saude` apresentou:

- 8.601 pedidos;
- 633 atrasos;
- taxa de atraso de 7,36%;
- nota média de 4,23;
- 11,45% de avaliações negativas.

Apesar do grande número de atrasos, a nota média permanece relativamente alta.

Esse comportamento reforça que atraso não é o único fator associado à avaliação do cliente.

## Móveis e decoração

A categoria `moveis_decoracao` apresentou:

- 6.260 pedidos;
- 440 atrasos;
- taxa de atraso de 7,03%;
- nota média de 4,06;
- 15,35% de avaliações negativas.

É outro segmento relevante por combinar volume elevado com centenas de entregas atrasadas.

## Informática e acessórios

A categoria `informatica_acessorios` apresentou:

- 6.498 pedidos;
- 407 atrasos;
- taxa de atraso de 6,26%;
- nota média de 4,08;
- 14,54% de avaliações negativas.

Embora sua taxa de atraso esteja próxima da média geral, o alto volume torna o segmento relevante em número absoluto de ocorrências.

### Insight

As categorias com maior taxa de atraso não são necessariamente as que causam maior impacto operacional.

Categorias como:

- `cama_mesa_banho`;
- `beleza_saude`;
- `moveis_decoracao`;
- `informatica_acessorios`;

devem receber atenção por combinarem alto volume com um número significativo de entregas atrasadas.

---

# 5. Análise por vendedor

Um pedido pode conter produtos de diferentes vendedores.

Para reduzir o risco de atribuir um mesmo atraso a múltiplos vendedores, a análise foi limitada inicialmente a pedidos associados a apenas um vendedor.

Também foram considerados somente vendedores com pelo menos 100 pedidos com avaliação.

## Maior volume absoluto de atrasos

O vendedor:

`4a3ca9315b744ce9f8e9374361493884`

localizado em São Paulo, apresentou:

- 1.655 pedidos;
- 166 atrasos;
- taxa de atraso de 10,03%;
- nota média de 3,91;
- 16,98% de avaliações negativas.

Foi o vendedor com maior número absoluto de atrasos dentro dos critérios utilizados.

## Caso com forte impacto na satisfação

O vendedor:

`7c67e1448b00f6e969d365cea6b010ab`

localizado em São Paulo, apresentou:

- 957 pedidos;
- 87 atrasos;
- taxa de atraso de 9,09%;
- nota média de 3,51;
- 25,08% de avaliações negativas.

Além da taxa de atraso acima da média geral, o vendedor apresentou um percentual elevado de avaliações negativas.

## Caso com alta taxa de atraso

O vendedor:

`06a2c3af7b3aee5d69171b0e14f0ee87`

localizado no Maranhão, apresentou:

- 384 pedidos;
- 71 atrasos;
- taxa de atraso de 18,49%;
- nota média de 4,02;
- 15,89% de avaliações negativas.

Embora possua volume menor que os principais vendedores de São Paulo, sua taxa de atraso é significativamente superior à média geral.

## Vendedores com alta insatisfação e menor atraso

Também foram encontrados vendedores que possuem taxa de atraso relativamente moderada, mas níveis elevados de avaliações negativas.

Um exemplo é:

`6560211a19b47992c3666cc44a7e94c0`

com:

- 1.774 pedidos;
- 94 atrasos;
- taxa de atraso de 5,30%;
- nota média de 4,00;
- 15,39% de avaliações negativas.

Esse comportamento indica que problemas relacionados à experiência do cliente podem existir independentemente do desempenho de entrega.

### Insight

O desempenho dos vendedores deve ser avaliado utilizando diferentes métricas em conjunto.

Uma análise baseada exclusivamente na taxa de atraso pode não identificar vendedores que possuem grandes volumes de ocorrências ou níveis elevados de insatisfação.

---

# 6. Principais descobertas

A análise identificou cinco pontos principais.

## 1. Atrasos estão fortemente associados à insatisfação

Pedidos entregues no prazo apresentam nota média de 4,29.

Pedidos atrasados apresentam nota média de 2,27.

A taxa de avaliações negativas passa de 9,27% para 62,42%.

---

## 2. A severidade do atraso importa

A avaliação do cliente piora significativamente conforme o atraso aumenta.

Pedidos com 8 a 14 dias de atraso apresentaram:

- nota média de 1,67;
- 80,15% de avaliações negativas.

---

## 3. Taxa e volume representam problemas diferentes

Estados ou categorias com maior taxa de atraso não necessariamente concentram o maior número de pedidos atrasados.

São Paulo exemplifica essa diferença:

- taxa de atraso de apenas 4,44%;
- maior número absoluto de atrasos entre os estados analisados.

---

## 4. Existem segmentos prioritários

Categorias de grande volume como:

- `cama_mesa_banho`;
- `beleza_saude`;
- `moveis_decoracao`;
- `informatica_acessorios`;

concentram centenas de atrasos e representam oportunidades relevantes de melhoria operacional.

---

## 5. A entrega não explica toda a insatisfação

Algumas categorias e vendedores apresentam níveis elevados de avaliações negativas mesmo quando a taxa de atraso não é especialmente alta.

Isso indica que outros fatores podem influenciar a experiência, como:

- qualidade do produto;
- divergência entre produto e descrição;
- embalagem;
- atendimento;
- comunicação;
- problemas relacionados ao vendedor.

Essas possibilidades são hipóteses e não foram diretamente medidas neste estudo.

---

# 7. Resposta à pergunta de negócio

Os dados indicam que atrasos de entrega estão fortemente associados a avaliações negativas.

Pedidos atrasados apresentam nota média substancialmente inferior e uma incidência muito maior de avaliações negativas.

A intensidade do atraso também está relacionada ao resultado: atrasos mais longos apresentam os piores indicadores de satisfação.

Os problemas não estão distribuídos uniformemente.

Existem diferenças importantes entre estados, categorias de produtos e vendedores.

Por isso, ações de melhoria não devem considerar apenas a taxa geral de atraso.

A priorização deve combinar:

- quantidade de pedidos;
- número de atrasos;
- taxa de atraso;
- nota média;
- taxa de avaliações negativas.

Essa abordagem permite identificar segmentos que apresentam maior risco operacional e maior impacto potencial sobre a experiência dos clientes.

---

# 8. Limitações da análise

Algumas limitações devem ser consideradas na interpretação dos resultados.

## Dados históricos

O conjunto representa um período histórico específico do marketplace e não deve ser interpretado como retrato do desempenho atual da empresa.

## Associação não significa causalidade

Os dados mostram uma forte associação entre atraso e avaliações negativas, mas não permitem afirmar que o atraso seja a única causa da insatisfação.

## Avaliações múltiplas

Alguns pedidos possuíam mais de uma avaliação.

Foi utilizada a avaliação mais recente para manter uma única observação por pedido.

## Pedidos com múltiplos vendedores

A análise de vendedores foi limitada a pedidos associados a apenas um vendedor para evitar atribuição inadequada de atrasos.

## Categorias de produtos

Pedidos com produtos de categorias diferentes podem aparecer em mais de uma categoria.

Por isso, os resultados por categoria não representam grupos mutuamente exclusivos.

## Outras variáveis

O estudo não avaliou diretamente fatores como:

- conteúdo dos comentários;
- preço;
- frete;
- forma de pagamento;
- qualidade física do produto;
- atendimento ao cliente.

Essas dimensões podem ser investigadas em análises futuras.
