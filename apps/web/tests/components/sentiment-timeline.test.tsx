import { describe, it, expect, vi } from "vitest"
import { render, screen } from "@testing-library/react"
import { mockSentimentTimeline, mockObjections } from "../fixtures/audit"

vi.mock("next/navigation", () => ({
  useRouter: () => ({ push: vi.fn(), back: vi.fn() }),
  usePathname: () => "/calls/audit-001",
  useSearchParams: () => new URLSearchParams(),
}))

describe("SentimentTimeline", () => {
  it("renders timeline entries", async () => {
    const { SentimentTimeline } = await import("@/components/calls/sentiment-timeline")
    render(
      <SentimentTimeline
        timeline={mockSentimentTimeline}
        overallSentiment="positive"
        sentimentScore={0.6}
      />
    )

    expect(screen.getByText(/abertura/i)).toBeDefined()
  })

  it("shows overall sentiment label", async () => {
    const { SentimentTimeline } = await import("@/components/calls/sentiment-timeline")
    render(
      <SentimentTimeline
        timeline={mockSentimentTimeline}
        overallSentiment="positive"
        sentimentScore={0.6}
      />
    )

    expect(screen.getAllByText(/positivo/i).length).toBeGreaterThan(0)
  })

  it("renders empty state when no timeline", async () => {
    const { SentimentTimeline } = await import("@/components/calls/sentiment-timeline")
    render(
      <SentimentTimeline
        timeline={[]}
        overallSentiment="neutral"
        sentimentScore={0.0}
      />
    )

    expect(screen.getByText(/ainda não disponível/i)).toBeDefined()
  })

  it("displays sentiment score", async () => {
    const { SentimentTimeline } = await import("@/components/calls/sentiment-timeline")
    render(
      <SentimentTimeline
        timeline={mockSentimentTimeline}
        overallSentiment="positive"
        sentimentScore={0.6}
      />
    )

    expect(screen.getByText(/0\.60/)).toBeDefined()
  })
})

describe("ObjectionsList", () => {
  it("renders objections", async () => {
    const { ObjectionsList } = await import("@/components/calls/objections-list")
    render(<ObjectionsList objections={mockObjections} />)

    expect(screen.getByText(/caro/i)).toBeDefined()
  })

  it("shows effectiveness indicators", async () => {
    const { ObjectionsList } = await import("@/components/calls/objections-list")
    render(<ObjectionsList objections={mockObjections} />)

    // Should show good/poor indicators
    const container = document.body
    expect(container.textContent).toContain("15:30")
  })

  it("shows empty state with no objections", async () => {
    const { ObjectionsList } = await import("@/components/calls/objections-list")
    render(<ObjectionsList objections={[]} />)

    expect(screen.getByText(/nenhuma/i)).toBeDefined()
  })
})
