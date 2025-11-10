import React from 'react';

export default function Team() {
  return (
    <section
      className="section"
      style={{ backgroundColor: 'var(--color-bg-light)' }}>
      <div className="container">
        <h2>El Equipo</h2>
        <div className="team-grid">
          <span className="team-member">Matías Vigneau</span>
          <span className="team-member">Luis Valdenegro</span>
          <span className="team-member">Gabriel González</span>
          <span className="team-member">Ezequiel Morales</span>
        </div>
      </div>
    </section>
  );
}
