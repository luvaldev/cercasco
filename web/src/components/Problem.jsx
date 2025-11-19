import React from 'react';

export default function Problem() {
  return (
    <section className="py-24 relative overflow-hidden" id="problem">
      {/* Fondo decorativo sutil */}
      <div className="absolute top-0 left-0 w-full h-full overflow-hidden -z-10 pointer-events-none">
        <div className="absolute top-1/4 -left-64 w-96 h-96 bg-red-600/20 rounded-full blur-[100px]"></div>
      </div>

      <div className="container mx-auto px-4">
        <h2 className="text-center text-4xl font-bold text-white mb-16 drop-shadow-[0_0_15px_rgba(255,50,50,0.5)]">
          El <span className="text-red-500">Riesgo</span> es Real
        </h2>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
          {/* --- COLUMNA IZQUIERDA: TEXTO --- */}
          <div className="glass-card p-8 rounded-2xl bg-white/5 border border-white/10 backdrop-blur-md flex flex-col justify-center h-full relative overflow-hidden">
            {/* Borde decorativo rojo para indicar alerta/problema */}
            <div className="absolute left-0 top-0 bottom-0 w-1 bg-gradient-to-b from-red-500 to-transparent"></div>

            <h3 className="text-3xl font-bold text-white mb-6">
              Desafíos Urbanos
            </h3>

            <p className="text-gray-300 text-lg mb-6 leading-relaxed">
              La movilidad urbana presenta peligros constantes. En entornos con
              tráfico mixto y carriles estrechos, la{' '}
              <strong className="text-white">
                falta de visibilidad trasera
              </strong>{' '}
              es el talón de Aquiles del ciclista.
            </p>

            <p className="text-gray-300 text-lg mb-8 leading-relaxed">
              Los siniestros por adelantamientos indebidos o acercamientos
              sorpresivos son evitables si se cuenta con la información correcta
              a tiempo.
            </p>

            {/* Estadística destacada */}
            <div className="bg-red-500/10 border border-red-500/30 rounded-xl p-6 flex items-center gap-6 transform transition hover:scale-[1.02] duration-300">
              <div className="text-5xl font-black text-red-500 drop-shadow-[0_0_10px_rgba(239,68,68,0.4)]">
                58%
              </div>
              <div className="text-gray-200 text-sm font-medium">
                De los accidentes graves de ciclistas involucran el impacto de
                un vehículo motorizado.
              </div>
            </div>
          </div>

          {/* --- COLUMNA DERECHA: IMAGEN --- */}
          <div className="relative group h-full min-h-[400px]">
            {/* Efecto Glow Rojo */}
            <div className="absolute -inset-1 bg-gradient-to-br from-red-600 to-orange-600 rounded-2xl blur opacity-20 group-hover:opacity-40 transition duration-500"></div>

            <img
              src="/riesgo.webp"
              alt="Ciclista en tráfico urbano peligroso"
              className="relative w-full h-full object-cover rounded-2xl border border-white/10 shadow-2xl grayscale-[30%] group-hover:grayscale-0 transition duration-500"
            />

            {/* Overlay sutil para integrar la imagen */}
            <div className="absolute inset-0 rounded-2xl bg-gradient-to-t from-black/60 to-transparent pointer-events-none"></div>
          </div>
        </div>
      </div>
    </section>
  );
}
