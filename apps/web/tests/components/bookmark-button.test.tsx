import { render, screen, fireEvent, waitFor } from "@testing-library/react"
import { vi } from "vitest"
import { mockBookmark } from "../fixtures/audit"

// Mock bookmarks actions
const mockGetBookmark = vi.fn()
const mockRemoveBookmark = vi.fn()

vi.mock("@/lib/actions/bookmarks", () => ({
  getBookmark: (...args: unknown[]) => mockGetBookmark(...args),
  removeBookmark: (...args: unknown[]) => mockRemoveBookmark(...args),
  toggleBookmark: vi.fn().mockResolvedValue({ success: true }),
}))

import { BookmarkButton } from "@/components/calls/bookmark-button"

describe("BookmarkButton", () => {
  beforeEach(() => {
    mockGetBookmark.mockReset()
    mockRemoveBookmark.mockReset()
  })

  it("shows empty star when not bookmarked", async () => {
    mockGetBookmark.mockResolvedValue(null)

    render(<BookmarkButton auditId="audit-001" />)

    await waitFor(() => {
      const button = screen.getByRole("button")
      expect(button).toHaveAttribute("title", "Marcar como call modelo")
    })
  })

  it("shows filled star when bookmarked", async () => {
    mockGetBookmark.mockResolvedValue(mockBookmark)

    render(<BookmarkButton auditId="audit-001" />)

    await waitFor(() => {
      const button = screen.getByRole("button")
      expect(button).toHaveAttribute("title", "Remover dos modelos")
    })
  })

  it("opens dialog when clicking empty star", async () => {
    mockGetBookmark.mockResolvedValue(null)

    render(<BookmarkButton auditId="audit-001" />)

    await waitFor(() => {
      const button = screen.getByRole("button")
      expect(button).toHaveAttribute("title", "Marcar como call modelo")
    })

    fireEvent.click(screen.getByRole("button"))

    await waitFor(() => {
      expect(screen.getByText("Marcar como Call Modelo")).toBeInTheDocument()
    })
  })

  it("removes bookmark when clicking filled star", async () => {
    mockGetBookmark.mockResolvedValue(mockBookmark)
    mockRemoveBookmark.mockResolvedValue({ success: true })

    render(<BookmarkButton auditId="audit-001" />)

    await waitFor(() => {
      const button = screen.getByRole("button")
      expect(button).toHaveAttribute("title", "Remover dos modelos")
    })

    fireEvent.click(screen.getByRole("button"))

    await waitFor(() => {
      expect(mockRemoveBookmark).toHaveBeenCalledWith("audit-001")
    })
  })

  it("fetches bookmark status on mount", async () => {
    mockGetBookmark.mockResolvedValue(null)

    render(<BookmarkButton auditId="audit-001" />)

    await waitFor(() => {
      expect(mockGetBookmark).toHaveBeenCalledWith("audit-001")
    })
  })
})
