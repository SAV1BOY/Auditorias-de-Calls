import { describe, it, expect, vi } from "vitest"
import { render, screen, fireEvent } from "@testing-library/react"

vi.mock("@/lib/actions/export-pdf", () => ({
  generateAuditPDF: vi.fn().mockResolvedValue({ url: "https://example.com/report.pdf" }),
  generateBatchPDF: vi.fn().mockResolvedValue({ url: "https://example.com/batch.pdf" }),
}))

describe("ExportPdfButton", () => {
  it("renders the button", async () => {
    const { ExportPdfButton } = await import("@/components/calls/export-pdf-button")
    render(<ExportPdfButton auditId="audit-001" />)

    expect(screen.getByText(/exportar pdf/i)).toBeDefined()
  })

  it("shows button with FileText icon label", async () => {
    const { ExportPdfButton } = await import("@/components/calls/export-pdf-button")
    render(<ExportPdfButton auditId="audit-001" />)

    const button = screen.getByRole("button")
    expect(button).toBeDefined()
    expect(button.textContent).toContain("Exportar PDF")
  })

  it("is clickable", async () => {
    const { ExportPdfButton } = await import("@/components/calls/export-pdf-button")
    render(<ExportPdfButton auditId="audit-001" />)

    const button = screen.getByRole("button")
    expect(button).not.toBeDisabled()
  })

  it("button exists for different audit IDs", async () => {
    const { ExportPdfButton } = await import("@/components/calls/export-pdf-button")
    render(<ExportPdfButton auditId="audit-999" />)

    expect(screen.getByText(/exportar pdf/i)).toBeDefined()
  })
})

describe("BatchExportButton", () => {
  it("renders nothing when no IDs selected", async () => {
    const { BatchExportButton } = await import("@/components/calls/batch-export-button")
    const { container } = render(<BatchExportButton selectedIds={[]} />)

    expect(container.innerHTML).toBe("")
  })

  it("shows count of selected items", async () => {
    const { BatchExportButton } = await import("@/components/calls/batch-export-button")
    render(<BatchExportButton selectedIds={["a", "b", "c"]} />)

    expect(screen.getByText(/3/)).toBeDefined()
  })

  it("renders button when IDs are selected", async () => {
    const { BatchExportButton } = await import("@/components/calls/batch-export-button")
    render(<BatchExportButton selectedIds={["audit-001"]} />)

    const button = screen.getByRole("button")
    expect(button).toBeDefined()
  })
})
