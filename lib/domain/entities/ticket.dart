import 'package:flutter/material.dart';
enum TicketStatus { newTicket, inProgress, resolved }
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

extension TicketCopy on Ticket {
  Ticket copyWith({
    String? technicianId,
    TicketPriority? priority,
    // otros campos si querés
  }) {
    return Ticket(
      id: id,
      title: title,
      description: description,
      status: status,
      priority: priority ?? this.priority,
      category: category,
      otherCaregory: otherCaregory,
      deviceId: deviceId,
      technicianId: technicianId ?? this.technicianId,
      createdAt: createdAt,
    );
  }

}

extension TicketStatusText on TicketStatus {
  String get label {
    switch (this) {
      case TicketStatus.newTicket:
        return 'Nuevo';
      case TicketStatus.inProgress:
        return 'En curso';
      case TicketStatus.resolved:
        return 'Resuelto';
    }
  }
}

extension TicketPriorityText on TicketPriority {
  String get label {
    switch (this) {
      case TicketPriority.low:
        return 'Baja';
      case TicketPriority.medium:
        return 'Media';
      case TicketPriority.high:
        return 'Alta';
    }
  }
}

extension TicketCategoryText on TicketCategory {
  String get label {
    switch (this) {
      case TicketCategory.hardware:
        return 'Hardware';
      case TicketCategory.software:
        return 'Software';
      case TicketCategory.account:
        return 'Cuenta';
      case TicketCategory.network:
        return 'Red';
      case TicketCategory.other:
        return 'Otro';
    }
  }
}

extension TicketStatusColor on TicketStatus {
  Color get color {
    switch (this) {
      case TicketStatus.newTicket:
        return const Color.fromARGB(37, 36, 196, 218);
      case TicketStatus.inProgress:
        return const Color.fromARGB(37, 231, 151, 60);
      case TicketStatus.resolved:
        return const Color.fromARGB(37, 73, 217, 109);
    }
  }
}

extension TicketCategoryColor on TicketCategory {
  Color get color {
    switch (this) {
      case TicketCategory.hardware:
        return const Color.fromARGB(36, 80, 255, 208);
      case TicketCategory.software:
        return const Color.fromRGBO(224, 113, 255, 0.141);
      case TicketCategory.account:
        return const Color.fromARGB(37, 36, 196, 218);
      case TicketCategory.network:
        return const Color.fromARGB(31, 98, 195, 255);
      case TicketCategory.other:
        return const Color.fromARGB(37, 189, 189, 189);
    }
  }
}

extension TicketPriorityColor on TicketPriority {
  Color get color {
    switch (this) {
      case TicketPriority.low:
        return const Color.fromARGB(37, 73, 217, 109);
      case TicketPriority.medium:
        return const Color.fromARGB(37, 231, 151, 60);
      case TicketPriority.high:
        return const Color.fromARGB(36, 255, 71, 71);
    }
  }
}