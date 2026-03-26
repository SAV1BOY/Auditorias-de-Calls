"use client"

import * as React from "react"
import { Slot } from "@radix-ui/react-slot"
import { cn } from "@/lib/utils"

interface AmberGlassButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  asChild?: boolean
  variant?: "default" | "icon"
}

export function AmberGlassButton({
  className,
  asChild = false,
  variant = "default",
  children,
  ...props
}: AmberGlassButtonProps) {
  const Comp = asChild ? Slot : "button"

  const baseClasses = variant === "icon"
    ? "w-16 h-16 rounded-full p-0 flex items-center justify-center"
    : "px-5 py-2.5 rounded-xl"

  return (
    <>
      <Comp
        className={cn(
          "relative inline-flex items-center justify-center gap-2 cursor-pointer",
          "text-sm font-bold tracking-widest uppercase",
          "text-[#ffa600] transition-all duration-300",
          "hover:scale-[1.03] hover:brightness-110",
          "active:scale-[0.97] active:brightness-90",
          "disabled:opacity-50 disabled:pointer-events-none",
          baseClasses,
          className
        )}
        {...props}
      >
        {/* Glass layer — inset shadows for depth */}
        <div
          className={cn(
            "absolute inset-0 z-0",
            variant === "icon" ? "rounded-full" : "rounded-xl",
          )}
          style={{
            boxShadow: [
              "0 0 8px rgba(255,166,0,0.08)",
              "0 2px 8px rgba(0,0,0,0.15)",
              "inset 2px 2px 1px -1.5px rgba(255,166,0,0.15)",
              "inset -2px -2px 1px -1.5px rgba(255,166,0,0.1)",
              "inset 0 0 8px 4px rgba(255,166,0,0.06)",
              "inset 0 0 2px 1px rgba(255,166,0,0.08)",
              "0 0 20px rgba(255,166,0,0.12)",
            ].join(", "),
          }}
        />

        {/* Backdrop distortion layer */}
        <div
          className={cn(
            "absolute inset-0 isolate -z-10 overflow-hidden",
            variant === "icon" ? "rounded-full" : "rounded-xl",
          )}
          style={{ backdropFilter: 'blur(12px) saturate(1.2) url("#amber-glass-filter")' }}
        />

        {/* Border glow */}
        <div
          className={cn(
            "absolute inset-0 z-0 border border-[#ffa600]/20",
            variant === "icon" ? "rounded-full" : "rounded-xl",
          )}
        />

        {/* Content */}
        <span className="relative z-10 flex items-center gap-2">
          {children}
        </span>

        <GlassFilter />
      </Comp>
    </>
  )
}

function GlassFilter() {
  return (
    <svg className="hidden" aria-hidden="true">
      <defs>
        <filter
          id="amber-glass-filter"
          x="0%"
          y="0%"
          width="100%"
          height="100%"
          colorInterpolationFilters="sRGB"
        >
          <feTurbulence
            type="fractalNoise"
            baseFrequency="0.04 0.04"
            numOctaves="1"
            seed="2"
            result="turbulence"
          />
          <feGaussianBlur in="turbulence" stdDeviation="2" result="blurredNoise" />
          <feDisplacementMap
            in="SourceGraphic"
            in2="blurredNoise"
            scale="50"
            xChannelSelector="R"
            yChannelSelector="B"
            result="displaced"
          />
          <feGaussianBlur in="displaced" stdDeviation="3" result="finalBlur" />
          <feComposite in="finalBlur" in2="finalBlur" operator="over" />
        </filter>
      </defs>
    </svg>
  )
}
