import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Upload } from "lucide-react"

export default function UploadPage() {
  return (
    <Card>
      <CardHeader>
        <CardTitle className="flex items-center gap-2">
          <Upload className="h-5 w-5" />
          Upload de Call
        </CardTitle>
      </CardHeader>
      <CardContent>
        <p className="text-muted-foreground">
          Upload de gravações com drag & drop — disponível no Sprint 2.
        </p>
      </CardContent>
    </Card>
  )
}
