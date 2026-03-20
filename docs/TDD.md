# TDD — Technical Design Document
# CallAudit: Sistema de Auditoria de Calls
## Versão 1.0

---

## 1. Decisões de Arquitetura

### ADR-001: Next.js 14 com App Router (não Pages Router)
**Contexto:** Precisamos de SSR, Server Actions e React Server Components para performance.
**Decisão:** App Router com Server Components por padrão, Client Components apenas para interatividade.
**Consequência:** Melhor performance, menos JavaScript no cliente, Server Actions substituem API routes para mutações.

### ADR-002: Supabase Storage em vez de Google Drive
**Contexto:** Google Drive precisa de OAuth complexo e não oferece RLS. Supabase Storage integra nativamente com auth e DB.
**Decisão:** Supabase Storage como storage primário. Google Drive como sync opcional futuro.
**Consequência:** API unificada, RLS no storage, upload direto do browser com signed URLs.

### ADR-003: Python Worker em vez de n8n
**Contexto:** n8n é visual mas frágil para produção, não versionável, difícil de testar.
**Decisão:** Python scripts rodando como serviço no Oracle VPS, polling a job queue no Supabase.
**Consequência:** Testável, versionável, debugável. Trade-off: precisa manter o serviço rodando (systemd).

### ADR-004: Job Queue via Supabase (não Redis/BullMQ)
**Contexto:** Adicionar Redis seria mais uma infra para manter. Volume é baixo (5-20 calls/semana).
**Decisão:** Tabela `job_queue` no Supabase com polling a cada 30s pelo worker.
**Consequência:** Zero infra adicional. Para >100 calls/dia, migrar para BullMQ + Redis.

### ADR-005: Monorepo com workspaces
**Contexto:** Frontend (Next.js/TypeScript) e Worker (Python) são projetos separados mas relacionados.
**Decisão:** Monorepo com `apps/web` (Next.js) e `workers/` (Python). Shared types via docs.
**Consequência:** Um repositório, dois deploys. CI/CD testa ambos.

---

## 2. Contratos de API

### 2.1 Server Actions (Next.js)

#### `uploadCall(formData: FormData): Promise<{ auditId: string }>`
```typescript
// Input (FormData):
// - file: File (audio)
// - closerId: string (UUID)
// - leadName: string
// - callDate: string (YYYY-MM-DD)
// - resultado: 'fechamento' | 'nao_fechou' | 'reagendar' | 'outro'
// - valorFechamento?: number

// Flow:
// 1. Validate inputs
// 2. Upload file to Supabase Storage (bucket: audios)
// 3. Create call_audits row (status: 'uploaded')
// 4. Create job_queue row (type: 'transcribe')
// 5. Return audit ID

// Output:
{ auditId: "uuid-here" }
```

#### `getAudits(filters): Promise<Audit[]>`
```typescript
interface AuditFilters {
  closerId?: string;
  dateFrom?: string;
  dateTo?: string;
  classificacao?: string;
  resultado?: string;
  status?: string;
  sortBy?: string;
  sortOrder?: 'asc' | 'desc';
  page?: number;
  pageSize?: number;
}

// Returns: Paginated list of audits with closer name joined
```

#### `getAuditDetail(id: string): Promise<AuditDetail>`
```typescript
// Returns: Full audit with all fields, including parsed JSONB fields
```

#### `getDashboardStats(): Promise<DashboardStats>`
```typescript
interface DashboardStats {
  totalCalls: number;
  mediaScore: number;
  taxaFechamento: number;
  callsEstaSemana: number;
  porClassificacao: { elite: number; forte: number; mediana: number; fraca: number };
  evolucaoScore: { date: string; score: number }[];
}
```

### 2.2 Worker Pipeline (Python)

#### Transcriber
```python
class TranscriptionResult:
    text: str                    # Full text
    segments: list[Segment]      # Timestamped segments
    duration_seconds: float
    language: str
    
class Segment:
    start: float
    end: float
    text: str

def transcribe(audio_path: str) -> TranscriptionResult:
    """Send audio to Whisper API, return structured result."""
```

#### Analyzer
```python
class AnalysisResult:
    raw_text: str                # Full markdown report
    score_final: float           
    classificacao: str           
    dimensions: dict[str, float] # d01..d13
    top_erros: list[dict]        
    top_acertos: list[dict]      
    plano_acao: list[dict]       
    frases_proibidas: list[dict] 
    reescrita_falas: list[dict]  
    mapa_frameworks: dict        
    tokens_input: int
    tokens_output: int

def analyze(transcription: str, metadata: dict) -> AnalysisResult:
    """Send transcription + system prompt to Claude, parse result."""
```

#### Parser
```python
def parse_analysis(raw_text: str) -> AnalysisResult:
    """Parse Claude's markdown output into structured data.
    
    Extracts:
    - Score final (regex on X.X/10 pattern)
    - Classification (regex on ELITE/FORTE/MEDIANA/FRACA)
    - 13 dimension scores (regex on markdown table)
    - Top errors section
    - Top wins section
    - Action plan section
    - Prohibited phrases section
    - Rewrite section
    - Framework map section
    """
```

