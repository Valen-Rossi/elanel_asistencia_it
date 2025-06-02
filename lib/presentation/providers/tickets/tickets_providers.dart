import 'package:elanel_asistencia_it/domain/entities/ticket.dart';
import 'package:elanel_asistencia_it/presentation/providers/tickets/tickets_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final recentTicketsProvider = StateNotifierProvider<TicketsNotifier, List<Ticket>>((ref) {
  final repository = ref.watch(ticketRepositoryProvider);
  return TicketsNotifier(
    fetchTickets: repository.getTickets,
    addTicket: repository.addTicket,
    ticketUpdate: repository.updateTicket,
  );
});


typedef TicketCallback = Future<List<Ticket>> Function();
typedef TicketAddCallback = Future<void> Function(Ticket ticket);
typedef TicketUpdateCallback = Future<void> Function(Ticket ticket);

class TicketsNotifier extends StateNotifier<List<Ticket>> {

  bool isLoading = false;
  final TicketCallback fetchTickets;
  final TicketAddCallback addTicket;
  final TicketUpdateCallback ticketUpdate;

  TicketsNotifier({
    required this.fetchTickets,
    required this.addTicket,
    required this.ticketUpdate,
  }) : super([]);

  Future<void> loadTickets() async {
    if (isLoading) return;

    isLoading = true;

    final List<Ticket> tickets = await fetchTickets();
    state = [...tickets];

    isLoading = false;
  }

  Future<void> createTicket(Ticket ticket) async {
    
    if (isLoading) return;

    isLoading = true;
    
    await addTicket(ticket);
    state = [ticket, ...state];
    
    isLoading = false;
  }

  Future<void> updateTicket(Ticket updatedTicket) async {
    if (isLoading) return;

    isLoading = true;

    await ticketUpdate(updatedTicket);

    state = state.map((ticket) {
      return ticket.id == updatedTicket.id ? updatedTicket : ticket;
    }).toList();

    isLoading = false;
  }

}
