import { cn } from "@/lib/utils"

function Skeleton({
  className,
  ...props
}: React.HTMLAttributes<HTMLDivElement>) {
  return (
    <div
      className={cn("animate-amber-pulse rounded-md bg-surface-interaction", className)}
      {...props}
    />
  )
}

export { Skeleton }
