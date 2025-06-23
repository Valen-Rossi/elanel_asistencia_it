import 'package:elanel_asistencia_it/domain/datasources/tickets_datasource.dart';
import 'package:elanel_asistencia_it/domain/entities/ticket.dart';
import 'package:elanel_asistencia_it/domain/entities/user.dart';

class TicketsRepositoryImpl implements ITicketsDatasource {
  final ITicketsDatasource datasource;
  
  TicketsRepositoryImpl(this.datasource);

  @override
  Future<void> addTicket(Ticket t) => datasource.addTicket(t);

  @override
  Future<void> deleteTicket(String id) => datasource.deleteTicket(id);

  @override
  Future<List<Ticket>> getTickets(User? user) => datasource.getTickets(user);

  @override
  Future<void> updateTicket(Ticket t) => datasource.updateTicket(t);
}
