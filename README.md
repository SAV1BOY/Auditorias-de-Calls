# 📊 Sistema de Auditoria de Calls de Fechamento — High Ticket

> Pipeline automatizado de análise de calls comerciais usando IA, com scoring de 13 dimensões, cruzamento de 10 frameworks especializados e distribuição automática de relatórios.

---

## 🎯 O que é este projeto

Um sistema completo para auditar calls de fechamento high ticket, construído a partir da análise cirúrgica de uma call real (Evelyn x Elane, 2h44min, fechamento de R$ 44.000) cruzada com 10 frameworks de vendas de elite.

O sistema:
1. **Recebe** a gravação de uma call (upload no Google Drive)
2. **Transcreve** automaticamente (Whisper API)
3. **Analisa** com IA usando 10 frameworks especializados (Claude API)
4. **Pontua** em 13 dimensões com score ponderado
5. **Distribui** resumo no WhatsApp + relatório completo por email
6. **Persiste** tudo no Supabase para evolução histórica

---

## 📂 Estrutura do Repositório

```
📁 Auditorias-de-Calls/
│
├── 📁 01-auditoria-call-elane/          # Auditoria minuto a minuto da call base
│   └── auditoria-call-elane-completa.md
│
├── 📁 02-protocolo-elite/               # Protocolo de 6 fases com perguntas exatas
│   └── protocolo-elite-call-fechamento-v1.md
│
├── 📁 03-playbook-operacional/          # Playbook .docx profissional (25+ pgs)
│   └── playbook-call-fechamento-v1.docx
│
├── 📁 04-scorecard/                     # Scorecard Excel com 5 abas e 134 fórmulas
│   └── scorecard-auditoria-calls-v1.xlsx
│
├── 📁 05-system-prompt-analista/        # Cérebro da IA — system prompt completo
│   └── system-prompt-analista-calls-v1.md
│
├── 📁 06-guia-integracao/              # Guia técnico de integração no n8n
│   └── guia-integracao-n8n-analista-calls.md
│
├── 📁 07-pipeline-n8n/                 # Workflow completo (12 nós) + SQL Supabase
│   └── workflow-pipeline-auditoria-calls-v1.md
│
├── 📁 08-documentos-base/             # Documentos originais usados como base
│   ├── 📁 framework-evelyn/           # Framework de call da Evelyn
│   ├── 📁 transcricao-elane/          # Transcrição bruta da call com a Elane
│   └── 📁 analise-gemini/            # Análise prévia feita pelo Gemini
│
└── README.md
```

---

## 🔧 Componentes do Sistema

### 1. Auditoria da Call Elane (`01-auditoria-call-elane/`)
Análise minuto a minuto da call Evelyn x Elane (2h44min) com:
- Score recalibrado por dimensão (vs análise do Gemini)
- Identificação de frameworks por bloco temporal
- Pontos fortes com evidência textual
- Erros críticos ordenados por gravidade
- Protocolo extraído de 6 fases

### 2. Protocolo de Elite (`02-protocolo-elite/`)
O protocolo operacional completo com:
- 6 fases sequenciais com objetivo único
- Perguntas exatas (scripts word-by-word)
- Transições entre fases
- Sinais de avanço e risco
- Árvores de decisão para cada bifurcação
- Gates de passagem (checklists entre fases)
- Frases proibidas com substituições
- Tempos ideais vs call real

### 3. Playbook Operacional (`03-playbook-operacional/`)
Documento Word profissional (25+ páginas) com:
- Headers coloridos por fase
- Scripts em blocos destacados
- Tabelas de perguntas com tratamentos
- Alertas visuais (vermelho/laranja/dourado)
- Scorecard completo
- Pronto para impressão e distribuição

### 4. Scorecard Excel (`04-scorecard/`)
Planilha com 5 abas e 134 fórmulas:
- **Scorecard** — 13 dimensões com score ponderado automático
- **Checklist por Fase** — 54 itens operacionais
- **Exemplo (Call Elane)** — preenchido como referência
- **Histórico de Calls** — evolução ao longo do tempo
- **Referência Rápida** — frases proibidas + tempos ideais

