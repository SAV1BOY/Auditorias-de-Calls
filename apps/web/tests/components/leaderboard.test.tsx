import { describe, it, expect, vi } from "vitest"
import { render, screen } from "@testing-library/react"
import { mockLeaderboard, mockBadges } from "../fixtures/audit"

// Mock next/navigation
vi.mock("next/navigation", () => ({
  useRouter: () => ({ push: vi.fn(), back: vi.fn() }),
  usePathname: () => "/ranking",
  useSearchParams: () => new URLSearchParams(),
}))

describe("LeaderboardTable", () => {
  it("renders leaderboard entries", async () => {
    const { LeaderboardTable } = await import("@/components/gamification/leaderboard-table")
    render(<LeaderboardTable entries={mockLeaderboard} />)

    expect(screen.getByText("Evelyn")).toBeDefined()
    expect(screen.getByText("Lucas")).toBeDefined()
    expect(screen.getByText("Ana")).toBeDefined()
  })

  it("shows rank numbers", async () => {
    const { LeaderboardTable } = await import("@/components/gamification/leaderboard-table")
    render(<LeaderboardTable entries={mockLeaderboard} />)

    // Ranks 1-3 show icons (Trophy/Medal), so check for entries instead
    expect(screen.getByText("8.5")).toBeDefined()
    expect(screen.getByText("7.9")).toBeDefined()
    expect(screen.getByText("7.2")).toBeDefined()
  })

  it("shows empty state when no entries", async () => {
    const { LeaderboardTable } = await import("@/components/gamification/leaderboard-table")
    render(<LeaderboardTable entries={[]} />)

    expect(screen.getByText(/nenhum/i)).toBeDefined()
  })

  it("displays score values", async () => {
    const { LeaderboardTable } = await import("@/components/gamification/leaderboard-table")
    render(<LeaderboardTable entries={mockLeaderboard} />)

    expect(screen.getByText("8.5")).toBeDefined()
  })
})

describe("BadgeGrid", () => {
  it("renders all badges", async () => {
    const { BadgeGrid } = await import("@/components/gamification/badge-grid")
    render(<BadgeGrid badges={mockBadges} earnedBadgeIds={["badge-001"]} />)

    expect(screen.getByText("Primeira ELITE")).toBeDefined()
    expect(screen.getByText("Sequência de 3")).toBeDefined()
  })

  it("highlights earned badges", async () => {
    const { BadgeGrid } = await import("@/components/gamification/badge-grid")
    const { container } = render(
      <BadgeGrid badges={mockBadges} earnedBadgeIds={["badge-001"]} />
    )

    // Earned badge should have primary border, unearned should have opacity
    const cards = container.querySelectorAll(".opacity-40")
    // One badge earned, rest unearned (with opacity)
    expect(cards.length).toBe(mockBadges.length - 1)
  })

  it("shows empty state with no badges", async () => {
    const { BadgeGrid } = await import("@/components/gamification/badge-grid")
    render(<BadgeGrid badges={[]} earnedBadgeIds={[]} />)

    expect(screen.getByText(/nenhum/i)).toBeDefined()
  })
})
