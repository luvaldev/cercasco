import React from 'react';

export default function AppShowcase() {
  return (
    <section className="py-24 relative overflow-hidden" id="app">
      <div className="container mx-auto px-4 relative z-10">
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-16 items-center">
          {/* --- COLUMNA IZQUIERDA: MOCKUP FIEL A LA CAPTURA DE PANTALLA --- */}
          <div className="flex justify-center lg:justify-end order-last lg:order-first">
            {/* Marco del teléfono */}
            <div className="relative w-[320px] h-[680px] bg-gray-900 rounded-[3rem] border-[6px] border-gray-800 shadow-[0_0_50px_rgba(0,198,255,0.15)] overflow-hidden ring-1 ring-white/10">
              {/* Isla Dinámica / Notch */}
              <div className="absolute top-4 left-1/2 transform -translate-x-1/2 w-28 h-7 bg-black rounded-full z-50"></div>

              {/* --- PANTALLA SIMULADA (Ahora sí, basada en tu imagen) --- */}
              <div className="w-full h-full bg-[#0b022d] text-white flex flex-col font-sans">
                <div className="pt-14 pb-4 px-4 flex justify-between items-center bg-gradient-to-br from-[#1b084e] to-[#2e1966] shadow-md z-20 border-b border-white/5">
                  <span className="font-bold text-lg tracking-wide text-white">
                    Cercasco Dashboard
                  </span>
                  <div className="flex gap-3">
                    <div className="w-8 h-8 rounded-full bg-white/10 flex items-center justify-center">
                      <div className="w-4 h-4 rounded-full bg-white opacity-90 shadow-sm"></div>
                    </div>
                    <div className="w-8 h-8 rounded-full bg-white/10 flex items-center justify-center">
                      <svg
                        className="w-4 h-4 text-white"
                        fill="none"
                        viewBox="0 0 24 24"
                        stroke="currentColor">
                        <path
                          strokeLinecap="round"
                          strokeLinejoin="round"
                          strokeWidth={2}
                          d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"
                        />
                      </svg>
                    </div>
                  </div>
                </div>

                {/* Cuerpo Principal (Scrollable) */}
                <div className="flex-1 overflow-y-auto px-3 py-6 space-y-4">
                  {/* Card: Estado del Casco */}
                  <div className="bg-gradient-to-br from-[#2e1966]/80 to-[#1b084e]/80 p-5 rounded-2xl border border-white/10 backdrop-blur-md shadow-lg">
                    <div className="flex items-center gap-2 mb-3">
                      <svg
                        className="w-5 h-5 text-accent"
                        fill="none"
                        viewBox="0 0 24 24"
                        stroke="currentColor">
                        <path
                          strokeLinecap="round"
                          strokeLinejoin="round"
                          strokeWidth={2}
                          d="M13 10V3L4 14h7v7l9-11h-7z"
                        />
                      </svg>
                      <h3 className="text-white font-bold text-lg">
                        Estado del Casco
                      </h3>
                    </div>
                    <p className="text-gray-300 text-sm mb-4">Desconectado</p>
                    <button className="w-full py-2 bg-accent/20 hover:bg-accent/30 text-accent font-semibold rounded-lg flex items-center justify-center gap-2 transition-colors">
                      <svg
                        className="w-4 h-4"
                        fill="none"
                        viewBox="0 0 24 24"
                        stroke="currentColor">
                        <path
                          strokeLinecap="round"
                          strokeLinejoin="round"
                          strokeWidth={2}
                          d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m0 0H15"
                        />
                      </svg>
                      Reconectar Casco
                    </button>
                    <div className="flex items-center gap-2 mt-4 text-gray-400 text-sm">
                      <svg
                        className="w-4 h-4"
                        fill="none"
                        viewBox="0 0 24 24"
                        stroke="currentColor">
                        <path
                          strokeLinecap="round"
                          strokeLinejoin="round"
                          strokeWidth={2}
                          d="M13 10V3L4 14h7v7l9-11h-7z"
                        />
                      </svg>
                      Batería: N/A
                    </div>
                  </div>

                  {/* Card: Control de LEDs RGB */}
                  <div className="bg-gradient-to-br from-[#2e1966]/80 to-[#1b084e]/80 p-5 rounded-2xl border border-white/10 backdrop-blur-md shadow-lg">
                    <div className="flex items-center gap-2 mb-4">
                      <svg
                        className="w-5 h-5 text-yellow-400"
                        fill="none"
                        viewBox="0 0 24 24"
                        stroke="currentColor">
                        <path
                          strokeLinecap="round"
                          strokeLinejoin="round"
                          strokeWidth={2}
                          d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z"
                        />
                      </svg>
                      <h3 className="text-white font-bold text-lg">
                        Control de LEDs RGB
                      </h3>
                    </div>

                    <div className="flex justify-between items-center mb-4">
                      <span className="text-gray-300 text-sm">
                        Color actual:
                      </span>
                      <div className="w-8 h-8 rounded-full bg-blue-500 border border-white/20 shadow-md"></div>{' '}
                    </div>

                    <div className="mb-4">
                      <div className="flex justify-between text-gray-300 text-sm mb-1">
                        <span>Intensidad:</span>
                        <span>100 %</span>
                      </div>
                      <div className="h-2 w-full rounded-full bg-gray-700 overflow-hidden relative">
                        <div className="h-full w-full bg-gradient-to-r from-gray-500 to-white"></div>{' '}
                        <div className="absolute left-[calc(100%-8px)] top-1/2 -translate-y-1/2 w-4 h-4 rounded-full bg-white shadow-md border-2 border-accent"></div>
                      </div>
                    </div>

                    <button className="w-full py-2 bg-gradient-to-r from-purple-600 to-pink-500 hover:from-purple-700 hover:to-pink-600 text-white font-semibold rounded-lg flex items-center justify-center gap-2 transition-all">
                      <svg
                        className="w-4 h-4"
                        fill="none"
                        viewBox="0 0 24 24"
                        stroke="currentColor">
                        <path
                          strokeLinecap="round"
                          strokeLinejoin="round"
                          strokeWidth={2}
                          d="M7 21a4 4 0 01-4-4V5a2 2 0 012-2h4a2 2 0 012 2v11a4 4 0 01-4 4zm0 0h12a2 2 0 002-2v-4a2 2 0 00-2-2h-2.343M11 7.343h7.071c.711 0 1.307.337 1.636.853l2.545 4.072m-4.072-2.545a1.5 1.5 0 01-.853-1.636M11 7.343L15.616 3m-4.503 16.588A3.001 3.001 0 0017.5 14h-5.83m-1.047 5.588a3.001 3.001 0 01-1.047-5.588"
                        />
                      </svg>
                      Cambiar Color
                    </button>
                  </div>

                  {/* Card: Estadísticas de Uso */}
                  <div className="bg-gradient-to-br from-[#2e1966]/80 to-[#1b084e]/80 p-5 rounded-2xl border border-white/10 backdrop-blur-md shadow-lg">
                    <div className="flex items-center gap-2 mb-4">
                      <svg
                        className="w-5 h-5 text-green-400"
                        fill="none"
                        viewBox="0 0 24 24"
                        stroke="currentColor">
                        <path
                          strokeLinecap="round"
                          strokeLinejoin="round"
                          strokeWidth={2}
                          d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"
                        />
                      </svg>
                      <h3 className="text-white font-bold text-lg">
                        Estadísticas de Uso
                      </h3>
                    </div>
                    <div className="space-y-3">
                      <div className="flex justify-between items-center text-gray-300 text-base">
                        <div className="flex items-center gap-2">
                          <svg
                            className="w-5 h-5 text-gray-500"
                            fill="none"
                            viewBox="0 0 24 24"
                            stroke="currentColor">
                            <path
                              strokeLinecap="round"
                              strokeLinejoin="round"
                              strokeWidth={2}
                              d="M9 12l2 2 4-4M7.835 4.697A7.903 7.903 0 0112 4c4.478 0 8.268 2.943 9.543 7a9.97 9.97 0 01-1.336 4.405M14.934 14.934a6.574 6.574 0 01-1.121.219c-1.285 0-2.565-.593-3.326-1.57M16 12a4 4 0 11-8 0 4 4 0 018 0z"
                            />
                          </svg>
                          <span>Total de Alertas:</span>
                        </div>
                        <span className="font-semibold text-white">0</span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          {/* --- COLUMNA DERECHA: DESCRIPCIÓN --- */}
          <div className="text-left">
            <h2 className="text-4xl font-bold text-white mb-6 drop-shadow-[0_0_15px_rgba(0,198,255,0.5)]">
              Monitoreo y <span className="text-accent">Control Completo</span>
            </h2>

            <p className="text-gray-300 text-lg mb-8 leading-relaxed">
              La aplicación de Cercasco te ofrece una interfaz intuitiva para
              gestionar tu seguridad. Conecta tu casco, controla la iluminación
              RGB y revisa tus estadísticas de viaje, todo desde tu smartphone.
            </p>

            <div className="space-y-8">
              <div className="flex gap-4 items-start">
                <div className="p-3 bg-accent/10 rounded-lg border border-accent/20">
                  <svg
                    className="w-6 h-6 text-accent"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor">
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth={2}
                      d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"
                    />
                  </svg>
                </div>
                <div>
                  <h4 className="text-white font-bold text-lg">
                    Estado en Tiempo Real
                  </h4>
                  <p className="text-gray-400 text-sm mt-1">
                    Verifica instantáneamente la conexión Bluetooth y el nivel
                    de batería de tu casco Cercasco.
                  </p>
                </div>
              </div>

              <div className="flex gap-4 items-start">
                <div className="p-3 bg-accent/10 rounded-lg border border-accent/20">
                  <svg
                    className="w-6 h-6 text-accent"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor">
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth={2}
                      d="M7 21a4 4 0 01-4-4V5a2 2 0 012-2h4a2 2 0 012 2v11a4 4 0 01-4 4zm0 0h12a2 2 0 002-2v-4a2 2 0 00-2-2h-2.343M11 7.343h7.071c.711 0 1.307.337 1.636.853l2.545 4.072m-4.072-2.545a1.5 1.5 0 01-.853-1.636M11 7.343L15.616 3m-4.503 16.588A3.001 3.001 0 0017.5 14h-5.83m-1.047 5.588a3.001 3.001 0 01-1.047-5.588"
                    />
                  </svg>
                </div>
                <div>
                  <h4 className="text-white font-bold text-lg">
                    Personalización Avanzada
                  </h4>
                  <p className="text-gray-400 text-sm mt-1">
                    Ajusta el color y la intensidad de las luces RGB del casco
                    para adaptarlo a tus preferencias o condiciones de
                    visibilidad.
                  </p>
                </div>
              </div>

              <div className="flex gap-4 items-start">
                <div className="p-3 bg-accent/10 rounded-lg border border-accent/20">
                  <svg
                    className="w-6 h-6 text-accent"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor">
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth={2}
                      d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"
                    />
                  </svg>
                </div>
                <div>
                  <h4 className="text-white font-bold text-lg">
                    Estadísticas Detalladas
                  </h4>
                  <p className="text-gray-400 text-sm mt-1">
                    Mantente al tanto de tu seguridad con un registro de alertas
                    y la distancia recorrida en cada viaje.
                  </p>
                </div>
              </div>
            </div>

            <div className="mt-10 flex flex-wrap gap-4">
              <a
                href="https://github.com/luvaldev/cercasco/tree/main/app/cercasco_app"
                className="px-8 py-3 bg-white text-dark-bg font-bold rounded-full hover:bg-gray-200 transition-colors">
                Ver Repositorio
              </a>
              <button className="px-8 py-3 border border-accent text-accent font-bold rounded-full hover:bg-accent/10 transition-colors">
                Proximamente en App Stores
              </button>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
