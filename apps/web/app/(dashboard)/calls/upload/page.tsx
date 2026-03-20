import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Upload } from "lucide-react"
import { createClient } from "@/lib/supabase/server"
import { UploadForm } from "@/components/upload/upload-form"

async function getClosers() {
  const supabase = await createClient()
  const { data } = await supabase
    .from("closers")
    .select("id, name")
    .eq("active", true)
    .order("name")

  return data ?? []
}

export default async function UploadPage() {
  const closers = await getClosers()

  return (
    <div className="mx-auto max-w-2xl">
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <Upload className="h-5 w-5" />
            Upload de Call
          </CardTitle>
          <CardDescription>
            Envie a gravação de uma call de fechamento para auditoria automática.
          </CardDescription>
        </CardHeader>
        <CardContent>
          <UploadForm closers={closers} />
        </CardContent>
      </Card>
    </div>
  )
}
