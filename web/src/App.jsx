import React from 'react';
import Header from './components/Header';
import Hero from './components/Hero';
import Problem from './components/Problem';
import Solution from './components/Solution';
import Features from './components/Features';
import Footer from './components/Footer';

function App() {
  return (
    <>
      <Header />
      <main>
        {/* Envolvemos cada componente en un div con ID para la navegación */}
        <div id="home">
          <Hero />
        </div>
        <div id="problem">
          <Problem />
        </div>
        <div id="solution">
          <Solution />
        </div>
        {/* Features ya tiene el ID dentro de su propio componente, pero esto asegura el orden */}
        <Features />
      </main>
      <Footer />
    </>
  );
}

export default App;
