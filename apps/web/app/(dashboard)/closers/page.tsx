"use client"

import { useEffect, useState } from "react"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import { Plus, Users } from "lucide-react"
import type { CloserRow } from "@/lib/types/audit"
import { getClosersList } from "@/lib/actions/closers"
import { CloserList } from "@/components/closers/closer-list"
import { CloserFormDialog } from "@/components/closers/closer-form-dialog"

export default function ClosersPage() {
  const [closers, setClosers] = useState<CloserRow[]>([])
  const [createOpen, setCreateOpen] = useState(false)

  useEffect(() => {
    getClosersList().then(setClosers)
  }, [createOpen])

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <h1 className="flex items-center gap-2 text-2xl font-bold">
          <Users className="h-6 w-6" />
          Closers
        </h1>
        <Button onClick={() => setCreateOpen(true)}>
          <Plus className="mr-1 h-4 w-4" />
          Novo Closer
        </Button>
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-base">
            {closers.length} closer{closers.length !== 1 ? "s" : ""} cadastrado
            {closers.length !== 1 ? "s" : ""}
          </CardTitle>
        </CardHeader>
        <CardContent>
          <CloserList closers={closers} />
        </CardContent>
      </Card>

      <CloserFormDialog
        open={createOpen}
        onOpenChange={setCreateOpen}
      />
    </div>
  )
}
