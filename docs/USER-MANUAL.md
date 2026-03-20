# Manual do Usuário — CallAudit

Guia completo de todas as funcionalidades, telas e campos do sistema.

---

## O Que é o CallAudit

O CallAudit é um sistema de auditoria automática de calls de fechamento high ticket. Ele:

1. **Recebe** gravações de calls de vendas (upload manual ou via Google Drive)
2. **Transcreve** o áudio automaticamente (Whisper API)
3. **Analisa** a call contra 10 frameworks de vendas e 13 dimensões de scoring (Claude IA)
4. **Gera** um relatório completo com score, erros, acertos, reescrita de falas e plano de ação
5. **Distribui** o resultado via WhatsApp (resumo) e Email (relatório completo)

O objetivo é que supervisores consigam auditar 100% das calls sem precisar ouvir cada uma manualmente.

---

## Navegação Principal

O app tem uma sidebar (menu lateral) com 5 seções:

| Menu | O que faz |
|------|----------|
| **Dashboard** | Visão geral com estatísticas e gráficos |
| **Calls** | Lista de todas as calls auditadas |
| **Upload** | Enviar nova gravação para auditoria |
| **Closers** | Gestão de closers (vendedores) |
| **Configurações** | WhatsApp, Email e status das integrações |

Em telas mobile, o menu aparece como um botão hamburguer no canto superior esquerdo.

---

## 1. Dashboard

A tela principal ao fazer login. Mostra o panorama geral do time.

### Stat Cards (4 cartões no topo)

| Cartão | O que mostra |
|--------|-------------|
| **Total de Calls** | Quantidade total de calls auditadas |
| **Score Médio** | Média geral de score de todas as calls (0 a 10) |
| **Taxa de Fechamento** | Porcentagem de calls que resultaram em venda |
| **Calls Esta Semana** | Quantidade de calls enviadas nos últimos 7 dias |

### Gráfico de Evolução de Score

Gráfico de linha mostrando como o score médio do time evolui ao longo do tempo. Cada ponto é uma call concluída.

### Distribuição por Classificação

Gráfico mostrando quantas calls caem em cada faixa:

| Classificação | Score | Cor |
|---------------|-------|-----|
| **ELITE** | 8.5 a 10.0 | Verde |
| **FORTE** | 7.0 a 8.4 | Azul |
| **MEDIANA** | 5.5 a 6.9 | Amarelo |
| **FRACA** | 0.0 a 5.4 | Vermelho |

### Calls Recentes

Tabela com as últimas calls processadas. Colunas: Closer, Lead, Data, Score, Classificação, Status. Clique em uma linha para ver o detalhe.

---

## 2. Calls (Lista de Calls)

Página com todas as calls do sistema, com filtros e ordenação.

### Filtros Disponíveis

| Filtro | Tipo | Opções |
|--------|------|--------|
| **Closer** | Dropdown | Todos os closers cadastrados |
| **Classificação** | Dropdown | Elite, Forte, Mediana, Fraca |
| **Resultado** | Dropdown | Fechamento, Não Fechou, Reagendar, Outro |
| **Status** | Dropdown | Enviado, Transcrevendo, Analisando, Completo, Erro |
| **Data De** | Campo de data | Data inicial do filtro |
| **Data Até** | Campo de data | Data final do filtro |

### Colunas da Tabela

| Coluna | Descrição | Ordenável |
|--------|-----------|-----------|
| **Closer** | Nome do vendedor | Não |
| **Lead** | Nome do lead/prospect | Sim |
| **Data** | Data da call | Sim |
| **Duração** | Tempo da call em minutos | Sim |
| **Score** | Nota final (0-10) com cor | Sim |
| **Classificação** | Elite/Forte/Mediana/Fraca | Sim |
| **Status** | Status atual no pipeline | Sim |

Clique no cabeçalho de uma coluna para ordenar. Clique novamente para inverter (crescente/decrescente).

Clique em qualquer linha para abrir o **detalhe completo da auditoria**.

### Status do Pipeline

Cada call passa por estas etapas automaticamente:

```
Enviado → Transcrevendo → Transcrito → Analisando → Analisado → Notificando → Completo
```

Se algo der errado, o status muda para **Erro** com uma mensagem explicativa.

---

## 3. Upload (Enviar Nova Call)

Página para enviar uma gravação de call para auditoria.

### Campos do Formulário

