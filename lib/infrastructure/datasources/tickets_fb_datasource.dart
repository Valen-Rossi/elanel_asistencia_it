import 'package:elanel_asistencia_it/domain/datasources/tickets_datasource.dart';
import 'package:elanel_asistencia_it/domain/entities/ticket.dart';

class TicketsFbDatasource extends ITicketsDatasource {

  final List<Ticket> tickets = [
    Ticket(
      id: '001',
      title: 'Problema con impresora HP: no funciona',
      description: 'La impresora no imprime documentos PDF. Aparece un error de "trabajo en cola".',
      status: TicketStatus.newTicket,
      priority: TicketPriority.medium,
      category: TicketCategory.hardware,
      otherCaregory: '',
      deviceId: '001',
      technicianId: '002',
      createdAt: DateTime.now(),
    ),
    Ticket(
      id: '002',
      title: 'Configuración de red',
      description: 'El nuevo router no distribuye IPs a través de DHCP.',
      status: TicketStatus.inProgress,
      priority: TicketPriority.high,
      category: TicketCategory.network,
      otherCaregory: '',
      deviceId: '003',
      technicianId: '007',
      createdAt: DateTime.now().subtract(const Duration(minutes: 9)),
    ),
    Ticket(
      id: '003',
      title: 'Actualización de software',
      description: 'Solicitada actualización del sistema contable a versión 2025.1.',
      status: TicketStatus.resolved,
      priority: TicketPriority.low,
      category: TicketCategory.software,
      otherCaregory: '',
      deviceId: '002',
      technicianId: '008',
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    Ticket(
      id: '004',
      title: 'Error al iniciar sesión',
      description: 'Usuarios no pueden iniciar sesión en la intranet corporativa.',
      status: TicketStatus.newTicket,
      priority: TicketPriority.high,
      category: TicketCategory.account,
      otherCaregory: '',
      deviceId: '001',
      technicianId: '005',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Ticket(
      id: '005',
      title: 'Correo electrónico no funciona',
      description: 'No se pueden enviar correos desde Outlook, error de servidor SMTP.',
      status: TicketStatus.inProgress,
      priority: TicketPriority.medium,
      category: TicketCategory.account,
      otherCaregory: '',
      deviceId: '003',
      technicianId: '002',
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
    ),
    Ticket(
      id: '006',
      title: 'Pantalla azul en laptop',
      description: 'Laptop de dirección muestra pantalla azul al iniciar.',
      status: TicketStatus.resolved,
      priority: TicketPriority.high,
      category: TicketCategory.software,
      otherCaregory: '',
      deviceId: '002',
      technicianId: '005',
      createdAt: DateTime.now().subtract(const Duration(days: 8)),
    ),
    Ticket(
      id: '007',
      title: 'Solicitar nuevo monitor',
      description: 'El monitor actual parpadea y tiene líneas verticales.',
      status: TicketStatus.newTicket,
      priority: TicketPriority.low,
      category: TicketCategory.hardware,
      otherCaregory: '',
      deviceId: '002',
      technicianId: '007',
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
    ),
    Ticket(
      id: '008',
      title: 'Fallo en backup diario',
      description: 'El sistema de backups no está generando las copias de seguridad automáticas.',
      status: TicketStatus.inProgress,
      priority: TicketPriority.high,
      category: TicketCategory.software,
      otherCaregory: '',
      deviceId: '001',
      technicianId: '008',
      createdAt: DateTime.now().subtract(const Duration(days: 31)),
    ),
  ];

  @override
  Future<void> addTicket(Ticket ticket) async{
    // TODO: implement addTicket
    tickets.insert(0, ticket);
  }

  @override
  Future<void> deleteTicket(String id) {
    // TODO: implement deleteTicket
    throw UnimplementedError();
  }

  @override
  Future<List<Ticket>> getTickets() async{
    // Todo: implementar getTickets con dio o fb
    return tickets;
  }

  @override
  Future<void> updateTicket(Ticket ticket) async{
    // TODO: implement updateTicket
    final index = tickets.indexWhere((t) => t.id == ticket.id);
    if (index != -1) {
      tickets[index] = ticket;
    }
  }
  
}