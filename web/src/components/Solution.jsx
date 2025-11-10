import React from 'react';
// Importamos la imagen del blueprint
import blueprintImg from '../assets/blueprint.png';

export default function Solution() {
  return (
    // Añadimos .solution-section para controlar el orden en móvil (ver CSS)
    <section className="section solution-section">
      <div className="container">
        <h2>Nuestra Solución</h2>
        <div className="problem-solution-grid">
          <div className="image-content">
            <img src={blueprintImg} alt="Blueprint del casco Cercasco" />
          </div>
          {/* La tarjeta de cristal es el contenido de texto */}
          <div className="text-content glass-card">
            <h3>Cercasco</h3>
            <p>
              Proponemos **Cercasco**: una carcasa externa desmontable e
              inteligente para cascos de ciclista.
            </p>
            <p>
              El sistema integra sensores de proximidad y una cámara para
              detectar vehículos que se aproximan por detrás, notificando al
              usuario mediante **vibraciones hápticas y alertas visuales** con
              luces LED.
            </p>
            <p>
              El diseño no altera la integridad ni la certificación del casco,
              sujetándose externamente.
            </p>
          </div>
        </div>
      </div>
    </section>
  );
}
