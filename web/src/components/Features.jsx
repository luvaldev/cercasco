import React from 'react';

export default function Features() {
  return (
    <section className="section">
      <div className="container">
        <h2>Cómo Funciona: Arquitectura "Hub & Spoke"</h2>
        <div className="features-grid">
          <div className="feature-card">
            <h4>1. Pod de Sensores (Trasero)</h4>
            <p>
              Ubicado en la bicicleta. Contiene una ESP32-CAM para detección de
              vehículos y un ESP32 con sensor de ultrasonido para medir la
              distancia. Envía los datos vía ESP-NOW para latencia ultra baja.
            </p>
          </div>
          <div className="feature-card">
            <h4>2. Hub de Alertas (Casco)</h4>
            <p>
              Ubicado en el casco. Recibe los datos del Pod, procesa el nivel de
              riesgo y activa las alertas: un motor de vibración y tiras LED. Es
              el cerebro del sistema.
            </p>
          </div>
          <div className="feature-card">
            <h4>3. App Móvil (Configuración)</h4>
            <p>
              El Hub del Casco se conecta a una app móvil vía Bluetooth (BLE).
              La app permite al usuario configurar los patrones de luz, ver el
              historial de alertas y el estado de la batería.
            </p>
          </div>
        </div>
      </div>
    </section>
  );
}
