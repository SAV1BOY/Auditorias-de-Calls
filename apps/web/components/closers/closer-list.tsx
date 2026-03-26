"use client"

import { useState, useTransition } from "react"
import Link from "next/link"
import { useRouter } from "next/navigation"
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table"
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu"
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
} from "@/components/ui/alert-dialog"
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
import { Badge } from "@/components/ui/badge"
import { Button } from "@/components/ui/button"
import { useToast } from "@/components/ui/use-toast"
import { MoreHorizontal, Pencil, Eye, Power } from "lucide-react"
import type { CloserRow } from "@/lib/types/audit"
import { toggleCloserActive } from "@/lib/actions/closers"
import { CloserFormDialog } from "./closer-form-dialog"

interface CloserListProps {
  closers: CloserRow[]
  isAdmin?: boolean
}

export function CloserList({ closers, isAdmin = false }: CloserListProps) {
  const router = useRouter()
  const { toast } = useToast()
  const [isPending, startTransition] = useTransition()
  const [editCloser, setEditCloser] = useState<CloserRow | undefined>()
  const [editOpen, setEditOpen] = useState(false)
  const [toggleTarget, setToggleTarget] = useState<CloserRow | null>(null)

  function handleToggle() {
    if (!toggleTarget) return
    startTransition(async () => {
      const result = await toggleCloserActive(toggleTarget.id, !toggleTarget.active)
      if (result.error) {
        toast({ title: "Erro", description: result.error, variant: "destructive" })
      } else {
        toast({
          title: toggleTarget.active ? "Closer desativado" : "Closer ativado",
        })
        router.refresh()
      }
      setToggleTarget(null)
    })
  }

  return (
    <>
      <div className="overflow-x-auto">
      <Table>
        <TableHeader>
          <TableRow>
            <TableHead>Nome</TableHead>
            <TableHead className="hidden md:table-cell">Email</TableHead>
            <TableHead className="hidden md:table-cell">WhatsApp</TableHead>
            <TableHead>Status</TableHead>
            <TableHead className="w-10" />
          </TableRow>
        </TableHeader>
        <TableBody>
          {closers.length === 0 ? (
            <TableRow>
              <TableCell colSpan={5} className="text-center text-muted-foreground py-8">
                Nenhum closer cadastrado.
              </TableCell>
            </TableRow>
          ) : (
            closers.map((closer) => (
              <TableRow key={closer.id}>
                <TableCell>
                  <div className="flex items-center gap-2">
                    <Avatar className="h-8 w-8">
                      <AvatarImage src={closer.avatar_url ?? undefined} />
                      <AvatarFallback>
                        {closer.name.slice(0, 2).toUpperCase()}
                      </AvatarFallback>
                    </Avatar>
                    <span className="font-medium">{closer.name}</span>
                  </div>
                </TableCell>
                <TableCell className="hidden md:table-cell text-muted-foreground">
                  {closer.email ?? "—"}
                </TableCell>
                <TableCell className="hidden md:table-cell text-muted-foreground">
                  {closer.whatsapp ?? "—"}
                </TableCell>
                <TableCell>
                  <Badge variant={closer.active ? "default" : "secondary"}>
                    {closer.active ? "Ativo" : "Inativo"}
                  </Badge>
                </TableCell>
                <TableCell>
                  <DropdownMenu>
                    <DropdownMenuTrigger asChild>
                      <Button variant="ghost" size="sm">
                        <MoreHorizontal className="h-4 w-4" />
                      </Button>
                    </DropdownMenuTrigger>
                    <DropdownMenuContent align="end">
                      <DropdownMenuItem asChild>
                        <Link href={`/closers/${closer.id}`}>
                          <Eye className="mr-2 h-4 w-4" />
                          Ver Perfil
                        </Link>
                      </DropdownMenuItem>
                      <DropdownMenuItem
                        onClick={() => {
                          setEditCloser(closer)
                          setEditOpen(true)
                        }}
                      >
                        <Pencil className="mr-2 h-4 w-4" />
                        Editar
                      </DropdownMenuItem>
                      <DropdownMenuItem onClick={() => setToggleTarget(closer)}>
                        <Power className="mr-2 h-4 w-4" />
                        {closer.active ? "Desativar" : "Ativar"}
                      </DropdownMenuItem>
                    </DropdownMenuContent>
                  </DropdownMenu>
                </TableCell>
              </TableRow>
            ))
          )}
        </TableBody>
      </Table>
      </div>

      <CloserFormDialog
        closer={editCloser}
        open={editOpen}
        onOpenChange={(open) => {
          setEditOpen(open)
          if (!open) setEditCloser(undefined)
        }}
        isAdmin={isAdmin}
        notificationEmails={editCloser?.notification_emails ?? []}
      />

      <AlertDialog
        open={!!toggleTarget}
        onOpenChange={(open) => {
          if (!open) setToggleTarget(null)
        }}
      >
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>
              {toggleTarget?.active ? "Desativar" : "Ativar"} closer?
            </AlertDialogTitle>
            <AlertDialogDescription>
              {toggleTarget?.active
                ? `O closer "${toggleTarget?.name}" não aparecerá mais em novas auditorias.`
                : `O closer "${toggleTarget?.name}" voltará a aparecer em novas auditorias.`}
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogCancel>Cancelar</AlertDialogCancel>
            <AlertDialogAction onClick={handleToggle} disabled={isPending}>
              {isPending ? "Salvando..." : "Confirmar"}
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </>
  )
}
