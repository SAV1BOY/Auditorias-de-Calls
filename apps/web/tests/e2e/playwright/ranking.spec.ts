import { test, expect } from "@playwright/test"

test.describe("Ranking Page", () => {
  test("ranking page returns valid response", async ({ page }) => {
    const response = await page.goto("/ranking")
    expect(response?.status()).toBeLessThan(500)
  })

  test("should redirect or show ranking page", async ({ page }) => {
    await page.goto("/ranking")
    await expect(page).toHaveURL(/\/(login|ranking)/)
  })

  test("all main routes return valid responses", async ({ page }) => {
    const routes = ["/", "/calls", "/analytics", "/closers", "/ranking", "/reports", "/settings", "/library"]
    for (const route of routes) {
      const response = await page.goto(route)
      expect(response?.status()).toBeLessThan(500)
    }
  })
})
