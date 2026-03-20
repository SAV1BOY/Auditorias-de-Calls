import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { getClosersList } from "@/lib/actions/closers"
import { getGoals } from "@/lib/actions/analytics"
import { ClosersComparison } from "@/components/analytics/closers-comparison"
import { DimensionTrends } from "@/components/analytics/dimension-trends"
import { GoalsDashboard } from "@/components/analytics/goals-dashboard"

export default async function AnalyticsPage() {
  const [closers, goals] = await Promise.all([getClosersList(), getGoals()])

  return (
    <div className="space-y-6">
      <h1 className="text-2xl font-bold">Analytics</h1>

      <Tabs defaultValue="comparativo" className="space-y-4">
        <TabsList className="flex w-full sm:w-auto overflow-x-auto">
          <TabsTrigger value="comparativo" className="flex-1 sm:flex-none">
            Comparativo
          </TabsTrigger>
          <TabsTrigger value="tendencias" className="flex-1 sm:flex-none">
            Tendências
          </TabsTrigger>
          <TabsTrigger value="metas" className="flex-1 sm:flex-none">
            Metas
          </TabsTrigger>
        </TabsList>

        <TabsContent value="comparativo">
          <ClosersComparison closers={closers} />
        </TabsContent>

        <TabsContent value="tendencias">
          <DimensionTrends closers={closers} />
        </TabsContent>

        <TabsContent value="metas">
          <GoalsDashboard goals={goals} closers={closers} />
        </TabsContent>
      </Tabs>
    </div>
  )
}