| Campo | Tipo | Obrigatório | Descrição |
|-------|------|-------------|-----------|
| **Áudio da Call** | Drag & drop / file picker | Sim | Arraste ou clique para selecionar o arquivo de áudio |
| **Closer** | Dropdown | Sim | Selecione qual vendedor fez esta call |
| **Nome do Lead** | Texto | Sim | Nome do prospect/cliente (ex: "Elane Lima") |
| **Data da Call** | Data | Não | Data em que a call aconteceu (padrão: hoje) |
| **Resultado** | Radio buttons | Não | Fechamento, Não Fechou, Reagendar ou Outro |
| **Valor do Fechamento** | Número (R$) | Não | Aparece apenas se resultado = "Fechamento" |

### Formatos de Áudio Aceitos

| Formato | Extensão |
|---------|----------|
| OGG Vorbis | `.ogg` |
| MP3 | `.mp3` |
| MP4 Audio | `.mp4` |
| WebM Audio | `.webm` |
| WAV | `.wav` |
| M4A (Apple) | `.m4a` |

**Tamanho máximo:** 500 MB por arquivo.

### O Que Acontece Após o Upload

1. O áudio é salvo no armazenamento seguro (Supabase Storage)
2. Um job de transcrição é criado automaticamente
3. Você é redirecionado para a lista de calls
4. O worker processa a call automaticamente em segundo plano
5. O status atualiza em tempo real na tela

---

## 4. Detalhe da Auditoria

A tela mais completa do sistema. Acessada ao clicar em uma call na lista.

### Header (Cabeçalho)

Exibe as informações principais da call:

| Campo | Descrição |
|-------|-----------|
| **Closer** | Nome do vendedor |
| **Lead** | Nome do prospect |
| **Data** | Data da call |
| **Duração** | Tempo total em minutos |
| **Resultado** | Fechamento, Não Fechou, etc. |
| **Score Final** | Nota de 0 a 10 (destaque grande) |
| **Classificação** | Badge colorido: Elite/Forte/Mediana/Fraca |
| **Links do Drive** | Links para áudio e relatório no Google Drive (se configurado) |

### Player de Áudio

Reprodutor de áudio integrado para ouvir a call diretamente no navegador. Controles: play/pause, barra de progresso, volume.

### Tab 1 — Scorecard (13 Dimensões)

Tabela com as 13 dimensões avaliadas na call. Cada dimensão tem:

| Elemento | Descrição |
|----------|-----------|
| **Nome** | Nome da dimensão |
| **Peso** | Porcentagem do peso no score final |
| **Nota** | Score de 0 a 10 |
| **Barra** | Barra de progresso colorida |

**As 13 Dimensões:**

| # | Dimensão | Peso | O que avalia |
|---|----------|------|-------------|
| 1 | **Frame e Liderança** | 8% | Se o closer conduziu a call ou deixou o lead conduzir |
| 2 | **Qualificação Preliminar** | 10% | Se confirmou que o lead tem perfil e pode pagar |
| 3 | **Diagnóstico Quantitativo** | 12% | Se levantou números concretos (faturamento, investimento, metas) |
| 4 | **Diagnóstico Qualitativo** | 8% | Se explorou dores emocionais e impactos pessoais |
| 5 | **Perguntas de Consequência** | 10% | Se fez o lead visualizar o custo de não agir |
| 6 | **Ensino Comercial** | 5% | Se educou o lead com insights antes de apresentar a oferta |
| 7 | **Reframe de Identidade** | 5% | Se conectou a solução à identidade/aspiração do lead |
| 8 | **Ancoragem de Valor** | 10% | Se construiu valor antes de apresentar preço |
| 9 | **Isolamento de Objeção** | 10% | Se tratou objeções de forma estruturada |
| 10 | **Proporção de Fala** | 8% | Se o closer falou menos que 40% do tempo |
| 11 | **Segurança de Promessas** | 8% | Se usou provas, cases e garantias |
| 12 | **Checkpoints** | 3% | Se fez check-ins de entendimento durante a call |
| 13 | **Controle e Fechamento** | 3% | Se conduziu para o fechamento de forma natural |

**Cores das notas:**
- Verde (8.5+): Excelente
- Azul (7.0-8.4): Bom
- Amarelo (5.5-6.9): Precisa melhorar
- Vermelho (<5.5): Crítico

### Tab 2 — Relatório Completo

O relatório completo gerado pela IA, renderizado em markdown com formatação rica:
- Cabeçalhos e subcabeçalhos
- Listas com bullet points
- Tabelas
- Texto em negrito e itálico
- Blocos de citação

