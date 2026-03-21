import {
  getClassificacaoColor,
  getScoreColor,
  getStatusColor,
} from "@/lib/utils/colors"

describe("getClassificacaoColor", () => {
  it("returns emerald for ELITE", () => {
    expect(getClassificacaoColor("ELITE")).toBe("bg-emerald-100 text-emerald-800")
  })

  it("returns blue for FORTE", () => {
    expect(getClassificacaoColor("FORTE")).toBe("bg-blue-100 text-blue-800")
  })

  it("returns amber for MEDIANA", () => {
    expect(getClassificacaoColor("MEDIANA")).toBe("bg-amber-100 text-amber-800")
  })

  it("returns red for FRACA", () => {
    expect(getClassificacaoColor("FRACA")).toBe("bg-red-100 text-red-800")
  })

  it("returns gray for null", () => {
    expect(getClassificacaoColor(null)).toBe("bg-gray-100 text-gray-800")
  })
})

describe("getScoreColor", () => {
  it("returns muted foreground for null", () => {
    expect(getScoreColor(null)).toBe("text-muted-foreground")
  })

  it("returns emerald for score >= 8.5", () => {
    expect(getScoreColor(8.5)).toBe("text-emerald-600")
  })

  it("returns blue for score >= 7.0 and < 8.5", () => {
    expect(getScoreColor(7.0)).toBe("text-blue-600")
  })

  it("returns amber for score >= 5.5 and < 7.0", () => {
    expect(getScoreColor(5.5)).toBe("text-amber-600")
  })

  it("returns red for score < 5.5", () => {
    expect(getScoreColor(3.0)).toBe("text-red-600")
  })
})

describe("getStatusColor", () => {
  it("returns emerald for completed", () => {
    expect(getStatusColor("completed")).toBe("bg-emerald-100 text-emerald-800")
  })

  it("returns red for error", () => {
    expect(getStatusColor("error")).toBe("bg-red-100 text-red-800")
  })

  it("returns gray for uploaded", () => {
    expect(getStatusColor("uploaded")).toBe("bg-gray-100 text-gray-800")
  })

  it("returns blue for any other status", () => {
    expect(getStatusColor("transcribing")).toBe("bg-blue-100 text-blue-800")
    expect(getStatusColor("analyzing")).toBe("bg-blue-100 text-blue-800")
  })
})
