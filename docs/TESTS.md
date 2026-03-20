# TEST SPECIFICATIONS — CallAudit
## Testes Unitários, Integração e E2E

---

## 1. Testes do Worker (Python — pytest)

### 1.1 test_transcriber.py

```python
"""Testes para o módulo de transcrição (Whisper API)."""

class TestTranscriber:
    
    def test_transcribe_valid_ogg_returns_text(self):
        """Áudio .ogg válido retorna transcrição com texto não-vazio."""
        # Given: arquivo .ogg de teste (fixtures/sample_audio.ogg)
        # When: transcribe(audio_path)
        # Then: result.text não é vazio, result.duration_seconds > 0
    
    def test_transcribe_returns_segments_with_timestamps(self):
        """Transcrição retorna segmentos com start/end timestamps."""
        # Given: arquivo de áudio válido
        # When: transcribe(audio_path)
        # Then: len(result.segments) > 0
        #       cada segment tem start, end, text
        #       segments estão ordenados por start

    def test_transcribe_detects_portuguese(self):
        """Idioma detectado é português."""
        # Given: áudio em português
        # When: transcribe(audio_path)
        # Then: result.language == 'pt'

    def test_transcribe_calculates_duration(self):
        """Duração calculada corretamente."""
        # Given: áudio de ~24 segundos (fixtures)
        # When: transcribe(audio_path)
        # Then: 20 < result.duration_seconds < 30

    def test_transcribe_handles_invalid_file(self):
        """Arquivo inválido levanta exceção clara."""
        # Given: arquivo .txt (não áudio)
        # When: transcribe("invalid.txt")
        # Then: raises TranscriptionError com mensagem explicativa

    def test_transcribe_handles_empty_file(self):
        """Arquivo vazio levanta exceção."""
        # Given: arquivo de 0 bytes
        # When: transcribe("empty.ogg")
        # Then: raises TranscriptionError

    def test_transcribe_handles_api_timeout(self, mock_openai):
        """Timeout da API é tratado com retry."""
        # Given: mock que retorna timeout nas 2 primeiras chamadas
        # When: transcribe(audio_path)
        # Then: retorna resultado na 3ª tentativa

    def test_transcribe_formats_timestamps(self):
        """Timestamps formatados como [MM:SS]."""
        # Given: transcrição com segmentos
        # When: format_transcription(result)
        # Then: output contém "[00:00]", "[01:25]", etc.
```

### 1.2 test_analyzer.py

```python
"""Testes para o módulo de análise (Claude API)."""

class TestAnalyzer:
    
    def test_analyze_returns_complete_report(self):
        """Análise retorna relatório markdown não-vazio."""
        # Given: transcrição válida + metadata
        # When: analyze(transcription, metadata)
        # Then: result.raw_text contém "# RELATÓRIO"
        #       len(result.raw_text) > 1000

    def test_analyze_extracts_score_final(self):
        """Score final extraído corretamente."""
        # Given: transcrição válida
        # When: analyze(transcription, metadata)
        # Then: 0 <= result.score_final <= 10
        #       result.score_final tem 1 casa decimal

    def test_analyze_extracts_classificacao(self):
        """Classificação é uma das 4 válidas."""
        # Given: transcrição válida
        # When: analyze(transcription, metadata)
        # Then: result.classificacao in ['ELITE', 'FORTE', 'MEDIANA', 'FRACA']

    def test_analyze_extracts_13_dimensions(self):
        """Todas as 13 dimensões extraídas com nota válida."""
        # Given: transcrição válida
        # When: analyze(transcription, metadata)
        # Then: len(result.dimensions) == 13
        #       todas as notas entre 0 e 10

    def test_analyze_score_matches_weighted_average(self):
        """Score final = média ponderada das 13 dimensões."""
        # Given: resultado de análise com dimensões
        # When: calcular média ponderada manualmente
        # Then: abs(calculated - result.score_final) < 0.5
        # (tolerância de 0.5 para arredondamento da IA)

    def test_analyze_includes_system_prompt(self, mock_claude):
        """System prompt é enviado na chamada à API."""
        # Given: mock do Claude API
        # When: analyze(transcription, metadata)
        # Then: mock chamado com system= contendo "ANALISTA DE CALLS"

    def test_analyze_sends_metadata_in_prompt(self, mock_claude):
        """Metadata (closer, lead, data) incluída no prompt."""
        # Given: metadata = {closer: "Evelyn", lead: "Elane", ...}
        # When: analyze(transcription, metadata)
        # Then: mensagem contém "Evelyn" e "Elane"

    def test_analyze_handles_long_transcription(self):
        """Transcrição longa (>50k caracteres) é processada."""
        # Given: transcrição da Elane (154KB)
        # When: analyze(transcription, metadata)
        # Then: retorna resultado sem erro

    def test_analyze_handles_api_error(self, mock_claude):
        """Erro da API Claude é tratado com mensagem clara."""
        # Given: mock que retorna 500
        # When: analyze(transcription, metadata)
        # Then: raises AnalysisError com status code
```