Este é o relatório que também é enviado por email e salvo no Google Drive.

### Tab 3 — Transcrição

A transcrição completa da call em texto. Recursos:
- **Campo de busca**: digite uma palavra ou frase para encontrar no texto
- **Highlight**: os trechos encontrados são destacados em amarelo
- **Scroll**: área de rolagem com altura máxima de 600px

### Tab 4 — Erros & Acertos

Dividido em duas colunas:

**Top Erros (esquerda)**
Até 5 erros principais identificados na call, cada um com:
- Ranking (1-5)
- Título do erro
- Descrição detalhada
- Severidade (badge colorido)

**Top Acertos (direita)**
Até 5 pontos positivos da call, cada um com:
- Ranking (1-5)
- Título do acerto
- Descrição detalhada

### Tab 5 — Reescrita de Falas

Mostra falas problemáticas do closer e como deveriam ter sido ditas. Layout side-by-side:

| Lado Esquerdo (Vermelho) | Lado Direito (Verde) |
|--------------------------|---------------------|
| **O que foi dito** | **O que deveria ter sido dito** |
| Fala original do closer | Versão corrigida e melhorada |

Cada reescrita inclui:
- **Momento**: em que ponto da call aconteceu
- **Original**: o que o closer disse
- **Reescrita**: versão melhorada
- **Motivo**: por que a mudança é importante
- **Impacto**: qual seria o resultado esperado

### Tab 6 — Plano de Ação

5 prioridades de melhoria para o closer, estruturadas como:

| Campo | Descrição |
|-------|-----------|
| **Prioridade** | Ranking (1 a 5, do mais importante para o menos) |
| **O que fazer** | Ação específica que o closer deve tomar |
| **Por quê** | Justificativa baseada na análise da call |
| **Como treinar** | Método prático para desenvolver essa habilidade |

---

## 5. Closers (Gestão de Vendedores)

### Lista de Closers

Tabela com todos os closers cadastrados:

| Coluna | Descrição |
|--------|-----------|
| **Nome** | Nome do closer (com avatar) |
| **Email** | Email do closer (se cadastrado) |
| **WhatsApp** | Número WhatsApp (se cadastrado) |
| **Status** | Ativo ou Inativo |
| **Ações** | Menu com: Ver Perfil, Editar, Ativar/Desativar |

### Cadastrar Novo Closer

Clique em **Novo Closer** para abrir o formulário:

| Campo | Tipo | Obrigatório | Descrição |
|-------|------|-------------|-----------|
| **Nome** | Texto | Sim | Nome completo do closer |
| **Email** | Email | Não | Para receber relatórios por email |
| **WhatsApp** | Texto | Não | Número com DDD (ex: 5511999999999) |

### Editar Closer

No menu de ações (3 pontos), clique em **Editar**. Mesmos campos do cadastro.

### Ativar/Desativar Closer

No menu de ações, clique em **Desativar** (ou **Ativar**). Closers inativos não aparecem no dropdown de upload, mas seu histórico é mantido.

### Perfil do Closer

Ao clicar em **Ver Perfil**, você vê a página de performance individual:

**Stat Cards (5 cartões):**

| Cartão | O que mostra |
|--------|-------------|
| **Score Médio** | Média de todas as calls do closer |
| **Total de Calls** | Quantidade de calls auditadas |
| **Taxa de Fechamento** | Porcentagem de calls com resultado "fechamento" |
| **Melhor Score** | A maior nota já recebida |
| **Pior Score** | A menor nota já recebida |

**Gráfico de Evolução:**
Linha do tempo mostrando como o score do closer evolui a cada call. Útil para ver se o treinamento está dando resultado.

**Radar Chart (13 dimensões):**
Gráfico radar mostrando a média do closer em cada uma das 13 dimensões. Permite identificar visualmente quais áreas são fortes e quais precisam de atenção.

Dimensões no radar (abreviadas):
Frame, Qualif., Diag.Quant., Diag.Qual., Conseq., Ensino, Ident., Ancor., Isol., Prop.Fala, Promessas, Checkp., Fech.

---

## 6. Configurações

### Destinatários de Notificações

Configure quem recebe as notificações quando uma auditoria é concluída:

| Campo | Formato | Exemplo |
|-------|---------|---------|
| **Números WhatsApp** | Um número por linha, com código do país | `5511999999999` |
| **Endereços de Email** | Um email por linha | `supervisor@empresa.com` |

