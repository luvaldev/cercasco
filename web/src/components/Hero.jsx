import React, { Suspense } from 'react';
import { Canvas } from '@react-three/fiber';
import { OrbitControls, useGLTF, Environment } from '@react-three/drei';

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
        <h1>Cercasco</h1>
        <p>“Más seguridad, más confianza, más ciclismo.”</p>

        {/* La "caja negra" de tu dibujo (Integrantes) */}
        <div className="hero-team glass-card">
          <h4>Integrantes del Proyecto</h4>
          <ul>
            <li>Matías Vigneau</li>
            <li>Luis Valdenegro</li>
            <li>Gabriel González</li>
            <li>Ezequiel Morales</li>
          </ul>
        </div>
      </div>

      {/* --- COLUMNA DERECHA (VISOR 3D) --- */}
      <div className="hero-canvas-container">
        {/* La "caja azul" de tu dibujo (Contenedor del 3D) */}
        <div className="hero-canvas-box">
          <Canvas camera={{ position: [0, 10, 25], fov: 25 }}>
            <Suspense fallback={null}>
              <ambientLight intensity={0.2} />
              <directionalLight
                color="#00c6ff"
                position={[5, 5, 5]}
                intensity={2}
              />
              <directionalLight
                color="#a855f7"
                position={[-5, -5, -5]}
                intensity={1}
              />
              <Environment preset="city" />

              <Model />

              <OrbitControls
                enableZoom={true}
                enablePan={false}
                autoRotate
                autoRotateSpeed={1.5}
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
