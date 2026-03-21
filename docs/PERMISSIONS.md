# Matriz de Permissões por Role — CallAudit

## Roles

| Role | Descrição |
|---|---|
| **admin** | Administrador da organização. Acesso total. |
| **supervisor** | Supervisiona closers. Acesso a análises, configurações e gestão. |
| **closer** | Vendedor. Faz upload de calls, visualiza próprias auditorias. |
| **viewer** | Somente leitura. Visualiza dashboards e relatórios. |

## Matriz de Permissões

### Dashboard e Visualização

| Ação | admin | supervisor | closer | viewer |
|---|---|---|---|---|
| Ver dashboard | OK | OK | OK | OK |
| Ver lista de calls | OK | OK | OK | OK |
| Ver detalhe de auditoria | OK | OK | OK | OK |
| Ver analytics | OK | OK | OK | OK |
| Ver leaderboard | OK | OK | OK | OK |
| Ver badges | OK | OK | OK | OK |
| Ver relatórios semanais | OK | OK | OK | OK |
| Ver padrões de perda | OK | OK | OK | OK |

### Upload e Processamento

| Ação | admin | supervisor | closer | viewer |
|---|---|---|---|---|
| Upload de call | OK | OK | OK | — |
| Reenviar notificação | OK | OK | — | — |

### Closers (CRUD)

| Ação | admin | supervisor | closer | viewer |
|---|---|---|---|---|
| Criar closer | OK | OK | — | — |
| Editar closer | OK | OK | — | — |
| Ativar/desativar closer | OK | OK | — | — |

### Comentários

| Ação | admin | supervisor | closer | viewer |
|---|---|---|---|---|
| Criar comentário | OK | OK | OK | OK |
| Deletar próprio comentário | OK | OK | OK | OK |
| Deletar comentário de outro | OK | OK | — | — |
| Resolver comentário | OK | OK | — | — |
| Desresolver comentário | OK | OK | — | — |

### Bookmarks

| Ação | admin | supervisor | closer | viewer |
|---|---|---|---|---|
| Criar bookmark | OK | OK | OK | OK |
| Remover próprio bookmark | OK | OK | OK | OK |
| Remover bookmark de outro | OK | OK | — | — |

### Configurações

| Ação | admin | supervisor | closer | viewer |
|---|---|---|---|---|
| Ver configurações | OK | OK | — | — |
| Editar notificações | OK | OK | — | — |
| Ver status das APIs | OK | OK | — | — |

### Gamificação

| Ação | admin | supervisor | closer | viewer |
|---|---|---|---|---|
| Criar competição | OK | OK | — | — |
| Ver competições | OK | OK | OK | OK |

### Goals (Metas)

| Ação | admin | supervisor | closer | viewer |
|---|---|---|---|---|
| Criar meta | OK | OK | — | — |
| Atualizar status da meta | OK | OK | — | — |
| Deletar meta | OK | OK | — | — |
| Ver metas | OK | OK | OK | OK |

### Relatórios

| Ação | admin | supervisor | closer | viewer |
|---|---|---|---|---|
| Gerar análise de padrões de perda | OK | OK | — | — |
| Exportar PDF | OK | OK | OK | OK |

## Implementação

As permissões são enforçadas em duas camadas:

1. **Server Actions** — `requireRole()` em `lib/auth/require-role.ts`
2. **RLS (Row Level Security)** — Policies no Supabase por `organization_id`

### Funções de Autorização

```typescript
// Requer role específico
const ctx = await requireRole(["admin", "supervisor"])

// Requer apenas autenticação (qualquer role)
const ctx = await requireAuth()
```

### Ownership Check

Para operações de delete em recursos do próprio usuário:
- Verifica se `author_id === user.id` (comentários)
- Verifica se `bookmarked_by === user.id` (bookmarks)
- Se não é o autor, requer role `admin` ou `supervisor`
