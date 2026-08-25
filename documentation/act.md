# Act — Recomendações e próximos passos

## Objetivo

A etapa Act tem como objetivo transformar os principais resultados da análise em recomendações que possam apoiar decisões relacionadas ao desempenho logístico e à experiência dos clientes.

As recomendações apresentadas neste estudo consideram os padrões identificados nos dados e as limitações do conjunto analisado.

---

## Principais conclusões

A análise mostrou uma forte associação entre atraso de entrega e insatisfação dos clientes.

Entre os pedidos analisados:

- 96.470 pedidos foram entregues com data de entrega válida;
- 6,77% foram entregues após a data estimada;
- pedidos entregues no prazo apresentaram nota média de 4,29;
- pedidos atrasados apresentaram nota média de 2,27;
- 9,27% dos pedidos entregues no prazo receberam avaliações negativas;
- 62,42% dos pedidos atrasados receberam avaliações negativas.

Assim, pedidos atrasados apresentaram aproximadamente 6,7 vezes mais avaliações negativas do que pedidos entregues no prazo.

A análise também mostrou que a severidade do atraso está associada à piora da satisfação.

Pedidos com atrasos de quatro dias ou mais apresentaram taxas de avaliações negativas superiores a 67%.

---

# 1. Priorizar a prevenção de atrasos

O atraso de entrega foi o fator com associação mais clara à pior avaliação do cliente dentro das variáveis analisadas.

Por esse motivo, uma das principais prioridades operacionais deve ser reduzir a quantidade de pedidos entregues após a data prevista.

Possíveis ações incluem:

- acompanhamento periódico da taxa de atraso;
- criação de alertas para pedidos próximos da data estimada;
- identificação antecipada de pedidos com risco de atraso;
- acompanhamento dos principais gargalos logísticos;
- revisão de prazos estimados quando necessário.

### Impacto esperado

Reduzir atrasos pode contribuir para melhorar a experiência do cliente e diminuir a incidência de avaliações negativas.

---

# 2. Monitorar a severidade dos atrasos

A análise mostrou que a insatisfação aumenta significativamente quando o atraso se torna mais longo.

As taxas de avaliações negativas encontradas foram:

| Faixa de atraso | Avaliações negativas |
|---|---:|
| No prazo | 9,27% |
| 1–3 dias | 32,13% |
| 4–7 dias | 67,68% |
| 8–14 dias | 80,15% |
| 15+ dias | 78,35% |

Isso indica que não é suficiente acompanhar apenas se um pedido está atrasado.

Também é importante monitorar a quantidade de dias de atraso.

### Recomendação

Pedidos com atraso crescente podem receber prioridade operacional ou ações específicas de comunicação com o cliente.

---

# 3. Criar acompanhamento regional

A análise por estado mostrou diferenças relevantes no desempenho logístico.

Os estados com maiores taxas de atraso entre os pedidos com avaliação foram:

- AL: 20,81%;
- MA: 17,13%;
- SE: 14,97%;
- PI: 13,80%;
- CE: 13,67%.

Entretanto, estados com grande volume também podem gerar forte impacto operacional mesmo quando apresentam taxas menores.

São Paulo, por exemplo, possui taxa de atraso inferior a vários outros estados, mas concentra um grande número absoluto de ocorrências devido ao volume de pedidos.

### Recomendação

O acompanhamento regional deve considerar simultaneamente:

- taxa de atraso;
- volume de pedidos;
- número absoluto de atrasos;
- nota média;
- taxa de avaliações negativas.

Essa abordagem evita priorizar apenas regiões com percentuais elevados, mas baixo volume operacional.

---

# 4. Acompanhar categorias com maior impacto

A análise por categoria mostrou que diferentes segmentos apresentam comportamentos distintos.

Algumas categorias possuem taxas elevadas de atraso, enquanto outras apresentam grande quantidade absoluta de ocorrências devido ao alto volume.

Entre os segmentos que merecem atenção estão:

- `cama_mesa_banho`;
- `beleza_saude`;
- `moveis_decoracao`;
- `informatica_acessorios`;
- `moveis_escritorio`.

### Recomendação

Criar acompanhamento periódico das categorias utilizando métricas como:

- volume de pedidos;
- quantidade de atrasos;
- taxa de atraso;
- nota média;
- avaliações negativas.

Categorias com grande volume e desempenho abaixo da média podem receber prioridade em investigações operacionais.

---

# 5. Monitorar vendedores com indicadores críticos

A análise identificou diferenças importantes entre vendedores.

Alguns apresentam:

- alto volume de pedidos;
- número elevado de atrasos;
- taxa de atraso superior à média;
- níveis elevados de avaliações negativas.

