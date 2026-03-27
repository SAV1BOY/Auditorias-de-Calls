"use client"

import { useCallback, useState } from "react"
import { useRouter } from "next/navigation"
import { useDropzone } from "react-dropzone"
import { Upload, X, FileAudio, FileText, Loader2 } from "lucide-react"

import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { uploadCall, uploadTranscription } from "@/lib/actions/upload"
import { AUDIO_FORMATS, TRANSCRIPTION_FORMATS, MAX_FILE_SIZE_MB, MAX_TRANSCRIPTION_FILE_SIZE_MB } from "@/lib/utils/constants"

type Closer = {
  id: string
  name: string
}

interface UploadFormProps {
  closers: Closer[]
}

const AUDIO_ACCEPT_MAP: Record<string, string[]> = {
  "audio/ogg": [".ogg"],
  "audio/mpeg": [".mp3"],
  "audio/mp4": [".mp4"],
  "audio/webm": [".webm"],
  "audio/wav": [".wav"],
  "audio/x-m4a": [".m4a"],
}

const TRANSCRIPTION_ACCEPT_MAP: Record<string, string[]> = {
  "text/markdown": [".md"],
  "text/plain": [".txt"],
  "application/pdf": [".pdf"],
  "application/vnd.openxmlformats-officedocument.wordprocessingml.document": [".docx"],
}

const RESULTADO_OPTIONS = [
  { value: "fechamento", label: "Fechamento" },
  { value: "nao_fechou", label: "Não Fechou" },
  { value: "reagendar", label: "Reagendar" },
  { value: "outro", label: "Outro" },
]

type UploadMode = "audio" | "transcription"

