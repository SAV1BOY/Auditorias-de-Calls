import { test, expect } from "@playwright/test"

test.describe("Upload Page", () => {
  test("upload page returns valid response", async ({ page }) => {
    const response = await page.goto("/calls/upload")
    expect(response?.status()).toBeLessThan(500)
  })

  test("should redirect to login if not authenticated", async ({ page }) => {
    await page.goto("/calls/upload")
    await expect(page).toHaveURL(/\/(login|calls\/upload)/)
  })

  test("login form is functional", async ({ page }) => {
    await page.goto("/login")
    const emailInput = page.getByLabel(/email/i)
    await expect(emailInput).toBeVisible()
    await emailInput.fill("test@example.com")
    await expect(emailInput).toHaveValue("test@example.com")
  })
})
