import React from 'react';

export default function Problem() {
  return (
    <section className="section">
      <div className="container">
        <h2>El Riesgo es Real</h2>
        <div className="problem-solution-grid">
          {/* La tarjeta de cristal es el contenido de texto */}
          <div className="text-content glass-card">
            <h3>El Problema</h3>
            <p>
              La movilidad urbana presenta desafíos crecientes para la seguridad
              de los ciclistas. En entornos con tráfico mixto y carriles
              estrechos, la percepción del riesgo no siempre es inmediata.
            </p>
            <p>
              Los siniestros por adelantamientos o acercamientos por la
              retaguardia son comunes y podrían evitarse si el ciclista tuviera
              información adicional en tiempo real.
            </p>
            <span className="stat">
              El 58% de los accidentes de ciclistas involucran un vehículo
              motorizado.
            </span>
          </div>
          <div className="image-content">
            {/* Imagen de contexto más dramática */}
            <img
              src="https://images.unsplash.com/photo-1576426863848-c21f68c6086f?auto=format&fit=crop&w=1100&q=80"
              alt="Ciclista en tráfico urbano"
              style={{
                objectFit: 'cover',
                height: '100%',
                borderRadius: '16px',
              }}
            />
          </div>
        </div>
      </div>
    </section>
  );
}
