import 'package:elanel_asistencia_it/domain/datasources/tickets_datasource.dart';
import 'package:elanel_asistencia_it/domain/entities/ticket.dart';
import 'package:elanel_asistencia_it/domain/repositories/tickets_repository.dart';


class TicketsRepositoryImpl extends TicketsRepository {

  final TicketsDatasource datasource;

  TicketsRepositoryImpl(this.datasource);
  
  @override
  Future<List<Ticket>> getTickets() {

    return datasource.getTickets();

  }
  
  @override
  Future<void> addTicket(Ticket ticket) {
    // TODO: implement addTicket
    throw UnimplementedError();
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