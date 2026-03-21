import { Badge } from "@/components/ui/badge"
import { SENTIMENT_LABELS, SENTIMENT_COLORS } from "@/lib/utils/constants"

interface SentimentBadgeProps {
  sentiment: string
}

export function SentimentBadge({ sentiment }: SentimentBadgeProps) {
  const label = SENTIMENT_LABELS[sentiment] ?? sentiment
  const color = SENTIMENT_COLORS[sentiment] ?? "#a3a3a3"

  return (
    <Badge
      variant="outline"
      className="text-xs font-medium border"
      style={{
        color,
        borderColor: color,
        backgroundColor: `${color}15`,
      }}
    >
      {label}
    </Badge>
  )
}
