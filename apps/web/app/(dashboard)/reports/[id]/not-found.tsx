import Link from "next/link"

export default function NotFound() {
  return (
    <div className="flex items-center justify-center py-20">
      <div className="text-center space-y-4 max-w-md">
        <span className="material-symbols-outlined text-5xl text-stone-600 block">search_off</span>
        <h2 className="text-xl font-headline font-bold">Não encontrado</h2>
        <p className="text-stone-500">O recurso solicitado não existe ou foi removido.</p>
        <Link
          href="/"
          className="inline-flex items-center gap-2 bg-[#ffa600] text-[#2a1800] px-6 py-3 rounded-lg font-headline font-bold text-xs tracking-widest uppercase hover:brightness-110 transition-all"
        >
          <span className="material-symbols-outlined text-sm">arrow_back</span>
          Voltar ao Dashboard
        </Link>
      </div>
    </div>
  )
}

