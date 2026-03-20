# Pesquisa de Mercado — CallAudit

Análise de plataformas concorrentes e funcionalidades que agregariam valor ao sistema.

Data: Março 2026

---

## 1. Panorama do Mercado

O mercado de "Conversation Intelligence" (inteligência de conversas) movimenta bilhões e cresce a ~14% ao ano. As principais plataformas são:

| Plataforma | Foco Principal | Preço Estimado | Destaque |
|-----------|---------------|---------------|----------|
| **Gong** | Revenue Intelligence | ~$100-150/user/mês | Líder de mercado. Deal scoring, previsão de pipeline |
| **Chorus (ZoomInfo)** | Conversation Intel + Dados | ~$80-120/user/mês | Integração nativa com base de dados ZoomInfo |
| **Revenue.io** | Coaching em Tempo Real | ~$60-100/user/mês | Coaching ao vivo durante a call |
| **Claap** | Análise de Calls | ~$30-60/user/mês | 70% mais barato que Gong, IA nativa |
| **Salesloft** | Engagement + Coaching | ~$75-125/user/mês | Cadências multi-canal + análise |
| **Avoma** | Notas + Scoring | ~$20-50/user/mês | Bom custo-benefício para times pequenos |
| **Fireflies.ai** | Transcrição + Notas | ~$10-30/user/mês | Plano gratuito disponível |
| **Observe.AI** | QA para Contact Centers | Enterprise | Auditoria automatizada de 100% das calls |
| **Mindtickle** | Treinamento + Roleplay | Enterprise | Simulações com IA para onboarding |
| **Hyperbound** | Roleplay IA | ~$30-40/user/mês | Simulação de objeções com IA em tempo real |

### Onde o CallAudit se posiciona

O CallAudit é um **nicho específico**: auditoria de calls de fechamento high ticket no mercado brasileiro, com análise contra frameworks de vendas específicos. Não é um concorrente direto do Gong (que foca em pipeline/forecast), mas sim uma ferramenta especializada de **coaching baseado em dados**.

**Vantagens atuais do CallAudit:**
- Análise profunda contra 10 frameworks de vendas (SPIN, Challenger, BANT, MEDDIC, etc.)
- 13 dimensões de scoring com pesos calibrados para high ticket
- Reescrita de falas (original vs corrigido) — funcionalidade rara no mercado
- Plano de ação estruturado por call — vai além do "o que errou"
- Custo por call (~R$1-3) vs assinatura mensal de US$100+/user
- Interface 100% em português

**Lacunas vs mercado:**
O CallAudit faz análise pós-call excelente, mas faltam funcionalidades que os concorrentes oferecem para **fechar o loop** entre análise → ação → melhoria mensurável.

---

## 2. Funcionalidades Recomendadas

### Prioridade ALTA — Impacto direto em resultado

---

#### 2.1 Análise Comparativa entre Closers

**O que é:** Dashboard que compara side-by-side o desempenho de dois ou mais closers nas 13 dimensões.

**Como funciona:**
- Selecionar 2-5 closers para comparar
- Radar chart sobreposto (um polígono por closer)
- Tabela comparativa com médias por dimensão
- Filtro por período (última semana, mês, trimestre)
- Highlight automático: "Closer A é 35% melhor em Ancoragem de Valor que Closer B"

**Quem usa:** Gong (Team Analytics), Revenue.io (Team Scorecards)

**Valor para o supervisor:** Identifica padrões do time, descobre quem pode mentorar quem, e justifica decisões de treinamento com dados.

**Valor para o closer:** Ver onde está abaixo da média do time motiva melhoria.

---

#### 2.2 Tendências e Evolução por Dimensão

**O que é:** Gráficos de tendência para cada uma das 13 dimensões ao longo do tempo, tanto individual quanto do time.

**Como funciona:**
- Gráfico de linha por dimensão (ex: "Diagnóstico Quantitativo" nos últimos 30 dias)
- Média móvel para suavizar variação
- Marcadores de eventos (ex: "treinamento de ancoragem" → ver se a nota subiu depois)
- Alerta: "Dimensão X caiu 15% nas últimas 2 semanas"

**Quem usa:** Gong (Trend Analytics), Observe.AI (Performance Trends)

**Valor:** Medir o impacto real do treinamento. Hoje o supervisor sabe a média geral, mas não consegue ver "a nota de Ancoragem subiu depois do treinamento de terça?"

---

#### 2.3 Biblioteca de Calls Modelo

**O que é:** Curadoria de calls exemplares que servem como referência de treinamento.

**Como funciona:**
- Supervisor marca uma call como "modelo" (star/bookmark)
- Tags por tema: "excelente ancoragem", "objeção de preço resolvida", "diagnóstico perfeito"
- Filtro por dimensão e classificação (só calls ELITE)
- Player integrado com timestamps dos melhores momentos
- "Playlist" de treinamento: selecionar 5 calls modelo para novo closer estudar

