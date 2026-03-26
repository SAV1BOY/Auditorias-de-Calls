import { render, screen } from "@testing-library/react"
import { vi } from "vitest"
import type { AudioMarker } from "@/lib/types/audit"

// Mock Supabase client for signed URL
const mockCreateSignedUrl = vi.fn()

vi.mock("@/lib/supabase/client", () => ({
  createClient: () => ({
    storage: {
      from: () => ({
        createSignedUrl: mockCreateSignedUrl,
      }),
    },
  }),
}))

import { AudioPlayer } from "@/components/calls/audio-player"

describe("AudioPlayer", () => {
  beforeEach(() => {
    mockCreateSignedUrl.mockReset()
    mockCreateSignedUrl.mockResolvedValue({
      data: { signedUrl: "https://test.supabase.co/signed-audio.ogg" },
      error: null,
    })
    // Mock HTMLMediaElement methods
    vi.spyOn(HTMLMediaElement.prototype, "play").mockImplementation(() => Promise.resolve())
    vi.spyOn(HTMLMediaElement.prototype, "pause").mockImplementation(() => {})
  })

  afterEach(() => {
    vi.restoreAllMocks()
  })

  it("returns null when audioPath is null", () => {
    const { container } = render(<AudioPlayer audioPath={null} />)
    expect(container.innerHTML).toBe("")
  })

  it("shows loading state while fetching signed URL", () => {
    mockCreateSignedUrl.mockReturnValue(new Promise(() => {}))

    render(<AudioPlayer audioPath="audit-001/call.ogg" />)
    expect(screen.getByText(/Carregando/)).toBeInTheDocument()
  })

  it("shows error state when signed URL fails", async () => {
    mockCreateSignedUrl.mockResolvedValue({
      data: null,
      error: { message: "Not found" },
    })

    render(<AudioPlayer audioPath="audit-001/call.ogg" />)

    await vi.waitFor(() => {
      expect(
        screen.getByText(/poss/)  // "Não foi possível carregar o áudio"
      ).toBeInTheDocument()
    })
  })

  it("renders controls after URL loads", async () => {
    render(<AudioPlayer audioPath="audit-001/call.ogg" />)

    await vi.waitFor(() => {
      // Should have an audio element now
      expect(screen.getByText("1x")).toBeInTheDocument()
    })
  })

  it("shows time display after URL loads", async () => {
    render(<AudioPlayer audioPath="audit-001/call.ogg" />)

    await vi.waitFor(() => {
      expect(screen.getByText("0:00 / 0:00")).toBeInTheDocument()
    })
  })

  it("renders audio element with correct src after URL loads", async () => {
    const { container } = render(
      <AudioPlayer audioPath="audit-001/call.ogg" />
    )

    await vi.waitFor(() => {
      const audio = container.querySelector("audio")
      expect(audio).toBeInTheDocument()
      expect(audio).toHaveAttribute("src", "https://test.supabase.co/signed-audio.ogg")
    })
  })

  it("calls createSignedUrl with correct path", async () => {
    render(<AudioPlayer audioPath="audit-001/call.ogg" />)

    await vi.waitFor(() => {
      expect(mockCreateSignedUrl).toHaveBeenCalledWith("audit-001/call.ogg", 3600)
    })
  })
})
