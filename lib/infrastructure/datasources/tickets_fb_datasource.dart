import 'package:elanel_asistencia_it/domain/datasources/tickets_datasource.dart';
import 'package:elanel_asistencia_it/domain/entities/ticket.dart';

class TicketsFbDatasource extends ITicketsDatasource {

  final List<Ticket> tickets = [
    Ticket(
      id: '001',
      title: 'Problema con impresora HP: no funciona',
      description: 'La impresora HP conectada al escritorio de recepción no imprime documentos en formato PDF. El sistema muestra constantemente un error de "trabajo en cola", incluso después de reiniciar tanto la impresora como el equipo. Ya se intentó borrar la cola manualmente, pero el problema persiste.',
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
      title: 'Configuración de red incompleta en nuevo router',
      description: 'Se instaló un nuevo router en el sector administrativo, pero no está asignando direcciones IP automáticamente a los dispositivos conectados. Se sospecha que el servicio DHCP no está habilitado o presenta un fallo de configuración. Es necesario revisar tanto la configuración web del router como posibles conflictos con la red principal.',
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
      title: 'Actualización de software contable versión 2025.1',
      description: 'Se solicita la actualización del sistema contable a la nueva versión 2025.1 para asegurar compatibilidad con los cambios fiscales vigentes. Esta actualización debe realizarse fuera del horario laboral para evitar interrupciones. También se requiere hacer una copia de seguridad completa antes del proceso.',
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
      title: 'Error al iniciar sesión en la intranet de la empresa',
      description: 'Varios usuarios reportan que no pueden iniciar sesión en la intranet corporativa con sus credenciales habituales. El sistema muestra un mensaje de "usuario o contraseña inválidos", pero las credenciales son correctas. Se sospecha un problema con el servidor de autenticación o una caída del sistema LDAP.',
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
      title: 'Correo electrónico no funciona en Outlook',
      description: 'Los usuarios de Outlook no pueden enviar correos electrónicos. Al intentar enviar un mensaje, aparece un error relacionado con el servidor SMTP. Ya se reiniciaron las configuraciones del cliente de correo, pero el error persiste. Se necesita revisar los parámetros del servidor de correo saliente.',
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
      title: 'Pantalla azul en laptop al iniciar sesión',
      description: 'La laptop del área de dirección general muestra una pantalla azul con código de error al intentar iniciar sesión. Esto ocurre incluso en modo seguro, lo que sugiere un problema serio en el sistema operativo. Es urgente realizar un diagnóstico de memoria y disco.',
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
      title: 'Solicitar nuevo monitor para el puesto de recepción',
      description: 'El monitor actual del puesto de recepción presenta fallas visibles: parpadea constantemente y muestra líneas verticales que dificultan la lectura. Se solicita la reposición por uno nuevo o revisión del cableado.',
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
      title: 'Fallo en la ejecución del backup diario automático',
      description: 'El sistema de copias de seguridad ha dejado de generar los backups programados diariamente desde hace una semana. Se necesita revisar el servicio de tareas programadas y comprobar que el almacenamiento tenga espacio disponible. También es importante validar que el software de backup esté actualizado.',
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