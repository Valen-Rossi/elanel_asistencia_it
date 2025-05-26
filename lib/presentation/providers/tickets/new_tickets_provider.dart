import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elanel_asistencia_it/domain/entities/ticket.dart';
import 'package:elanel_asistencia_it/presentation/providers/tickets/tickets_providers.dart';


final newTicketsProvider = Provider<List<Ticket>>((ref) {
  final recentTickets = ref.watch(recentTicketsProvider);
  return recentTickets.where((ticket) => ticket.status == TicketStatus.newTicket).toList();
});