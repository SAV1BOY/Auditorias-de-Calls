import { Badge } from "@/components/ui/badge"
import { SENTIMENT_LABELS, SENTIMENT_COLORS } from "@/lib/utils/constants"

interface SentimentBadgeProps { sentiment: string }

export function SentimentBadge({ sentiment }: SentimentBadgeProps) {
  const label = SENTIMENT_LABELS[sentiment] ?? sentiment
  const color = SENTIMENT_COLORS[sentiment] ?? "#8a8a8a"

  return (
    <Badge variant="outline" className="text-xs font-medium font-body" style={{ color, borderColor: `${color}40`, backgroundColor: `${color}15` }}>
      {label}
    </Badge>
  )
}
