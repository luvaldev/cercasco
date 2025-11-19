import React, { Suspense } from 'react';
import { Canvas } from '@react-three/fiber';
import { OrbitControls, useGLTF, Environment, Stage } from '@react-three/drei';

/* Componente que carga el modelo */
function Model() {
  const { scene } = useGLTF('/cercasco-helmet.glb');
  return <primitive object={scene} />;
}

export default function Hero() {
  return (
    <section className="hero">
      {/* --- COLUMNA IZQUIERDA (TEXTO) --- */}
      <div className="hero-text-content">
        <h1>CERCASCO</h1>
        <p>“Más seguridad, más confianza, más ciclismo.”</p>

        {/* Caja de Integrantes */}
        <div className="hero-team">
          <h4>Equipo de Desarrollo</h4>
          <ul>
            <li>Matías Vigneau</li>
            <li>Luis Valdenegro</li>
            <li>Gabriel González</li>
            <li>Ezequiel Morales</li>
          </ul>
        </div>

        {/* --- NUEVO BOTÓN DE GITHUB --- */}
        <a
          href="https://github.com/luvaldev/cercasco"
          target="_blank"
          rel="noopener noreferrer"
          className="hero-button">
          <svg
            height="24"
            width="24"
            viewBox="0 0 16 16"
            fill="currentColor"
            style={{ marginRight: '10px' }}>
            <path d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013 8.013 0 0016 8c0-4.42-3.58-8-8-8z"></path>
          </svg>
          Documentación del Proyecto
        </a>
      </div>

      {/* --- COLUMNA DERECHA (VISOR 3D) --- */}
      <div className="hero-canvas-container">
        <div className="hero-canvas-box">
          <Canvas camera={{ position: [0, 5, 15], fov: 35 }}>
            <Suspense fallback={null}>
              <Stage environment="city" intensity={0.6} adjustCamera={false}>
                <Model />
              </Stage>
              <OrbitControls
                enableZoom={false}
                enablePan={false}
                autoRotate
                autoRotateSpeed={1.0}
                minPolarAngle={Math.PI / 4}
                maxPolarAngle={Math.PI / 2}
              />
            </Suspense>
          </Canvas>
        </div>

        <span className="hero-instructions">
          (Arrastra el modelo para rotar)
        </span>
      </div>
    </section>
  );
}