### 1.3 test_parser.py

```python
"""Testes para o parser do output do Claude."""

class TestParser:
    
    def test_parse_score_from_table(self):
        """Extrai score da tabela markdown."""
        # Given: markdown com "| 6.8/10 | CALL FORTE |"
        # When: parse_analysis(text)
        # Then: result.score_final == 6.8

    def test_parse_score_from_text(self):
        """Extrai score de texto livre."""
        # Given: markdown com "Score ponderado: 7.2/10"
        # When: parse_analysis(text)
        # Then: result.score_final == 7.2

    def test_parse_classificacao(self):
        """Extrai classificação corretamente."""
        # Given: markdown com "CALL DE ELITE"
        # When: parse_analysis(text)
        # Then: result.classificacao == "ELITE"

    def test_parse_13_dimensions_from_table(self):
        """Extrai todas as 13 notas da tabela de dimensões."""
        # Given: fixtures/sample_analysis.md
        # When: parse_analysis(text)
        # Then: result.dimensions tem 13 entries
        #       result.dimensions['d01'] == 8.5
        #       result.dimensions['d03'] == 4.0

    def test_parse_top_erros(self):
        """Extrai seção de top erros."""
        # Given: markdown com "## 5. Top 5 Erros"
        # When: parse_analysis(text)
        # Then: len(result.top_erros) >= 1
        #       cada erro tem 'descricao'

    def test_parse_top_acertos(self):
        """Extrai seção de top acertos."""
        # Given: markdown com "## 6. Top 5 Acertos"
        # When: parse_analysis(text)
        # Then: len(result.top_acertos) >= 1

    def test_parse_plano_acao(self):
        """Extrai plano de ação."""
        # Given: markdown com "## 8. Plano de Ação"
        # When: parse_analysis(text)
        # Then: len(result.plano_acao) >= 1

    def test_parse_frases_proibidas(self):
        """Extrai frases proibidas detectadas."""
        # Given: markdown com seção de frases proibidas
        # When: parse_analysis(text)
        # Then: result.frases_proibidas é lista (pode ser vazia)

    def test_parse_handles_missing_sections(self):
        """Parser não quebra se seção estiver ausente."""
        # Given: markdown incompleto (sem seção de erros)
        # When: parse_analysis(text)
        # Then: result.top_erros == []
        #       result.score_final ainda é extraído

    def test_parse_handles_malformed_table(self):
        """Parser lida com tabela markdown mal formatada."""
        # Given: tabela com colunas desalinhadas
        # When: parse_analysis(text)
        # Then: extrai o que conseguir, não levanta exceção

    def test_parse_whatsapp_summary_generation(self):
        """Gera resumo formatado para WhatsApp."""
        # Given: resultado parseado
        # When: generate_whatsapp_summary(parsed, metadata)
        # Then: contém emoji de score, nome do closer/lead
        #       contém top 3 erros e acertos
        #       <= 1000 caracteres

    def test_parse_sample_elane_analysis(self):
        """Parser funciona com a análise real da Elane."""
        # Given: fixtures/sample_analysis.md (análise real)
        # When: parse_analysis(text)
        # Then: score_final == 6.8
        #       classificacao == "FORTE"
        #       13 dimensões presentes
```

