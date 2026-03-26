"use client"

import { useState } from "react"
import { AmberGlassButton } from "@/components/ui/amber-glass-button"
import { Plus } from "lucide-react"
import { CloserFormDialog } from "./closer-form-dialog"

export function CloserPageActions() {
  const [createOpen, setCreateOpen] = useState(false)

  return (
    <>
      <AmberGlassButton onClick={() => setCreateOpen(true)}>
        <Plus className="mr-1 h-4 w-4" />
        Novo Closer
      </AmberGlassButton>
      <CloserFormDialog
        open={createOpen}
        onOpenChange={setCreateOpen}
      />
    </>
  )
}
