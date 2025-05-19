
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
        id: '001',
        title: 'Problema con impresora HP: no funciona',
        description: 'La impresora no imprime documentos PDF. Aparece un error de "trabajo en cola".',
        status: TicketStatus.newTicket,
        priority: TicketPriority.medium,
        category: 'Hardware',
        productId: '101',
        technicianId: '201',
        createdAt: DateTime.now(),
      ),
      Ticket(
        id: '002',
        title: 'Configuración de red',
        description: 'El nuevo router no distribuye IPs a través de DHCP.',
        status: TicketStatus.inProgress,
        priority: TicketPriority.high,
        category: 'Redes',
        productId: '102',
        technicianId: '202',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Ticket(
        id: '003',
        title: 'Actualización de software',
        description: 'Solicitada actualización del sistema contable a versión 2025.1.',
        status: TicketStatus.resolved,
        priority: TicketPriority.low,
        category: 'Software',
        productId: '103',
        technicianId: '203',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Ticket(
        id: '004',
        title: 'Error al iniciar sesión',
        description: 'Usuarios no pueden iniciar sesión en la intranet corporativa.',
        status: TicketStatus.newTicket,
        priority: TicketPriority.high,
        category: 'Autenticación',
        productId: '104',
        technicianId: '204',
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
      ),
      Ticket(
        id: '005',
        title: 'Correo electrónico no funciona',
        description: 'No se pueden enviar correos desde Outlook, error de servidor SMTP.',
        status: TicketStatus.inProgress,
        priority: TicketPriority.medium,
        category: 'Correo',
        productId: '105',
        technicianId: '205',
        createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      ),
      Ticket(
        id: '006',
        title: 'Pantalla azul en laptop',
        description: 'Laptop de dirección muestra pantalla azul al iniciar.',
        status: TicketStatus.resolved,
        priority: TicketPriority.high,
        category: 'Hardware',
        productId: '106',
        technicianId: '206',
        createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
      ),
      Ticket(
        id: '007',
        title: 'Solicitar nuevo monitor',
        description: 'El monitor actual parpadea y tiene líneas verticales.',
        status: TicketStatus.newTicket,
        priority: TicketPriority.low,
        category: 'Solicitudes',
        productId: '107',
        technicianId: '207',
        createdAt: DateTime.now().subtract(const Duration(minutes: 20)),
      ),
      Ticket(
        id: '008',
        title: 'Fallo en backup diario',
        description: 'El sistema de backups no está generando las copias de seguridad automáticas.',
        status: TicketStatus.inProgress,
        priority: TicketPriority.high,
        category: 'Infraestructura',
        productId: '108',
        technicianId: '208',
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