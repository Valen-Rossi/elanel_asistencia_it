import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elanel_asistencia_it/domain/entities/ticket.dart';
import 'package:elanel_asistencia_it/presentation/providers/tickets/tickets_providers.dart';

final ticketByIdProvider = Provider.family<Ticket, String>((ref, ticketId) {
  final tickets = ref.watch(recentTicketsProvider);
  return tickets.firstWhere((ticket) => ticket.id == ticketId,);
});
