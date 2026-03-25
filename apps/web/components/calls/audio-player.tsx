"use client"

import { useCallback, useEffect, useRef, useState } from "react"
import { createClient } from "@/lib/supabase/client"
import { Button } from "@/components/ui/button"
import { Play, Pause, SkipBack, SkipForward, Volume2, VolumeX } from "lucide-react"
import type { AudioMarker } from "@/lib/types/audit"
import { cn } from "@/lib/utils"

interface AudioPlayerProps { audioPath: string | null; markers?: AudioMarker[]; onTimeClick?: (sec: number) => void; onTimeUpdate?: (sec: number) => void; currentSeek?: number }

function formatTime(sec: number): string { const m = Math.floor(sec / 60); const s = Math.floor(sec % 60); return `${m}:${s.toString().padStart(2, "0")}` }

const SPEEDS = [0.5, 1, 1.5, 2] as const

export function AudioPlayer({ audioPath, markers = [], onTimeClick, onTimeUpdate, currentSeek }: AudioPlayerProps) {
  const audioRef = useRef<HTMLAudioElement>(null)
  const progressRef = useRef<HTMLDivElement>(null)
  const [src, setSrc] = useState<string | null>(null)
  const [error, setError] = useState(false)
  const [playing, setPlaying] = useState(false)
  const [currentTime, setCurrentTime] = useState(0)
  const [duration, setDuration] = useState(0)
  const [speedIdx, setSpeedIdx] = useState(1)
  const [muted, setMuted] = useState(false)

  useEffect(() => {
    if (!audioPath) return
    const supabase = createClient()
    supabase.storage.from("audios").createSignedUrl(audioPath, 3600).then(({ data: signed, error: signError }) => {
      if (signError || !signed?.signedUrl) { setError(true); return }
      setSrc(signed.signedUrl)
    })
  }, [audioPath])

  useEffect(() => { if (currentSeek !== undefined && audioRef.current) audioRef.current.currentTime = currentSeek }, [currentSeek])

  const handleTimeUpdate = useCallback(() => { if (!audioRef.current) return; const t = audioRef.current.currentTime; setCurrentTime(t); onTimeUpdate?.(t) }, [onTimeUpdate])
  const handleLoadedMetadata = useCallback(() => { if (!audioRef.current) return; setDuration(audioRef.current.duration) }, [])
  const togglePlay = useCallback(() => { if (!audioRef.current) return; if (playing) audioRef.current.pause(); else audioRef.current.play(); setPlaying(!playing) }, [playing])
  const skip = useCallback((delta: number) => { if (!audioRef.current) return; audioRef.current.currentTime = Math.max(0, Math.min(duration, audioRef.current.currentTime + delta)) }, [duration])
  const cycleSpeed = useCallback(() => { const next = (speedIdx + 1) % SPEEDS.length; setSpeedIdx(next); if (audioRef.current) audioRef.current.playbackRate = SPEEDS[next] }, [speedIdx])
  const toggleMute = useCallback(() => { if (!audioRef.current) return; audioRef.current.muted = !muted; setMuted(!muted) }, [muted])
  const handleProgressClick = useCallback((e: React.MouseEvent<HTMLDivElement>) => { if (!progressRef.current || !audioRef.current || duration === 0) return; const rect = progressRef.current.getBoundingClientRect(); const pct = Math.max(0, Math.min(1, (e.clientX - rect.left) / rect.width)); audioRef.current.currentTime = pct * duration; onTimeClick?.(pct * duration) }, [duration, onTimeClick])
  const handleEnded = useCallback(() => { setPlaying(false) }, [])

  if (!audioPath) return null
  if (error) return <div className="rounded-lg bg-surface-interaction/30 p-3 text-sm text-muted-foreground">N\u00e3o foi poss\u00edvel carregar o \u00e1udio.</div>
  if (!src) return <div className="rounded-lg bg-surface-interaction/30 p-3 text-sm text-muted-foreground animate-amber-pulse">Carregando \u00e1udio...</div>

  const progress = duration > 0 ? (currentTime / duration) * 100 : 0
  const pointMarkers = markers.filter((m) => m.type === "comment")

  return (
    <div className="rounded-lg bg-card p-4 space-y-3 shadow-elevation-1">
      <audio ref={audioRef} src={src} preload="metadata" onTimeUpdate={handleTimeUpdate} onLoadedMetadata={handleLoadedMetadata} onEnded={handleEnded} />
      <div className="flex items-center gap-2">
        <Button variant="ghost" size="icon" className="h-8 w-8" onClick={() => skip(-10)} title="-10s"><SkipBack className="h-4 w-4" /></Button>
        <Button variant="default" size="icon" className="h-9 w-9 rounded-full" onClick={togglePlay}>{playing ? <Pause className="h-4 w-4" /> : <Play className="h-4 w-4 ml-0.5" />}</Button>
        <Button variant="ghost" size="icon" className="h-8 w-8" onClick={() => skip(10)} title="+10s"><SkipForward className="h-4 w-4" /></Button>
        <Button variant="outline" size="sm" className="h-7 px-2 text-xs font-mono" onClick={cycleSpeed}>{SPEEDS[speedIdx]}x</Button>
        <span className="ml-auto text-xs font-mono text-muted-foreground">{formatTime(currentTime)} / {formatTime(duration)}</span>
        <Button variant="ghost" size="icon" className="h-8 w-8" onClick={toggleMute}>{muted ? <VolumeX className="h-4 w-4" /> : <Volume2 className="h-4 w-4" />}</Button>
      </div>
      <div ref={progressRef} className="relative h-3 cursor-pointer rounded-full bg-surface-interaction group" onClick={handleProgressClick}>
        <div className="absolute left-0 top-0 h-full rounded-full bg-primary transition-[width] duration-100" style={{ width: `${progress}%` }} />
        {pointMarkers.map((marker) => {
          if (duration === 0) return null
          const left = (marker.timestampSec / duration) * 100
          return <div key={marker.id} className={cn("absolute top-1/2 -translate-y-1/2 h-2.5 w-2.5 rounded-full border-2 border-background z-10", marker.color === "highlight" ? "bg-primary" : "bg-blue-400")} style={{ left: `${left}%` }} title={marker.label ?? ""} />
        })}
      </div>
    </div>
  )
}
