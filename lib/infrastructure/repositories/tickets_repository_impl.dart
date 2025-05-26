import 'package:elanel_asistencia_it/domain/datasources/tickets_datasource.dart';
import 'package:elanel_asistencia_it/domain/entities/ticket.dart';
import 'package:elanel_asistencia_it/domain/repositories/tickets_repository.dart';


class TicketsRepositoryImpl extends ITicketsRepository {

  final ITicketsDatasource datasource;

  TicketsRepositoryImpl(this.datasource);
  
  @override
  Future<List<Ticket>> getTickets() {
    return datasource.getTickets();
  }
  
  @override
  Future<void> addTicket(Ticket ticket) {
    return datasource.addTicket(ticket);
  }
  
  @override
  Future<void> deleteTicket(String id) {
    // TODO: implement deleteTicket
    throw UnimplementedError();
  }
  
  @override
  Future<void> updateTicket(Ticket ticket) {
    // TODO: implement updateTicket
    throw UnimplementedError();
  }
  
}