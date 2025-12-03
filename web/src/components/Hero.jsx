import React, { Suspense } from 'react';
import { Canvas } from '@react-three/fiber';
import { OrbitControls, useGLTF, Stage, Float } from '@react-three/drei';

function Model() {
  const { scene } = useGLTF('/cercasco-helmet.glb');
  return <primitive object={scene} />;
}

export default function Hero() {
  return (
    <section className="w-full min-h-screen flex flex-col md:flex-row items-center justify-between px-6 md:px-20 pt-20 gap-10">
      {/* COLUMNA IZQUIERDA: Tarjeta de Cristal */}
      <div className="w-full md:w-1/2 z-20">
        <div className="bg-[#0b022d]/60 backdrop-blur-xl border border-[#00c6ff]/30 p-8 md:p-12 rounded-3xl shadow-[0_0_50px_rgba(0,198,255,0.1)] relative overflow-hidden group">
          {/* Decoración de brillo en hover */}
          <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-transparent via-[#00c6ff] to-transparent opacity-50 group-hover:opacity-100 transition-opacity"></div>

          <h4 className="text-[#00c6ff] font-bold tracking-widest uppercase text-sm mb-4">
            Proyecto IoT & Hardware
          </h4>

          <h1 className="text-5xl md:text-6xl font-black text-white mb-6 leading-tight drop-shadow-[0_0_15px_rgba(0,198,255,0.5)]">
            CER
            <span className="text-transparent bg-clip-text bg-gradient-to-r from-[#00c6ff] to-[#0072ff]">
              CASCO
            </span>
          </h1>

          <p className="text-lg text-gray-300 mb-8 leading-relaxed">
            Integración de sensores, monitoreo en la nube y seguridad activa. La
            evolución del casco tradicional a un asistente de vida.
          </p>

          <div className="flex flex-wrap gap-4 items-center">
            <a
              href="https://github.com/luvaldev/cercasco"
              target="_blank"
              rel="noopener noreferrer"
              className="bg-[#00c6ff] text-[#0b022d] px-6 py-3 rounded-xl font-bold hover:shadow-[0_0_20px_rgba(0,198,255,0.6)] transition-all duration-300 flex items-center gap-2">
              <svg
                height="20"
                width="20"
                viewBox="0 0 16 16"
                fill="currentColor">
                <path d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013 8.013 0 0016 8c0-4.42-3.58-8-8-8z"></path>
              </svg>
              Código Fuente
            </a>

            <div className="flex -space-x-3">
              {/* Simulando avatares o iniciales del equipo */}
              {['M', 'L', 'G', 'E'].map((initial, i) => (
                <div
                  key={i}
                  className="w-10 h-10 rounded-full bg-gray-800 border-2 border-[#0b022d] flex items-center justify-center text-xs font-bold text-gray-400"
                  title="Miembro del equipo">
                  {initial}
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>

      {/* COLUMNA DERECHA: Modelo Flotando Libre */}
      <div className="w-full md:w-1/2 h-[50vh] md:h-[80vh] relative z-10">
        <Canvas camera={{ position: [0, 0, 14], fov: 40 }}>
          <Suspense fallback={null}>
            <Stage environment="city" intensity={0.6}>
              {/* Float añadido para movimiento orgánico */}
              <Float speed={2} rotationIntensity={0.2} floatIntensity={0.5}>
                <Model />
              </Float>
            </Stage>
            <OrbitControls autoRotate enableZoom={false} />
          </Suspense>
        </Canvas>

        {/* Indicador sutil */}
        <div className="absolute bottom-10 right-10 text-white/30 text-xs uppercase tracking-widest animate-pulse pointer-events-none">
          /// Sistema Cercasco v1.0
        </div>
      </div>
    </section>
  );
}
