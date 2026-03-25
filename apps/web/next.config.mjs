/** @type {import('next').NextConfig} */
const nextConfig = {
  poweredByHeader: false,
  compress: true,
  images: {
    formats: ["image/avif", "image/webp"],
  },
  async redirects() {
    return [
      { source: "/biblioteca", destination: "/library", permanent: true },
      { source: "/relatorios", destination: "/reports", permanent: true },
      { source: "/relatorios/:id", destination: "/reports/:id", permanent: true },
      { source: "/upload", destination: "/calls/upload", permanent: true },
      { source: "/configuracoes", destination: "/settings", permanent: true },
    ];
  },
  async headers() {
    return [
      {
        source: "/:path*",
        headers: [
          { key: "X-Content-Type-Options", value: "nosniff" },
          { key: "X-Frame-Options", value: "DENY" },
          { key: "Referrer-Policy", value: "strict-origin-when-cross-origin" },
          {
            key: "Strict-Transport-Security",
            value: "max-age=31536000; includeSubDomains",
          },
          {
            key: "Permissions-Policy",
            value: "camera=(), microphone=(), geolocation=(), browsing-topics=()",
          },
          // CSP is now set dynamically in middleware.ts with per-request nonce
        ],
      },
    ];
  },
};

export default nextConfig;