### 1.4 test_notifications.py

```python
"""Testes para módulo de notificações."""

class TestWhatsApp:
    
    def test_send_whatsapp_group(self, mock_evolution):
        """Envia mensagem para grupo via Evolution API."""
        # Given: grupo_id e mensagem
        # When: send_whatsapp(grupo_id, message)
        # Then: mock chamado com URL/body corretos
        #       retorna True

    def test_send_whatsapp_handles_api_error(self, mock_evolution):
        """Erro da Evolution API é logado sem crashar."""
        # Given: mock que retorna 500
        # When: send_whatsapp(grupo_id, message)
        # Then: retorna False, não levanta exceção

    def test_whatsapp_message_under_limit(self):
        """Mensagem WhatsApp <= 4096 caracteres."""
        # Given: resumo gerado
        # When: format_whatsapp_message(resumo)
        # Then: len(result) <= 4096

class TestEmail:
    
    def test_send_email_with_report(self, mock_resend):
        """Envia email com relatório completo."""
        # Given: lista de emails, subject, relatório
        # When: send_email(recipients, subject, report)
        # Then: mock chamado com dados corretos

    def test_send_email_html_formatted(self, mock_resend):
        """Email contém HTML formatado do markdown."""
        # Given: relatório em markdown
        # When: send_email(...)
        # Then: body contém tags HTML (<h2>, <table>, etc)
```

### 1.5 test_drive_sync.py

