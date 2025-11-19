import React from 'react';
import Header from './components/Header';
import Hero from './components/Hero';
import Problem from './components/Problem';
import Solution from './components/Solution';
import Features from './components/Features';
import Footer from './components/Footer';
import AppShowcase from './components/AppShowcase';

function App() {
  return (
    <>
      <Header />
      <main>
        <div id="home">
          <Hero />
        </div>
        <div id="problem">
          <Problem />
        </div>
        <div id="solution">
          <Solution />
        </div>
        <Features />
        <AppShowcase />
      </main>
      <Footer />
    </>
  );
}

export default App;
