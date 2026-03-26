# CallAudit — Product Roadmap

## v1.0 — Core Platform (Sprints 1-7) ✅ CONCLUIDO

| Sprint | Feature | Status |
|---|---|---|
| 1 | Analise do Supervisor (16 etapas protocolo System Digital) | GOLD STANDARD |
| 2 | Security + DevOps (CSP nonce, rate limiting, CI/CD, Dependabot) | GOLD STANDARD |
| 3 | Design System FACE 100K (M3 tokens, 3 novos componentes) | GOLD STANDARD |
| 4 | Polish + Deploy (loading states, error boundaries, Vercel Analytics) | GOLD STANDARD |
| 5 | Coaching & Training (biblioteca, comments, weekly reports) | GOLD STANDARD |
| 6 | Integracoes Externas (WhatsApp, Email, Google Drive, Whisper, Claude) | GOLD STANDARD |
| 7 | Testes + Qualidade (214 tests, 100% pass rate) | GOLD STANDARD |

---

## v2.0 — Advanced Features (Sprints 8-9) ✅ CONCLUIDO

| Sprint | Feature | Status |
|---|---|---|
| 8 | Pesos configuraveis (13 dimensoes editaveis) | GOLD STANDARD |
| 8 | CRM Webhook (API route + config UI) | GOLD STANDARD |
| 8 | Comparativo Closers (radar side-by-side, ja existia) | VERIFIED |
| 8 | Protocol Editor (16 etapas, ja existia) | VERIFIED |
| 9 | Gamificacao Avancada (badges, streaks, competitions, leaderboard) | VERIFIED |

### Features Adiadas (ADRs documentados):
- **ADR-018**: Diarizacao de Speakers — requer API diferente (AssemblyAI/Deepgram)
- **ADR-021**: Google Meet/Zoom — requer OAuth2 + recording APIs
- **ADR-022**: Roleplay com IA — requer modulo conversacional novo
- **ADR-023**: App Mobile/PWA — adiado para v3.0

---

## v3.0 — Future Features (Planejamento)

### F9: Diarizacao de Speakers
**Descricao**: Separar transcricao por speaker (closer vs lead) com chat-style visualization
**Pre-requisitos**: API de diarizacao (AssemblyAI, Deepgram, ou pyannote.audio)
**Estimativa**: 2 sprints
**Dependencias**: Mudanca no pipeline de transcricao, novo schema para speaker turns

### F10: Integracao Google Meet/Zoom
**Descricao**: Auto-importar gravacoes de reunioes via API
**Pre-requisitos**: Google Workspace com Meet Recording, ou Zoom Pro/Business
**Estimativa**: 2-3 sprints
**Dependencias**: OAuth2 flow, recording download API, integracao com pipeline existente

### F14: App Mobile (React Native)
**Descricao**: App nativo iOS/Android para closers e supervisores
**Pre-requisitos**: React Native setup, push notifications
**Estimativa**: 4-5 sprints
**Alternativa**: PWA (Progressive Web App) como quick-win (1 sprint)

### Roleplay com IA
**Descricao**: Praticar calls com "lead" simulado por IA, scoring automatico
**Pre-requisitos**: Claude API conversacional, banco de cenarios, UI de chat
**Estimativa**: 3-4 sprints
**Alternativa**: Training Actions do Supervisor (ja existe)

### F11: Integracao CRM Bidirecional
**Descricao**: Sync bidirecional com Pipedrive, HubSpot, Salesforce, RD Station
**Pre-requisitos**: APIs de cada CRM, mapping de campos
**Estimativa**: 2-3 sprints por CRM
**Nota**: Webhook outbound (v2.0) ja implementado como primeiro passo

### Exportacao PDF Profissional
**Descricao**: Reports PDF com branding, graficos, metricas completas
**Pre-requisitos**: @react-pdf/renderer (ja instalado)
**Estimativa**: 1 sprint
**Nota**: export-pdf-button.tsx ja existe com funcionalidade basica

---

## Metricas do Projeto

| Metrica | Valor |
|---|---|
| Total de sprints concluidos | 9/9 |
| Certificacoes Gold Standard | 8/8 |
| Testes passando | 214/214 (100%) |
| TypeScript errors | 0 |
| Migrations SQL | 11 |
| Server Actions | 40+ funcoes |
| Componentes React | 80+ |
| Worker Python modules | 15+ |
| Integracoes externas | 6 (Supabase, Whisper, Claude, Evolution, Resend, Drive) |
| Paginas do app | 15+ rotas |

---

*Documento gerado em 26/03/2026 — CallAudit v2.0 | System Digital x FACE 100K*
