"use client"

import { useCallback, useMemo, useState } from "react"
import { AudioPlayer } from "./audio-player"
import { AuditTabs } from "./audit-tabs"
import type { CallAuditWithCloser, AudioMarker } from "@/lib/types/audit"

interface CallDetailClientProps {
  audit: CallAuditWithCloser
}

export function CallDetailClient({ audit }: CallDetailClientProps) {
  const [currentTime, setCurrentTime] = useState(0)
  const [seekTo, setSeekTo] = useState<number | undefined>(undefined)

  const handleTimeUpdate = useCallback((sec: number) => {
    setCurrentTime(sec)
  }, [])

  const handleSeek = useCallback((sec: number) => {
    setSeekTo(sec)
    // Reset after seeking so subsequent clicks to same timestamp work
    setTimeout(() => setSeekTo(undefined), 100)
  }, [])

  // Comment markers will be loaded by CommentsPanel via realtime;
  // For now we pass empty markers (populated later when comments load)
  const markers: AudioMarker[] = useMemo(() => [], [])

  return (
    <>
      <AudioPlayer
        audioPath={audit.audio_path}
        markers={markers}
        onTimeUpdate={handleTimeUpdate}
        currentSeek={seekTo}
      />
      <AuditTabs
        audit={audit}
        currentTime={currentTime}
        onSeek={handleSeek}
      />
    </>
  )
}