```python
"""Testes para sync bidirecional Google Drive ↔ Supabase."""

class TestDriveWatcher:
    
    def test_detect_new_file_in_closer_folder(self, mock_drive_api):
        """Detecta arquivo novo na pasta de um closer."""
        # Given: pasta evelyn/ com 1 arquivo novo (.ogg)
        # When: check_new_files()
        # Then: retorna 1 DriveFile com folder_name='evelyn'

    def test_ignores_already_synced_files(self, mock_drive_api, db_with_sync):
        """Ignora arquivos que já existem na tabela drive_sync."""
        # Given: arquivo X no Drive + drive_sync row com drive_file_id=X
        # When: check_new_files()
        # Then: retorna lista vazia

    def test_ignores_files_uploaded_from_frontend(self, mock_drive_api, db_with_sync):
        """Ignora arquivos que vieram do frontend (origin='frontend')."""
        # Given: arquivo no Drive com drive_sync.origin='frontend'
        # When: check_new_files()
        # Then: retorna lista vazia (anti-loop)

    def test_extracts_closer_name_from_folder(self):
        """Extrai nome do closer do nome da pasta."""
        # Given: DriveFile com folder_name='evelyn'
        # When: file.closer_name
        # Then: 'Evelyn'

    def test_extracts_lead_name_from_filename(self):
        """Extrai nome do lead do nome do arquivo."""
        # Given: DriveFile com name='2026-03-02_elane-lima.ogg'
        # When: file.lead_name
        # Then: 'Elane Lima'

    def test_extracts_date_from_filename(self):
        """Extrai data do nome do arquivo."""
        # Given: DriveFile com name='2026-03-02_elane-lima.ogg'
        # When: file.call_date
        # Then: '2026-03-02'

    def test_handles_malformed_filename(self):
        """Lida com nomes de arquivo fora do padrão."""
        # Given: DriveFile com name='gravacao_qualquer.ogg'
        # When: file.lead_name, file.call_date
        # Then: lead_name = 'gravacao qualquer', call_date = hoje

class TestDriveSyncFromDrive:
    """Testes do Fluxo B: arquivo sobe pelo Drive → Supabase."""

    def test_sync_downloads_and_stores_in_supabase(self, mock_drive_api):
        """Baixa do Drive e salva no Supabase Storage."""
        # Given: novo arquivo no Drive
        # When: sync_from_drive(drive_file)
        # Then: arquivo existe no Supabase Storage bucket 'audios'

    def test_sync_creates_audit_record(self, mock_drive_api):
        """Cria registro em call_audits com status 'uploaded'."""
        # Given: novo arquivo no Drive, pasta 'evelyn'
        # When: sync_from_drive(drive_file)
        # Then: call_audits row existe com closer='Evelyn', status='uploaded'

    def test_sync_creates_drive_sync_record(self, mock_drive_api):
        """Registra na tabela drive_sync com origin='drive'."""
        # Given: novo arquivo no Drive
        # When: sync_from_drive(drive_file)
        # Then: drive_sync row com origin='drive' e drive_file_id correto

    def test_sync_creates_processing_job(self, mock_drive_api):
        """Cria job de processamento na fila."""
        # Given: novo arquivo no Drive
        # When: sync_from_drive(drive_file)
        # Then: job_queue row com tipo 'process_call' e audit_id correto

class TestDriveSyncFromFrontend:
    """Testes do Fluxo A: arquivo sobe pelo frontend → Drive."""

    def test_sync_uploads_to_drive(self, mock_drive_api):
        """Upload do Supabase para pasta do closer no Drive."""
        # Given: audit com áudio no Supabase Storage, closer='evelyn'
        # When: sync_to_drive(audit_id)
        # Then: arquivo existe na pasta 'Gravações/evelyn/' no Drive

    def test_sync_creates_drive_sync_with_frontend_origin(self, mock_drive_api):
        """Registra na drive_sync com origin='frontend'."""
        # Given: audit processado
        # When: sync_to_drive(audit_id)
        # Then: drive_sync row com origin='frontend'

    def test_sync_updates_audit_with_drive_ids(self, mock_drive_api):
        """Atualiza call_audits com drive_file_id e drive_url."""
        # Given: audit sem drive_file_id
        # When: sync_to_drive(audit_id)
        # Then: audit.drive_file_id preenchido, audit.drive_url preenchido

    def test_save_report_creates_md_in_drive(self, mock_drive_api):
        """Salva relatório .md na pasta Relatórios/closer/."""
        # Given: audit com relatorio_completo
        # When: save_report_to_drive(audit_id)
        # Then: arquivo .md existe em 'Relatórios/evelyn/' no Drive
        #       audit.drive_report_url preenchido

class TestAntiLoop:
    """Testes específicos para o mecanismo anti-loop."""

    def test_frontend_upload_then_drive_detect_no_duplicate(self, mock_drive_api):
        """Arquivo do frontend não é reprocessado quando detectado no Drive."""
        # Given: arquivo subiu pelo frontend
        # When: sync_to_drive(audit_id) → drive watcher detecta o mesmo arquivo
        # Then: check_new_files() retorna vazio (já existe em drive_sync)
        #       NÃO cria segundo audit

    def test_drive_upload_then_frontend_check_no_duplicate(self, mock_drive_api):
        """Arquivo do Drive não é duplicado se alguém tentar subir pelo frontend."""
        # Given: arquivo processado vindo do Drive
        # When: alguém tenta upload do mesmo áudio pelo frontend
        # Then: detectar duplicata por hash ou nome e alertar
```

### 1.6 test_pipeline_integration.py

