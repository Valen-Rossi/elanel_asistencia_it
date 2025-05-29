enum TicketStatus { newTicket, inProgress, assigned, resolved }
enum TicketPriority { low, medium, high }
// enum TicketCategory {
//   hardware,
//   software,
//   network,        // Problemas de conexión, Wi-Fi, VPN, etc.
//   access,         // Problemas de inicio de sesión, permisos, cuentas bloqueadas
//   peripheral,     // Impresoras, teclados, escáneres, etc.
//   configuration,  // Malas configuraciones, instalaciones, ajustes de sistema
//   security,       // Antivirus, incidentes sospechosos, bloqueo de contenido
//   other,          // Casos especiales
// }


class Ticket {
  final String id;
  final String title;
  final String description;
  final TicketStatus status;
  final TicketPriority priority;
  final String category;
  final String deviceId;
  final String technicianId;
  final DateTime createdAt;

  Ticket({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.category,
    required this.deviceId,
    required this.technicianId,
    required this.createdAt,
  });
}
