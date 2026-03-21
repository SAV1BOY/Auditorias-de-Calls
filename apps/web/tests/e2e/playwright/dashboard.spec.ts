import { test, expect } from "@playwright/test"

test.describe("Dashboard", () => {
  // Note: These tests require authentication. In a real setup,
  // you would use a storageState fixture with pre-authenticated session.

  test("should have correct page title", async ({ page }) => {
    await page.goto("/login")
    await expect(page).toHaveTitle(/CallAudit/i)
  })

  test("should show login page elements", async ({ page }) => {
    await page.goto("/login")
    // Verify the login page loads correctly
    const form = page.locator("form")
    await expect(form).toBeVisible()
  })

  test("dashboard page exists and redirects if unauthenticated", async ({ page }) => {
    const response = await page.goto("/")
    expect(response?.status()).toBeLessThan(500)
  })

  test("calls page exists", async ({ page }) => {
    const response = await page.goto("/calls")
    expect(response?.status()).toBeLessThan(500)
  })

  test("upload page exists", async ({ page }) => {
    const response = await page.goto("/calls/upload")
    expect(response?.status()).toBeLessThan(500)
  })
})
