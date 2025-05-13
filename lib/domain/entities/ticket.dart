enum TicketStatus { newTicket, inProgress, assigned, resolved }
enum TicketPriority { low, medium, high }

class Ticket {
  final String id;
  final String title;
  final String description;
  final TicketStatus status;
  final TicketPriority priority;
  final String category;
  final String productId;
  final String technicianId;
  final DateTime createdAt;

  Ticket({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.category,
    required this.productId,
    required this.technicianId,
    required this.createdAt,
  });
}
