export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export interface Database {
  public: {
    Tables: {
      organizations: {
        Row: {
          id: string
          name: string
          slug: string
          created_at: string
        }
        Insert: {
          id?: string
          name: string
          slug: string
          created_at?: string
        }
        Update: {
          id?: string
          name?: string
          slug?: string
          created_at?: string
        }
        Relationships: []
      }
      profiles: {
        Row: {
          id: string
          organization_id: string | null
          full_name: string
          role: "admin" | "supervisor" | "closer" | "viewer"
          avatar_url: string | null
          created_at: string
        }
        Insert: {
          id: string
          organization_id?: string | null
          full_name: string
          role?: "admin" | "supervisor" | "closer" | "viewer"
          avatar_url?: string | null
          created_at?: string
        }
        Update: {
          id?: string
          organization_id?: string | null
          full_name?: string
          role?: "admin" | "supervisor" | "closer" | "viewer"
          avatar_url?: string | null
          created_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "profiles_organization_id_fkey"
            columns: ["organization_id"]
            isOneToOne: false
            referencedRelation: "organizations"
            referencedColumns: ["id"]
          }
        ]
      }
      closers: {
        Row: {
          id: string
          organization_id: string | null
          name: string
          email: string | null
          whatsapp: string | null
          avatar_url: string | null
          active: boolean
          created_at: string
        }
        Insert: {
          id?: string
          organization_id?: string | null
          name: string
          email?: string | null
          whatsapp?: string | null
          avatar_url?: string | null
          active?: boolean
          created_at?: string
        }
        Update: {
          id?: string
          organization_id?: string | null
          name?: string
          email?: string | null
          whatsapp?: string | null
          avatar_url?: string | null
          active?: boolean
          created_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "closers_organization_id_fkey"
            columns: ["organization_id"]
            isOneToOne: false
            referencedRelation: "organizations"
            referencedColumns: ["id"]
          }
        ]
      }
      call_audits: {
        Row: {
          id: string
          organization_id: string | null
          closer_id: string | null
          lead_name: string
          call_date: string
          duration_minutes: number | null
          resultado: "fechamento" | "nao_fechou" | "reagendar" | "outro" | null
          valor_fechamento: number | null
          status: "uploaded" | "transcribing" | "transcribed" | "analyzing" | "analyzed" | "notifying" | "completed" | "error"
          error_message: string | null
          score_final: number | null
          classificacao: "ELITE" | "FORTE" | "MEDIANA" | "FRACA" | null
          d01_frame: number | null
          d02_qualificacao: number | null
          d03_diag_quantitativo: number | null
          d04_diag_qualitativo: number | null
          d05_consequencia: number | null
          d06_ensino: number | null
          d07_identidade: number | null
          d08_ancoragem: number | null
          d09_isolamento: number | null
          d10_proporcao_fala: number | null
          d11_promessas: number | null
          d12_checkpoints: number | null
          d13_fechamento: number | null
          transcricao: string | null
          relatorio_completo: string | null
          resumo_whatsapp: string | null
          top_erros: Json
          top_acertos: Json
          plano_acao: Json
          frases_proibidas: Json
          reescrita_falas: Json
          mapa_frameworks: Json
          fases_analise: Json
          audio_path: string | null
          audio_duration_seconds: number | null
          drive_file_id: string | null
          drive_url: string | null
          drive_report_url: string | null
          modelo_transcricao: string
          modelo_analise: string
          tokens_input: number | null
          tokens_output: number | null
          custo_estimado: number | null
          uploaded_at: string
          transcribed_at: string | null
          analyzed_at: string | null
          notified_at: string | null
          completed_at: string | null
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          organization_id?: string | null
          closer_id?: string | null
          lead_name: string
          call_date: string
          duration_minutes?: number | null
          resultado?: "fechamento" | "nao_fechou" | "reagendar" | "outro" | null
          valor_fechamento?: number | null
          status?: "uploaded" | "transcribing" | "transcribed" | "analyzing" | "analyzed" | "notifying" | "completed" | "error"
          error_message?: string | null
          score_final?: number | null
          classificacao?: "ELITE" | "FORTE" | "MEDIANA" | "FRACA" | null
          d01_frame?: number | null
          d02_qualificacao?: number | null
          d03_diag_quantitativo?: number | null
          d04_diag_qualitativo?: number | null
          d05_consequencia?: number | null
          d06_ensino?: number | null
          d07_identidade?: number | null
          d08_ancoragem?: number | null
          d09_isolamento?: number | null
          d10_proporcao_fala?: number | null
          d11_promessas?: number | null
          d12_checkpoints?: number | null
          d13_fechamento?: number | null
          transcricao?: string | null
          relatorio_completo?: string | null
          resumo_whatsapp?: string | null
          top_erros?: Json
          top_acertos?: Json
          plano_acao?: Json
          frases_proibidas?: Json
          reescrita_falas?: Json
          mapa_frameworks?: Json
          fases_analise?: Json
          audio_path?: string | null
          audio_duration_seconds?: number | null
          drive_file_id?: string | null
          drive_url?: string | null
          drive_report_url?: string | null
          modelo_transcricao?: string
          modelo_analise?: string
          tokens_input?: number | null
          tokens_output?: number | null
          custo_estimado?: number | null
          uploaded_at?: string
          transcribed_at?: string | null
          analyzed_at?: string | null
          notified_at?: string | null
          completed_at?: string | null
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          organization_id?: string | null
          closer_id?: string | null
          lead_name?: string
          call_date?: string
          duration_minutes?: number | null
          resultado?: "fechamento" | "nao_fechou" | "reagendar" | "outro" | null
          valor_fechamento?: number | null
          status?: "uploaded" | "transcribing" | "transcribed" | "analyzing" | "analyzed" | "notifying" | "completed" | "error"
          error_message?: string | null
          score_final?: number | null
          classificacao?: "ELITE" | "FORTE" | "MEDIANA" | "FRACA" | null
          d01_frame?: number | null
          d02_qualificacao?: number | null
          d03_diag_quantitativo?: number | null
          d04_diag_qualitativo?: number | null
          d05_consequencia?: number | null
          d06_ensino?: number | null
          d07_identidade?: number | null
          d08_ancoragem?: number | null
          d09_isolamento?: number | null
          d10_proporcao_fala?: number | null
          d11_promessas?: number | null
          d12_checkpoints?: number | null
          d13_fechamento?: number | null
          audio_path?: string | null
          audio_duration_seconds?: number | null
          drive_file_id?: string | null
          drive_url?: string | null
          drive_report_url?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "call_audits_organization_id_fkey"
            columns: ["organization_id"]
            isOneToOne: false
            referencedRelation: "organizations"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "call_audits_closer_id_fkey"
            columns: ["closer_id"]
            isOneToOne: false
            referencedRelation: "closers"
            referencedColumns: ["id"]
          }
        ]
      }
      job_queue: {
        Row: {
          id: string
          audit_id: string | null
          job_type: "transcribe" | "analyze" | "notify" | "weekly_report"
          status: "pending" | "processing" | "completed" | "failed"
          attempts: number
          max_attempts: number
          error_message: string | null
          started_at: string | null
          completed_at: string | null
          created_at: string
        }
        Insert: {
          id?: string
          audit_id?: string | null
          job_type: "transcribe" | "analyze" | "notify" | "weekly_report"
          status?: "pending" | "processing" | "completed" | "failed"
          attempts?: number
          max_attempts?: number
          error_message?: string | null
          started_at?: string | null
          completed_at?: string | null
          created_at?: string
        }
        Update: {
          id?: string
          audit_id?: string | null
          job_type?: "transcribe" | "analyze" | "notify" | "weekly_report"
          status?: "pending" | "processing" | "completed" | "failed"
          attempts?: number
          max_attempts?: number
          error_message?: string | null
          started_at?: string | null
          completed_at?: string | null
          created_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "job_queue_audit_id_fkey"
            columns: ["audit_id"]
            isOneToOne: false
            referencedRelation: "call_audits"
            referencedColumns: ["id"]
          }
        ]
      }
      app_config: {
        Row: {
          id: string
          organization_id: string | null
          key: string
          value: Json
          updated_at: string
        }
        Insert: {
          id?: string
          organization_id?: string | null
          key: string
          value: Json
          updated_at?: string
        }
        Update: {
          id?: string
          organization_id?: string | null
          key?: string
          value?: Json
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "app_config_organization_id_fkey"
            columns: ["organization_id"]
            isOneToOne: false
            referencedRelation: "organizations"
            referencedColumns: ["id"]
          }
        ]
      }
      notifications: {
        Row: {
          id: string
          audit_id: string | null
          channel: "whatsapp" | "email"
          recipient: string
          content: string | null
          status: string
          sent_at: string
        }
        Insert: {
          id?: string
          audit_id?: string | null
          channel: "whatsapp" | "email"
          recipient: string
          content?: string | null
          status?: string
          sent_at?: string
        }
        Update: {
          id?: string
          audit_id?: string | null
          channel?: "whatsapp" | "email"
          recipient?: string
          content?: string | null
          status?: string
          sent_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "notifications_audit_id_fkey"
            columns: ["audit_id"]
            isOneToOne: false
            referencedRelation: "call_audits"
            referencedColumns: ["id"]
          }
        ]
      }
      goals: {
        Row: {
          id: string
          organization_id: string | null
          title: string
          type: "individual" | "team" | "dimension"
          metric: "score_avg" | "score_min" | "classificacao_count" | "taxa_fechamento" | "dimension_avg"
          target_value: number
          dimension_id: string | null
          closer_id: string | null
          start_date: string
          end_date: string
          status: "active" | "completed" | "failed"
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          organization_id?: string | null
          title: string
          type: "individual" | "team" | "dimension"
          metric: "score_avg" | "score_min" | "classificacao_count" | "taxa_fechamento" | "dimension_avg"
          target_value: number
          dimension_id?: string | null
          closer_id?: string | null
          start_date: string
          end_date: string
          status?: "active" | "completed" | "failed"
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          organization_id?: string | null
          title?: string
          type?: "individual" | "team" | "dimension"
          metric?: "score_avg" | "score_min" | "classificacao_count" | "taxa_fechamento" | "dimension_avg"
          target_value?: number
          dimension_id?: string | null
          closer_id?: string | null
          start_date?: string
          end_date?: string
          status?: "active" | "completed" | "failed"
          created_at?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "goals_organization_id_fkey"
            columns: ["organization_id"]
            isOneToOne: false
            referencedRelation: "organizations"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "goals_closer_id_fkey"
            columns: ["closer_id"]
            isOneToOne: false
            referencedRelation: "closers"
            referencedColumns: ["id"]
          }
        ]
      }
      call_bookmarks: {
        Row: {
          id: string
          audit_id: string
          organization_id: string | null
          bookmarked_by: string | null
          tags: string[]
          highlight_timestamps: Json
          notes: string | null
          created_at: string
        }
        Insert: {
          id?: string
          audit_id: string
          organization_id?: string | null
          bookmarked_by?: string | null
          tags?: string[]
          highlight_timestamps?: Json
          notes?: string | null
          created_at?: string
        }
        Update: {
          id?: string
          audit_id?: string
          organization_id?: string | null
          bookmarked_by?: string | null
          tags?: string[]
          highlight_timestamps?: Json
          notes?: string | null
          created_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "call_bookmarks_audit_id_fkey"
            columns: ["audit_id"]
            isOneToOne: true
            referencedRelation: "call_audits"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "call_bookmarks_organization_id_fkey"
            columns: ["organization_id"]
            isOneToOne: false
            referencedRelation: "organizations"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "call_bookmarks_bookmarked_by_fkey"
            columns: ["bookmarked_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          }
        ]
      }
      call_comments: {
        Row: {
          id: string
          audit_id: string
          author_id: string
          parent_id: string | null
          timestamp_sec: number | null
          content: string
          resolved: boolean
          resolved_by: string | null
          resolved_at: string | null
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          audit_id: string
          author_id: string
          parent_id?: string | null
          timestamp_sec?: number | null
          content: string
          resolved?: boolean
          resolved_by?: string | null
          resolved_at?: string | null
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          audit_id?: string
          author_id?: string
          parent_id?: string | null
          timestamp_sec?: number | null
          content?: string
          resolved?: boolean
          resolved_by?: string | null
          resolved_at?: string | null
          created_at?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "call_comments_audit_id_fkey"
            columns: ["audit_id"]
            isOneToOne: false
            referencedRelation: "call_audits"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "call_comments_author_id_fkey"
            columns: ["author_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "call_comments_parent_id_fkey"
            columns: ["parent_id"]
            isOneToOne: false
            referencedRelation: "call_comments"
            referencedColumns: ["id"]
          }
        ]
      }
      weekly_reports: {
        Row: {
          id: string
          organization_id: string | null
          week_start: string
          week_end: string
          report_markdown: string
          stats: Json
          sent_whatsapp: boolean
          sent_email: boolean
          sent_at: string | null
          generated_at: string
          created_at: string
        }
        Insert: {
          id?: string
          organization_id?: string | null
          week_start: string
          week_end: string
          report_markdown: string
          stats?: Json
          sent_whatsapp?: boolean
          sent_email?: boolean
          sent_at?: string | null
          generated_at?: string
          created_at?: string
        }
        Update: {
          id?: string
          organization_id?: string | null
          week_start?: string
          week_end?: string
          report_markdown?: string
          stats?: Json
          sent_whatsapp?: boolean
          sent_email?: boolean
          sent_at?: string | null
          generated_at?: string
          created_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "weekly_reports_organization_id_fkey"
            columns: ["organization_id"]
            isOneToOne: false
            referencedRelation: "organizations"
            referencedColumns: ["id"]
          }
        ]
      }
      drive_sync: {
        Row: {
          id: string
          drive_file_id: string
          drive_folder_id: string | null
          audit_id: string | null
          file_name: string
          origin: "frontend" | "drive"
          synced_at: string
        }
        Insert: {
          id?: string
          drive_file_id: string
          drive_folder_id?: string | null
          audit_id?: string | null
          file_name: string
          origin: "frontend" | "drive"
          synced_at?: string
        }
        Update: {
          id?: string
          drive_file_id?: string
          drive_folder_id?: string | null
          audit_id?: string | null
          file_name?: string
          origin?: "frontend" | "drive"
          synced_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "drive_sync_audit_id_fkey"
            columns: ["audit_id"]
            isOneToOne: false
            referencedRelation: "call_audits"
            referencedColumns: ["id"]
          }
        ]
      }
    }
    Views: {
      v_dashboard_stats: {
        Row: {
          organization_id: string | null
          total_calls: number
          calls_completas: number
          calls_em_processamento: number
          media_score: number | null
          total_fechamentos: number
          taxa_fechamento_pct: number | null
          calls_elite: number
          calls_forte: number
          calls_mediana: number
          calls_fraca: number
        }
        Relationships: []
      }
      v_closer_performance: {
        Row: {
          closer_id: string
          closer_name: string
          organization_id: string | null
          total_calls: number
          media_score: number | null
          pior_score: number | null
          melhor_score: number | null
          fechamentos: number
          avg_d01: number | null
          avg_d02: number | null
          avg_d03: number | null
          avg_d04: number | null
          avg_d05: number | null
          avg_d06: number | null
          avg_d07: number | null
          avg_d08: number | null
          avg_d09: number | null
          avg_d10: number | null
          avg_d11: number | null
          avg_d12: number | null
          avg_d13: number | null
        }
        Relationships: []
      }
    }
    Functions: {
      [_ in never]: never
    }
  }
}
