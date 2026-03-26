"use client"

export function AnimatedBackgroundLines() {
  const lineWrapperTops = ["top-[10%]", "top-[30%]", "top-[50%]", "top-[70%]", "top-[90%]"]

  return (
    <>
      <style jsx global>{`
        @keyframes gridMove {
          0% { background-position: 0 0; }
          100% { background-position: 50px 50px; }
        }
        @keyframes lineMove {
          0% { transform: translateX(-100%); }
          100% { transform: translateX(100%); }
        }
        @keyframes cornerLineAnimation {
          0% { stroke-dashoffset: 0; }
          25% { stroke-dashoffset: 100; }
          50% { stroke-dashoffset: 200; }
          75% { stroke-dashoffset: 300; }
          100% { stroke-dashoffset: 400; }
        }
      `}</style>

      {/* Grid Background */}
      <div
        className="absolute inset-0 w-full h-full z-0"
        style={{
          backgroundImage:
            "linear-gradient(rgba(255,149,0,0.07) 1px, transparent 1px), linear-gradient(90deg, rgba(255,149,0,0.07) 1px, transparent 1px)",
          backgroundSize: "50px 50px",
          animation: "gridMove 20s linear infinite",
        }}
      />

      {/* Animated Lines */}
      <div className="absolute inset-0 w-full h-full overflow-hidden z-[1]">
        {lineWrapperTops.map((topClass, index) => (
          <div key={index} className={`absolute w-full h-[100px] ${topClass}`}>
            <div className="w-full h-0.5 relative overflow-hidden">
              <div
                className="absolute top-0 w-full h-full"
                style={{
                  background:
                    "linear-gradient(90deg, transparent 0%, #ff9500 20%, #ffd700 50%, #ff9500 80%, transparent 100%)",
                  animation: `lineMove 4s linear infinite${index % 2 !== 0 ? " reverse" : ""}`,
                  animationDelay: index % 2 !== 0 ? "2s" : "0s",
                }}
              />
            </div>
          </div>
        ))}
      </div>

      {/* Corner Lines */}
      <div className="hidden md:block absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[300px] h-[100px] z-[5]">
        <svg
          className="absolute top-1/2 -translate-y-1/2 left-[-150px] w-[120px] h-[60px]"
          viewBox="0 0 120 60"
          stroke="#ff9500"
          strokeWidth="2"
          fill="none"
          strokeDasharray="50"
          style={{ animation: "cornerLineAnimation 6s linear infinite" }}
        >
          <path d="M120 0 L20 0 Q0 0 0 20 L0 60" />
        </svg>
        <svg
          className="absolute top-1/2 -translate-y-1/2 right-[-150px] w-[120px] h-[60px] scale-x-[-1]"
          viewBox="0 0 120 60"
          stroke="#ff9500"
          strokeWidth="2"
          fill="none"
          strokeDasharray="50"
          style={{ animation: "cornerLineAnimation 6s linear infinite", animationDelay: "3s" }}
        >
          <path d="M120 0 L20 0 Q0 0 0 20 L0 60" />
        </svg>
      </div>
    </>
  )
}
