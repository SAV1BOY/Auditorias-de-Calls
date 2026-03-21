import { render, screen } from "@testing-library/react"
import { vi } from "vitest"
import { mockBookmark } from "../fixtures/audit"
import type { CallBookmark } from "@/lib/types/audit"

// Mock server actions
vi.mock("@/lib/actions/bookmarks", () => ({
  getBookmarkedCalls: vi.fn().mockResolvedValue([]),
}))

import { LibraryContent } from "@/components/library/library-content"

const closers = [
  { id: "closer-001", name: "Evelyn" },
  { id: "closer-002", name: "Lucas" },
]
const allTags = ["excelente-ancoragem", "fechamento-perfeito", "rapport-alto"]

describe("LibraryContent", () => {
  it("shows empty state when no bookmarks", () => {
    render(
      <LibraryContent
        initialBookmarks={[]}
        closers={closers}
        allTags={allTags}
      />
    )

    expect(screen.getByText("Nenhuma call modelo encontrada.")).toBeInTheDocument()
  })

  it("renders bookmark cards", () => {
    render(
      <LibraryContent
        initialBookmarks={[mockBookmark]}
        closers={closers}
        allTags={allTags}
      />
    )

    expect(screen.getByText("Elane Lima")).toBeInTheDocument()
    expect(screen.getByText("FORTE")).toBeInTheDocument()
  })

  it("shows tags on bookmark cards", () => {
    render(
      <LibraryContent
        initialBookmarks={[mockBookmark]}
        closers={closers}
        allTags={allTags}
      />
    )

    expect(screen.getByText("excelente-ancoragem")).toBeInTheDocument()
    expect(screen.getByText("fechamento-perfeito")).toBeInTheDocument()
  })

  it("shows notes on bookmark cards", () => {
    render(
      <LibraryContent
        initialBookmarks={[mockBookmark]}
        closers={closers}
        allTags={allTags}
      />
    )

    expect(
      screen.getByText("Call modelo para treinamento de ancoragem")
    ).toBeInTheDocument()
  })

  it("shows score on bookmark cards", () => {
    render(
      <LibraryContent
        initialBookmarks={[mockBookmark]}
        closers={closers}
        allTags={allTags}
      />
    )

    expect(screen.getByText("8.2")).toBeInTheDocument()
  })

  it("renders filter dropdowns", () => {
    render(
      <LibraryContent
        initialBookmarks={[mockBookmark]}
        closers={closers}
        allTags={allTags}
      />
    )

    expect(screen.getByText("Filtrar por tag")).toBeInTheDocument()
    expect(screen.getByText("Filtrar por closer")).toBeInTheDocument()
    expect(screen.getByText("Classificação")).toBeInTheDocument()
  })

  it("renders links to call detail pages", () => {
    render(
      <LibraryContent
        initialBookmarks={[mockBookmark]}
        closers={closers}
        allTags={allTags}
      />
    )

    const link = screen.getByText("Ver detalhes").closest("a")
    expect(link).toHaveAttribute("href", "/calls/audit-001")
  })
})
