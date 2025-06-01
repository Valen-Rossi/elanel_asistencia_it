enum TicketStatus { newTicket, inProgress, assigned, resolved }
enum TicketPriority { low, medium, high }
enum TicketCategory {
  hardware,
  software,
  account,         // Problemas de inicio de sesión, permisos, cuentas bloqueadas
  network,
  other,          // Casos especiales
}


class Ticket {
  final String id;
  final String title;
  final String description;
  final TicketStatus status;
  final TicketPriority priority;
  final TicketCategory category;
  final String otherCaregory;
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
    required this.otherCaregory,
    required this.deviceId,
    required this.technicianId,
    required this.createdAt,
  });
}
