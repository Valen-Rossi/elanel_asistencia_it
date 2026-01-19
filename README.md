<p align="center">
  <img src="assets/images/elanel.png" alt="Logo Elanel IT" width="200px">
</p>

# Elanel Asistencia IT - Gestión de Soporte Técnico / Technical Support Management

<p align="left">
   <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" />
   <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" />
   <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" />
</p>

## 📝 Descripción / Description
Esta aplicación fue diseñada para optimizar la gestión de incidentes técnicos en **Elanel IT**. Permite a los técnicos y administradores centralizar el flujo de trabajo de reparaciones, mantenimiento preventivo y control de inventario de dispositivos.

This application was designed to optimize technical incident management at **Elanel IT**. It allows technicians and administrators to centralize the workflow for repairs, preventive maintenance, and device inventory control.

### Características Principales / Key Features:
- 🎫 **Gestión de Tickets / Ticket Management:** Creación, asignación y seguimiento de estados en tiempo real. / Creation, assignment, and real-time status tracking.
- 🔍 **Escaneo QR / QR Scanning:** Identificación rápida de dispositivos mediante códigos QR. / Quick device identification using QR codes.
- 📊 **Inventario / Inventory:** Control detallado de hardware y software por usuario. / Detailed hardware and software control per user.
- 🌓 **Modo Oscuro/Claro / Dark/Light Mode:** Interfaz adaptativa mediante Riverpod. / Adaptive interface powered by Riverpod.

### 📸 Galería del Proyecto / Project Gallery

<div align="center">
  <table>
    <tr>
      <td align="center"><b>Vista Principal / Main View</b></td>
      <td align="center"><b>Gestión de Tickets / Ticket Management</b></td>
      <td align="center"><b>Detalle de Ticket / Ticket Details</b></td>
    </tr>
    <tr>
      <td><img src="assets/images/home.jpg" width="220"></td>
      <td><img src="assets/images/tickets.jpg" width="220"></td>
      <td><img src="assets/images/detalle.jpg" width="220"></td>
    </tr>
  </table>
</div>

<details>
  <summary><b>👉 Ver capturas adicionales por categoría (Click para desplegar) / See more screenshots by category (Click to expand)</b></summary>
  <br>

  #### 🎫 Gestión de Tickets y Usuarios / Ticket and User Management
  | Nuevo Ticket / New Ticket | Usuarios / Users | Perfil / Profile | Registro / Registration |
  | :---: | :---: | :---: | :---: |
  | <img src="assets/images/nuevoticket.jpg" width="180"> | <img src="assets/images/usuarios.jpg" width="180"> | <img src="assets/images/ficha.jpg" width="180"> | <img src="assets/images/crearusuario.jpg" width="180"> |

  #### 📦 Inventario y Dispositivos / Inventory and Devices
  | Inventario / Inventory | Detalle / Details | Alta / New Asset |
  | :---: | :---: | :---: |
  | <img src="assets/images/inventario.jpg" width="180"> | <img src="assets/images/dispositivo.jpg" width="180"> | <img src="assets/images/creardispositivo.jpg" width="180"> |

  #### 💡 Centro de Ayuda (FAQ) / Help Center
  | Preguntas / FAQ | Solución / Solution | Nueva Pregunta / New Question |
  | :---: | :---: | :---: |
  | <img src="assets/images/preguntas.jpg" width="180"> | <img src="assets/images/solucion.jpg" width="180"> | <img src="assets/images/nuevapregunta.jpg" width="180"> |

</details>

## 🏗️ Arquitectura y Stack Técnico / Architecture and Technical Stack

El proyecto sigue los principios de **Clean Architecture**, separando las responsabilidades en capas bien definidas para facilitar el mantenimiento y la escalabilidad:

The project follows **Clean Architecture** principles, separating responsibilities into well-defined layers to facilitate maintenance and scalability:

- **Domain:** Entidades de negocio y contratos (Repositories). / Business entities and contracts (Repositories).
- **Infrastructure:** Implementación de repositorios, Data Sources y Mappers para Firebase. / Repository implementation, Data Sources, and Mappers for Firebase.
- **Presentation:** UI con widgets optimizados y gestión de estado reactiva. / UI with optimized widgets and reactive state management.

### Tecnologías utilizadas / Technologies used:
- **Estado / State:** [Riverpod](https://riverpod.dev/) (StateNotifier & Providers).
- **Navegación / Navigation:** [GoRouter](https://pub.dev/packages/go_router).
- **Backend:** Firebase (Firestore & Auth).
- **Estilo / Style:** Material 3.

## ✉️ Contacto / Contact
Luca Valentino Rossi - [valerossi2004@gmail.com](mailto:valerossi2004@gmail.com) - [LinkedIn](https://www.linkedin.com/in/lucavalentinorossi/)