**Quem usa:** Gong (Call Library), Salesforce (Call Playlists), Salesloft (Coaching Playlists)

**Valor para o closer:** Aprender com exemplos reais do próprio time, não com teoria genérica.

**Valor para o supervisor:** Onboarding de novos closers em dias, não semanas.

---

#### 2.4 Análise de Sentimento do Lead

**O que é:** Detectar emoções do lead durante a call (interesse, hesitação, frustração, entusiasmo) usando análise de tom de voz e linguagem.

**Como funciona:**
- Timeline de sentimento ao longo da call (gráfico: positivo/neutro/negativo)
- Marcação de "momentos de virada" (quando sentimento muda drasticamente)
- Correlação: "o lead ficou hesitante quando o preço foi mencionado no minuto 23:45"
- Score de engagement do lead (quanto participou vs ficou passivo)
- Proporção de fala mais granular: closer vs lead por fase da call

**Quem usa:** Gong (Customer Engagement Score), Observe.AI (Sentiment Detection), IBM Watson NLU

**Valor:** O closer não percebe que perdeu o lead no minuto 15 quando fez uma promessa vaga. A análise de sentimento mostra exatamente onde.

---

#### 2.5 Metas e OKRs de Performance

**O que é:** Sistema de metas individuais e do time com tracking automático.

**Como funciona:**
- Definir metas: "Score médio >= 7.5 até fim do mês", "Zero calls FRACA em março"
- Progresso visual (barra de progresso na dashboard)
- Metas por dimensão: "Ancoragem de Valor >= 8.0 para todos os closers"
- Meta de time: "Taxa de fechamento >= 40%"
- Histórico de metas cumpridas/não cumpridas

**Quem usa:** Ambition (Goal Tracking), SalesScreen (Performance Goals)

**Valor:** Transforma a análise em ação mensurável. Sem metas, os dados ficam bonitos mas não geram accountability.

---

### Prioridade MÉDIA — Diferencial competitivo

---

#### 2.6 Gamificação e Ranking

**O que é:** Leaderboard com ranking de closers, conquistas (badges) e competições.

**Como funciona:**
- **Leaderboard semanal/mensal:** ranking por score médio, taxa de fechamento, evolução
- **Badges de conquista:** "5 calls ELITE seguidas", "Melhor Ancoragem do Mês", "Evolução +20%"
- **Competições:** "Quem tem o melhor Diagnóstico Quantitativo esta semana?"
- **Streaks:** "3 semanas consecutivas acima de 7.5"
- **Pontuação:** acumular pontos por calls ELITE/FORTE, trocar por prêmios (configurável)

**Quem usa:** Ambition, SalesScreen, Spinify, Hoopla

**Valor para o closer:** Competição saudável motiva, especialmente o "meio do ranking" (60% dos closers que não são nem top nem bottom).

**Valor para o gestor:** Engajamento com a ferramenta sobe drasticamente — closers abrem o app por conta própria.

---

#### 2.7 Roleplay com IA (Simulação de Call)

**O que é:** Closer pratica calls com um "lead virtual" alimentado por IA, que reage como um prospect real.

**Como funciona:**
- Escolher cenário: "Lead com objeção de preço", "Lead indeciso", "Lead que quer desconto"
- IA faz o papel do lead, respondendo em tempo real (texto ou voz)
- IA calibrada com as objeções reais encontradas nas calls auditadas do closer
- Ao final, scoring automático nas 13 dimensões (mesmo scorecard das calls reais)
- Comparativo: "Seu roleplay deu 6.8, sua última call real deu 5.2 — você sabe o que fazer, só precisa aplicar"

**Quem usa:** Hyperbound, Mindtickle, Second Nature, PitchMonster, FullyRamped

**Valor:** Reduz ramp time de novos closers em ~50%. Closers podem praticar cenários difíceis sem risco real. O treinamento deixa de ser "assista esse vídeo" e vira "pratique até acertar".

**Custo estimado:** Usa a mesma API do Claude que já temos. ~R$0.50 por sessão de roleplay.

---

#### 2.8 Resumo Executivo Semanal Automático

**O que é:** Relatório automático enviado toda segunda-feira com o resumo da semana anterior.

**Como funciona:**
- Gerado automaticamente pela IA (Claude) toda segunda-feira
- Conteúdo:
  - Total de calls auditadas na semana
  - Score médio do time (vs semana anterior: subiu/caiu)
  - Top 3 closers da semana
  - Closer que mais evoluiu
  - Dimensão mais fraca do time (prioridade de treinamento)
  - Calls destaque (melhor e pior da semana)
  - Taxa de fechamento vs meta
- Enviado por WhatsApp e/ou Email
- Link para o dashboard com filtro da semana

