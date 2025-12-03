/** @type {import('tailwindcss').Config} */
export default {
  content: ['./index.html', './src/**/*.{js,ts,jsx,tsx}'],
  theme: {
    extend: {
      // AGREGAR ESTO: Redefinimos los tamaños de fuente base
      fontSize: {
        sm: ['1rem', { lineHeight: '1.5rem' }], // Antes 14px -> Ahora 16px (Tamaño estándar)
        base: ['1.125rem', { lineHeight: '1.75rem' }], // Antes 16px -> Ahora 18px (Más legible)
        lg: ['1.25rem', { lineHeight: '1.75rem' }], // Antes 18px -> Ahora 20px
        xl: ['1.5rem', { lineHeight: '2rem' }], // Antes 20px -> Ahora 24px
        '2xl': ['1.75rem', { lineHeight: '2.25rem' }], // Antes 24px -> Ahora 28px
      },
      colors: {
        accent: {
          DEFAULT: '#00c6ff',
          dark: '#0072ff',
        },
        dark: {
          bg: '#0b022d',
        },
      },
      // ... resto de tu configuración (fontFamily, animations, etc.) ...
      fontFamily: {
        sans: ['Inter', 'system-ui', 'sans-serif'],
      },
      animation: {
        'gradient-bg': 'gradientBG 15s ease infinite',
        'text-shine': 'textShine 4s linear infinite',
      },
      keyframes: {
        gradientBG: {
          '0%': { backgroundPosition: '0% 50%' },
          '50%': { backgroundPosition: '100% 50%' },
          '100%': { backgroundPosition: '0% 50%' },
        },
        textShine: {
          '0%': { backgroundPosition: '0% 50%' },
          '100%': { backgroundPosition: '200% 50%' },
        },
      },
    },
  },
  plugins: [],
};
