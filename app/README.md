# Cercasco

Aplicación móvil para el casco inteligente Cercasco.

## Descripción

Esta aplicación de Flutter permite a los usuarios interactuar con la interfaz inteligente Cercasco. Las características incluyen:

*   **Control de luces LED:** Cambia el color de las luces LED del casco.
*   **Comunicación HTTP:** Se comunica con el microcontrolador ESP32 del casco.
*   **Configuraciones locales:** Guarda las preferencias del usuario y la información de la sesión.
*   **Autenticación de Firebase:** Maneja el registro y el inicio de sesión de usuarios (actualmente opcional).

## Cómo empezar

### Prerrequisitos

*   [Flutter SDK](https://flutter.dev/docs/get-started/install)
*   Un dispositivo o emulador de Android/iOS

### Instalación

1.  Clona este repositorio:
    ```sh
    git clone https://github.com/luvaldev/cercasco.git
    ```
2.  Instala las dependencias:
    ```sh
    flutter pub get
    ```

### Ejecutando la aplicación

1.  Asegúrate de que un dispositivo esté conectado o que un emulador se esté ejecutando.
2.  Ejecuta la aplicación:
    ```sh
    flutter run
    ```

## Dependencias

*   [cupertino_icons](https://pub.dev/packages/cupertino_icons): Iconos de estilo iOS.
*   [http](https://pub.dev/packages/http): Comunicación con el ESP32 a través de HTTP.
*   [flutter_colorpicker](https://pub.dev/packages/flutter_colorpicker): Selector de color para el control de los LED.
*   [shared_preferences](https://pub.dev/packages/shared_preferences): Almacenamiento de configuraciones y sesiones de forma local.
*   [firebase_core](https://pub.dev/packages/firebase_core): Requerido para los servicios de Firebase.
*   [firebase_auth](https://pub.dev/packages/firebase_auth): Autenticación de Firebase.
*   [cloud_firestore](https://pub.dev/packages/cloud_firestore): Base de datos en la nube de Firestore.

## Estructura del proyecto

*   **lib/main.dart**: El punto de entrada principal de la aplicación.
*   **android/**: Código nativo de Android.
*   **ios/**: Código nativo de iOS.
*   **assets/**: Imágenes, iconos y otros recursos.
*   **test/**: Pruebas unitarias y de widgets.