**Quem usa:** Gong (Weekly Digest), Revenue.io (Manager Insights)

**Valor para o supervisor:** Não precisa entrar no app todo dia — recebe o panorama pronto.

---

#### 2.9 Detecção de Padrões de Perda

**O que é:** IA analisa todas as calls que NÃO fecharam para identificar padrões em comum.

**Como funciona:**
- Agrupamento automático: "70% das calls perdidas têm nota < 5 em Diagnóstico Quantitativo"
- Identificação de "frases assassinas" recorrentes (ex: "o preço é X" antes de construir valor)
- Correlação: "Quando Proporção de Fala > 50%, taxa de fechamento cai para 12%"
- Relatório mensal: "Top 3 motivos de perda deste mês"
- Sugestão de treinamento baseada nos padrões encontrados

**Quem usa:** Gong (Deal Intelligence), Clari (Revenue Leak Detection)

**Valor:** Transforma calls perdidas em aprendizado sistêmico. Em vez de "perdemos a call", é "perdemos porque não fizemos X — e isso acontece em 65% das perdas".

---

#### 2.10 Coaching Assíncrono (Comentários em Timestamp)

**O que é:** Supervisor pode deixar comentários em momentos específicos da call, como feedback pontual.

**Como funciona:**
- Na timeline do áudio, supervisor clica em qualquer momento
- Escreve um comentário: "Aqui você deveria ter feito uma pergunta de consequência"
- Closer recebe notificação: "Novo feedback do supervisor na call X"
- Closer abre e vê os comentários sincronizados com o áudio
- Thread de discussão: closer pode responder/perguntar
- Marcar como "resolvido" quando o closer absorveu o feedback

**Quem usa:** Gong (Call Comments), Jiminny (In-Context Coaching), Salesloft (Call Annotations)

**Valor:** Feedback específico e contextual é 10x mais eficaz que feedback genérico. O supervisor não precisa agendar 1:1 — deixa o comentário e o closer absorve no seu tempo.

---

### Prioridade BAIXA — Futuro / Nice to Have

---

#### 2.11 Integração com CRM

**O que é:** Conectar CallAudit com o CRM da empresa para sincronizar dados de deals e leads.

**Como funciona:**
- Integrar com Pipedrive, HubSpot, Salesforce ou RD Station CRM
- Vincular call ao deal do lead no CRM
- Enviar score e classificação de volta para o CRM
- No CRM: ver histórico de calls e scores do lead
- Correlação: deals que fecharam vs score médio das calls

**Quem usa:** Praticamente todos os concorrentes

**Valor:** Conecta a qualidade da call ao resultado comercial. "Deals onde o closer teve score > 8 fecham 3x mais."

---

#### 2.12 Transcrição com Diarização (Quem Falou o Quê)

**O que é:** Separar a transcrição por falante (closer vs lead), com identificação automática de quem é quem.

**Como funciona:**
- Whisper + diarização: atribuir cada trecho da fala ao closer ou ao lead
- Visualização: transcrição estilo chat (closer à esquerda, lead à direita)
- Métricas precisas: tempo de fala do closer vs lead por fase
- Análise mais precisa: IA sabe exatamente quem disse o quê

**Quem usa:** Gong, Chorus, Fireflies.ai, todos os líderes

**Valor:** Melhora significativamente a qualidade da análise. Hoje o Claude infere quem é quem pelo contexto — com diarização, é exato.

---

#### 2.13 App Mobile Nativo

**O que é:** App para iOS/Android para closers e supervisores.

**Como funciona:**
- Closer: ver seus scores, feedback, plano de ação, ouvir calls
- Supervisor: aprovar auditorias, deixar comentários, ver dashboard
- Push notifications: "Nova auditoria concluída: Score 8.2 — FORTE"
- Modo offline para ler relatórios

**Quem usa:** Gong, SalesScreen, Ambition (todos têm app mobile)

**Valor:** Closers acessam feedback no trânsito, entre calls, no almoço. Aumenta engagement com a ferramenta.

---

#### 2.14 Exportação e Relatórios PDF

**O que é:** Gerar relatórios em PDF formatados para impressão, apresentações ou compartilhamento externo.

**Como funciona:**
- Botão "Exportar PDF" na página de detalhe da auditoria
- PDF profissional com: header, scorecard visual, erros/acertos, plano de ação
- Relatório mensal do time em PDF (para apresentação ao gestor)
- Relatório individual do closer em PDF (para coaching 1:1)

**Quem usa:** Observe.AI (QA Reports), CallMiner (Analytics Export)

**Valor:** Gestores precisam apresentar resultados em reuniões. PDF formatado é mais profissional que screenshot do dashboard.

---

## 3. Roadmap Sugerido

