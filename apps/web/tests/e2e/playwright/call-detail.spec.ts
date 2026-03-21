import { test, expect } from "@playwright/test"

test.describe("Call Detail", () => {
  test("should redirect non-existent call gracefully", async ({ page }) => {
    const response = await page.goto("/calls/00000000-0000-0000-0000-000000000000")
    // Should not crash with 500
    expect(response?.status()).toBeLessThan(500)
  })

  test("call detail page structure", async ({ page }) => {
    await page.goto("/calls/00000000-0000-0000-0000-000000000000")
    // Should either redirect to login or show error/not found
    const url = page.url()
    expect(url).toMatch(/\/(login|calls)/)
  })

  test("reports page returns valid response", async ({ page }) => {
    const response = await page.goto("/reports")
    expect(response?.status()).toBeLessThan(500)
  })

  test("library page returns valid response", async ({ page }) => {
    const response = await page.goto("/library")
    expect(response?.status()).toBeLessThan(500)
  })
})
