import { render, screen, waitFor } from "@testing-library/react"
import { vi } from "vitest"

// Mock the supervisor actions
vi.mock("@/lib/actions/supervisor", () => ({
  getSupervisorAnalysisByAudit: vi.fn(),
  requestSupervisorAnalysis: vi.fn(),
}))

// Mock toast
vi.mock("@/components/ui/use-toast", () => ({
  useToast: () => ({
    toast: vi.fn(),
  }),
}))

import { SupervisorTabContent } from "@/components/calls/supervisor-tab-content"
import { getSupervisorAnalysisByAudit } from "@/lib/actions/supervisor"

describe("SupervisorTabContent", () => {
  beforeEach(() => {
    vi.clearAllMocks()
  })

  it("shows loading state initially", () => {
    vi.mocked(getSupervisorAnalysisByAudit).mockReturnValue(new Promise(() => {})) // never resolves

    render(<SupervisorTabContent auditId="audit-001" />)

    expect(screen.getByText(/Carregando/i)).toBeTruthy()
  })

  it("shows empty state with request button when no analysis exists", async () => {
    vi.mocked(getSupervisorAnalysisByAudit).mockResolvedValue(null)

    render(<SupervisorTabContent auditId="audit-001" />)

    await waitFor(() => {
      expect(screen.getByText(/Nenhuma análise/i)).toBeTruthy()
    })

    expect(screen.getByText(/Solicitar Análise/i)).toBeTruthy()
  })

  it("shows analysis data when it exists", async () => {
    vi.mocked(getSupervisorAnalysisByAudit).mockResolvedValue({
      id: "sa-001",
      overall_score: 8.2,
      overall_label: "Call de alta qualidade",
      classification: "BOA",
      executive_summary: "Resumo executivo da call",
      stages: [],
      priority_improvements: ["Melhorar rapport"],
      negotiation: {} as any,
      training_actions: [],
      objections_detected: [],
    } as any)

    render(<SupervisorTabContent auditId="audit-001" />)

    await waitFor(() => {
      expect(screen.getByText("8.2")).toBeTruthy()
    })

    expect(screen.getByText("BOA")).toBeTruthy()
    expect(screen.getAllByText(/Resumo Executivo/i).length).toBeGreaterThan(0)
  })
})