### 2.3 Webhook (Worker → Frontend)

```typescript
// POST /api/webhooks/processing
// Called by worker after each status change
{
  auditId: string;
  status: 'transcribed' | 'analyzed' | 'completed' | 'error';
  data?: {
    score?: number;
    classificacao?: string;
  };
}
```

---

## 3. Componentes do Frontend

### 3.1 Componentes de Página

| Componente | Tipo | Props | Data Source |
|---|---|---|---|
| DashboardPage | Server | - | `getDashboardStats()` |
| CallListPage | Server | searchParams | `getAudits(filters)` |
| CallDetailPage | Server | params.id | `getAuditDetail(id)` |
| UploadPage | Client | - | `getClosers()` |
| CloserListPage | Server | - | `getClosers()` |
| CloserProfilePage | Server | params.id | `getCloserProfile(id)` |
| SettingsPage | Server | - | `getConfig()` |

### 3.2 Componentes de UI

| Componente | Tipo | Responsabilidade |
|---|---|---|
| StatsCards | Server | 4 cards no topo do dashboard |
| RecentCalls | Server | Tabela das últimas calls |
| ScoreChart | Client | Gráfico de evolução (recharts) |
| CallList | Client | Tabela com filtros e ordenação |
| ScorecardDisplay | Client | 13 dimensões com barras e notas |
| ReportViewer | Client | Markdown renderizado do relatório |
| TranscriptionViewer | Client | Transcrição com scroll e busca |
| ErrorsAcertos | Client | Tabs de erros e acertos |
| RewriteComparison | Client | Side-by-side original vs corrigido |
| ActionPlan | Client | Lista de 5 prioridades |
| AudioPlayer | Client | Player de áudio customizado |
| UploadForm | Client | Form com dropzone e validação |
| ProcessingStatus | Client | Status em tempo real (realtime) |
| CloserCard | Server | Card com avatar, nome, score médio |
| RadarChart | Client | Radar das 13 dimensões (recharts) |
| EvolutionChart | Client | Linha de evolução de score |

### 3.3 Estado em Tempo Real

Para mostrar o status do processamento em tempo real:

```typescript
// hooks/use-realtime-audit.ts
import { useEffect, useState } from 'react';
import { createClient } from '@/lib/supabase/client';

export function useRealtimeAudit(auditId: string) {
  const [audit, setAudit] = useState(null);
  
  useEffect(() => {
    const supabase = createClient();
    
    const channel = supabase
      .channel(`audit-${auditId}`)
      .on('postgres_changes', {
        event: 'UPDATE',
        schema: 'public',
        table: 'call_audits',
        filter: `id=eq.${auditId}`,
      }, (payload) => {
        setAudit(payload.new);
      })
      .subscribe();
    
    return () => { supabase.removeChannel(channel); };
  }, [auditId]);
  
  return audit;
}
```

---

## 4. Worker — Design Detalhado

### 4.1 Job Runner (main.py)

```python
"""
Loop principal do worker:
1. Poll job_queue a cada 30s
2. Pega o job mais antigo com status 'pending'
3. Marca como 'processing'
4. Executa baseado no job_type
5. Marca como 'completed' ou 'failed'
6. Se failed e attempts < max_attempts, re-enfileira
"""

POLL_INTERVAL = 30  # segundos

def run():
    while True:
        job = fetch_next_job()
        if job:
            process_job(job)
        else:
            sleep(POLL_INTERVAL)

def process_job(job):
    try:
        mark_job_processing(job.id)
        
        if job.job_type == 'transcribe':
            result = transcribe_call(job.audit_id)
            # Cria próximo job: analyze
            create_job(job.audit_id, 'analyze')
            
        elif job.job_type == 'analyze':
            result = analyze_call(job.audit_id)
            # Cria próximo job: notify
            create_job(job.audit_id, 'notify')
            
        elif job.job_type == 'notify':
            notify_stakeholders(job.audit_id)
            # Pipeline completo
            update_audit_status(job.audit_id, 'completed')
        
        mark_job_completed(job.id)
        
    except Exception as e:
        handle_job_failure(job, e)
```

### 4.2 Pipeline de Transcrição

```python
def transcribe_call(audit_id: str):
    # 1. Buscar audit do DB
    audit = get_audit(audit_id)
    update_audit_status(audit_id, 'transcribing')
    
    # 2. Baixar áudio do Supabase Storage
    audio_bytes = download_audio(audit.audio_path)
    
    # 3. Enviar para Whisper API
    result = whisper_transcribe(audio_bytes)
    
    # 4. Salvar transcrição no DB
    update_audit(audit_id, {
        'transcricao': result.text,
        'duration_minutes': round(result.duration_seconds / 60),
        'audio_duration_seconds': result.duration_seconds,
        'status': 'transcribed',
        'transcribed_at': now()
    })
    
    return result
```

