import type { Config } from "tailwindcss"
import tailwindcssAnimate from "tailwindcss-animate"
import typography from "@tailwindcss/typography"
import forms from "@tailwindcss/forms"

const config: Config = {
  darkMode: ["class"],
  content: [
    "./pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./components/**/*.{js,ts,jsx,tsx,mdx}",
    "./app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      colors: {
        // M3 Color Tokens
        "on-surface-variant": "#d8c3ac",
        "surface-variant": "#343538",
        "surface-bright": "#38393c",
        "on-primary-fixed-variant": "#643f00",
        "on-secondary-fixed-variant": "#604100",
        "error-container": "#93000a",
        "on-surface": "#e3e2e5",
        "outline-variant": "#534433",
        "secondary-fixed-dim": "#ffba37",
        "secondary-fixed": "#ffdeac",
        "surface-container-lowest": "#0d0e11",
        "on-secondary": "#432c00",
        "on-primary-fixed": "#2a1800",
        "tertiary-fixed-dim": "#66d3ff",
        "secondary-container": "#fab000",
        "inverse-on-surface": "#2f3033",
        "primary-fixed": "#ffddb6",
        "on-primary": "#462a00",
        "surface-container-highest": "#343538",
        "outline": "#a08e79",
        "on-tertiary-container": "#005067",
        "primary-container": "#ffa600",
        "primary": "#ffcc8d",
        "tertiary-fixed": "#bde9ff",
        "surface-tint": "#ffb95a",
        "surface-container": "#1e2022",
        "secondary": "#ffd38f",
        "on-tertiary-fixed-variant": "#004d64",
        "on-secondary-fixed": "#281900",
        "on-primary-container": "#684100",
        "error": "#ffb4ab",
        "surface-dim": "#121316",
        "on-tertiary-fixed": "#001f2a",
        "surface-container-high": "#292a2d",
        "primary-fixed-dim": "#ffb95a",
        "inverse-surface": "#e3e2e5",
        "on-tertiary": "#003546",
        "on-secondary-container": "#684700",
        "inverse-primary": "#845400",
        "tertiary-container": "#00c8fe",
        "surface": "#121316",
        "background": "#121316",
        "on-error": "#690005",
        "tertiary": "#97deff",
        "on-background": "#e3e2e5",
        "surface-container-low": "#1a1c1e",
        "on-error-container": "#ffdad6",
        // Legacy aliases (used by shadcn/ui components from previous design system)
        "surface-interaction": "#292a2d",
        "surface-secondary": "#1a1c1e",
        "surface-highest": "#343538",
        "surface-base": "#121316",
        "primary-dim": "#c47f00",
        "primary-light": "#ffcc8d",
        // shadcn compatibility
        border: "hsl(var(--border))",
        input: "hsl(var(--input))",
        ring: "hsl(var(--ring))",
        foreground: "hsl(var(--foreground))",
        destructive: {
          DEFAULT: "hsl(var(--destructive))",
          foreground: "hsl(var(--destructive-foreground))",
        },
        muted: {
          DEFAULT: "hsl(var(--muted))",
          foreground: "hsl(var(--muted-foreground))",
        },
        accent: {
          DEFAULT: "hsl(var(--accent))",
          foreground: "hsl(var(--accent-foreground))",
        },
        popover: {
          DEFAULT: "hsl(var(--popover))",
          foreground: "hsl(var(--popover-foreground))",
        },
        card: {
          DEFAULT: "hsl(var(--card))",
          foreground: "hsl(var(--card-foreground))",
        },
      },
      fontFamily: {
        headline: ["var(--font-jakarta)", "Plus Jakarta Sans", "sans-serif"],
        body: ["var(--font-manrope)", "Manrope", "sans-serif"],
        label: ["var(--font-manrope)", "Manrope", "sans-serif"],
        mono: ["var(--font-jetbrains)", "JetBrains Mono", "monospace"],
        // shadcn compat aliases
        sans: ["var(--font-manrope)", "Manrope", "sans-serif"],
        display: ["var(--font-jakarta)", "Plus Jakarta Sans", "sans-serif"],
        technical: ["var(--font-manrope)", "Manrope", "sans-serif"],
      },
      borderRadius: {
        DEFAULT: "1rem",
        lg: "2rem",
        xl: "3rem",
        full: "9999px",
        md: "0.75rem",
        sm: "0.5rem",
      },
      boxShadow: {
        'panel': '0 40px 40px -10px rgba(0,0,0,0.4)',
        'amber-glow': '0 0 30px rgba(255,166,0,0.4)',
        'elevation-1': '0 1px 3px rgba(0,0,0,0.3)',
        'elevation-2': '0 4px 12px rgba(0,0,0,0.4)',
        'elevation-3': '0 8px 24px rgba(0,0,0,0.5)',
        'amber-sm': '0 0 10px rgba(255,166,0,0.08)',
        'amber-md': '0 0 20px rgba(255,166,0,0.12)',
      },
      animation: {
        'amber-pulse': 'amber-pulse 2s ease-in-out infinite',
      },
      keyframes: {
        'amber-pulse': {
          '0%, 100%': { opacity: '0.4' },
          '50%': { opacity: '1' },
        },
      },
    },
  },
  plugins: [tailwindcssAnimate, typography, forms],
}
export default config
