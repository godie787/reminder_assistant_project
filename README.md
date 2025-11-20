# Reminder Assistant 📱

Aplicación móvil desarrollada en Flutter para la gestión de recordatorios personalizados con notificaciones programadas.

Enlace a Demo y apk: https://drive.google.com/drive/folders/1BC7Cx-nyLgf3K76IdnaIoNJKKw2j6l2u?usp=drive_link

## Librerías Principales

- **firebase_core** & **firebase_auth**: Autenticación de usuarios
- **google_sign_in**: Inicio de sesión con Google
- **flutter_local_notifications**: Sistema de notificaciones locales
- **timezone** & **flutter_timezone**: Manejo de zonas horarias
- **permission_handler**: Gestión de permisos del dispositivo
- **go_router**: Navegación y enrutamiento
- **provider**: Gestión de estado
- **intl**: Internacionalización y formato de fechas
- **flutter_datetime_picker** & **time_picker_spinner**: Selectores de fecha y hora

## Arquitectura y Módulos

### Arquitectura Limpia (Clean Architecture)
El proyecto implementa una arquitectura en capas:

- **Domain**: Entidades, repositorios y casos de uso
  - Use Cases: Recordatorios y usuarios
  - Entidades del dominio
  
- **Infrastructure**: Implementaciones concretas
  - Repositorios
  - Fuentes de datos

- **Presentation**: Interfaz de usuario
  - Screens (Pantallas)
  - Widgets reutilizables
  - Providers para gestión de estado

- **Services**: Servicios auxiliares
  - Gestión de permisos de notificaciones

## Integraciones Firebase

### Firebase Authentication
- Autenticación de usuarios con email y contraseña
- Inicio de sesión con Google Sign-In
- Gestión de sesiones de usuario


## Sistema de Notificaciones

- Notificaciones locales programadas
- Configuración de zonas horarias
- Recordatorios recurrentes (diario, semanal)
- Gestión de permisos de notificaciones

## Reflexión Personal

Este proyecto fue un desafío significativo que me permitió profundizar en conceptos avanzados de Flutter y Firebase. La implementación de notificaciones locales con manejo de zonas horarias, junto con la integración de Firebase Authentication y Firestore, representó un reto técnico importante. Aplicar Clean Architecture me ayudó a mantener un código organizado y escalable, aunque requirió una planificación cuidadosa desde el inicio.

