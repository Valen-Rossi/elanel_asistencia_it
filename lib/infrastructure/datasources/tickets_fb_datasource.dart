import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elanel_asistencia_it/domain/datasources/tickets_datasource.dart';
import 'package:elanel_asistencia_it/domain/entities/ticket.dart';
import 'package:elanel_asistencia_it/domain/entities/user.dart';
import 'package:elanel_asistencia_it/infrastructure/mappers/ticket_mapper.dart';
import 'package:elanel_asistencia_it/infrastructure/models/firebase/ticket_firebase.dart';

class TicketsFbDatasource extends ITicketsDatasource {
  final _db = FirebaseFirestore.instance.collection('tickets');

  @override
  Future<List<Ticket>> getTickets(User? user) async {
    
    final snap = await _db.orderBy('createdAt', descending: true).get();

    return user == null || user.role == UserRole.admin
        ? snap.docs
            .map((d) => TicketMapper.fromFirebase(
                TicketFromFirebase.fromJson(d.id, d.data())))
            .toList()
        : user.role == UserRole.client 
            ? snap.docs
                .where((d) => d.data()['createdById'] == user.id)
                .map((d) => TicketMapper.fromFirebase(
                    TicketFromFirebase.fromJson(d.id, d.data())))
                .toList()
            : snap.docs
                .where((d) => d.data()['technicianId'] == user.id)
                .map((d) => TicketMapper.fromFirebase(
                    TicketFromFirebase.fromJson(d.id, d.data())))
                .toList();
  }

  @override
  Future<void> addTicket(Ticket ticket) async {
    final docRef = _db.doc(); // genera un nuevo id
    final newTicket = ticket.copyWith(id: docRef.id); // copiás el ticket con ese id

    final ticketfb = TicketMapper.toFirebase(newTicket);
    await docRef.set(ticketfb.toJson());
  }

  @override
  Future<void> updateTicket(Ticket ticket) async {
    final fb = TicketMapper.toFirebase(ticket);
    await _db.doc(ticket.id).update(fb.toJson());
  }

  @override
  Future<void> deleteTicket(String id) async {
    await _db.doc(id).delete();
  }
}