```python
"""Testes de integração do pipeline completo."""

class TestPipelineIntegration:
    
    def test_full_pipeline_with_sample_audio(self):
        """Pipeline completo com áudio de teste."""
        # Given: áudio de 24s no Supabase Storage + audit criado
        # When: processar pipeline completo (transcribe → analyze → notify)
        # Then: audit status == 'completed'
        #       score_final não é None
        #       relatorio_completo não é vazio
        #       transcricao não é vazia

    def test_pipeline_updates_status_at_each_step(self):
        """Status atualizado em cada etapa."""
        # Given: audit com status 'uploaded'
        # When: processar pipeline
        # Then: status passou por: uploaded → transcribing → transcribed → analyzing → analyzed → completed

    def test_pipeline_creates_chained_jobs(self):
        """Cada etapa cria o próximo job automaticamente."""
        # Given: job de tipo 'transcribe'
        # When: process_job(transcribe_job)
        # Then: novo job com tipo 'analyze' criado na queue

    def test_pipeline_retries_on_failure(self, mock_whisper_fail_once):
        """Pipeline faz retry em falha transiente."""
        # Given: Whisper falha na 1ª tentativa, sucede na 2ª
        # When: process_job(transcribe_job)
        # Then: job.attempts == 2, job.status == 'completed'

    def test_pipeline_marks_error_after_max_retries(self):
        """Após max retries, marca como error."""
        # Given: API sempre falha
        # When: processar 3 tentativas
        # Then: audit.status == 'error'
        #       audit.error_message contém descrição
```

---

## 2. Testes do Frontend (TypeScript — Vitest + Testing Library)

### 2.1 Testes de Server Actions

```typescript
// __tests__/actions/upload.test.ts

describe('uploadCall', () => {
  it('creates audit record with status uploaded', async () => {
    // Given: FormData with valid audio file
    // When: uploadCall(formData)
    // Then: call_audits row created with status 'uploaded'
  });

  it('uploads file to supabase storage', async () => {
    // Given: FormData with .ogg file
    // When: uploadCall(formData)
    // Then: file exists in storage bucket 'audios'
  });

  it('creates transcribe job in queue', async () => {
    // Given: FormData válido
    // When: uploadCall(formData)
    // Then: job_queue row with type 'transcribe' created
  });

  it('rejects files over 500MB', async () => {
    // Given: file.size > 500 * 1024 * 1024
    // When: uploadCall(formData)
    // Then: throws error "Arquivo excede limite de 500MB"
  });

  it('rejects invalid file types', async () => {
    // Given: file.type = 'application/pdf'
    // When: uploadCall(formData)
    // Then: throws error "Formato não suportado"
  });

  it('requires closer_id', async () => {
    // Given: FormData without closerId
    // When: uploadCall(formData)
    // Then: throws error "Selecione um closer"
  });

  it('requires lead_name', async () => {
    // Given: FormData without leadName
    // When: uploadCall(formData)
    // Then: throws error "Informe o nome do lead"
  });
});

describe('getAudits', () => {
  it('returns paginated results', async () => {
    // Given: 25 audits in DB
    // When: getAudits({ page: 1, pageSize: 10 })
    // Then: result.length == 10, result has pagination metadata
  });

  it('filters by closer', async () => {
    // Given: audits from multiple closers
    // When: getAudits({ closerId: 'evelyn-id' })
    // Then: all results have closer_id == 'evelyn-id'
  });

  it('filters by date range', async () => {
    // Given: audits from multiple dates
    // When: getAudits({ dateFrom: '2026-03-01', dateTo: '2026-03-31' })
    // Then: all results within range
  });

  it('filters by classificacao', async () => {
    // Given: audits with various classifications
    // When: getAudits({ classificacao: 'ELITE' })
    // Then: all results have classificacao == 'ELITE'
  });

  it('sorts by score descending', async () => {
    // Given: audits with different scores
    // When: getAudits({ sortBy: 'score_final', sortOrder: 'desc' })
    // Then: results ordered by score descending
  });
});

describe('getAuditDetail', () => {
  it('returns full audit with all fields', async () => {
    // Given: completed audit in DB
    // When: getAuditDetail(auditId)
    // Then: result has all 13 dimension scores
    //       result has transcricao, relatorio_completo
    //       result has parsed JSONB fields as objects
  });

  it('includes closer name joined', async () => {
    // Given: audit with closer_id
    // When: getAuditDetail(auditId)
    // Then: result.closer_name is populated
  });

  it('returns 404 for non-existent audit', async () => {
    // Given: random UUID
    // When: getAuditDetail(randomId)
    // Then: returns null or throws NotFoundError
  });
});
```