export function UploadForm({ closers }: UploadFormProps) {
  const router = useRouter()
  const [mode, setMode] = useState<UploadMode>("audio")
  const [file, setFile] = useState<File | null>(null)
  const [closerId, setCloserId] = useState("")
  const [leadName, setLeadName] = useState("")
  const [callDate, setCallDate] = useState(new Date().toISOString().split("T")[0])
  const [resultado, setResultado] = useState("")
  const [valorFechamento, setValorFechamento] = useState("")
  const [error, setError] = useState("")
  const [isUploading, setIsUploading] = useState(false)
  const [progress, setProgress] = useState(0)

  const isAudio = mode === "audio"
  const acceptMap = isAudio ? AUDIO_ACCEPT_MAP : TRANSCRIPTION_ACCEPT_MAP
  const maxSize = isAudio ? MAX_FILE_SIZE_MB : MAX_TRANSCRIPTION_FILE_SIZE_MB
  const formats = isAudio ? AUDIO_FORMATS : TRANSCRIPTION_FORMATS

  const onDrop = useCallback((acceptedFiles: File[]) => {
    setError("")
    if (acceptedFiles.length > 0) {
      const f = acceptedFiles[0]
      if (f.size > maxSize * 1024 * 1024) {
        setError(`Arquivo muito grande. Máximo: ${maxSize} MB.`)
        return
      }
      setFile(f)
    }
  }, [maxSize])

  const { getRootProps, getInputProps, isDragActive } = useDropzone({
    onDrop,
    accept: acceptMap,
    maxFiles: 1,
    multiple: false,
  })

  function switchMode(newMode: UploadMode) {
    setMode(newMode)
    setFile(null)
    setError("")
  }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setError("")

    if (!file) {
      setError(isAudio ? "Selecione um arquivo de áudio." : "Selecione um arquivo de transcrição.")
      return
    }
    if (!closerId) {
      setError("Selecione um closer.")
      return
    }
    if (!leadName.trim()) {
      setError("Nome do lead é obrigatório.")
      return
    }

    setIsUploading(true)
    setProgress(10)

    try {
      const formData = new FormData()
      formData.append("file", file)
      formData.append("closerId", closerId)
      formData.append("leadName", leadName)
      formData.append("callDate", callDate)
      if (resultado) formData.append("resultado", resultado)
      if (valorFechamento) formData.append("valorFechamento", valorFechamento)

      setProgress(30)
      const result = isAudio
        ? await uploadCall(formData)
        : await uploadTranscription(formData)
      setProgress(90)

      if (result.error) {
        setError(result.error)
        setIsUploading(false)
        setProgress(0)
        return
      }

      setProgress(100)
      router.push("/calls")
    } catch {
      setError("Erro inesperado. Tente novamente.")
      setIsUploading(false)
      setProgress(0)
    }
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-6">
      {/* Mode Toggle */}
      <div className="flex gap-2 p-1 bg-[#292a2d] rounded-lg w-fit">
        <button
          type="button"
          onClick={() => switchMode("audio")}
          className={`px-4 py-2 rounded-md text-xs font-bold tracking-widest uppercase transition-all ${
            isAudio
              ? "bg-[#ffa600] text-[#2a1800]"
              : "text-stone-400 hover:text-stone-200"
          }`}
        >
          <FileAudio className="inline mr-1.5 h-4 w-4" />
          Áudio
        </button>
        <button
          type="button"
          onClick={() => switchMode("transcription")}
          className={`px-4 py-2 rounded-md text-xs font-bold tracking-widest uppercase transition-all ${
            !isAudio
              ? "bg-[#ffa600] text-[#2a1800]"
              : "text-stone-400 hover:text-stone-200"
          }`}
        >
          <FileText className="inline mr-1.5 h-4 w-4" />
          Transcrição
        </button>
      </div>

      {/* Dropzone */}
      <div>
        <Label>{isAudio ? "Áudio da Call" : "Arquivo de Transcrição"}</Label>
        <div
          {...getRootProps()}
          className={`mt-2 flex flex-col items-center justify-center rounded-lg border-2 border-dashed p-8 transition-colors cursor-pointer
            ${isDragActive ? "border-primary bg-primary/5" : "border-muted-foreground/25 hover:border-primary/50"}
            ${file ? "bg-muted/50" : ""}`}
        >
          <input {...getInputProps()} />
          {file ? (
            <div className="flex items-center gap-3">
              {isAudio ? (
                <FileAudio className="h-8 w-8 text-primary" />
              ) : (
                <FileText className="h-8 w-8 text-primary" />
              )}
              <div>
                <p className="font-medium">{file.name}</p>
                <p className="text-sm text-muted-foreground">
                  {(file.size / (1024 * 1024)).toFixed(1)} MB
                </p>
              </div>
              <Button
                type="button"
                variant="ghost"
                size="sm"
                onClick={(e) => {
                  e.stopPropagation()
                  setFile(null)
                }}
              >
                <X className="h-4 w-4" />
              </Button>
            </div>
          ) : (
            <>
              {isAudio ? (
                <Upload className="h-10 w-10 text-muted-foreground mb-2" />
              ) : (
                <FileText className="h-10 w-10 text-muted-foreground mb-2" />
              )}
              <p className="text-sm text-muted-foreground text-center">
                {isAudio
                  ? "Arraste o áudio aqui ou clique para selecionar"
                  : "Arraste a transcrição aqui ou clique para selecionar"}
              </p>
              <p className="text-xs text-muted-foreground mt-1">
                Formatos: {formats.join(", ")} — Máx: {maxSize} MB
              </p>
            </>
          )}
        </div>
      </div>

      {/* Closer + Lead Name */}
      <div className="grid gap-4 md:grid-cols-2">
      <div>
        <Label htmlFor="closerId">Closer</Label>
        <select
          id="closerId"
          value={closerId}
          onChange={(e) => setCloserId(e.target.value)}
          className="mt-1 flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring"
        >
          <option value="">Selecione um closer...</option>
          {closers.map((c) => (
            <option key={c.id} value={c.id}>
              {c.name}
            </option>
          ))}
        </select>
      </div>

      <div>
        <Label htmlFor="leadName">Nome do Lead</Label>
        <Input
          id="leadName"
          value={leadName}
          onChange={(e) => setLeadName(e.target.value)}
          placeholder="Ex: Elane Lima"
          className="mt-1"
        />
      </div>
      </div>

      {/* Call Date + Resultado */}
      <div className="grid gap-4 md:grid-cols-2">
      <div>
        <Label htmlFor="callDate">Data da Call</Label>
        <Input
          id="callDate"
          type="date"
          value={callDate}
          onChange={(e) => setCallDate(e.target.value)}
          className="mt-1"
        />
      </div>

      <div>
        <Label>Resultado</Label>
        <div className="mt-2 flex flex-wrap gap-3">
          {RESULTADO_OPTIONS.map((opt) => (
            <label key={opt.value} className="flex items-center gap-2 cursor-pointer">
              <input
                type="radio"
                name="resultado"
                value={opt.value}
                checked={resultado === opt.value}
                onChange={(e) => setResultado(e.target.value)}
                className="h-4 w-4 text-primary"
              />
              <span className="text-sm">{opt.label}</span>
            </label>
          ))}
        </div>
      </div>
      </div>

      {/* Valor Fechamento (conditional, audio only) */}
      {resultado === "fechamento" && isAudio && (
        <div>
          <Label htmlFor="valorFechamento">Valor do Fechamento (R$)</Label>
          <Input
            id="valorFechamento"
            type="number"
            step="0.01"
            min="0"
            value={valorFechamento}
            onChange={(e) => setValorFechamento(e.target.value)}
            placeholder="Ex: 5000.00"
            className="mt-1"
          />
        </div>
      )}

      {/* Info banner for transcription mode */}
      {!isAudio && (
        <div className="rounded-lg bg-[#ffa600]/5 border border-[#ffa600]/20 p-3">
          <p className="text-xs text-[#d8c3ac]">
            A transcrição será enviada diretamente para análise, sem transcrição por IA.
            Use arquivos .md ou .txt para melhor resultado.
          </p>
        </div>
      )}

      {/* Progress bar */}
      {isUploading && (
        <div className="w-full bg-muted rounded-full h-2">
          <div
            className="bg-primary h-2 rounded-full transition-all duration-300"
            style={{ width: `${progress}%` }}
          />
        </div>
      )}

      {/* Error */}
      {error && (
        <p className="text-sm text-destructive">{error}</p>
      )}

      {/* Submit */}
      <Button type="submit" disabled={isUploading} className="w-full">
        {isUploading ? (
          <>
            <Loader2 className="mr-2 h-4 w-4 animate-spin" />
            Enviando...
          </>
        ) : (
          <>
            <Upload className="mr-2 h-4 w-4" />
            {isAudio ? "Enviar Call para Auditoria" : "Enviar Transcrição para Análise"}
          </>
        )}
      </Button>
    </form>
  )
}
