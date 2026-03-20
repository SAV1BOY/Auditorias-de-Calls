"use client"

import { useEffect, useRef, useState } from "react"
import { createClient } from "@/lib/supabase/client"

interface AudioPlayerProps {
  audioPath: string | null
}

export function AudioPlayer({ audioPath }: AudioPlayerProps) {
  const audioRef = useRef<HTMLAudioElement>(null)
  const [src, setSrc] = useState<string | null>(null)
  const [error, setError] = useState(false)

  useEffect(() => {
    if (!audioPath) return

    const supabase = createClient()

    // Private bucket — use signed URL (1h expiry)
    supabase.storage
      .from("audios")
      .createSignedUrl(audioPath, 3600)
      .then(({ data: signed, error: signError }) => {
        if (signError || !signed?.signedUrl) {
          setError(true)
          return
        }
        setSrc(signed.signedUrl)
      })
  }, [audioPath])

  if (!audioPath) {
    return null
  }

  if (error) {
    return (
      <div className="rounded border p-3 text-sm text-muted-foreground">
        Não foi possível carregar o áudio.
      </div>
    )
  }

  if (!src) {
    return (
      <div className="rounded border p-3 text-sm text-muted-foreground animate-pulse">
        Carregando áudio...
      </div>
    )
  }

  return (
    <div className="rounded border p-3">
      <audio ref={audioRef} controls className="w-full" preload="metadata">
        <source src={src} />
        Seu navegador não suporta o elemento de áudio.
      </audio>
    </div>
  )
}
