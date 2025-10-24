# 🚴‍♂️ Cercasco – Sistema de Detección de Vehículos para Ciclistas  

**Cercasco** es un sistema inteligente de alerta diseñado para mejorar la seguridad de los ciclistas en entornos urbanos. Detecta vehículos que se aproximan por detrás y emite **alertas hápticas y visuales** en tiempo real, sin distraer al usuario.  
Desarrollado como proyecto académico en la **Universidad Diego Portales (Chile)** por estudiantes de Ingeniería en Informática.

---

## 🎯 Objetivo del Proyecto  

Reducir el riesgo de accidentes mediante un dispositivo accesible que aumente la percepción del entorno del ciclista, combinando sensores, microcontroladores y una aplicación móvil para monitoreo y configuración.

---

## ⚙️ Componentes Principales  

- **ESP32-CAM** → Captura de imágenes y detección de vehículos.  
- **Sensor ToF / Ultrasonido** → Medición de distancia.  
- **ESP32 principal** → Control de alertas hápticas y visuales.  
- **Motor vibrador coin** → Alerta háptica según cercanía.  
- **LEDs de alta intensidad (500 lm)** → Señalización visual.  
- **App móvil (Flutter/Java)** → Configuración y visualización de alertas.  

---

## 🧩 Estructura del Repositorio  

| Carpeta | Descripción |
|----------|-------------|
| `/docs` | Documentación técnica, informes, presentaciones y bitácoras. |
| `/firmware` | Código fuente de los microcontroladores (ESP32 y ESP32-CAM). |
| `/app` | Aplicación móvil para visualización y configuración del sistema. |
| `/hardware` | Modelos 3D, esquemas eléctricos y montaje físico. |

---

## 🔧 Tecnologías Utilizadas  

- **Hardware:** ESP32, ESP32-CAM, sensores ToF y ultrasonido.  
- **Software embebido:** C / C++ (Arduino Framework).  **(En Planificación)**
- **Aplicación móvil:** Flutter (Dart) y Java.  
- **Diseño 3D:** Fusion 360 / Blender.  
- **Control de versiones:** Git y GitHub.  

---

## 🚀 Funcionamiento General  

1. El módulo trasero detecta vehículos mediante cámara y sensores.  
2. Los datos se procesan en el ESP32 principal.  
3. Si un vehículo se aproxima a menos de 2 m, se activa una **vibración leve**.  
4. Si la distancia es menor a 1.5 m, la vibración se intensifica y los **LEDs parpadean**.  
5. El sistema envía los datos a la app móvil vía **Bluetooth/Wi-Fi**.  

---

## 🧠 Equipo de Desarrollo  
 
- **Gabriel González**  
- **Ezequiel Morales**  
- **Matías Vigneau**  
- **Luis Valdenegro** 

---

## 📅 Contexto Académico  

Proyecto desarrollado en el marco de la asignatura de **Proyectos en Tics I**,  
**Universidad Diego Portales**, Santiago de Chile, 2025.  

---

## 💡 Frase del Proyecto  

> “Más seguridad, más confianza, más ciclismo.” 🚴‍♀️

---

### 🌐 Enlaces de interés  
- [Universidad Diego Portales](https://www.udp.cl/)  
- [Documentación del proyecto](./docs)  
- [Firmware](./firmware)  
- [Aplicación móvil](./app)  DE CHILL
- 