### 4.3 Pipeline de Análise

```python
def analyze_call(audit_id: str):
    # 1. Buscar audit com transcrição
    audit = get_audit(audit_id)
    update_audit_status(audit_id, 'analyzing')
    
    # 2. Preparar contexto
    closer = get_closer(audit.closer_id)
    metadata = {
        'closer_name': closer.name,
        'lead_name': audit.lead_name,
        'call_date': audit.call_date,
        'duration_minutes': audit.duration_minutes,
    }
    
    # 3. Chamar Claude API
    raw_analysis = claude_analyze(
        system_prompt=SYSTEM_PROMPT,
        transcription=audit.transcricao,
        metadata=metadata
    )
    
    # 4. Parsear output
    parsed = parse_analysis(raw_analysis.text)
    
    # 5. Gerar resumo WhatsApp
    resumo = generate_whatsapp_summary(parsed, metadata)
    
    # 6. Salvar tudo no DB
    update_audit(audit_id, {
        'status': 'analyzed',
        'score_final': parsed.score_final,
        'classificacao': parsed.classificacao,
        'd01_frame': parsed.dimensions.get('d01'),
        # ... d02-d13
        'relatorio_completo': raw_analysis.text,
        'resumo_whatsapp': resumo,
        'top_erros': json.dumps(parsed.top_erros),
        'top_acertos': json.dumps(parsed.top_acertos),
        'plano_acao': json.dumps(parsed.plano_acao),
        'frases_proibidas': json.dumps(parsed.frases_proibidas),
        'reescrita_falas': json.dumps(parsed.reescrita_falas),
        'mapa_frameworks': json.dumps(parsed.mapa_frameworks),
        'tokens_input': raw_analysis.tokens_input,
        'tokens_output': raw_analysis.tokens_output,
        'custo_estimado': calculate_cost(raw_analysis),
        'analyzed_at': now()
    })
    
    return parsed
```

### 4.4 Retry e Error Handling

```python
MAX_ATTEMPTS = 3
RETRY_DELAYS = [60, 300, 900]  # 1min, 5min, 15min

def handle_job_failure(job, error):
    job.attempts += 1
    
    if job.attempts >= job.max_attempts:
        mark_job_failed(job.id, str(error))
        update_audit_status(job.audit_id, 'error', error_message=str(error))
        notify_error(job.audit_id, error)  # Alertar supervisor
    else:
        # Re-enfileirar com delay
        delay = RETRY_DELAYS[job.attempts - 1]
        requeue_job(job.id, delay_seconds=delay)
```

---

## 5. Deploy

### 5.1 Frontend (Vercel)

```bash
# vercel.json
{
  "framework": "nextjs",
  "buildCommand": "cd apps/web && npm run build",
  "outputDirectory": "apps/web/.next",
  "env": {
    "NEXT_PUBLIC_SUPABASE_URL": "@supabase-url",
    "NEXT_PUBLIC_SUPABASE_ANON_KEY": "@supabase-anon-key",
    "SUPABASE_SERVICE_ROLE_KEY": "@supabase-service-key"
  }
}
```

### 5.2 Worker (Oracle VPS)

```bash
# /etc/systemd/system/callaudit-worker.service
[Unit]
Description=CallAudit Worker
After=network.target

[Service]
Type=simple
User=ubuntu
WorkingDirectory=/opt/callaudit/workers
ExecStart=/opt/callaudit/workers/venv/bin/python -m src.main
Restart=always
RestartSec=10
EnvironmentFile=/opt/callaudit/workers/.env

[Install]
WantedBy=multi-user.target
```

```bash
# Deploy script
#!/bin/bash
cd /opt/callaudit
git pull origin main
cd workers
source venv/bin/activate
pip install -r requirements.txt
sudo systemctl restart callaudit-worker
```

---

## 6. Segurança

| Aspecto | Implementação |
|---|---|
| Auth | Supabase Auth (JWT), middleware em todas as rotas |
| RLS | Ativo em todas as tabelas, filtro por organization_id |
| API Keys | Apenas no servidor (Server Actions + Worker), nunca no cliente |
| Storage | Buckets privados, acesso via signed URLs (expiram em 1h) |
| CORS | Configurado no Supabase para domínio específico |
| Rate Limit | Vercel Edge middleware (10 uploads/hora por usuário) |
| Worker Auth | Service Role Key do Supabase (nunca exposta) |

---

## 7. Monitoramento

| O que monitorar | Como |
|---|---|
| Worker alive | Heartbeat a cada 5min (update em tabela de status) |
| Jobs com falha | Query em job_queue WHERE status = 'failed' |
| Tempo de processamento | Diferença entre uploaded_at e completed_at |
| Erros de API | Logs do worker (stdout → journalctl) |
| Custos de API | Soma de custo_estimado por mês |
| Storage usage | Supabase dashboard |
