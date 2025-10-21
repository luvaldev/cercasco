# 🔩 Hardware del Sistema Cercasco

Este directorio contiene todos los elementos físicos y de diseño mecánico del proyecto **Cercasco**, enfocado en el montaje del sistema de detección de vehículos para ciclistas.

## Contenido
- `esquemas/` — diagramas eléctricos y conexiones entre sensores, microcontroladores y actuadores.  
- `modelos3D/` — diseños CAD del soporte trasero y piezas impresas en 3D.  
- `alimentacion/` — documentación sobre baterías, powerbanks y cableado de energía.  

## Objetivo
Desarrollar un **módulo compacto, ergonómico y resistente**, capaz de integrarse fácilmente a cascos o bicicletas, garantizando estabilidad en la detección y protección de los sensores.

## Materiales principales
- ESP32-CAM + ESP32 DevKit V1  
- Sensor ToF y/o ultrasónico  
- LEDs de alta intensidad (500 lm)  
- Motor vibrador tipo coin  
- Carcasa impresa en 3D (PLA/ABS)  
- Powerbank recargable  

## Notas
Los diseños pueden adaptarse a distintos tamaños de casco o soporte según la impresora 3D disponible. Se recomienda respetar la ventilación del ESP32-CAM y aislar los cables de señal.
