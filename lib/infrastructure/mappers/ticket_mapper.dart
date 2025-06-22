import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elanel_asistencia_it/domain/entities/ticket.dart';
import 'package:elanel_asistencia_it/infrastructure/models/firebase/ticket_firebase.dart';

class TicketMapper {
  static Ticket fromFirebase(TicketFromFirebase fb) => Ticket(
        id: fb.id,
        title: fb.title,
        description: fb.description,
        status: TicketStatusX.fromString(fb.status),
        priority: TicketPriorityX.fromString(fb.priority),
        category: TicketCategoryX.fromString(fb.category),
        otherCaregory: fb.otherCategory,
        createdById: fb.createdById,
        createdByEmail: fb.createdByEmail,
        createdByName: fb.createdByName,
        deviceId: fb.deviceId,
        technicianId: fb.technicianId,
        createdAt: fb.createdAt.toDate(),
        assignedAt: fb.assignedAt.toDate(),
        openedAt: fb.openedAt.toDate(),
        closedAt: fb.closedAt.toDate(),
        hasFeedback: fb.hasFeedback,
      );

  static TicketFromFirebase toFirebase(Ticket t) => TicketFromFirebase(
        id: t.id,
        title: t.title,
        description: t.description,
        status: t.status.name,
        priority: t.priority.name,
        category: t.category.name,
        otherCategory: t.otherCaregory,
        createdById: t.createdById,
        createdByEmail: t.createdByEmail,
        createdByName: t.createdByName,
        deviceId: t.deviceId,
        technicianId: t.technicianId,
        createdAt: Timestamp.fromDate(t.createdAt),
        assignedAt: Timestamp.fromDate(t.assignedAt),
        openedAt: Timestamp.fromDate(t.openedAt),
        closedAt: Timestamp.fromDate(t.closedAt),
        hasFeedback: t.hasFeedback,
      );
}
