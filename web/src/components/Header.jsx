import React from 'react';

export default function Header() {
  return (
    <header className="header">
      <div className="container">
        <a href="#" className="logo">
          Cercasco
        </a>
        <nav className="nav-links">
          <a href="#home">Inicio</a>
          <a href="#problem">Problema</a>
          <a href="#solution">Solución</a>
          <a href="#features">Circuito</a>
        </nav>
      </div>
    </header>
  );
}
