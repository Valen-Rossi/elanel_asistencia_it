import 'package:elanel_asistencia_it/domain/entities/ticket.dart';
import 'package:elanel_asistencia_it/domain/entities/user.dart';


abstract class ITicketsRepository {

  Future<List<Ticket>> getTickets(User? user);
  Future<void> addTicket(Ticket ticket);
  Future<void> updateTicket(Ticket ticket);
  Future<void> deleteTicket(String id);
  
}