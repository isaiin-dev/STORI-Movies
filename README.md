# STORI Movies

**STORI Movies** es una aplicación iOS desarrollada en Swift que consume la API de The Movie Database (TMDb) para mostrar una lista de películas mejor calificadas. La aplicación está diseñada siguiendo los principios de **Clean Architecture** y las mejores prácticas de desarrollo en iOS.

## Características principales

- **Listado de Películas Mejor Calificadas:**
  - Muestra una lista paginada de las películas mejor calificadas obtenidas de la API de TMDb.
  - Implementa paginación para cargar más películas a medida que el usuario se acerca al final de la lista, mejorando la experiencia y el rendimiento.

- **Detalle de Películas:**
  - Al seleccionar una película, se muestra una vista de detalle que presenta toda la información relevante.
  - La vista incluye:
    - Póster de la película en alta resolución.
    - Información detallada como título, título original, resumen, fecha de lanzamiento, calificación, idioma original, popularidad, entre otros.
    - Un componente personalizado (`MovieDetailView`) que organiza y muestra automáticamente todos los datos de la película de manera elegante.
  - Utiliza un `UIScrollView` para permitir el desplazamiento si el contenido excede el tamaño de la pantalla.

- **Favoritos:**
  - Los usuarios pueden marcar películas como favoritas.
  - Los favoritos se almacenan localmente utilizando `UserDefaults`, guardando el objeto completo de la película para acceso rápido.
  - Incluye funcionalidad para agregar, eliminar y alternar el estado de favorito de una película.
  - La lista de favoritos se sincroniza con la interfaz de usuario para reflejar el estado actual de cada película.

- **Interfaz de Usuario y Experiencia:**
  - La aplicación siempre se ejecuta en modo claro (Light Mode) para mantener una apariencia consistente.
  - Al navegar a la vista de detalle, el `UITabBar` se oculta automáticamente para ofrecer una experiencia de visualización más inmersiva, y reaparece al regresar.
  - Diseño adaptativo utilizando Auto Layout y `UIStackView` para asegurar compatibilidad con diferentes tamaños de pantalla y orientaciones.
  - Soporte para desplazamiento suave y actualizaciones de interfaz de usuario eficientes al cargar nuevos datos.

- **Arquitectura y Buenas Prácticas:**
  - Implementa **Clean Architecture** para mantener una separación clara de responsabilidades y facilitar el mantenimiento y escalabilidad del código.
  - Utiliza protocolos y abstracciones para desacoplar componentes y mejorar la testabilidad.
  - Manejo de errores y respuestas de red de manera robusta, con validaciones y manejo adecuado de estados de carga.

- **Integración con la API de TMDb:**
  - Maneja solicitudes de red utilizando un `NetworkClient` personalizado que construye y ejecuta las solicitudes de manera genérica.
  - Soporta parámetros dinámicos como paginación y búsquedas personalizadas.
  - Gestiona las configuraciones de seguridad necesarias en el `Info.plist` para permitir conexiones de red seguras.

## Tecnologías y Herramientas Utilizadas

- **Swift 5+**
- **UIKit**
- **URLSession** para las solicitudes de red
- **Auto Layout** y **UIStackView**
- **UserDefaults** para almacenamiento local
- **Clean Architecture**
- **Xcode** como entorno de desarrollo

## Cómo Ejecutar el Proyecto

### Prerrequisitos

- **Xcode 12** o superior
- **iOS 13** o superior
- Una clave de API de [The Movie Database](https://www.themoviedb.org/)

### Instalación

1. **Clonar el repositorio:**

   ```bash
   git clone https://github.com/tuusuario/stori-movies.git
   ```

2. **Abrir el proyecto en Xcode:**

   ```bash
   cd stori-movies
   open STORI_Movies.xcodeproj
   ```

3. **Configurar la clave de API (Opcional, ya existe una configuracion):**

   - Regístrate en [The Movie Database](https://www.themoviedb.org/) para obtener una clave de API.
   - Añade tu clave de API al proyecto:
     - Localiza el archivo `APIConfig.swift`.
     - Reemplaza `"TU_API_KEY"` con tu clave real:

       ```swift
       struct APIConfig {
           static let apiKey = "TU_API_KEY"
           static let baseURL = URL(string: "https://api.themoviedb.org/3")!
           static let language = "es-ES"
       }
       ```

4. **Ejecutar la aplicación:**

   - Selecciona un simulador o dispositivo real.
   - Presiona `Run` o utiliza el atajo `Cmd + R`.

## Uso

- **Navegar por las Películas:**
  - Desplázate por la lista de películas mejor calificadas.
  - A medida que llegues al final, se cargarán más películas automáticamente.

- **Ver Detalles de una Película:**
  - Toca una película para ver su información detallada.
  - La vista de detalle incluye el póster y todos los detalles relevantes.

- **Gestionar Favoritos:**
  - Toca el botón de favoritos (generalmente representado por un corazón o estrella) para agregar o eliminar una película de tus favoritos.
  - Los favoritos se guardan localmente y persisten entre sesiones de la aplicación.

## Contribuciones

¡Las contribuciones son bienvenidas! Por favor, sigue estos pasos:

1. **Haz un fork del repositorio.**

2. **Crea una nueva rama:**

   ```bash
   git checkout -b feature/nueva-funcionalidad
   ```

3. **Realiza tus cambios y haz commit:**

   ```bash
   git commit -m "Agrega tu mensaje"
   ```

4. **Envía tus cambios al repositorio remoto:**

   ```bash
   git push origin feature/nueva-funcionalidad
   ```

5. **Crea un Pull Request.**

## Licencia

Este proyecto está bajo la Licencia MIT - consulta el archivo [LICENSE](LICENSE) para más detalles.

## Contacto

Si tienes preguntas o necesitas más información, puedes contactarme:

- **Email:** isaiin.dev@gmail.com
- **GitHub:** [isaiin-dev](https://github.com/isaiin-dev)

---

¡Gracias por tu interés en STORI Movies! Espero que disfrutes explorando y utilizando este proyecto.
