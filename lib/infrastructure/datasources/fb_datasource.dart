
import 'package:elanel_asistencia_it/domain/datasources/tickets_datasource.dart';
import 'package:elanel_asistencia_it/domain/entities/ticket.dart';

class FbDatasource extends TicketsDatasource {
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
  Future<List<Ticket>> getTickets() async{
    // Todo: implementar getTickets con dio o fb

    final List<Ticket> tickets = [
      Ticket(
        id: '1',
        title: 'Ticket 1',
        description: 'Description 1',
        status: TicketStatus.newTicket,
        priority: TicketPriority.low,
        category: 'Category 1',
        productId: 'Product 1',
        technicianId: 'Technician 1',
        createdAt: DateTime.now(),
      ),
      Ticket(
        id: '2',
        title: 'Ticket 2',
        description: 'Description 2',
        status: TicketStatus.inProgress,
        priority: TicketPriority.medium,
        category: 'Category 2',
        productId: 'Product 2',
        technicianId: 'Technician 2',
        createdAt: DateTime.now(),
      ),
    ];

    return tickets;
  }

  @override
  Future<void> updateTicket(Ticket ticket) {
    // TODO: implement updateTicket
    throw UnimplementedError();
  }
  
}