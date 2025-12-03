import React, { useState } from 'react';
import Header from './components/Header';
import Hero from './components/Hero';
import Problem from './components/Problem';
import Solution from './components/Solution';
import Features from './components/Features';
import Footer from './components/Footer';
import AppShowcase from './components/AppShowcase';
import Carrusel from './components/Carrusel';
import Galeria from './components/Galeria'; // Importamos el nuevo componente

function App() {
  // Estado para controlar qué vista se muestra
  const [showGallery, setShowGallery] = useState(false);

  return (
    <>
      <Header />

      <main>
        {showGallery ? (
          /* --- VISTA GALERÍA --- */
          /* Pasamos la función para volver a 'false' */
          <Galeria onBack={() => setShowGallery(false)} />
        ) : (
          /* --- VISTA PRINCIPAL (Landing Page) --- */
          <>
            <div id="home">
              <Hero />
            </div>
            <div id="problem">
              <Problem />
            </div>
            <div id="solution">
              <Solution />
            </div>

            {/* Sección del Carrusel con la función para abrir galería */}
            <div id="process">
              <Carrusel onOpenGallery={() => setShowGallery(true)} />
            </div>

            <Features />
            <AppShowcase />
          </>
        )}
      </main>

      <Footer />
    </>
  );
}

export default App;
