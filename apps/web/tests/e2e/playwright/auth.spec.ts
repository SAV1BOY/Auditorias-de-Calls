import { test, expect } from "@playwright/test"

test.describe("Authentication", () => {
  test("should redirect unauthenticated users to login", async ({ page }) => {
    await page.goto("/")
    await expect(page).toHaveURL(/\/login/)
  })

  test("should show login form with email and password fields", async ({ page }) => {
    await page.goto("/login")
    await expect(page.getByLabel(/email/i)).toBeVisible()
    await expect(page.getByLabel(/senha/i)).toBeVisible()
    await expect(page.getByRole("button", { name: /entrar/i })).toBeVisible()
  })

  test("should show error on invalid credentials", async ({ page }) => {
    await page.goto("/login")
    await page.getByLabel(/email/i).fill("invalid@example.com")
    await page.getByLabel(/senha/i).fill("wrongpassword")
    await page.getByRole("button", { name: /entrar/i }).click()
    await expect(page.getByText(/inválid|erro|incorrect/i)).toBeVisible({ timeout: 5000 })
  })

  test("should show the login page title", async ({ page }) => {
    await page.goto("/login")
    await expect(page.getByText(/CallAudit|Login|Entrar/i)).toBeVisible()
  })
})
