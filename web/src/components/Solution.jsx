import React from 'react';
import blueprintImg from '../assets/blueprint.png';

export default function Solution() {
  return (
    <section className="py-24 relative overflow-hidden" id="solution">
      {/* Contenedor corregido para márgenes consistentes */}
      <div className="container mx-auto px-4">
        <h2 className="text-center text-4xl font-bold text-accent mb-16 drop-shadow-[0_0_15px_rgba(0,198,255,0.5)]">
          Nuestra Solución
        </h2>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
          {/* --- COLUMNA IZQUIERDA: IMAGEN (BLUEPRINT) --- */}
          <div className="relative group w-full flex justify-center">
            {/* Efecto de brillo trasero */}
            <div className="absolute -inset-1 bg-gradient-to-r from-accent to-blue-600 rounded-2xl blur opacity-20 group-hover:opacity-50 transition duration-1000 group-hover:duration-200"></div>

            <img
              src={blueprintImg}
              alt="Blueprint del casco Cercasco"
              className="relative w-full max-w-md lg:max-w-full rounded-2xl border border-accent/30 shadow-2xl bg-black/20 backdrop-blur-sm transform transition hover:scale-[1.02] duration-500"
            />
          </div>

          {/* --- COLUMNA DERECHA: TEXTO EXPLICATIVO --- */}
          <div className="glass-card p-8 rounded-2xl bg-white/5 border border-white/10 backdrop-blur-md h-full flex flex-col justify-center">
            <h3 className="text-3xl font-bold text-white mb-6">
              <span className="text-accent">Cercasco:</span> Integración
              Inteligente
            </h3>

            <p className="text-gray-300 text-lg mb-8 leading-relaxed">
              Redefinimos la seguridad ciclista con una{' '}
              <strong className="text-white">
                carcasa externa desmontable
              </strong>
              . No necesitas comprar un casco nuevo; evolucionamos el que ya
              tienes.
            </p>

            <ul className="space-y-5">
              <li className="flex items-start">
                <span className="flex-shrink-0 w-6 h-6 rounded-full bg-accent/20 flex items-center justify-center mr-4 mt-1">
                  <span className="w-2 h-2 bg-accent rounded-full animate-pulse"></span>
                </span>
                <div>
                  <strong className="text-white text-lg block">
                    Detección Híbrida
                  </strong>
                  <span className="text-gray-400 text-sm">
                    Fusión de sensores de proximidad y visión por computadora
                    para identificar amenazas traseras.
                  </span>
                </div>
              </li>

              <li className="flex items-start">
                <span className="flex-shrink-0 w-6 h-6 rounded-full bg-accent/20 flex items-center justify-center mr-4 mt-1">
                  <span className="w-2 h-2 bg-accent rounded-full animate-pulse"></span>
                </span>
                <div>
                  <strong className="text-white text-lg block">
                    Feedback Sensorial
                  </strong>
                  <span className="text-gray-400 text-sm">
                    Sistema de doble alerta: <strong>Vibración háptica</strong>{' '}
                    en la nuca y luces LED periféricas.
                  </span>
                </div>
              </li>

              <li className="flex items-start">
                <span className="flex-shrink-0 w-6 h-6 rounded-full bg-accent/20 flex items-center justify-center mr-4 mt-1">
                  <span className="w-2 h-2 bg-accent rounded-full animate-pulse"></span>
                </span>
                <div>
                  <strong className="text-white text-lg block">
                    Diseño No Invasivo
                  </strong>
                  <span className="text-gray-400 text-sm">
                    Sujeción externa que respeta la integridad estructural y
                    certificación original del casco.
                  </span>
                </div>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </section>
  );
}