### 2.2 Testes de Componentes

```typescript
// __tests__/components/scorecard-display.test.tsx

describe('ScorecardDisplay', () => {
  it('renders all 13 dimensions', () => {
    // Given: audit with all 13 scores
    // When: render(<ScorecardDisplay audit={audit} />)
    // Then: 13 dimension rows visible
  });

  it('shows correct colors per score range', () => {
    // Given: audit with d01=9.0 (green), d02=4.0 (red)
    // When: render(<ScorecardDisplay />)
    // Then: d01 has green background, d02 has red background
  });

  it('shows score final prominently', () => {
    // Given: audit with score_final=7.2
    // When: render(<ScorecardDisplay />)
    // Then: "7.2" visible in large text
  });

  it('shows classification badge', () => {
    // Given: audit with classificacao='FORTE'
    // When: render(<ScorecardDisplay />)
    // Then: "CALL FORTE" badge visible with blue color
  });
});

// __tests__/components/upload-form.test.tsx

describe('UploadForm', () => {
  it('shows dropzone', () => {
    // When: render(<UploadForm />)
    // Then: dropzone text visible
  });

  it('accepts drag and drop', async () => {
    // Given: rendered form
    // When: drop .ogg file on dropzone
    // Then: file name appears, submit button enabled
  });

  it('validates file type on selection', async () => {
    // Given: rendered form
    // When: select .pdf file
    // Then: error message "Formato não suportado"
  });

  it('shows progress during upload', async () => {
    // Given: rendered form with file selected
    // When: click submit
    // Then: progress bar visible, percentage increases
  });

  it('redirects to detail page after upload', async () => {
    // Given: successful upload
    // When: upload completes
    // Then: redirected to /calls/[new-audit-id]
  });
});

// __tests__/components/processing-status.test.tsx

describe('ProcessingStatus', () => {
  it('shows uploading state', () => {
    // Given: audit with status 'uploaded'
    // When: render(<ProcessingStatus audit={audit} />)
    // Then: "Enviado, aguardando processamento" visible
  });

  it('shows transcribing state', () => {
    // Given: audit with status 'transcribing'
    // When: render
    // Then: "Transcrevendo áudio..." with spinner
  });

  it('shows analyzing state', () => {
    // Given: audit with status 'analyzing'
    // When: render
    // Then: "Analisando com IA..." with spinner
  });

  it('shows completed state with score', () => {
    // Given: audit with status 'completed', score 7.5
    // When: render
    // Then: score visible, no spinner
  });

  it('shows error state', () => {
    // Given: audit with status 'error'
    // When: render
    // Then: error message visible, retry button available
  });

  it('updates in realtime via subscription', () => {
    // Given: audit with status 'transcribing'
    // When: Supabase sends UPDATE event (status → 'analyzed')
    // Then: component updates without page reload
  });
});
```

---

## 3. Testes E2E (Playwright)