Para evitar atribuições incorretas, a análise realizada neste estudo considerou apenas pedidos associados a um único vendedor.

### Recomendação

Criar um acompanhamento de desempenho dos vendedores utilizando uma combinação de indicadores:

- quantidade de pedidos;
- pedidos atrasados;
- taxa de atraso;
- nota média;
- taxa de avaliações negativas.

Vendedores com desempenho persistentemente abaixo da média podem ser investigados de forma mais detalhada.

---

# 6. Melhorar a comunicação com clientes em pedidos atrasados

Os dados mostram que mesmo atrasos relativamente curtos estão associados a uma pior experiência.

Pedidos com atraso de 1 a 3 dias apresentaram 32,13% de avaliações negativas.

Embora o conjunto de dados não permita avaliar diretamente a comunicação entre empresa e cliente, uma possível ação de negócio seria melhorar a comunicação em situações de risco ou confirmação de atraso.

Possíveis ações:

- informar antecipadamente alterações na previsão;
- fornecer atualizações sobre o status do pedido;
- evitar expectativas incorretas sobre a data de entrega;
- priorizar atendimento de clientes com atrasos mais severos.

Essa recomendação deve ser validada em estudos futuros, pois a comunicação não foi diretamente medida neste conjunto de dados.

---

# 7. Investigar outras causas de avaliações negativas

O atraso de entrega apresenta forte associação com insatisfação, mas não explica todas as avaliações negativas.

Algumas categorias e vendedores apresentaram níveis elevados de insatisfação mesmo quando a taxa de atraso não estava entre as maiores.

Isso indica que outras variáveis podem influenciar a experiência.

Possíveis fatores incluem:

- qualidade do produto;
- divergência entre produto recebido e descrição;
- embalagem;
- atendimento;
- comunicação;
- preço;
- custo do frete;
- desempenho do vendedor.

Essas hipóteses não foram testadas diretamente neste estudo.

---

# Próximos passos

Para aprofundar a análise, estudos futuros poderiam incorporar outras tabelas e variáveis disponíveis no conjunto de dados.

## Análise de preço e frete

Investigar se:

- pedidos de maior valor apresentam padrões diferentes de satisfação;
- valores elevados de frete estão associados a avaliações piores;
- a relação entre valor do produto e frete influencia a experiência.

---

## Análise dos comentários

Os textos das avaliações poderiam ser utilizados para identificar os principais motivos relatados pelos clientes.

Possíveis temas incluem:

- atraso;
- produto danificado;
- produto incorreto;
- qualidade;
- embalagem;
- atendimento.

Uma análise de texto poderia complementar os resultados quantitativos deste estudo.

---

## Análise temporal

Uma análise futura poderia investigar:

- evolução da taxa de atraso ao longo do tempo;
- sazonalidade;
- períodos de maior volume;
- meses com pior desempenho;
- impacto de datas comemorativas.

Isso permitiria identificar se determinados períodos apresentam maior risco operacional.

---

## Análise de vendedores com múltiplos sellers por pedido

Neste estudo, a análise por vendedor foi limitada a pedidos associados a apenas um vendedor.

Uma análise mais avançada poderia desenvolver uma metodologia específica para pedidos com múltiplos vendedores.

Isso permitiria ampliar a cobertura sem atribuir incorretamente um problema logístico a todos os vendedores envolvidos.

---

# Recomendações prioritárias

Com base nos resultados encontrados, as ações poderiam ser priorizadas da seguinte maneira:

1. reduzir a ocorrência de pedidos entregues após a data estimada;
2. acompanhar separadamente atrasos mais severos;
3. monitorar regiões com desempenho logístico abaixo da média;
4. identificar categorias que combinam alto volume e grande número de atrasos;
5. acompanhar vendedores com indicadores persistentemente críticos;
6. melhorar a comunicação com clientes em pedidos com risco de atraso;
7. investigar fatores adicionais associados às avaliações negativas.

---

# Considerações finais

Este estudo identificou uma forte associação entre desempenho logístico e satisfação dos clientes no conjunto de dados analisado.

A entrega dentro do prazo está relacionada a avaliações significativamente melhores, enquanto atrasos apresentam forte associação com avaliações negativas.

Além disso, os resultados mostram que a análise deve considerar não apenas médias gerais, mas também diferenças entre regiões, categorias e vendedores.

As recomendações propostas têm como objetivo apoiar a priorização de problemas e orientar investigações futuras.

Como o conjunto de dados é histórico e anonimizado, os resultados não devem ser interpretados como uma avaliação do desempenho atual da Olist.

O principal valor do estudo está na demonstração de como dados de pedidos, logística e avaliações podem ser utilizados para transformar um problema de negócio em indicadores, insights e recomendações acionáveis.
