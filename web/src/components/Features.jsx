import React, { Suspense } from 'react';
import { Canvas } from '@react-three/fiber';
import { OrbitControls, useGLTF, Stage } from '@react-three/drei';

/* Modelo del Circuito */
function CircuitModel() {
  const { scene } = useGLTF('/cercasco-circuito.glb');
  return <primitive object={scene} />;
}

export default function Features() {
  return (
    <section className="py-28 relative overflow-hidden" id="features">
      <div className="container-custom">
        <h2 className="section-title">Ingeniería Interior</h2>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
          {/* --- COLUMNA IZQUIERDA: TEXTO TÉCNICO --- */}
          <div className="glass-card">
            <h3 className="text-3xl font-bold text-accent mb-6">
              Arquitectura de Hardware
            </h3>
            <p className="text-gray-300 mb-6 text-lg">
              Cercasco opera mediante un sistema distribuido de{' '}
              <strong className="text-white">Hub & Spoke</strong> para máxima
              eficiencia y seguridad.
            </p>

            <ul className="space-y-6 list-none p-0 m-0">
              <li>
                <strong className="text-accent text-xl block mb-2">
                  1. ESP32-CAM (Visión):
                </strong>
                <span className="text-gray-400 text-base block leading-relaxed">
                  Procesamiento de imagen en tiempo real para detección de
                  vehículos trasera.
                </span>
              </li>

              <li>
                <strong className="text-accent text-xl block mb-2">
                  2. Sensores de Distancia:
                </strong>
                <span className="text-gray-400 text-base block leading-relaxed">
                  Tecnología Ultrasónica/ToF para medición precisa de proximidad
                  hasta 6 metros.
                </span>
              </li>

              <li>
                <strong className="text-accent text-xl block mb-2">
                  3. Hub de Alertas:
                </strong>
                <span className="text-gray-400 text-base block leading-relaxed">
                  Microcontrolador central que gestiona la lógica de riesgo y
                  activa vibraciones y luces LED RGB.
                </span>
              </li>
            </ul>
          </div>

          {/* --- COLUMNA DERECHA: VISOR 3D DEL CIRCUITO --- */}
          <div className="flex flex-col items-center w-full">
            {/* Caja estilo Neón/Glass similar al Hero */}
            <div className="w-full h-[500px] bg-white/5 backdrop-blur-sm rounded-3xl border border-accent/20 shadow-[0_0_40px_rgba(0,198,255,0.1)] overflow-hidden relative">
              {/* AJUSTE DE CÁMARA: [0, 10, 30] aleja la cámara significativamente */}
              <Canvas camera={{ position: [0, 10, 30], fov: 40 }}>
                <Suspense fallback={null}>
                  {/* adjustCamera={false} es CLAVE para que Stage respete nuestra posición manual */}
                  <Stage
                    environment="city"
                    intensity={0.5}
                    adjustCamera={false}>
                    <CircuitModel />
                  </Stage>

                  <OrbitControls
                    autoRotate
                    autoRotateSpeed={1.0}
                    enableZoom={
                      false
                    } /* IMPORTANTE: Esto permite hacer scroll en la página sin quedarse atascado en el 3D */
                    enablePan={false}
                    minPolarAngle={Math.PI / 4}
                    maxPolarAngle={Math.PI / 2}
                  />
                </Suspense>
              </Canvas>
            </div>

            <span className="text-sm text-accent mt-4 font-medium opacity-80 tracking-widest uppercase">
              (Explora el circuito en 3D)
            </span>
          </div>
        </div>
      </div>
    </section>
  );
}
