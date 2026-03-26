export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  // Allows to automatically instantiate createClient with right options
  // instead of createClient<Database, { PostgrestVersion: 'XX' }>(URL, KEY)
  __InternalSupabase: {
    PostgrestVersion: "14.1"
  }
  public: {
    Tables: {
      app_config: {
        Row: {
          id: string
          key: string
          organization_id: string | null
          updated_at: string | null
          value: Json
        }
        Insert: {
          id?: string
          key: string
          organization_id?: string | null
          updated_at?: string | null
          value: Json
        }
        Update: {
          id?: string
          key?: string
          organization_id?: string | null
          updated_at?: string | null
          value?: Json
        }
        Relationships: [
          {
            foreignKeyName: "app_config_organization_id_fkey"
            columns: ["organization_id"]
            isOneToOne: false
            referencedRelation: "organizations"
            referencedColumns: ["id"]
          },
        ]
      }
      Assignment: {
        Row: {
          assignedAt: string
          assignedById: string
          assignedToId: string
          id: string
          leadId: string
          notes: string | null
        }
        Insert: {
          assignedAt?: string
          assignedById: string
          assignedToId: string
          id: string
          leadId: string
          notes?: string | null
        }
        Update: {
          assignedAt?: string
          assignedById?: string
          assignedToId?: string
          id?: string
          leadId?: string
          notes?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "Assignment_assignedById_fkey"
            columns: ["assignedById"]
            isOneToOne: false
            referencedRelation: "User"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "Assignment_assignedToId_fkey"
            columns: ["assignedToId"]
            isOneToOne: false
            referencedRelation: "User"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "Assignment_leadId_fkey"
            columns: ["leadId"]
            isOneToOne: false
            referencedRelation: "Lead"
            referencedColumns: ["id"]
          },
        ]
      }
      badges: {
        Row: {
          category: string
          created_at: string | null
          criteria: Json
          description: string
          icon: string
          id: string
          name: string
          organization_id: string | null
          slug: string
        }
        Insert: {
          category: string
          created_at?: string | null
          criteria: Json
          description: string
          icon?: string
          id?: string
          name: string
          organization_id?: string | null
          slug: string
        }
        Update: {
          category?: string
          created_at?: string | null
          criteria?: Json
          description?: string
          icon?: string
          id?: string
          name?: string
          organization_id?: string | null
          slug?: string
        }
        Relationships: [
          {
            foreignKeyName: "badges_organization_id_fkey"
            columns: ["organization_id"]
            isOneToOne: false
            referencedRelation: "organizations"
            referencedColumns: ["id"]
          },
        ]
      }
      call_audits: {
        Row: {
          analyzed_at: string | null
          audio_duration_seconds: number | null
          audio_path: string | null
          call_date: string
          classificacao: string | null
          closer_id: string | null
          completed_at: string | null
          created_at: string | null
          custo_estimado: number | null
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
          drive_file_id: string | null
          drive_report_url: string | null
          drive_url: string | null
          duration_minutes: number | null
          engagement_level: string | null
          error_message: string | null
          fases_analise: Json | null
          frases_proibidas: Json | null
          id: string
          lead_name: string
          mapa_frameworks: Json | null
          modelo_analise: string | null
          modelo_transcricao: string | null
          notified_at: string | null
          objections_detected: Json | null
          organization_id: string | null
          plano_acao: Json | null
          prompt_version: string | null
          reescrita_falas: Json | null
          relatorio_completo: string | null
          report_hash: string | null
          resultado: string | null
          resumo_whatsapp: string | null
          score_final: number | null
          sentiment_overall: string | null
          sentiment_score: number | null
          sentiment_timeline: Json | null
          status: string
          storage_report_path: string | null
          tokens_input: number | null
          tokens_output: number | null
          top_acertos: Json | null
          top_erros: Json | null
          transcribed_at: string | null
          transcricao: string | null
          updated_at: string | null
          uploaded_at: string | null
          valor_fechamento: number | null
        }
        Insert: {
          analyzed_at?: string | null
          audio_duration_seconds?: number | null
          audio_path?: string | null
          call_date: string
          classificacao?: string | null
          closer_id?: string | null
          completed_at?: string | null
          created_at?: string | null
          custo_estimado?: number | null
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
          drive_file_id?: string | null
          drive_report_url?: string | null
          drive_url?: string | null
          duration_minutes?: number | null
          engagement_level?: string | null
          error_message?: string | null
          fases_analise?: Json | null
          frases_proibidas?: Json | null
          id?: string
          lead_name: string
          mapa_frameworks?: Json | null
          modelo_analise?: string | null
          modelo_transcricao?: string | null
          notified_at?: string | null
          objections_detected?: Json | null
          organization_id?: string | null
          plano_acao?: Json | null
          prompt_version?: string | null
          reescrita_falas?: Json | null
          relatorio_completo?: string | null
          report_hash?: string | null
          resultado?: string | null
          resumo_whatsapp?: string | null
          score_final?: number | null
          sentiment_overall?: string | null
          sentiment_score?: number | null
          sentiment_timeline?: Json | null
          status?: string
          storage_report_path?: string | null
          tokens_input?: number | null
          tokens_output?: number | null
          top_acertos?: Json | null
          top_erros?: Json | null
          transcribed_at?: string | null
          transcricao?: string | null
          updated_at?: string | null
          uploaded_at?: string | null
          valor_fechamento?: number | null
        }
        Update: {
          analyzed_at?: string | null
          audio_duration_seconds?: number | null
          audio_path?: string | null
          call_date?: string
          classificacao?: string | null
          closer_id?: string | null
          completed_at?: string | null
          created_at?: string | null
          custo_estimado?: number | null
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
          drive_file_id?: string | null
          drive_report_url?: string | null
          drive_url?: string | null
          duration_minutes?: number | null
          engagement_level?: string | null
          error_message?: string | null
          fases_analise?: Json | null
          frases_proibidas?: Json | null
          id?: string
          lead_name?: string
          mapa_frameworks?: Json | null
          modelo_analise?: string | null
          modelo_transcricao?: string | null
          notified_at?: string | null
          objections_detected?: Json | null
          organization_id?: string | null
          plano_acao?: Json | null
          prompt_version?: string | null
          reescrita_falas?: Json | null
          relatorio_completo?: string | null
          report_hash?: string | null
          resultado?: string | null
          resumo_whatsapp?: string | null
          score_final?: number | null
          sentiment_overall?: string | null
          sentiment_score?: number | null
          sentiment_timeline?: Json | null
          status?: string
          storage_report_path?: string | null
          tokens_input?: number | null
          tokens_output?: number | null
          top_acertos?: Json | null
          top_erros?: Json | null
          transcribed_at?: string | null
          transcricao?: string | null
          updated_at?: string | null
          uploaded_at?: string | null
          valor_fechamento?: number | null
        }
        Relationships: [
          {
            foreignKeyName: "call_audits_closer_id_fkey"
            columns: ["closer_id"]
            isOneToOne: false
            referencedRelation: "closers"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "call_audits_closer_id_fkey"
            columns: ["closer_id"]
            isOneToOne: false
            referencedRelation: "mv_closer_performance"
            referencedColumns: ["closer_id"]
          },
          {
            foreignKeyName: "call_audits_closer_id_fkey"
            columns: ["closer_id"]
            isOneToOne: false
            referencedRelation: "v_closer_performance"
            referencedColumns: ["closer_id"]
          },
          {
            foreignKeyName: "call_audits_closer_id_fkey"
            columns: ["closer_id"]
            isOneToOne: false
            referencedRelation: "v_supervisor_closer_performance"
            referencedColumns: ["closer_id"]
          },
          {
            foreignKeyName: "call_audits_organization_id_fkey"
            columns: ["organization_id"]
            isOneToOne: false
            referencedRelation: "organizations"
            referencedColumns: ["id"]
          },
        ]
      }
      call_bookmarks: {
        Row: {
          audit_id: string
          bookmarked_by: string | null
          created_at: string | null
          highlight_timestamps: Json | null
          id: string
          notes: string | null
          organization_id: string | null
          tags: string[] | null
        }
        Insert: {
          audit_id: string
          bookmarked_by?: string | null
          created_at?: string | null
          highlight_timestamps?: Json | null
          id?: string
          notes?: string | null
          organization_id?: string | null
          tags?: string[] | null
        }
        Update: {
          audit_id?: string
          bookmarked_by?: string | null
          created_at?: string | null
          highlight_timestamps?: Json | null
          id?: string
          notes?: string | null
          organization_id?: string | null
          tags?: string[] | null
        }
        Relationships: [
          {
            foreignKeyName: "call_bookmarks_audit_id_fkey"
            columns: ["audit_id"]
            isOneToOne: false
            referencedRelation: "call_audits"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "call_bookmarks_bookmarked_by_fkey"
            columns: ["bookmarked_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "call_bookmarks_organization_id_fkey"
            columns: ["organization_id"]
            isOneToOne: false
            referencedRelation: "organizations"
            referencedColumns: ["id"]
          },
        ]
      }
      call_comments: {
        Row: {
          audit_id: string
          author_id: string
          content: string
          created_at: string | null
          id: string
          parent_id: string | null
          resolved: boolean | null
          resolved_at: string | null
          resolved_by: string | null
          timestamp_sec: number | null
          updated_at: string | null
        }
        Insert: {
          audit_id: string
          author_id: string
          content: string
          created_at?: string | null
          id?: string
          parent_id?: string | null
          resolved?: boolean | null
          resolved_at?: string | null
          resolved_by?: string | null
          timestamp_sec?: number | null
          updated_at?: string | null
        }
        Update: {
          audit_id?: string
          author_id?: string
          content?: string
          created_at?: string | null
          id?: string
          parent_id?: string | null
          resolved?: boolean | null
          resolved_at?: string | null
          resolved_by?: string | null
          timestamp_sec?: number | null
          updated_at?: string | null
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
          },
          {
            foreignKeyName: "call_comments_resolved_by_fkey"
            columns: ["resolved_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      closer_badges: {
        Row: {
          audit_id: string | null
          badge_id: string
          closer_id: string
          earned_at: string | null
          id: string
        }
        Insert: {
          audit_id?: string | null
          badge_id: string
          closer_id: string
          earned_at?: string | null
          id?: string
        }
        Update: {
          audit_id?: string | null
          badge_id?: string
          closer_id?: string
          earned_at?: string | null
          id?: string
        }
        Relationships: [
          {
            foreignKeyName: "closer_badges_audit_id_fkey"
            columns: ["audit_id"]
            isOneToOne: false
            referencedRelation: "call_audits"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "closer_badges_badge_id_fkey"
            columns: ["badge_id"]
            isOneToOne: false
            referencedRelation: "badges"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "closer_badges_closer_id_fkey"
            columns: ["closer_id"]
            isOneToOne: false
            referencedRelation: "closers"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "closer_badges_closer_id_fkey"
            columns: ["closer_id"]
            isOneToOne: false
            referencedRelation: "mv_closer_performance"
            referencedColumns: ["closer_id"]
          },
          {
            foreignKeyName: "closer_badges_closer_id_fkey"
            columns: ["closer_id"]
            isOneToOne: false
            referencedRelation: "v_closer_performance"
            referencedColumns: ["closer_id"]
          },
          {
            foreignKeyName: "closer_badges_closer_id_fkey"
            columns: ["closer_id"]
            isOneToOne: false
            referencedRelation: "v_supervisor_closer_performance"
            referencedColumns: ["closer_id"]
          },
        ]
      }
      closer_streaks: {
        Row: {
          best_count: number
          closer_id: string
          current_count: number
          id: string
          last_audit_id: string | null
          last_updated: string | null
          streak_type: string
        }
        Insert: {
          best_count?: number
          closer_id: string
          current_count?: number
          id?: string
          last_audit_id?: string | null
          last_updated?: string | null
          streak_type: string
        }
        Update: {
          best_count?: number
          closer_id?: string
          current_count?: number
          id?: string
          last_audit_id?: string | null
          last_updated?: string | null
          streak_type?: string
        }
        Relationships: [
          {
            foreignKeyName: "closer_streaks_closer_id_fkey"
            columns: ["closer_id"]
            isOneToOne: false
            referencedRelation: "closers"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "closer_streaks_closer_id_fkey"
            columns: ["closer_id"]
            isOneToOne: false
            referencedRelation: "mv_closer_performance"
            referencedColumns: ["closer_id"]
          },
          {
            foreignKeyName: "closer_streaks_closer_id_fkey"
            columns: ["closer_id"]
            isOneToOne: false
            referencedRelation: "v_closer_performance"
            referencedColumns: ["closer_id"]
          },
          {
            foreignKeyName: "closer_streaks_closer_id_fkey"
            columns: ["closer_id"]
            isOneToOne: false
            referencedRelation: "v_supervisor_closer_performance"
            referencedColumns: ["closer_id"]
          },
          {
            foreignKeyName: "closer_streaks_last_audit_id_fkey"
            columns: ["last_audit_id"]
            isOneToOne: false
            referencedRelation: "call_audits"
            referencedColumns: ["id"]
          },
        ]
      }
      closer_training_actions: {
        Row: {
          closer_id: string | null
          created_at: string | null
          id: string
          priority: string | null
          recommendation: string
          source_analysis_id: string | null
          stage_key: string | null
          status: string | null
          weakness_key: string
        }
        Insert: {
          closer_id?: string | null
          created_at?: string | null
          id?: string
          priority?: string | null
          recommendation: string
          source_analysis_id?: string | null
          stage_key?: string | null
          status?: string | null
          weakness_key: string
        }
        Update: {
          closer_id?: string | null
          created_at?: string | null
          id?: string
          priority?: string | null
          recommendation?: string
          source_analysis_id?: string | null
          stage_key?: string | null
          status?: string | null
          weakness_key?: string
        }
        Relationships: [
          {
            foreignKeyName: "closer_training_actions_closer_id_fkey"
            columns: ["closer_id"]
            isOneToOne: false
            referencedRelation: "closers"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "closer_training_actions_closer_id_fkey"
            columns: ["closer_id"]
            isOneToOne: false
            referencedRelation: "mv_closer_performance"
            referencedColumns: ["closer_id"]
          },
          {
            foreignKeyName: "closer_training_actions_closer_id_fkey"
            columns: ["closer_id"]
            isOneToOne: false
            referencedRelation: "v_closer_performance"
            referencedColumns: ["closer_id"]
          },
          {
            foreignKeyName: "closer_training_actions_closer_id_fkey"
            columns: ["closer_id"]
            isOneToOne: false
            referencedRelation: "v_supervisor_closer_performance"
            referencedColumns: ["closer_id"]
          },
          {
            foreignKeyName: "closer_training_actions_source_analysis_id_fkey"
            columns: ["source_analysis_id"]
            isOneToOne: false
            referencedRelation: "supervisor_analyses"
            referencedColumns: ["id"]
          },
        ]
      }
      closers: {
        Row: {
          active: boolean | null
          avatar_url: string | null
          created_at: string | null
          email: string | null
          id: string
          name: string
          notification_emails: string[] | null
          organization_id: string | null
          whatsapp: string | null
        }
        Insert: {
          active?: boolean | null
          avatar_url?: string | null
          created_at?: string | null
          email?: string | null
          id?: string
          name: string
          notification_emails?: string[] | null
          organization_id?: string | null
          whatsapp?: string | null
        }
        Update: {
          active?: boolean | null
          avatar_url?: string | null
          created_at?: string | null
          email?: string | null
          id?: string
          name?: string
          notification_emails?: string[] | null
          organization_id?: string | null
          whatsapp?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "closers_organization_id_fkey"
            columns: ["organization_id"]
            isOneToOne: false
            referencedRelation: "organizations"
            referencedColumns: ["id"]
          },
        ]
      }
      Company: {
        Row: {
          city: string | null
          cnpj: string
          consentimento: boolean
          createdAt: string
          createdById: string | null
          id: string
          nomeFantasia: string | null
          razaoSocial: string
          segment: string | null
          size: Database["public"]["Enums"]["CompanySize"] | null
          state: string | null
          updatedAt: string
          website: string | null
        }
        Insert: {
          city?: string | null
          cnpj: string
          consentimento?: boolean
          createdAt?: string
          createdById?: string | null
          id: string
          nomeFantasia?: string | null
          razaoSocial: string
          segment?: string | null
          size?: Database["public"]["Enums"]["CompanySize"] | null
          state?: string | null
          updatedAt: string
          website?: string | null
        }
        Update: {
          city?: string | null
          cnpj?: string
          consentimento?: boolean
          createdAt?: string
          createdById?: string | null
          id?: string
          nomeFantasia?: string | null
          razaoSocial?: string
          segment?: string | null
          size?: Database["public"]["Enums"]["CompanySize"] | null
          state?: string | null
          updatedAt?: string
          website?: string | null
        }
        Relationships: []
      }
      competitions: {
        Row: {
          created_at: string | null
          description: string | null
          end_date: string
          id: string
          metric: string
          metric_params: Json | null
          organization_id: string | null
          start_date: string
          status: string
          title: string
        }
        Insert: {
          created_at?: string | null
          description?: string | null
          end_date: string
          id?: string
          metric: string
          metric_params?: Json | null
          organization_id?: string | null
          start_date: string
          status?: string
          title: string
        }
        Update: {
          created_at?: string | null
          description?: string | null
          end_date?: string
          id?: string
          metric?: string
          metric_params?: Json | null
          organization_id?: string | null
          start_date?: string
          status?: string
          title?: string
        }
        Relationships: [
          {
            foreignKeyName: "competitions_organization_id_fkey"
            columns: ["organization_id"]
            isOneToOne: false
            referencedRelation: "organizations"
            referencedColumns: ["id"]
          },
        ]
      }
      Contact: {
        Row: {
          companyId: string
          consentimento: boolean
          createdAt: string
          email: string | null
          id: string
          isPrimary: boolean
          name: string
          phone: string | null
          position: string | null
          updatedAt: string
          whatsapp: string | null
        }
        Insert: {
          companyId: string
          consentimento?: boolean
          createdAt?: string
          email?: string | null
          id: string
          isPrimary?: boolean
          name: string
          phone?: string | null
          position?: string | null
          updatedAt: string
          whatsapp?: string | null
        }
        Update: {
          companyId?: string
          consentimento?: boolean
          createdAt?: string
          email?: string | null
          id?: string
          isPrimary?: boolean
          name?: string
          phone?: string | null
          position?: string | null
          updatedAt?: string
          whatsapp?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "Contact_companyId_fkey"
            columns: ["companyId"]
            isOneToOne: false
            referencedRelation: "Company"
            referencedColumns: ["id"]
          },
        ]
      }
      drive_sync: {
        Row: {
          audit_id: string | null
          drive_file_id: string
          drive_folder_id: string | null
          file_name: string
          id: string
          origin: string
          synced_at: string | null
        }
        Insert: {
          audit_id?: string | null
          drive_file_id: string
          drive_folder_id?: string | null
          file_name: string
          id?: string
          origin: string
          synced_at?: string | null
        }
        Update: {
          audit_id?: string | null
          drive_file_id?: string
          drive_folder_id?: string | null
          file_name?: string
          id?: string
          origin?: string
          synced_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "drive_sync_audit_id_fkey"
            columns: ["audit_id"]
            isOneToOne: false
            referencedRelation: "call_audits"
            referencedColumns: ["id"]
          },
        ]
      }
      goals: {
        Row: {
          closer_id: string | null
          created_at: string | null
          dimension_id: string | null
          end_date: string
          id: string
          metric: string
          organization_id: string | null
          start_date: string
          status: string
          target_value: number
          title: string
          type: string
          updated_at: string | null
        }
        Insert: {
          closer_id?: string | null
          created_at?: string | null
          dimension_id?: string | null
          end_date: string
          id?: string
          metric: string
          organization_id?: string | null
          start_date: string
          status?: string
          target_value: number
          title: string
          type: string
          updated_at?: string | null
        }
        Update: {
          closer_id?: string | null
          created_at?: string | null
          dimension_id?: string | null
          end_date?: string
          id?: string
          metric?: string
          organization_id?: string | null
          start_date?: string
          status?: string
          target_value?: number
          title?: string
          type?: string
          updated_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "goals_closer_id_fkey"
            columns: ["closer_id"]
            isOneToOne: false
            referencedRelation: "closers"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "goals_closer_id_fkey"
            columns: ["closer_id"]
            isOneToOne: false
            referencedRelation: "mv_closer_performance"
            referencedColumns: ["closer_id"]
          },
          {
            foreignKeyName: "goals_closer_id_fkey"
            columns: ["closer_id"]
            isOneToOne: false
            referencedRelation: "v_closer_performance"
            referencedColumns: ["closer_id"]
          },
          {
            foreignKeyName: "goals_closer_id_fkey"
            columns: ["closer_id"]
            isOneToOne: false
            referencedRelation: "v_supervisor_closer_performance"
            referencedColumns: ["closer_id"]
          },
          {
            foreignKeyName: "goals_organization_id_fkey"
            columns: ["organization_id"]
            isOneToOne: false
            referencedRelation: "organizations"
            referencedColumns: ["id"]
          },
        ]
      }
      Interaction: {
        Row: {
          authorId: string
          createdAt: string
          durationMinutes: number | null
          id: string
          leadId: string
          nextStep: string | null
          nextStepDate: string | null
          notes: string | null
          occurredAt: string
          result: Database["public"]["Enums"]["InteractionResult"] | null
          type: Database["public"]["Enums"]["InteractionType"]
        }
        Insert: {
          authorId: string
          createdAt?: string
          durationMinutes?: number | null
          id: string
          leadId: string
          nextStep?: string | null
          nextStepDate?: string | null
          notes?: string | null
          occurredAt?: string
          result?: Database["public"]["Enums"]["InteractionResult"] | null
          type: Database["public"]["Enums"]["InteractionType"]
        }
        Update: {
          authorId?: string
          createdAt?: string
          durationMinutes?: number | null
          id?: string
          leadId?: string
          nextStep?: string | null
          nextStepDate?: string | null
          notes?: string | null
          occurredAt?: string
          result?: Database["public"]["Enums"]["InteractionResult"] | null
          type?: Database["public"]["Enums"]["InteractionType"]
        }
        Relationships: [
          {
            foreignKeyName: "Interaction_authorId_fkey"
            columns: ["authorId"]
            isOneToOne: false
            referencedRelation: "User"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "Interaction_leadId_fkey"
            columns: ["leadId"]
            isOneToOne: false
            referencedRelation: "Lead"
            referencedColumns: ["id"]
          },
        ]
      }
      job_queue: {
        Row: {
          attempts: number | null
          audit_id: string | null
          completed_at: string | null
          created_at: string | null
          error_message: string | null
          id: string
          job_type: string
          max_attempts: number | null
          started_at: string | null
          status: string
        }
        Insert: {
          attempts?: number | null
          audit_id?: string | null
          completed_at?: string | null
          created_at?: string | null
          error_message?: string | null
          id?: string
          job_type: string
          max_attempts?: number | null
          started_at?: string | null
          status?: string
        }
        Update: {
          attempts?: number | null
          audit_id?: string | null
          completed_at?: string | null
          created_at?: string | null
          error_message?: string | null
          id?: string
          job_type?: string
          max_attempts?: number | null
          started_at?: string | null
          status?: string
        }
        Relationships: [
          {
            foreignKeyName: "job_queue_audit_id_fkey"
            columns: ["audit_id"]
            isOneToOne: false
            referencedRelation: "call_audits"
            referencedColumns: ["id"]
          },
        ]
      }
      Lead: {
        Row: {
          assignedAt: string | null
          closedAt: string | null
          closeReason: Database["public"]["Enums"]["CloseReason"] | null
          closeReasonDetail: string | null
          companyId: string
          contactId: string | null
          createdAt: string
          firstContactAt: string | null
          id: string
          imageUrl: string | null
          isProspeccao: boolean
          leadScore: number
          necessity: string | null
          notes: string | null
          qualifiedAt: string | null
          registradorId: string
          responsavelId: string | null
          source: string | null
          status: Database["public"]["Enums"]["LeadStatus"]
          updatedAt: string
          urgency: Database["public"]["Enums"]["Urgency"] | null
        }
        Insert: {
          assignedAt?: string | null
          closedAt?: string | null
          closeReason?: Database["public"]["Enums"]["CloseReason"] | null
          closeReasonDetail?: string | null
          companyId: string
          contactId?: string | null
          createdAt?: string
          firstContactAt?: string | null
          id: string
          imageUrl?: string | null
          isProspeccao?: boolean
          leadScore?: number
          necessity?: string | null
          notes?: string | null
          qualifiedAt?: string | null
          registradorId: string
          responsavelId?: string | null
          source?: string | null
          status?: Database["public"]["Enums"]["LeadStatus"]
          updatedAt: string
          urgency?: Database["public"]["Enums"]["Urgency"] | null
        }
        Update: {
          assignedAt?: string | null
          closedAt?: string | null
          closeReason?: Database["public"]["Enums"]["CloseReason"] | null
          closeReasonDetail?: string | null
          companyId?: string
          contactId?: string | null
          createdAt?: string
          firstContactAt?: string | null
          id?: string
          imageUrl?: string | null
          isProspeccao?: boolean
          leadScore?: number
          necessity?: string | null
          notes?: string | null
          qualifiedAt?: string | null
          registradorId?: string
          responsavelId?: string | null
          source?: string | null
          status?: Database["public"]["Enums"]["LeadStatus"]
          updatedAt?: string
          urgency?: Database["public"]["Enums"]["Urgency"] | null
        }
        Relationships: [
          {
            foreignKeyName: "Lead_companyId_fkey"
            columns: ["companyId"]
            isOneToOne: false
            referencedRelation: "Company"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "Lead_contactId_fkey"
            columns: ["contactId"]
            isOneToOne: false
            referencedRelation: "Contact"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "Lead_registradorId_fkey"
            columns: ["registradorId"]
            isOneToOne: false
            referencedRelation: "User"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "Lead_responsavelId_fkey"
            columns: ["responsavelId"]
            isOneToOne: false
            referencedRelation: "User"
            referencedColumns: ["id"]
          },
        ]
      }
      loss_patterns: {
        Row: {
          common_objections: Json | null
          created_at: string | null
          generated_at: string | null
          id: string
          organization_id: string | null
          patterns: Json
          period_end: string
          period_start: string
          report_markdown: string | null
          total_lost_calls: number
          weakest_phases: Json | null
        }
        Insert: {
          common_objections?: Json | null
          created_at?: string | null
          generated_at?: string | null
          id?: string
          organization_id?: string | null
          patterns?: Json
          period_end: string
          period_start: string
          report_markdown?: string | null
          total_lost_calls: number
          weakest_phases?: Json | null
        }
        Update: {
          common_objections?: Json | null
          created_at?: string | null
          generated_at?: string | null
          id?: string
          organization_id?: string | null
          patterns?: Json
          period_end?: string
          period_start?: string
          report_markdown?: string | null
          total_lost_calls?: number
          weakest_phases?: Json | null
        }
        Relationships: [
          {
            foreignKeyName: "loss_patterns_organization_id_fkey"
            columns: ["organization_id"]
            isOneToOne: false
            referencedRelation: "organizations"
            referencedColumns: ["id"]
          },
        ]
      }
      negotiation_rules: {
        Row: {
          allowed_bonuses: Json | null
          concession_order: Json | null
          downsell_products: Json | null
          id: string
          max_discount_pct: number | null
          max_installments: number | null
          organization_id: string | null
          updated_at: string | null
          version: string | null
          what_is_good_downsell: string | null
          what_is_good_negotiation: string | null
        }
        Insert: {
          allowed_bonuses?: Json | null
          concession_order?: Json | null
          downsell_products?: Json | null
          id?: string
          max_discount_pct?: number | null
          max_installments?: number | null
          organization_id?: string | null
          updated_at?: string | null
          version?: string | null
          what_is_good_downsell?: string | null
          what_is_good_negotiation?: string | null
        }
        Update: {
          allowed_bonuses?: Json | null
          concession_order?: Json | null
          downsell_products?: Json | null
          id?: string
          max_discount_pct?: number | null
          max_installments?: number | null
          organization_id?: string | null
          updated_at?: string | null
          version?: string | null
          what_is_good_downsell?: string | null
          what_is_good_negotiation?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "negotiation_rules_organization_id_fkey"
            columns: ["organization_id"]
            isOneToOne: false
            referencedRelation: "organizations"
            referencedColumns: ["id"]
          },
        ]
      }
      notifications: {
        Row: {
          audit_id: string | null
          channel: string
          content: string | null
          id: string
          recipient: string
          sent_at: string | null
          status: string | null
        }
        Insert: {
          audit_id?: string | null
          channel: string
          content?: string | null
          id?: string
          recipient: string
          sent_at?: string | null
          status?: string | null
        }
        Update: {
          audit_id?: string | null
          channel?: string
          content?: string | null
          id?: string
          recipient?: string
          sent_at?: string | null
          status?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "notifications_audit_id_fkey"
            columns: ["audit_id"]
            isOneToOne: false
            referencedRelation: "call_audits"
            referencedColumns: ["id"]
          },
        ]
      }
      organizations: {
        Row: {
          created_at: string | null
          id: string
          name: string
          slug: string
        }
        Insert: {
          created_at?: string | null
          id?: string
          name: string
          slug: string
        }
        Update: {
          created_at?: string | null
          id?: string
          name?: string
          slug?: string
        }
        Relationships: []
      }
      Product: {
        Row: {
          active: boolean
          createdAt: string
          description: string | null
          id: string
          name: string
          updatedAt: string
        }
        Insert: {
          active?: boolean
          createdAt?: string
          description?: string | null
          id: string
          name: string
          updatedAt: string
        }
        Update: {
          active?: boolean
          createdAt?: string
          description?: string | null
          id?: string
          name?: string
          updatedAt?: string
        }
        Relationships: []
      }
      profiles: {
        Row: {
          avatar_url: string | null
          created_at: string | null
          full_name: string
          id: string
          organization_id: string | null
          role: string
        }
        Insert: {
          avatar_url?: string | null
          created_at?: string | null
          full_name: string
          id: string
          organization_id?: string | null
          role?: string
        }
        Update: {
          avatar_url?: string | null
          created_at?: string | null
          full_name?: string
          id?: string
          organization_id?: string | null
          role?: string
        }
        Relationships: [
          {
            foreignKeyName: "profiles_organization_id_fkey"
            columns: ["organization_id"]
            isOneToOne: false
            referencedRelation: "organizations"
            referencedColumns: ["id"]
          },
        ]
      }
      protocol_rules: {
        Row: {
          description: string | null
          expected_behaviors: Json | null
          failure_behaviors: Json | null
          id: string
          is_active: boolean | null
          organization_id: string | null
          scoring_weight: number
          stage_key: string
          stage_name: string
          stage_order: number
          updated_at: string | null
          version: string
        }
        Insert: {
          description?: string | null
          expected_behaviors?: Json | null
          failure_behaviors?: Json | null
          id?: string
          is_active?: boolean | null
          organization_id?: string | null
          scoring_weight: number
          stage_key: string
          stage_name: string
          stage_order: number
          updated_at?: string | null
          version?: string
        }
        Update: {
          description?: string | null
          expected_behaviors?: Json | null
          failure_behaviors?: Json | null
          id?: string
          is_active?: boolean | null
          organization_id?: string | null
          scoring_weight?: number
          stage_key?: string
          stage_name?: string
          stage_order?: number
          updated_at?: string | null
          version?: string
        }
        Relationships: [
          {
            foreignKeyName: "protocol_rules_organization_id_fkey"
            columns: ["organization_id"]
            isOneToOne: false
            referencedRelation: "organizations"
            referencedColumns: ["id"]
          },
        ]
      }
      StatusHistory: {
        Row: {
          changedAt: string
          changedById: string
          id: string
          leadId: string
          newStatus: Database["public"]["Enums"]["LeadStatus"]
          previousStatus: Database["public"]["Enums"]["LeadStatus"] | null
          reason: string | null
        }
        Insert: {
          changedAt?: string
          changedById: string
          id: string
          leadId: string
          newStatus: Database["public"]["Enums"]["LeadStatus"]
          previousStatus?: Database["public"]["Enums"]["LeadStatus"] | null
          reason?: string | null
        }
        Update: {
          changedAt?: string
          changedById?: string
          id?: string
          leadId?: string
          newStatus?: Database["public"]["Enums"]["LeadStatus"]
          previousStatus?: Database["public"]["Enums"]["LeadStatus"] | null
          reason?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "StatusHistory_changedById_fkey"
            columns: ["changedById"]
            isOneToOne: false
            referencedRelation: "User"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "StatusHistory_leadId_fkey"
            columns: ["leadId"]
            isOneToOne: false
            referencedRelation: "Lead"
            referencedColumns: ["id"]
          },
        ]
      }
      supervisor_analyses: {
        Row: {
          audit_id: string | null
          cac_explained: boolean | null
          classification: string | null
          created_at: string | null
          custo_estimado: number | null
          downsell_narrative_quality: number | null
          downsell_used: boolean | null
          executive_summary: string | null
          id: string
          modelo_analise: string | null
          negotiation_firmness: number | null
          objections_detected: Json | null
          organization_id: string | null
          overall_label: string | null
          overall_score: number | null
          priority_improvements: Json | null
          prompt_version: string
          protagonist_transition_quality: number | null
          protocol_version: string
          raw_json: Json | null
          silence_applied: boolean | null
          table_price_presented: boolean | null
          tokens_input: number | null
          tokens_output: number | null
          training_actions: Json | null
          updated_at: string | null
          who_spoke_first: string | null
        }
        Insert: {
          audit_id?: string | null
          cac_explained?: boolean | null
          classification?: string | null
          created_at?: string | null
          custo_estimado?: number | null
          downsell_narrative_quality?: number | null
          downsell_used?: boolean | null
          executive_summary?: string | null
          id?: string
          modelo_analise?: string | null
          negotiation_firmness?: number | null
          objections_detected?: Json | null
          organization_id?: string | null
          overall_label?: string | null
          overall_score?: number | null
          priority_improvements?: Json | null
          prompt_version?: string
          protagonist_transition_quality?: number | null
          protocol_version?: string
          raw_json?: Json | null
          silence_applied?: boolean | null
          table_price_presented?: boolean | null
          tokens_input?: number | null
          tokens_output?: number | null
          training_actions?: Json | null
          updated_at?: string | null
          who_spoke_first?: string | null
        }
        Update: {
          audit_id?: string | null
          cac_explained?: boolean | null
          classification?: string | null
          created_at?: string | null
          custo_estimado?: number | null
          downsell_narrative_quality?: number | null
          downsell_used?: boolean | null
          executive_summary?: string | null
          id?: string
          modelo_analise?: string | null
          negotiation_firmness?: number | null
          objections_detected?: Json | null
          organization_id?: string | null
          overall_label?: string | null
          overall_score?: number | null
          priority_improvements?: Json | null
          prompt_version?: string
          protagonist_transition_quality?: number | null
          protocol_version?: string
          raw_json?: Json | null
          silence_applied?: boolean | null
          table_price_presented?: boolean | null
          tokens_input?: number | null
          tokens_output?: number | null
          training_actions?: Json | null
          updated_at?: string | null
          who_spoke_first?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "supervisor_analyses_audit_id_fkey"
            columns: ["audit_id"]
            isOneToOne: false
            referencedRelation: "call_audits"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "supervisor_analyses_organization_id_fkey"
            columns: ["organization_id"]
            isOneToOne: false
            referencedRelation: "organizations"
            referencedColumns: ["id"]
          },
        ]
      }
      supervisor_stage_scores: {
        Row: {
          analysis_id: string | null
          created_at: string | null
          evidence_excerpt: string | null
          id: string
          justification: string | null
          max_score: number | null
          missed_actions: Json | null
          score: number
          stage_key: string
          stage_name: string
          stage_order: number
          status: string | null
          suggested_fix: Json | null
          weight: number | null
        }
        Insert: {
          analysis_id?: string | null
          created_at?: string | null
          evidence_excerpt?: string | null
          id?: string
          justification?: string | null
          max_score?: number | null
          missed_actions?: Json | null
          score: number
          stage_key: string
          stage_name: string
          stage_order: number
          status?: string | null
          suggested_fix?: Json | null
          weight?: number | null
        }
        Update: {
          analysis_id?: string | null
          created_at?: string | null
          evidence_excerpt?: string | null
          id?: string
          justification?: string | null
          max_score?: number | null
          missed_actions?: Json | null
          score?: number
          stage_key?: string
          stage_name?: string
          stage_order?: number
          status?: string | null
          suggested_fix?: Json | null
          weight?: number | null
        }
        Relationships: [
          {
            foreignKeyName: "supervisor_stage_scores_analysis_id_fkey"
            columns: ["analysis_id"]
            isOneToOne: false
            referencedRelation: "supervisor_analyses"
            referencedColumns: ["id"]
          },
        ]
      }
      User: {
        Row: {
          active: boolean
          createdAt: string
          email: string
          id: string
          lastLoginAt: string | null
          name: string
          passwordHash: string
          role: Database["public"]["Enums"]["UserRole"]
          updatedAt: string
        }
        Insert: {
          active?: boolean
          createdAt?: string
          email: string
          id: string
          lastLoginAt?: string | null
          name: string
          passwordHash: string
          role?: Database["public"]["Enums"]["UserRole"]
          updatedAt: string
        }
        Update: {
          active?: boolean
          createdAt?: string
          email?: string
          id?: string
          lastLoginAt?: string | null
          name?: string
          passwordHash?: string
          role?: Database["public"]["Enums"]["UserRole"]
          updatedAt?: string
        }
        Relationships: []
      }
      weekly_reports: {
        Row: {
          created_at: string | null
          generated_at: string | null
          id: string
          organization_id: string | null
          report_markdown: string
          sent_at: string | null
          sent_email: boolean | null
          sent_whatsapp: boolean | null
          stats: Json
          week_end: string
          week_start: string
        }
        Insert: {
          created_at?: string | null
          generated_at?: string | null
          id?: string
          organization_id?: string | null
          report_markdown: string
          sent_at?: string | null
          sent_email?: boolean | null
          sent_whatsapp?: boolean | null
          stats?: Json
          week_end: string
          week_start: string
        }
        Update: {
          created_at?: string | null
          generated_at?: string | null
          id?: string
          organization_id?: string | null
          report_markdown?: string
          sent_at?: string | null
          sent_email?: boolean | null
          sent_whatsapp?: boolean | null
          stats?: Json
          week_end?: string
          week_start?: string
        }
        Relationships: [
          {
            foreignKeyName: "weekly_reports_organization_id_fkey"
            columns: ["organization_id"]
            isOneToOne: false
            referencedRelation: "organizations"
            referencedColumns: ["id"]
          },
        ]
      }
    }
    Views: {
      mv_closer_performance: {
        Row: {
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
          closer_id: string | null
          closer_name: string | null
          fechamentos: number | null
          media_score: number | null
          melhor_score: number | null
          organization_id: string | null
          pior_score: number | null
          total_calls: number | null
        }
        Relationships: [
          {
            foreignKeyName: "closers_organization_id_fkey"
            columns: ["organization_id"]
            isOneToOne: false
            referencedRelation: "organizations"
            referencedColumns: ["id"]
          },
        ]
      }
      mv_dashboard_stats: {
        Row: {
          calls_completas: number | null
          calls_elite: number | null
          calls_em_processamento: number | null
          calls_forte: number | null
          calls_fraca: number | null
          calls_mediana: number | null
          media_score: number | null
          organization_id: string | null
          taxa_fechamento_pct: number | null
          total_calls: number | null
          total_fechamentos: number | null
        }
        Relationships: [
          {
            foreignKeyName: "call_audits_organization_id_fkey"
            columns: ["organization_id"]
            isOneToOne: false
            referencedRelation: "organizations"
            referencedColumns: ["id"]
          },
        ]
      }
      v_closer_performance: {
        Row: {
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
          closer_id: string | null
          closer_name: string | null
          fechamentos: number | null
          media_score: number | null
          melhor_score: number | null
          organization_id: string | null
          pior_score: number | null
          total_calls: number | null
        }
        Relationships: [
          {
            foreignKeyName: "closers_organization_id_fkey"
            columns: ["organization_id"]
            isOneToOne: false
            referencedRelation: "organizations"
            referencedColumns: ["id"]
          },
        ]
      }
      v_dashboard_stats: {
        Row: {
          calls_completas: number | null
          calls_elite: number | null
          calls_em_processamento: number | null
          calls_forte: number | null
          calls_fraca: number | null
          calls_mediana: number | null
          media_score: number | null
          organization_id: string | null
          taxa_fechamento_pct: number | null
          total_calls: number | null
          total_fechamentos: number | null
        }
        Relationships: [
          {
            foreignKeyName: "call_audits_organization_id_fkey"
            columns: ["organization_id"]
            isOneToOne: false
            referencedRelation: "organizations"
            referencedColumns: ["id"]
          },
        ]
      }
      v_supervisor_closer_performance: {
        Row: {
          avg_negotiation_firmness: number | null
          avg_score: number | null
          boa_count: number | null
          closer_id: string | null
          closer_name: string | null
          downsell_count: number | null
          excelente_count: number | null
          fraca_count: number | null
          organization_id: string | null
          regular_count: number | null
          total_analyses: number | null
        }
        Relationships: [
          {
            foreignKeyName: "closers_organization_id_fkey"
            columns: ["organization_id"]
            isOneToOne: false
            referencedRelation: "organizations"
            referencedColumns: ["id"]
          },
        ]
      }
      v_supervisor_weakest_stages: {
        Row: {
          avg_score: number | null
          avg_when_critical: number | null
          critical_count: number | null
          stage_key: string | null
          stage_name: string | null
          total_evaluations: number | null
        }
        Relationships: []
      }
    }
    Functions: {
      enqueue_job: {
        Args: { p_audit_id: string; p_job_type: string }
        Returns: string
      }
      get_org_id: { Args: never; Returns: string }
      refresh_dashboard_views: { Args: never; Returns: undefined }
      refresh_dashboard_views_debounced: { Args: never; Returns: undefined }
    }
    Enums: {
      CloseReason:
        | "VENDA_REALIZADA"
        | "SEM_INTERESSE"
        | "SEM_FIT"
        | "SEM_CONTATO"
        | "JA_CLIENTE"
        | "CONCORRENTE"
        | "TIMING"
        | "DUPLICADA"
        | "SEM_CONSENTIMENTO"
        | "DADOS_INCORRETOS"
        | "NAO_ATENDE_TELEFONE"
        | "OUTRO"
      CompanySize: "MICRO" | "PEQUENA" | "MEDIA" | "GRANDE"
      InteractionResult:
        | "SEM_RESPOSTA"
        | "CAIXA_POSTAL"
        | "OCUPADO"
        | "CONTATO_REALIZADO"
        | "CONTATO_SUCESSO"
      InteractionType: "LIGACAO" | "WHATSAPP" | "EMAIL" | "REUNIAO" | "NOTA"
      LeadStatus:
        | "PENDENTE"
        | "ATRIBUIDA"
        | "EM_CONTATO"
        | "QUALIFICADA"
        | "ENCERRADA"
        | "INATIVO"
      Urgency: "BAIXA" | "MEDIA" | "ALTA" | "IMEDIATA"
      UserRole: "ADMIN" | "GERENTE" | "ALIADO"
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DatabaseWithoutInternals = Omit<Database, "__InternalSupabase">

type DefaultSchema = DatabaseWithoutInternals[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof DatabaseWithoutInternals },
  EnumName extends DefaultSchemaEnumNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = DefaultSchemaEnumNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof DatabaseWithoutInternals },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never,
> = PublicCompositeTypeNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  public: {
    Enums: {
      CloseReason: [
        "VENDA_REALIZADA",
        "SEM_INTERESSE",
        "SEM_FIT",
        "SEM_CONTATO",
        "JA_CLIENTE",
        "CONCORRENTE",
        "TIMING",
        "DUPLICADA",
        "SEM_CONSENTIMENTO",
        "DADOS_INCORRETOS",
        "NAO_ATENDE_TELEFONE",
        "OUTRO",
      ],
      CompanySize: ["MICRO", "PEQUENA", "MEDIA", "GRANDE"],
      InteractionResult: [
        "SEM_RESPOSTA",
        "CAIXA_POSTAL",
        "OCUPADO",
        "CONTATO_REALIZADO",
        "CONTATO_SUCESSO",
      ],
      InteractionType: ["LIGACAO", "WHATSAPP", "EMAIL", "REUNIAO", "NOTA"],
      LeadStatus: [
        "PENDENTE",
        "ATRIBUIDA",
        "EM_CONTATO",
        "QUALIFICADA",
        "ENCERRADA",
        "INATIVO",
      ],
      Urgency: ["BAIXA", "MEDIA", "ALTA", "IMEDIATA"],
      UserRole: ["ADMIN", "GERENTE", "ALIADO"],
    },
  },
} as const

