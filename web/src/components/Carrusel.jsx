import React, { useState, useEffect } from 'react';


const slides = [
  {
    id: 1,
    title: 'Diseño del Circuito',
    description: 'Esquema inicial y planificación de componentes electrónicos.',
    src: '/src/assets/blueprint.png',
  },
  {
    id: 2,
    title: 'Prototipado',
    description: 'Primeras pruebas de montaje del hardware.',
    src: 'https://via.placeholder.com/800x400?text=Prototipado', 
  },
  {
    id: 3,
    title: 'Producto Final',
    description: 'Integración completa del sistema Cercasco.',
    src: 'https://via.placeholder.com/800x400?text=Resultado+Final', 
  },
];

const Carrusel = () => {
  const [currentIndex, setCurrentIndex] = useState(0);

  // Cambio automático cada 5 segundos
  useEffect(() => {
    const timer = setInterval(() => {
      nextSlide();
    }, 5000);
    return () => clearInterval(timer);
  }, [currentIndex]);

  const prevSlide = () => {
    const isFirstSlide = currentIndex === 0;
    const newIndex = isFirstSlide ? slides.length - 1 : currentIndex - 1;
    setCurrentIndex(newIndex);
  };

  const nextSlide = () => {
    const isLastSlide = currentIndex === slides.length - 1;
    const newIndex = isLastSlide ? 0 : currentIndex + 1;
    setCurrentIndex(newIndex);
  };

  const goToSlide = slideIndex => {
    setCurrentIndex(slideIndex);
  };

  return (
    <section id="carrusel" className="max-w-[1400px] mx-auto py-16 px-4 relative group">
      <h2 className="text-center text-4xl font-bold text-accent mb-16 drop-shadow-[0_0_15px_rgba(0,198,255,0.5)]">
        <span className='text-white'>Proceso de</span> Desarrollo
      </h2>

      <div className="w-full h-[500px] md:h-[600px] rounded-2xl bg-dark-bg/50 relative overflow-hidden shadow-2xl border border-accent/20">
        <div
          style={{ backgroundImage: `url(${slides[currentIndex].src})` }}
          className="w-full h-full bg-center bg-cover duration-500 ease-in-out transition-all">
          <div className="absolute inset-0 bg-gradient-to-t from-dark-bg via-transparent to-transparent opacity-90"></div>
        </div>

        <div className="absolute bottom-12 left-0 right-0 p-8 text-center md:text-left md:px-16">
          <h3 className="text-2xl md:text-3xl font-bold text-white mb-2 animate-fade-in-up">
            {slides[currentIndex].title}
          </h3>
          <p className="text-gray-300 text-lg max-w-2xl">
            {slides[currentIndex].description}
          </p>
        </div>

        <div className="hidden group-hover:block absolute top-[50%] -translate-x-0 translate-y-[-50%] left-5 text-2xl rounded-full p-2 bg-black/20 text-white cursor-pointer hover:bg-accent hover:text-white transition-colors">
          <button onClick={prevSlide} aria-label="Anterior">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              strokeWidth={2}
              stroke="currentColor"
              className="w-8 h-8">
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                d="M15.75 19.5L8.25 12l7.5-7.5"
              />
            </svg>
          </button>
        </div>

        <div className="hidden group-hover:block absolute top-[50%] -translate-x-0 translate-y-[-50%] right-5 text-2xl rounded-full p-2 bg-black/20 text-white cursor-pointer hover:bg-accent hover:text-white transition-colors">
          <button onClick={nextSlide} aria-label="Siguiente">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              strokeWidth={2}
              stroke="currentColor"
              className="w-8 h-8">
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                d="M8.25 4.5l7.5 7.5-7.5 7.5"
              />
            </svg>
          </button>
        </div>

        <div className="absolute bottom-4 left-0 right-0 flex justify-center py-2 gap-2">
          {slides.map((slide, slideIndex) => (
            <div
              key={slideIndex}
              onClick={() => goToSlide(slideIndex)}
              className={`text-2xl cursor-pointer transition-all duration-300 ${
                currentIndex === slideIndex
                  ? 'text-accent scale-125'
                  : 'text-gray-500 hover:text-white'
              }`}>
              <div
                className={`h-2 w-2 rounded-full ${
                  currentIndex === slideIndex ? 'bg-accent w-6' : 'bg-gray-500'
                }`}></div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
};

export default Carrusel;
