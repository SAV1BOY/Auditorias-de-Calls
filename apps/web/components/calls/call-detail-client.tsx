"use client"

import { useCallback, useEffect, useMemo, useState } from "react"
import { createClient } from "@/lib/supabase/client"
import { AudioPlayer } from "./audio-player"
import { AuditTabs } from "./audit-tabs"
import type { CallAuditWithCloser, AudioMarker, CallComment } from "@/lib/types/audit"
import { getComments } from "@/lib/actions/comments"

interface CallDetailClientProps {
  audit: CallAuditWithCloser
}

export function CallDetailClient({ audit }: CallDetailClientProps) {
  const [currentTime, setCurrentTime] = useState(0)
  const [seekTo, setSeekTo] = useState<number | undefined>(undefined)
  const [comments, setComments] = useState<CallComment[]>([])

  const handleTimeUpdate = useCallback((sec: number) => {
    setCurrentTime(sec)
  }, [])

  const handleSeek = useCallback((sec: number) => {
    setSeekTo(sec)
    // Reset after seeking so subsequent clicks to same timestamp work
    setTimeout(() => setSeekTo(undefined), 100)
  }, [])

  // Load comments and subscribe to realtime updates
  const refreshComments = useCallback(async () => {
    const data = await getComments(audit.id)
    setComments(data)
  }, [audit.id])

  useEffect(() => {
    refreshComments()
  }, [refreshComments])

  useEffect(() => {
    const supabase = createClient()
    const channel = supabase
      .channel(`markers-${audit.id}`)
      .on(
        "postgres_changes",
        {
          event: "*",
          schema: "public",
          table: "call_comments",
          filter: `audit_id=eq.${audit.id}`,
        },
        () => {
          refreshComments()
        }
      )
      .subscribe()

    return () => {
      supabase.removeChannel(channel)
    }
  }, [audit.id, refreshComments])

  // Transform comments with timestamps into AudioMarkers
  const markers: AudioMarker[] = useMemo(() => {
    const allComments = [...comments]
    // Flatten replies
    for (const c of comments) {
      if (c.replies) {
        allComments.push(...c.replies)
      }
    }

    return allComments
      .filter((c) => c.timestamp_sec !== null)
      .map((c) => ({
        id: c.id,
        timestampSec: c.timestamp_sec!,
        type: "comment" as const,
        label: `${c.author?.full_name ?? "Usuário"}: ${c.content.slice(0, 50)}`,
        color: c.resolved ? "muted" : "blue",
      }))
  }, [comments])

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