```typescript
// e2e/upload-and-view.spec.ts

test.describe('Upload and View Audit', () => {
  
  test('complete flow: login → upload → wait → view result', async ({ page }) => {
    // 1. Login
    await page.goto('/login');
    await page.fill('[name=email]', 'test@example.com');
    await page.fill('[name=password]', 'password');
    await page.click('button[type=submit]');
    await page.waitForURL('/');

    // 2. Navigate to upload
    await page.click('text=Upload');
    await page.waitForURL('/calls/upload');

    // 3. Upload file
    await page.setInputFiles('input[type=file]', 'fixtures/sample_audio.ogg');
    await page.selectOption('[name=closerId]', 'evelyn-id');
    await page.fill('[name=leadName]', 'Elane Lima');
    await page.fill('[name=callDate]', '2026-03-02');
    await page.click('text=Fechamento');
    await page.click('button:has-text("Enviar")');

    // 4. Wait for redirect to detail
    await page.waitForURL(/\/calls\/.+/);

    // 5. Wait for processing (with timeout)
    await page.waitForSelector('text=Score', { timeout: 300000 }); // 5 min

    // 6. Verify result
    await expect(page.locator('[data-testid=score-final]')).toBeVisible();
    await expect(page.locator('[data-testid=classificacao]')).toBeVisible();
  });

  test('dashboard shows recent calls', async ({ page }) => {
    await page.goto('/');
    await expect(page.locator('[data-testid=stats-total-calls]')).toBeVisible();
    await expect(page.locator('[data-testid=recent-calls-table]')).toBeVisible();
  });

  test('filter calls by closer', async ({ page }) => {
    await page.goto('/calls');
    await page.selectOption('[data-testid=filter-closer]', 'evelyn');
    await page.waitForTimeout(500);
    const rows = page.locator('[data-testid=call-row]');
    for (const row of await rows.all()) {
      await expect(row.locator('[data-testid=closer-name]')).toHaveText('Evelyn');
    }
  });

  test('view audit detail with all tabs', async ({ page }) => {
    await page.goto('/calls/[existing-audit-id]');
    
    // Scorecard tab
    await expect(page.locator('[data-testid=dimension-row]')).toHaveCount(13);
    
    // Report tab
    await page.click('text=Relatório');
    await expect(page.locator('[data-testid=report-content]')).toBeVisible();
    
    // Transcription tab
    await page.click('text=Transcrição');
    await expect(page.locator('[data-testid=transcription-content]')).toBeVisible();
    
    // Errors tab
    await page.click('text=Erros');
    await expect(page.locator('[data-testid=error-item]')).toHaveCount({ min: 1 });
  });
});
```

---

## 4. Fixtures de Teste

### fixtures/sample_audio.ogg
O áudio de 24 segundos do WhatsApp (briefing do pipeline) — já existe no repositório.

### fixtures/sample_transcription.txt
```
[00:00] O ideal seria colocar a pasta de cada closer na pasta de gravação record sabe
[00:08] E aí toda vez que subisse uma reunião nova ia fazer uma análise
[00:14] e enviar para os interessados tipo os supervisores
[00:18] e também colocar um resumo do grupo
```

### fixtures/sample_analysis.md
Usar a análise completa da Elane (`01-auditoria-call-elane/auditoria-call-elane-completa.md`) como fixture.

---

## 5. Checklist de Testes antes de Deploy

### Worker (Python)
- [ ] `pytest tests/ -v` — todos passando
- [ ] `pytest tests/ --cov=src --cov-report=term` — cobertura ≥80%
- [ ] `test_pipeline_integration` — pipeline completo funciona

### Frontend (Next.js)
- [ ] `vitest run` — todos passando
- [ ] `vitest run --coverage` — cobertura ≥70%
- [ ] `tsc --noEmit` — sem erros de tipo
- [ ] `next lint` — sem warnings

### E2E
- [ ] `playwright test` — fluxo principal funciona
- [ ] Upload → processamento → visualização: end-to-end ok

---

## 6. Ambientes de Teste

| Ambiente | Supabase | APIs | Propósito |
|---|---|---|---|
| Local (dev) | Supabase local (Docker) ou projeto dev | Mocks | Desenvolvimento rápido |
| Staging | Projeto Supabase separado | APIs reais (baixo volume) | Teste de integração |
| Produção | Projeto Supabase principal | APIs reais | Uso real |

Para testes unitários: sempre usar mocks das APIs externas (Whisper, Claude, Evolution, Resend).
Para testes de integração: usar APIs reais contra ambiente staging.
Para E2E: usar APIs reais ou ambiente staging.
