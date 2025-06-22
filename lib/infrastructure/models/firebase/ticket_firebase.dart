import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elanel_asistencia_it/domain/entities/ticket.dart';

class TicketFromFirebase {
  final String id;
  final String title;
  final String description;
  final String status;
  final String priority;
  final String category;
  final String otherCategory;
  final String createdById;
  final String createdByEmail;
  final String createdByName;
  final String deviceId;
  final String technicianId;
  final Timestamp createdAt;
  final Timestamp assignedAt;
  final Timestamp openedAt;
  final Timestamp closedAt;
  final bool hasFeedback;

  TicketFromFirebase({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.category,
    required this.otherCategory,
    required this.createdById,
    required this.createdByEmail,
    required this.createdByName,
    required this.deviceId,
    required this.technicianId,
    required this.createdAt,
    required this.assignedAt,
    required this.openedAt,
    required this.closedAt,
    required this.hasFeedback,
  });

  factory TicketFromFirebase.fromJson(String id, Map<String, dynamic> json) =>
      TicketFromFirebase(
        id: id,
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        status: json['status'] ?? TicketStatus.newTicket.name,
        priority: json['priority'] ?? TicketPriority.low.name,
        category: json['category'] ?? TicketCategory.other.name,
        otherCategory: json['otherCategory'] ?? '',
        createdById: json['createdById'] ?? '',
        createdByEmail: json['createdBy_email'] ?? '',
        createdByName: json['createdBy_name'] ?? '',
        deviceId: json['deviceId'] ?? '',
        technicianId: json['technicianId'] ?? '',
        createdAt: json['createdAt'] as Timestamp? ?? Timestamp.now(),
        assignedAt: (json['assignedAt']!=null) 
            ? json['assignedAt'] as Timestamp
            : Timestamp.now(),
        openedAt: (json['openedAt']!=null) 
            ? json['openedAt'] as Timestamp
            : Timestamp.now(),
        closedAt: (json['closedAt']!=null) 
            ? json['closedAt'] as Timestamp
            : Timestamp.now(),
        hasFeedback: json['hasFeedback'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'status': status,
        'priority': priority,
        'category': category,
        'otherCategory': otherCategory,
        'deviceId': deviceId,
        'createdById': createdById,
        'createdBy_email': createdByEmail,
        'createdBy_name': createdByName,
        'technicianId': technicianId,
        'createdAt': createdAt,
        'assignedAt': assignedAt,
        'openedAt': openedAt,
        'closedAt': closedAt,
        'hasFeedback': hasFeedback,
      };
}