import { render, screen, waitFor } from "@testing-library/react"
import { vi } from "vitest"
import { mockComment } from "../fixtures/audit"
import type { CallComment } from "@/lib/types/audit"

// Mock server actions
const mockGetComments = vi.fn()
const mockResolveComment = vi.fn()
const mockUnresolveComment = vi.fn()
const mockDeleteComment = vi.fn()
const mockCreateComment = vi.fn()

vi.mock("@/lib/actions/comments", () => ({
  getComments: (...args: unknown[]) => mockGetComments(...args),
  resolveComment: (...args: unknown[]) => mockResolveComment(...args),
  unresolveComment: (...args: unknown[]) => mockUnresolveComment(...args),
  deleteComment: (...args: unknown[]) => mockDeleteComment(...args),
  createComment: (...args: unknown[]) => mockCreateComment(...args),
}))

// Mock Supabase client for realtime
vi.mock("@/lib/supabase/client", () => ({
  createClient: () => ({
    channel: () => ({
      on: vi.fn().mockReturnThis(),
      subscribe: vi.fn().mockReturnThis(),
    }),
    removeChannel: vi.fn(),
  }),
}))

import { CommentsPanel } from "@/components/calls/comments-panel"

describe("CommentsPanel", () => {
  beforeEach(() => {
    mockGetComments.mockReset()
    mockResolveComment.mockReset()
    mockDeleteComment.mockReset()
    mockCreateComment.mockReset()
  })

  it("shows loading state initially", () => {
    mockGetComments.mockReturnValue(new Promise(() => {}))

    render(<CommentsPanel auditId="audit-001" />)

    expect(screen.getByText(/Carregando/)).toBeInTheDocument()
  })

  it("shows empty state when no comments", async () => {
    mockGetComments.mockResolvedValue([])

    render(<CommentsPanel auditId="audit-001" />)

    await waitFor(() => {
      expect(screen.getByText(/Nenhum coment/)).toBeInTheDocument()
    })
  })

  it("renders comment list", async () => {
    mockGetComments.mockResolvedValue([mockComment])

    render(<CommentsPanel auditId="audit-001" />)

    await waitFor(() => {
      expect(screen.getByText("Ótima ancoragem neste momento")).toBeInTheDocument()
      expect(screen.getByText("Carlos Supervisor")).toBeInTheDocument()
    })
  })

  it("shows author role badge", async () => {
    mockGetComments.mockResolvedValue([mockComment])

    render(<CommentsPanel auditId="audit-001" />)

    await waitFor(() => {
      expect(screen.getByText("supervisor")).toBeInTheDocument()
    })
  })

  it("shows timestamp link for comments with timestamp", async () => {
    mockGetComments.mockResolvedValue([mockComment])

    render(<CommentsPanel auditId="audit-001" />)

    await waitFor(() => {
      // timestamp_sec = 120 → "2:00"
      expect(screen.getByText("2:00")).toBeInTheDocument()
    })
  })

  it("renders nested replies", async () => {
    mockGetComments.mockResolvedValue([mockComment])

    render(<CommentsPanel auditId="audit-001" />)

    await waitFor(() => {
      expect(
        screen.getByText("Concordo, pode ser usada como exemplo")
      ).toBeInTheDocument()
      expect(screen.getByText("Ana Manager")).toBeInTheDocument()
    })
  })

  it("shows resolve and delete buttons", async () => {
    mockGetComments.mockResolvedValue([mockComment])

    render(<CommentsPanel auditId="audit-001" />)

    await waitFor(() => {
      const resolveBtn = screen.getByTitle("Resolver")
      expect(resolveBtn).toBeInTheDocument()
      const deleteBtn = screen.getByTitle("Excluir")
      expect(deleteBtn).toBeInTheDocument()
    })
  })

  it("shows 'Resolvido' badge for resolved comments", async () => {
    const resolvedComment: CallComment = {
      ...mockComment,
      resolved: true,
      resolved_by: "user-001",
      resolved_at: "2026-03-15T13:00:00Z",
    }
    mockGetComments.mockResolvedValue([resolvedComment])

    render(<CommentsPanel auditId="audit-001" />)

    await waitFor(() => {
      expect(screen.getByText("Resolvido")).toBeInTheDocument()
    })
  })
})
