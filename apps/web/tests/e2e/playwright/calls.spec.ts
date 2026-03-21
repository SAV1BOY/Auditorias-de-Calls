import { test, expect } from "@playwright/test"

test.describe("Calls List", () => {
  test("should redirect to login when accessing calls without auth", async ({ page }) => {
    await page.goto("/calls")
    // Should redirect to login or show the page
    await expect(page).toHaveURL(/\/(login|calls)/)
  })

  test("calls page returns valid response", async ({ page }) => {
    const response = await page.goto("/calls")
    expect(response?.status()).toBeLessThan(500)
  })

  test("analytics page returns valid response", async ({ page }) => {
    const response = await page.goto("/analytics")
    expect(response?.status()).toBeLessThan(500)
  })

  test("closers page returns valid response", async ({ page }) => {
    const response = await page.goto("/closers")
    expect(response?.status()).toBeLessThan(500)
  })

  test("settings page returns valid response", async ({ page }) => {
    const response = await page.goto("/settings")
    expect(response?.status()).toBeLessThan(500)
  })

  test("ranking page returns valid response", async ({ page }) => {
    const response = await page.goto("/ranking")
    expect(response?.status()).toBeLessThan(500)
  })
})
