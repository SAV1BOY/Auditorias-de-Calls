import { render, screen } from "@testing-library/react"
import { vi } from "vitest"
import { mockAudit } from "../fixtures/audit"
import type { CallAuditWithCloser } from "@/lib/types/audit"

// We need to test the ScorecardContent which is not directly exported.
// We'll test it through the AuditTabs component.

// Mock CommentsPanel to avoid complex dependencies
vi.mock("@/components/calls/comments-panel", () => ({
  CommentsPanel: () => <div data-testid="comments-panel" />,
}))

// Mock react-markdown
vi.mock("react-markdown", () => ({
  default: ({ children }: { children: string }) => <div>{children}</div>,
}))

vi.mock("remark-gfm", () => ({
  default: () => {},
}))

import { AuditTabs } from "@/components/calls/audit-tabs"

describe("ScorecardContent (via AuditTabs)", () => {
  it("renders 13 dimension bars", () => {
    render(<AuditTabs audit={mockAudit} />)

    expect(screen.getByText("Frame e Liderança")).toBeInTheDocument()
    expect(screen.getByText(/Qualifica/)).toBeInTheDocument()
    expect(screen.getByText("Diagnóstico Quantitativo")).toBeInTheDocument()
    expect(screen.getByText("Diagnóstico Qualitativo")).toBeInTheDocument()
    expect(screen.getByText("Perguntas de Consequência")).toBeInTheDocument()
    expect(screen.getByText("Ensino Comercial")).toBeInTheDocument()
    expect(screen.getByText("Reframe de Identidade")).toBeInTheDocument()
    expect(screen.getByText("Ancoragem de Valor")).toBeInTheDocument()
    expect(screen.getByText("Isolamento de Objeção")).toBeInTheDocument()
    expect(screen.getByText("Proporção de Fala")).toBeInTheDocument()
    expect(screen.getByText("Segurança de Promessas")).toBeInTheDocument()
    expect(screen.getByText("Checkpoints")).toBeInTheDocument()
    expect(screen.getByText("Controle e Fechamento")).toBeInTheDocument()
  })

  it("shows formatted scores for each dimension", () => {
    render(<AuditTabs audit={mockAudit} />)

    // d06_ensino = 9.0 (unique value)
    expect(screen.getByText("9.0")).toBeInTheDocument()
    // d12_checkpoints = 9.2 (unique value)
    expect(screen.getByText("9.2")).toBeInTheDocument()
    // d04_diag_qualitativo = 7.5 (unique value)
    expect(screen.getByText("7.5")).toBeInTheDocument()
  })

  it("shows weighted percentages", () => {
    render(<AuditTabs audit={mockAudit} />)

    // d03_diag_quantitativo peso = 0.12 → 12% (unique)
    expect(screen.getByText("(12%)")).toBeInTheDocument()
    // d05_consequencia peso = 0.10 → 10% (appears multiple times — use getAllByText)
    const tenPercentEls = screen.getAllByText("(10%)")
    expect(tenPercentEls.length).toBeGreaterThanOrEqual(1)
  })

  it("shows 'not available' when no dimensions are set", () => {
    const auditNoDimensions: CallAuditWithCloser = {
      ...mockAudit,
      d01_frame: null,
      d02_qualificacao: null,
      d03_diag_quantitativo: null,
      d04_diag_qualitativo: null,
      d05_consequencia: null,
      d06_ensino: null,
      d07_identidade: null,
      d08_ancoragem: null,
      d09_isolamento: null,
      d10_proporcao_fala: null,
      d11_promessas: null,
      d12_checkpoints: null,
      d13_fechamento: null,
    }

    render(<AuditTabs audit={auditNoDimensions} />)

    expect(
      screen.getByText(/Scorecard ainda/)
    ).toBeInTheDocument()
  })

  it("renders all 9 tab triggers", () => {
    render(<AuditTabs audit={mockAudit} />)

    expect(screen.getByText("Scorecard")).toBeInTheDocument()
    expect(screen.getByText(/Relat/)).toBeInTheDocument()
    expect(screen.getByText(/Transcri/)).toBeInTheDocument()
    expect(screen.getByText("Erros & Acertos")).toBeInTheDocument()
    expect(screen.getByText("Reescrita")).toBeInTheDocument()
    expect(screen.getByText(/Plano de A/)).toBeInTheDocument()
    expect(screen.getByText("Coaching")).toBeInTheDocument()
    expect(screen.getByText("Sentimento")).toBeInTheDocument()
    expect(screen.getByText("Supervisor")).toBeInTheDocument()
  })

  it("renders scorecard as default tab", () => {
    render(<AuditTabs audit={mockAudit} />)

    expect(screen.getAllByText(/Scorecard/).length).toBeGreaterThan(0)
  })

  it("shows score with correct color class for ELITE range (≥8.5)", () => {
    render(<AuditTabs audit={mockAudit} />)

    // d12_checkpoints = 9.2 — unique ELITE score
    const scoreEl = screen.getByText("9.2")
    expect(scoreEl.className).toContain("text-amber-300")
  })

  it("shows score with correct color class for FORTE range (7.0-8.4)", () => {
    render(<AuditTabs audit={mockAudit} />)

    // d04_diag_qualitativo = 7.5 — unique FORTE score
    const scoreEl = screen.getByText("7.5")
    expect(scoreEl.className).toContain("text-emerald-400")
  })
})
