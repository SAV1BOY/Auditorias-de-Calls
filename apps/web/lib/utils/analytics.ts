export function calculateMovingAverage(
  data: Array<{ date: string; score: number }>,
  windowSize: number
): Array<{ date: string; movingAvg: number }> {
  return data.map((point, index) => {
    const start = Math.max(0, index - windowSize + 1)
    const window = data.slice(start, index + 1)
    const avg =
      Math.round(
        (window.reduce((sum, p) => sum + p.score, 0) / window.length) * 10
      ) / 10
    return { date: point.date, movingAvg: avg }
  })
}

export function generateComparisonInsights(
  closers: Array<{
    closer_name: string
    dimensions: Array<{ name: string; shortName: string; score: number }>
    media_score: number | null
  }>
): string[] {
  if (closers.length < 2) return []

  const insights: string[] = []

  // Best overall
  const sorted = [...closers]
    .filter((c) => c.media_score !== null)
    .sort((a, b) => (b.media_score ?? 0) - (a.media_score ?? 0))

  if (sorted.length >= 2) {
    const best = sorted[0]
    const diff = ((best.media_score ?? 0) - (sorted[1].media_score ?? 0)).toFixed(1)
    if (Number(diff) > 0) {
      insights.push(
        `${best.closer_name} lidera com score médio ${Number(diff).toFixed(1)} pontos acima de ${sorted[1].closer_name}.`
      )
    }
  }

  // Best per dimension
  const numDimensions = closers[0]?.dimensions.length ?? 0
  for (let i = 0; i < numDimensions; i++) {
    const dimName = closers[0]?.dimensions[i]?.name
    if (!dimName) continue

    let bestCloser = ""
    let bestScore = 0
    let secondScore = 0

    for (const closer of closers) {
      const score = closer.dimensions[i]?.score ?? 0
      if (score > bestScore) {
        secondScore = bestScore
        bestScore = score
        bestCloser = closer.closer_name
      } else if (score > secondScore) {
        secondScore = score
      }
    }

    const gap = bestScore - secondScore
    if (gap >= 1.5 && bestScore >= 7 && secondScore > 0) {
      const pct = Math.round((gap / secondScore) * 100)
      insights.push(
        `${bestCloser} se destaca em ${dimName} com ${bestScore.toFixed(1)} (${pct}% acima do segundo).`
      )
    }
  }

  return insights.slice(0, 5)
}

export function getGoalProgressColor(progress: number, daysRemaining: number, totalDays: number): string {
  const timeProgress = totalDays > 0 ? ((totalDays - daysRemaining) / totalDays) * 100 : 100

  if (progress >= 100) return "bg-emerald-500"
  if (progress >= timeProgress) return "bg-blue-500"
  if (progress >= timeProgress * 0.7) return "bg-amber-500"
  return "bg-red-500"
}

export function getDaysRemaining(endDate: string): number {
  const end = new Date(endDate)
  const now = new Date()
  const diff = end.getTime() - now.getTime()
  return Math.max(0, Math.ceil(diff / (1000 * 60 * 60 * 24)))
}

export function getTotalDays(startDate: string, endDate: string): number {
  const start = new Date(startDate)
  const end = new Date(endDate)
  const diff = end.getTime() - start.getTime()
  return Math.max(1, Math.ceil(diff / (1000 * 60 * 60 * 24)))
}
