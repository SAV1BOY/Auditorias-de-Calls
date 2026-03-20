import Link from "next/link"
import { Button } from "@/components/ui/button"

export default function NotFound() {
  return (
    <div className="flex min-h-screen items-center justify-center p-4">
      <div className="text-center space-y-4 max-w-md">
        <h1 className="text-6xl font-bold text-muted-foreground">404</h1>
        <h2 className="text-xl font-semibold">Página não encontrada</h2>
        <p className="text-muted-foreground">
          A página que você procura não existe ou foi removida.
        </p>
        <Button asChild>
          <Link href="/">Voltar ao Dashboard</Link>
        </Button>
      </div>
    </div>
  )
}
