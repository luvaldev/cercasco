import React from 'react';

const photos = [
  {
    id: 1,
    src: '/ESP32-CAM/1.webp',
    label: 'Prueba de Detección',
  },
  {
    id: 2,
    src: '/ESP32-CAM/2.webp',
    label: 'Prueba de Detección',
  },
  {
    id: 3,
    src: '/ESP32-CAM/3.webp',
    label: 'Prueba de Detección',
  },
  {
    id: 4,
    src: '/ESP32-CAM/4.webp',
    label: 'Prueba de Detección',
  },
  {
    id: 5,
    src: '/ESP32-CAM/5.webp',
    label: 'Prueba de Detección',
  },
  {
    id: 6,
    src: '/ESP32-CAM/6.webp',
    label: 'Prueba de Detección',
  },
  {
    id: 7,
    src: '/ESP32-CAM/7.webp',
    label: 'Prueba de Detección',
  },
  {
    id: 8,
    src: '/ESP32-CAM/8.webp',
    label: 'Prueba de Detección',
  },

  {
    id: 9,
    src: '/ESP32-CAM/9.webp',
    label: 'Prueba de Detección',
  },
  {
    id: 10,
    src: '/ESP32-CAM/10.webp',
    label: 'Prueba de Detección',
  },

  {
    id: 11,
    src: '/ESP32-CAM/11.webp',
    label: 'Prueba de Detección',
  },
  {
    id: 12,
    src: '/ESP32-CAM/12.webp',
    label: 'Prueba de Detección',
  },
];

const Galeria = ({ onBack }) => {
  return (
    <section className="min-h-screen w-full pt-28 pb-10 px-4 md:px-20 bg-dark-bg animate-fade-in">
      {/* Encabezado de la Galería */}
      <div className="flex flex-col md:flex-row justify-between items-center mb-10 border-b border-white/10 pb-6">
        <div>
          <h2 className="text-4xl font-bold text-white mb-2">
            Galería <span className="text-accent">ESP32-CAM</span>
          </h2>
          <p className="text-gray-400">
            Evidencia fotográfica de las prácticas y pruebas de visión.
          </p>
        </div>

        {/* Botón Volver */}
        <button
          onClick={onBack}
          className="mt-4 md:mt-0 px-6 py-2 border border-accent text-accent hover:bg-accent hover:text-white rounded-full transition-all duration-300 flex items-center gap-2">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            fill="none"
            viewBox="0 0 24 24"
            strokeWidth={1.5}
            stroke="currentColor"
            className="w-5 h-5">
            <path
              strokeLinecap="round"
              strokeLinejoin="round"
              d="M9 15L3 9m0 0l6-6M3 9h12a6 6 0 010 12h-3"
            />
          </svg>
          Volver al Inicio
        </button>
      </div>

      {/* Grid de Imágenes */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {photos.map(photo => (
          <div
            key={photo.id}
            className="group relative overflow-hidden rounded-xl border border-white/10 shadow-lg bg-black/20">
            {/* Imagen */}
            <img
              src={photo.src}
              alt={photo.label}
              className="w-full h-64 object-cover transform group-hover:scale-110 transition-transform duration-500"
            />

            {/* Overlay con texto */}
            <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-end p-6">
              <span className="text-white font-medium text-lg border-l-4 border-accent pl-3">
                {photo.label}
              </span>
            </div>
          </div>
        ))}
      </div>
    </section>
  );
};

export default Galeria;