### 5. System Prompt do Analista (`05-system-prompt-analista/`)
O cérebro da IA para análise automática:
- 10 frameworks completos embutidos
- Protocolo de 6 fases como benchmark
- Scorecard de 13 dimensões com pesos
- Guia de calibração de notas (0-10 com referências)
- Tabela de frases proibidas para detecção
- 10 passos de análise sequencial
- Formato de output padronizado

### 6. Guia de Integração (`06-guia-integracao/`)
Como plugar no n8n:
- Arquitetura do workflow
- Configuração por nó
- Estimativa de custos por call
- Tabela de modelos recomendados

### 7. Pipeline n8n (`07-pipeline-n8n/`)
Workflow completo de 12 nós:
- Google Drive Trigger → Whisper API → Claude API → Supabase → WhatsApp → Email
- Schema SQL completo para o Supabase
- Views prontas para dashboard
- Código JavaScript de cada nó
- Variáveis de ambiente
- Checklist de implementação

---

## 🏗 Stack Tecnológico

| Componente | Tecnologia | Função |
|---|---|---|
| Orquestrador | n8n | Workflow automation |
| Storage (bruto) | Google Drive | Gravações de áudio |
| Transcrição | OpenAI Whisper API | Audio → Texto (PT-BR) |
| Análise IA | Claude API (Sonnet) | Auditoria com scoring |
| Persistência | Supabase (PostgreSQL) | Histórico + dashboard |
| WhatsApp | Evolution API | Resumo para grupo |
| Email | SMTP | Relatório completo |

---

## 💰 Custos Estimados

| Call de 1h | Call de 2h |
|---|---|
| ~R$ 2,50 | ~R$ 5,00 |

Para 20 calls/mês: **~R$ 50-100/mês**

---

## 📊 Os 10 Frameworks Integrados

1. **Alex Hormozi** — C.L.O.S.E.R. + Value Equation
2. **Jeremy Miner** — NEPQ (Neuro Emotional Persuasion Questioning)
3. **Jordan Belfort** — Straight Line Persuasion
4. **Cole Gordon** — 8-Figure Sales Framework
5. **Eli Wilde** — Wilde Influence (PNL + Mudança de Crenças)
6. **Dan Lok** — High-Ticket Closer
7. **Neil Rackham** — SPIN Selling
8. **Dixon & Adamson** — The Challenger Sale
9. **Sabri Suby** — Sell Like Crazy
10. **Bradley Lea** — Closer School

---

## 📈 As 13 Dimensões do Scorecard

| # | Dimensão | Peso |
|---|---|---|
| 1 | Frame e Liderança | 8% |
| 2 | Qualificação Preliminar | 10% |
| 3 | Diagnóstico Quantitativo | 12% |
| 4 | Diagnóstico Qualitativo | 8% |
| 5 | Perguntas de Consequência | 10% |
| 6 | Ensino Comercial | 5% |
| 7 | Reframe de Identidade | 5% |
| 8 | Ancoragem de Valor | 10% |
| 9 | Isolamento de Objeção | 10% |
| 10 | Proporção de Fala | 8% |
| 11 | Segurança de Promessas | 8% |
| 12 | Checkpoints | 3% |
| 13 | Controle e Fechamento | 3% |

**Classificação:** Elite (≥8.5) | Forte (7.0-8.4) | Mediana (5.5-6.9) | Fraca (<5.5)

---

## 🚀 Como Implementar

1. Clonar este repositório
2. Executar o SQL do `07-pipeline-n8n/` no Supabase
3. Criar workflow no n8n seguindo o guia do `07-pipeline-n8n/`
4. Colar o system prompt do `05-system-prompt-analista/` no nó do Claude
5. Configurar variáveis de ambiente (chaves de API)
6. Criar estrutura de pastas no Google Drive
7. Testar com a transcrição da Elane (`08-documentos-base/`)
8. Ativar trigger e começar a auditar calls reais

---

## 📋 Licença

Projeto interno — uso privado.

---

*Construído com Claude Opus 4.6 • Março 2026*
