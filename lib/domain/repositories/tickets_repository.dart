import 'package:elanel_asistencia_it/domain/entities/ticket.dart';


abstract class ITicketsRepository {

  Future<List<Ticket>> getTickets();
  Future<void> addTicket(Ticket ticket);
  Future<void> updateTicket(Ticket ticket);
  Future<void> deleteTicket(String id);
  
}