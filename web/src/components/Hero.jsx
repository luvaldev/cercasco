import React, { Suspense } from 'react';
import { Canvas } from '@react-three/fiber';
import { OrbitControls, useGLTF, Environment } from '@react-three/drei';

/* Componente que carga el modelo */
function Model() {
  // Ubicación de tu modelo en la carpeta public/
  const { scene } = useGLTF('/cercasco-helmet.glb');
  return <primitive object={scene} />;
}

export default function Hero() {
  return (
    <section className="hero">
      {/* 1. El Canvas (Visor 3D) 
           Lo ponemos primero. Como es 'position: absolute',
           no afectará al centrado del texto. */}
      <div className="hero-canvas">
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

      {/* 2. El Contenido de Texto 
           Lo envolvemos en .hero-content (z-index: 10) */}
      <div className="hero-content">
        <div className="container">
          <h1>Cercasco</h1>
          <p>“Más seguridad, más confianza, más ciclismo.”</p>
        </div>
      </div>

      {/* 3. Las Instrucciones
           También tiene z-index: 10 para estar por encima */}
      <span className="hero-instructions">(Arrastra el modelo para rotar)</span>
    </section>
  );
}
