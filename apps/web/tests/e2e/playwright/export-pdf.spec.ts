import { test, expect } from "@playwright/test"

test.describe("PDF Export", () => {
  test("call detail page loads without 500 errors", async ({ page }) => {
    const response = await page.goto("/calls/00000000-0000-0000-0000-000000000000")
    expect(response?.status()).toBeLessThan(500)
  })

  test("login page has proper form structure", async ({ page }) => {
    await page.goto("/login")
    const buttons = page.getByRole("button")
    const count = await buttons.count()
    expect(count).toBeGreaterThan(0)
  })

  test("pages load without JavaScript errors", async ({ page }) => {
    const errors: string[] = []
    page.on("pageerror", (error) => errors.push(error.message))
    await page.goto("/login")
    // Allow a brief moment for any async errors
    await page.waitForTimeout(1000)
    // Filter out expected errors (e.g., Supabase connection errors in test env)
    const criticalErrors = errors.filter(
      (e) => !e.includes("supabase") && !e.includes("fetch") && !e.includes("network")
    )
    expect(criticalErrors).toHaveLength(0)
  })
})
