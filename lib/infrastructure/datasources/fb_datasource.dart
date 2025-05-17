
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
      Ticket(
        id: '3',
        title: 'Ticket 3',
        description: 'Description 3',
        status: TicketStatus.resolved,
        priority: TicketPriority.high,
        category: 'Category 3',
        productId: 'Product 3',
        technicianId: 'Technician 3',
        createdAt: DateTime.now(),
      ),
      Ticket(
        id: '4',
        title: 'Ticket 4',
        description: 'Description 4',
        status: TicketStatus.newTicket,
        priority: TicketPriority.low,
        category: 'Category 4',
        productId: 'Product 4',
        technicianId: 'Technician 4',
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
      ),
      Ticket(
        id: '5',
        title: 'Ticket 5',
        description: 'Description 5',
        status: TicketStatus.inProgress,
        priority: TicketPriority.medium,
        category: 'Category 5',
        productId: 'Product 5',
        technicianId: 'Technician 5',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Ticket(
        id: '6',
        title: 'Ticket 6',
        description: 'Description 6',
        status: TicketStatus.resolved,
        priority: TicketPriority.high,
        category: 'Category 6',
        productId: 'Product 6',
        technicianId: 'Technician 6',
        createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
      ),
      Ticket(
        id: '7',
        title: 'Ticket 7',
        description: 'Description 7',
        status: TicketStatus.newTicket,
        priority: TicketPriority.low,
        category: 'Category 7',
        productId: 'Product 7',
        technicianId: 'Technician 7',
        createdAt: DateTime.now().subtract(const Duration(minutes: 20)),
      ),
      Ticket(
        id: '8',
        title: 'Ticket 8',
        description: 'Description 8',
        status: TicketStatus.inProgress,
        priority: TicketPriority.medium,
        category: 'Category 8',
        productId: 'Product 8',
        technicianId: 'Technician 8',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
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