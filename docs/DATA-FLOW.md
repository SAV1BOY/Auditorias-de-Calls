# Diagrama de Fluxo de Dados — CallAudit

## Visão Geral

```mermaid
graph TD
    subgraph "Entrada de Dados"
        A[Upload via Frontend] -->|audio file| B[Supabase Storage]
        C[Google Drive] -->|audio file| D[Drive Watcher]
    end

    subgraph "Worker Pipeline"
        B --> E[Job: transcribe]
        D --> F[Drive Sync]
        F -->|cria audit + job| E
        E -->|Whisper API| G[Transcrição]
        G --> H[Job: analyze]
        H -->|Claude API| I[Análise IA]
        I --> J[Parser]
        J -->|scores, erros, acertos| K[Supabase DB]
        J --> L[Job: notify]
        L --> M[WhatsApp / Email]
    end

    subgraph "Sync Bidirecional"
        B -->|após transcrição| N[Sync → Drive]
        N --> C
    end

    subgraph "Frontend - Leitura"
        K --> O[Dashboard]
        K --> P[Lista de Calls]
        K --> Q[Detalhe da Auditoria]
        K --> R[Perfil do Closer]
        K --> S[Analytics]
    end
```

## Fluxo 1: Upload pelo Frontend

```mermaid
sequenceDiagram
    participant U as Usuário
    participant W as Next.js
    participant S as Supabase Storage
    participant DB as Supabase DB
    participant WK as Worker
    participant WH as Whisper API
    participant CL as Claude API
    participant DR as Google Drive
    participant NT as WhatsApp/Email

    U->>W: Upload áudio
    W->>S: Salvar no bucket 'audios'
    W->>DB: INSERT call_audits (status=uploaded)
    W->>DB: INSERT job_queue (type=transcribe)

    WK->>DB: Poll job_queue
    WK->>DB: UPDATE status=transcribing
    WK->>S: Download áudio
    WK->>WH: Enviar áudio
    WH-->>WK: Transcrição
    WK->>DB: UPDATE transcrição + status=transcribed
    WK->>DR: Copiar áudio para pasta do closer
    WK->>DB: INSERT job_queue (type=analyze)

    WK->>DB: Poll job_queue
    WK->>DB: UPDATE status=analyzing
    WK->>CL: Enviar transcrição + system prompt
    CL-->>WK: Relatório markdown
    WK->>WK: Parser extrai scores/erros/acertos
    WK->>DB: UPDATE 13 dimensões + scores + relatório
    WK->>DR: Salvar relatório .md
    WK->>DB: INSERT job_queue (type=notify)

    WK->>DB: Poll job_queue
    WK->>NT: Enviar resumo WhatsApp
    WK->>NT: Enviar relatório email
    WK->>DB: UPDATE status=completed
```

## Fluxo 2: Upload pelo Google Drive

```mermaid
sequenceDiagram
    participant DR as Google Drive
    participant WK as Worker (Drive Watcher)
    participant S as Supabase Storage
    participant DB as Supabase DB

    WK->>DR: Poll pasta de gravações (a cada 120s)
    DR-->>WK: Novos arquivos de áudio
    WK->>DB: Verificar drive_sync (anti-loop)
    Note over WK,DB: Se arquivo já existe em drive_sync, ignorar
    WK->>S: Upload para Supabase Storage
    WK->>DB: INSERT call_audits (status=uploaded)
    WK->>DB: INSERT drive_sync (origin=drive)
    WK->>DB: INSERT job_queue (type=transcribe)
    Note over WK: Pipeline continua igual ao Fluxo 1
```

## Anti-Loop (Sync Bidirecional)

```mermaid
graph LR
    A[Frontend Upload] -->|origin=frontend| B[drive_sync]
    C[Drive Upload] -->|origin=drive| B
    B -->|drive_file_id| D{Já existe?}
    D -->|SIM| E[Ignorar]
    D -->|NÃO| F[Processar]
```

A tabela `drive_sync` garante que cada arquivo é processado **exatamente uma vez**, independente do ponto de entrada.

## Dados por Etapa

| Etapa | Input | Output | Destino |
|---|---|---|---|
| Upload | arquivo áudio (ogg/mp3/m4a/wav) | audio_path no Storage | `call_audits.audio_path` |
| Transcrição | audio_path | texto completo + segments | `call_audits.transcricao` |
| Análise | transcrição + system prompt | relatório markdown (~4000 tokens) | `call_audits.relatorio_completo` |
| Parser | relatório markdown | 13 scores + erros + acertos + reescritas | `call_audits.d01_frame..d13_fechamento` |
| Notificação | scores + resumo | mensagem WhatsApp + email | `notifications` |

## Volumes Esperados

| Métrica | Valor Típico |
|---|---|
| Tamanho do áudio | 5-50 MB |
| Duração da call | 10-90 min |
| Tamanho da transcrição | 5.000-30.000 chars |
| Tamanho do relatório | 3.000-8.000 chars |
| Tokens Claude (input) | 5.000-15.000 |
| Tokens Claude (output) | 2.000-5.000 |
| Tempo total do pipeline | 2-8 min |
