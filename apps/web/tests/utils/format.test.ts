import {
  formatDate,
  formatScore,
  formatCurrency,
  getClassificacao,
  formatDuration,
} from "@/lib/utils/format"

describe("formatDate", () => {
  it("formats ISO date string to pt-BR dd/mm/yyyy", () => {
    expect(formatDate("2024-03-15")).toBe("15/03/2024")
  })

  it("formats another date correctly", () => {
    expect(formatDate("2023-12-01")).toBe("01/12/2023")
  })
})

describe("formatScore", () => {
  it("returns em-dash for null", () => {
    expect(formatScore(null)).toBe("—")
  })

  it("formats integer score with one decimal", () => {
    expect(formatScore(8)).toBe("8.0")
  })

  it("formats decimal score with one decimal", () => {
    expect(formatScore(7.56)).toBe("7.6")
  })
})

describe("formatCurrency", () => {
  it("returns em-dash for null", () => {
    expect(formatCurrency(null)).toBe("—")
  })

  it("formats number as BRL currency", () => {
    const result = formatCurrency(1500)
    expect(result).toContain("1.500")
    expect(result).toContain("R$")
  })
})

describe("getClassificacao", () => {
  it("returns null for null score", () => {
    expect(getClassificacao(null)).toBeNull()
  })

  it("returns ELITE for score >= 8.5", () => {
    expect(getClassificacao(8.5)).toBe("ELITE")
    expect(getClassificacao(10)).toBe("ELITE")
  })

  it("returns FORTE for score >= 7.0 and < 8.5", () => {
    expect(getClassificacao(7.0)).toBe("FORTE")
    expect(getClassificacao(8.4)).toBe("FORTE")
  })

  it("returns MEDIANA for score >= 5.5 and < 7.0", () => {
    expect(getClassificacao(5.5)).toBe("MEDIANA")
    expect(getClassificacao(6.9)).toBe("MEDIANA")
  })

  it("returns FRACA for score < 5.5", () => {
    expect(getClassificacao(5.4)).toBe("FRACA")
    expect(getClassificacao(0)).toBe("FRACA")
  })
})

describe("formatDuration", () => {
  it("returns em-dash for null", () => {
    expect(formatDuration(null)).toBe("—")
  })

  it("formats 0 minutes", () => {
    expect(formatDuration(0)).toBe("0min")
  })

  it("formats minutes only", () => {
    expect(formatDuration(59)).toBe("59min")
  })

  it("formats exact hours without minutes suffix", () => {
    expect(formatDuration(60)).toBe("1h")
  })

  it("formats hours and minutes", () => {
    expect(formatDuration(150)).toBe("2h30min")
  })
})
