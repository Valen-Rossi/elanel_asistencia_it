import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elanel_asistencia_it/domain/entities/ticket.dart';
import 'tickets_providers.dart';

// 1. Estado para los filtros
class TicketFilterState {
  final TicketStatus? status;
  final TicketPriority? priority;
  final TicketCategory? category;

  const TicketFilterState({
    this.status,
    this.priority,
    this.category,
  });

  static const _noChange = Object();

  TicketFilterState copyWith({
    Object? status = _noChange,
    Object? priority = _noChange,
    Object? category = _noChange,
  }) {
    return TicketFilterState(
      status: status == _noChange ? this.status : status as TicketStatus?,
      priority: priority == _noChange ? this.priority : priority as TicketPriority?,
      category: category == _noChange ? this.category : category as TicketCategory?,
    );
  }

  static const empty = TicketFilterState();
}

// 2. Provider para el estado del filtro
final ticketFilterProvider = StateProvider<TicketFilterState>((ref) => TicketFilterState.empty);

// 3. Provider para la lista filtrada
final filteredTicketsProvider = Provider<List<Ticket>>((ref) {
  final filter = ref.watch(ticketFilterProvider);
  final allTickets = ref.watch(recentTicketsProvider);

  return allTickets.where((ticket) {
    final matchStatus = filter.status == null || ticket.status == filter.status;
    final matchPriority = filter.priority == null || ticket.priority == filter.priority;
    final matchCategory = filter.category == null || ticket.category == filter.category;
    return matchStatus && matchPriority && matchCategory;
  }).toList();
});