Após preencher, clique em **Salvar Configurações**.

### Status das Integrações

Mostra se cada API externa está configurada e funcionando:

| Integração | O que verifica |
|-----------|---------------|
| **WhatsApp (Evolution API)** | Se URL, Token e Instance ID estão configurados |
| **Email (Resend)** | Se API Key está configurada |
| **Whisper (OpenAI)** | Se API Key está configurada |
| **Claude (Anthropic)** | Se API Key está configurada |

Status possíveis:
- **Configurado** (verde): chaves preenchidas
- **Não configurado** (cinza): chaves ausentes

---

## 7. Fluxo Completo — Passo a Passo

### Via Upload pelo App

```
1. Closer grava a call (qualquer formato de áudio)
2. Supervisor faz upload pelo app (Upload > arrastar arquivo)
3. Sistema transcreve automaticamente (1-5 min)
4. Sistema analisa contra 13 dimensões (1-3 min)
5. Relatório aparece na página de detalhe da call
6. WhatsApp recebe resumo no grupo
7. Emails recebem relatório completo
8. Relatório salvo no Google Drive
9. Dashboard e perfil do closer atualizados
```

### Via Google Drive

```
1. Closer grava a call
2. Alguém joga o arquivo na pasta Gravações/[closer]/ do Drive
3. Worker detecta o novo arquivo automaticamente (a cada 2 min)
4. Worker baixa, cria a auditoria e inicia o pipeline
5. Mesmo fluxo: transcrição → análise → notificação → completo
```

Ambos os caminhos convergem no mesmo pipeline. O sistema garante que nenhum arquivo é processado duas vezes.

---

## 8. Classificações e Scores

### Como o Score Final é Calculado

O score final (0 a 10) é uma média ponderada das 13 dimensões. Cada dimensão tem um peso diferente (ver tabela na seção 4, Tab Scorecard). Dimensões mais importantes para a venda (como Diagnóstico Quantitativo: 12%) pesam mais no resultado.

### Faixas de Classificação

| Classificação | Faixa de Score | Significado |
|---------------|---------------|-------------|
| **ELITE** | 8.5 — 10.0 | Call excepcional. Seguiu todos os frameworks com maestria. |
| **FORTE** | 7.0 — 8.4 | Boa call. Alguns pontos de melhoria, mas sólida. |
| **MEDIANA** | 5.5 — 6.9 | Call razoável. Vários pontos precisam de atenção. |
| **FRACA** | 0.0 — 5.4 | Call problemática. Treinamento urgente necessário. |

### Frameworks de Vendas Analisados

A IA avalia a call contra 10 metodologias:

1. **SPIN Selling** — Perguntas de Situação, Problema, Implicação e Need-payoff
2. **Challenger Sale** — Ensinar, Customizar, Assumir o Controle
3. **BANT** — Budget, Authority, Need, Timeline
4. **MEDDIC** — Metrics, Economic Buyer, Decision Criteria/Process, Identify Pain, Champion
5. **Sandler** — Contrato inicial, Dor, Orçamento, Decisão, Fulfillment, Pós-venda
6. **Gap Selling** — Identificar a lacuna entre estado atual e desejado
7. **Solution Selling** — Diagnóstico antes de prescrição
8. **Conceptual Selling** — Vender o conceito, não o produto
9. **Value Selling** — Quantificar o valor antes do preço
10. **Consultative Selling** — Postura de consultor, não de vendedor

---

## 9. Dicas de Uso

### Para Supervisores

- Use o **Dashboard** diariamente para ter uma visão geral
- Filtre por **classificação "Fraca"** na lista de calls para priorizar treinamento
- Compare o **radar chart** de diferentes closers para identificar padrões do time
- Use o **Plano de Ação** como base para sessões de coaching 1:1
- Acompanhe o **gráfico de evolução** para medir o impacto do treinamento

### Para Closers

- Revise seus **Erros & Acertos** após cada call para aprendizado rápido
- Pratique a **Reescrita de Falas** — são exemplos concretos do que dizer
- Foque nas dimensões com nota **vermelha (<5.5)** no seu radar chart
- Siga o **Plano de Ação** como roteiro de evolução semanal

### Para Gestores

- Acompanhe a **Taxa de Fechamento** no dashboard para medir ROI do time
- Compare **Score Médio** entre closers para identificar top performers
- Use a classificação para definir bônus: ELITE = 100%, FORTE = 75%, etc.
- Exporte relatórios do Drive para apresentações de resultado
