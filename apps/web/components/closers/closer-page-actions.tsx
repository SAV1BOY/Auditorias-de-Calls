"use client"

import { useState } from "react"
import { Button } from "@/components/ui/button"
import { Plus } from "lucide-react"
import { CloserFormDialog } from "./closer-form-dialog"

export function CloserPageActions() {
  const [createOpen, setCreateOpen] = useState(false)

  return (
    <>
      <Button onClick={() => setCreateOpen(true)}>
        <Plus className="mr-1 h-4 w-4" />
        Novo Closer
      </Button>
      <CloserFormDialog
        open={createOpen}
        onOpenChange={setCreateOpen}
      />
    </>
  )
}
