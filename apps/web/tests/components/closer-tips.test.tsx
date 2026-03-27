import { render, screen } from "@testing-library/react"
import { CloserTips } from "@/components/calls/closer-tips"
import { mockAudit } from "../fixtures/audit"

describe("CloserTips", () => {
  it("shows empty state when no analysis data", () => {
    const emptyAudit = {
      ...mockAudit,
      top_erros: null,
      top_acertos: null,
      reescrita_falas: null,
      plano_acao: null,
    }

    render(<CloserTips audit={emptyAudit} />)

    expect(screen.getByText(/disponíveis após/i)).toBeTruthy()
  })

  it("renders 4 blocks when data exists", () => {
    const auditWithTips = {
      ...mockAudit,
      score_final: 7.2,
      classificacao: "FORTE",
      top_erros: [{ rank: 1, title: "Faltou diagnóstico", description: "Não explorou métricas" }],
      top_acertos: [{ rank: 1, title: "Rapport excelente", description: "Conectou bem" }],
      reescrita_falas: [{ original: "Garanto que funciona", rewritten: "Cases similares mostram X", reason: "Segurança" }],
      plano_acao: [{ rank: 1, title: "Melhorar SPIN", o_que_fazer: "Praticar perguntas", como_treinar: "Role play" }],
      engagement_level: "alto",
    }

    render(<CloserTips audit={auditWithTips} />)

    expect(screen.getByText(/Alavanca #1/i)).toBeTruthy()
    expect(screen.getByText(/O que você dominou/i)).toBeTruthy()
    expect(screen.getByText(/Swap de Script/i)).toBeTruthy()
    expect(screen.getByText(/Seu resultado/i)).toBeTruthy()
    expect(screen.getByText("7.2")).toBeTruthy()
    expect(screen.getByText("FORTE")).toBeTruthy()
  })

  it("shows correct classification badge colors", () => {
    const eliteAudit = {
      ...mockAudit,
      score_final: 9.0,
      classificacao: "ELITE",
      top_erros: [{ rank: 1, title: "Minor", description: "Small issue" }],
      top_acertos: [{ rank: 1, title: "Perfect", description: "Great job" }],
    }

    render(<CloserTips audit={eliteAudit} />)

    expect(screen.getByText("ELITE")).toBeTruthy()
    expect(screen.getByText("9.0")).toBeTruthy()
  })
})
