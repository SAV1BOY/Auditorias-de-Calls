import {
  getClassificacaoColor,
  getScoreColor,
  getStatusColor,
} from "@/lib/utils/colors"

describe("getClassificacaoColor", () => {
  it("returns amber for ELITE", () => {
    expect(getClassificacaoColor("ELITE")).toBe("bg-amber-900/30 text-amber-300")
  })

  it("returns emerald for FORTE", () => {
    expect(getClassificacaoColor("FORTE")).toBe("bg-emerald-900/30 text-emerald-400")
  })

  it("returns yellow for MEDIANA", () => {
    expect(getClassificacaoColor("MEDIANA")).toBe("bg-yellow-900/30 text-yellow-400")
  })

  it("returns red for FRACA", () => {
    expect(getClassificacaoColor("FRACA")).toBe("bg-red-900/30 text-red-400")
  })

  it("returns surface for null", () => {
    expect(getClassificacaoColor(null)).toBe("bg-surface-container-high text-muted-foreground")
  })
})

describe("getScoreColor", () => {
  it("returns muted foreground for null", () => {
    expect(getScoreColor(null)).toBe("text-muted-foreground")
  })

  it("returns amber for score >= 8.5 (ELITE)", () => {
    expect(getScoreColor(8.5)).toBe("text-amber-300 font-body font-bold")
  })

  it("returns emerald for score >= 7.0 (FORTE)", () => {
    expect(getScoreColor(7.0)).toBe("text-emerald-400 font-body font-bold")
  })

  it("returns yellow for score >= 5.5 (MEDIANA)", () => {
    expect(getScoreColor(5.5)).toBe("text-yellow-400 font-body font-bold")
  })

  it("returns red for score < 5.5 (FRACA)", () => {
    expect(getScoreColor(3.0)).toBe("text-red-400 font-body font-bold")
  })
})

describe("getStatusColor", () => {
  it("returns emerald for completed", () => {
    expect(getStatusColor("completed")).toBe("bg-emerald-900/30 text-emerald-400")
  })

  it("returns red for error", () => {
    expect(getStatusColor("error")).toBe("bg-red-900/30 text-red-400")
  })

  it("returns surface for uploaded", () => {
    expect(getStatusColor("uploaded")).toBe("bg-surface-container-high text-muted-foreground")
  })

  it("returns blue for any other status", () => {
    expect(getStatusColor("transcribing")).toBe("bg-blue-900/30 text-blue-400")
    expect(getStatusColor("analyzing")).toBe("bg-blue-900/30 text-blue-400")
  })
})