### Sprint 8 — Analytics Avançados
- Análise comparativa entre closers (2.1)
- Tendências por dimensão (2.2)
- Metas e OKRs (2.5)

### Sprint 9 — Coaching e Treinamento
- Biblioteca de calls modelo (2.3)
- Coaching assíncrono com comentários (2.10)
- Resumo executivo semanal (2.8)

### Sprint 10 — Inteligência e Gamificação
- Detecção de padrões de perda (2.9)
- Gamificação e ranking (2.6)
- Análise de sentimento (2.4)

### Sprint 11 — Expansão
- Roleplay com IA (2.7)
- Diarização de falantes (2.12)
- Integração CRM (2.11)
- Exportação PDF (2.14)
- App mobile (2.13)

---

## 4. Impacto Estimado

| Funcionalidade | Impacto no Closer | Impacto no Supervisor | Impacto no Gestor |
|---------------|-------------------|----------------------|-------------------|
| Comparativo entre closers | Motivação (ver onde está vs time) | Decisões de treinamento baseadas em dados | Identificar top performers |
| Tendências por dimensão | Ver evolução pessoal | Medir ROI de treinamento | Relatório de progresso |
| Biblioteca de calls | Aprender com os melhores | Onboarding acelerado | Padronização de qualidade |
| Análise de sentimento | Entender quando perdeu o lead | Coaching mais preciso | Insights de mercado |
| Metas e OKRs | Clareza no que melhorar | Accountability do time | Alinhar com metas comerciais |
| Gamificação | Motivação e engajamento | Engajamento sobe, cobrança cai | Cultura de alta performance |
| Roleplay IA | Treino sem risco | Reduz ramp time 50% | ROI rápido em contratações |
| Resumo semanal | Autoavaliação | Economiza 2-3h/semana | Visibilidade executiva |
| Padrões de perda | Evitar erros repetidos | Treinamento focado | Reduzir churn de pipeline |
| Coaching assíncrono | Feedback contextual | Escala de coaching | Qualidade consistente |

---

## 5. Fontes

- [Gong vs Chorus: The Honest Comparison](https://www.claap.io/blog/gong-vs-chorus-which-is-better-and-why)
- [12 Best Gong Alternatives & Competitors 2026](https://www.revenue.io/blog/best-gong-alternatives-and-competitors-in-2025)
- [9 Best Chorus AI Alternatives](https://www.revenue.io/blog/best-chorus-by-zoominfo-alternatives-competitors)
- [Top 5 AI Call Auditing Platforms 2026](https://www.autointerviewai.com/blog/top-5-ai-call-auditing-platforms-sales-teams-2026)
- [15 Best AI for Sales Calls Tools 2026](https://www.cirrusinsight.com/blog/ai-sales-calls)
- [9 Affordable Gong Alternatives](https://www.claap.io/blog/gong-alternatives)
- [9 Best Conversation Intelligence Software 2026](https://www.avoma.com/blog/best-conversation-intelligence-software)
- [10 Best Conversation Intelligence Solutions](https://www.revenue.io/blog/best-conversation-intelligence-solutions)
- [Top 12 Conversation Intelligence Tools — Outreach](https://www.outreach.io/resources/blog/best-conversation-intelligence-software-tools)
- [Best Sales Coaching Software Tools 2026](https://pipeline.zoominfo.com/sales/sales-coaching-software-tools)
- [15 Best AI Call Scoring Software 2026](https://www.cloudtalk.io/blog/best-ai-call-scoring-software/)
- [Sales Coaching Software Comparison — Nooks](https://www.nooks.ai/blog-posts/sales-coaching-software-comparison-6-picks-for-2026)
- [6 AI Features for Rep Coaching 2026](https://www.alpharun.com/blog/ai-features-software-rep-coaching)
- [Top 8 Sales Gamification Software 2026](https://www.fugo.ai/blog/top-8-sales-gamification-software-rankings-for-2026/)
- [Sales Leaderboards: Complete 2026 Guide](https://spotio.com/blog/sales-leaderboards/)
- [Top 8 AI Sales Roleplay Tools 2026](https://www.outdoo.ai/blog/best-ai-sales-roleplay-tools)
- [8 Best AI Sales Role Play Tools — Mindtickle](https://www.mindtickle.com/blog/best-ai-role-play-tools/)
- [AI Sales Roleplay: Future of Sales Training](https://eagr.ai/blog/ai-sales-roleplay)
- [Customer Sentiment Analysis Guide 2026](https://www.crescendo.ai/blog/customer-sentiment-analysis)
- [How to Leverage Call Sentiment Analysis in Sales](https://www.kixie.com/sales-blog/how-to-leverage-sentiment-analysis-in-sales-calls-with-ai/)
- [20 AI Sentiment Analysis Tools 2026](https://chattermill.com/blog/ai-sentiment-analysis-tools)
