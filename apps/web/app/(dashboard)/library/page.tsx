import { getBookmarkedCalls } from "@/lib/actions/bookmarks"
import { getClosers } from "@/lib/actions/calls"
import { LibraryContent } from "@/components/library/library-content"

export default async function LibraryPage() {
  const [bookmarks, closers] = await Promise.all([
    getBookmarkedCalls({}),
    getClosers(),
  ])

  // Collect all unique tags from bookmarks
  const allTags = Array.from(
    new Set(bookmarks.flatMap((b) => b.tags))
  ).sort()

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold">Biblioteca de Calls Modelo</h1>
        <p className="text-muted-foreground">
          Calls exemplares selecionadas para treinamento
        </p>
      </div>

      <LibraryContent
        initialBookmarks={bookmarks}
        closers={closers}
        allTags={allTags}
      />
    </div>
  )
}
