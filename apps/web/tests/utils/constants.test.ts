import {
  DIMENSIONS,
  CLASSIFICACAO_THRESHOLDS,
  AUDIO_FORMATS,
  STATUS_LABELS,
  RESULTADO_LABELS,
  RADAR_LABELS,
  DIM_INDEX_MAP,
} from "@/lib/utils/constants"

describe("DIMENSIONS", () => {
  it("has exactly 13 dimensions", () => {
    expect(DIMENSIONS).toHaveLength(13)
  })

  it("has unique IDs", () => {
    const ids = DIMENSIONS.map((d) => d.id)
    expect(new Set(ids).size).toBe(13)
  })

  it("has pesos that sum to 1.0", () => {
    const total = DIMENSIONS.reduce((sum, d) => sum + d.peso, 0)
    expect(total).toBeCloseTo(1.0)
  })
})

describe("CLASSIFICACAO_THRESHOLDS", () => {
  it("has correct threshold values", () => {
    expect(CLASSIFICACAO_THRESHOLDS.ELITE).toBe(8.5)
    expect(CLASSIFICACAO_THRESHOLDS.FORTE).toBe(7.0)
    expect(CLASSIFICACAO_THRESHOLDS.MEDIANA).toBe(5.5)
  })
})

describe("AUDIO_FORMATS", () => {
  it("includes common audio formats", () => {
    expect(AUDIO_FORMATS).toContain(".ogg")
    expect(AUDIO_FORMATS).toContain(".mp3")
    expect(AUDIO_FORMATS).toContain(".wav")
  })
})

describe("STATUS_LABELS", () => {
  it("covers all pipeline statuses", () => {
    const expectedKeys = [
      "uploaded",
      "transcribing",
      "transcribed",
      "analyzing",
      "analyzed",
      "notifying",
      "completed",
      "error",
    ]
    expectedKeys.forEach((key) => {
      expect(STATUS_LABELS).toHaveProperty(key)
    })
  })
})

describe("RESULTADO_LABELS", () => {
  it("covers all resultado types", () => {
    expect(RESULTADO_LABELS).toHaveProperty("fechamento")
    expect(RESULTADO_LABELS).toHaveProperty("nao_fechou")
    expect(RESULTADO_LABELS).toHaveProperty("reagendar")
    expect(RESULTADO_LABELS).toHaveProperty("outro")
  })
})

describe("RADAR_LABELS", () => {
  it("has a label for every dimension ID", () => {
    DIMENSIONS.forEach((d) => {
      expect(RADAR_LABELS).toHaveProperty(d.id)
    })
  })
})

describe("DIM_INDEX_MAP", () => {
  it("maps every dimension ID to an avg column", () => {
    DIMENSIONS.forEach((d) => {
      expect(DIM_INDEX_MAP).toHaveProperty(d.id)
      expect(DIM_INDEX_MAP[d.id]).toMatch(/^avg_d\d{2}$/)
    })
  })
})
