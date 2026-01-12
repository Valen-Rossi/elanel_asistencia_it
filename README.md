<p align="center">
  <img src="assets/images/elanel.png" alt="Logo Elanel IT" width="200px">
</p>

# Elanel Asistencia IT - Gestión de Soporte Técnico

<p align="left">
   <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" />
   <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" />
   <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" />
</p>

## 📝 Descripción
Esta aplicación fue diseñada para optimizar la gestión de incidentes técnicos en **Elanel IT**. Permite a los técnicos y administradores centralizar el flujo de trabajo de reparaciones, mantenimiento preventivo y control de inventario de dispositivos.

### Características Principales:
- 🎫 **Gestión de Tickets:** Creación, asignación y seguimiento de estados en tiempo real.
- 🔍 **Escaneo QR:** Identificación rápida de dispositivos mediante códigos QR.
- 📊 **Inventario:** Control detallado de hardware y software por usuario.
- 🌓 **Modo Oscuro/Claro:** Interfaz adaptativa mediante Riverpod.

### 📸 Galería del Proyecto

<div align="center">
  <table>
    <tr>
      <td align="center"><b>Vista Principal</b></td>
      <td align="center"><b>Gestión de Tickets</b></td>
      <td align="center"><b>Detalle de Ticket</b></td>
    </tr>
    <tr>
      <td><img src="assets/images/home.jpg" width="220"></td>
      <td><img src="assets/images/tickets.jpg" width="220"></td>
      <td><img src="assets/images/detalle.jpg" width="220"></td>
    </tr>
  </table>
</div>

<details>
  <summary><b>👉 Ver capturas adicionales por categoría (Click para desplegar)</b></summary>
  <br>

  #### 🎫 Gestión de Tickets y Usuarios
  | Nuevo Ticket | Listado de Usuarios | Ficha de Perfil | Registro de Usuario |
  | :---: | :---: | :---: | :---: |
  | <img src="assets/images/nuevoticket.jpg" width="180"> | <img src="assets/images/usuarios.jpg" width="180"> | <img src="assets/images/ficha.jpg" width="180"> | <img src="assets/images/crearusuario.jpg" width="180"> |

  #### 📦 Inventario y Dispositivos
  | Vista Inventario | Detalle de Dispositivo | Alta de Activo |
  | :---: | :---: | :---: |
  | <img src="assets/images/inventario.jpg" width="180"> | <img src="assets/images/dispositivo.jpg" width="180"> | <img src="assets/images/creardispositivo.jpg" width="180"> |

  #### 💡 Centro de Ayuda (FAQ)
  | Preguntas Frecuentes | Visualización de Solución | Nueva Pregunta |
  | :---: | :---: | :---: |
  | <img src="assets/images/preguntas.jpg" width="180"> | <img src="assets/images/solucion.jpg" width="180"> | <img src="assets/images/nuevapregunta.jpg" width="180"> |

</details>

## 🏗️ Arquitectura y Stack Técnico

El proyecto sigue los principios de **Clean Architecture**, separando las responsabilidades en capas bien definidas para facilitar el mantenimiento y la escalabilidad:

- **Domain:** Entidades de negocio y contratos (Repositories).
- **Infrastructure:** Implementación de repositorios, Data Sources y Mappers para Firebase.
- **Presentation:** UI con widgets optimizados y gestión de estado reactiva.

### Tecnologías utilizadas:
- **Estado:** [Riverpod](https://riverpod.dev/) (StateNotifier y Providers).
- **Navegación:** [GoRouter](https://pub.dev/packages/go_router) para manejo de rutas declarativas.
- **Backend:** Firebase (Firestore para base de datos y Auth para seguridad).
- **Estilo:** Material 3 con Temas personalizados.

## ✉️ Contacto
Luca Valentino Rossi - [valerossi2004@gmail.com](mailto:valerossi2004@gmail.com) - [LinkedIn](https://www.linkedin.com/in/valentino-rossi-1b2819338/)
