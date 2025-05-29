import 'package:elanel_asistencia_it/domain/entities/ticket.dart';
import 'package:elanel_asistencia_it/presentation/providers/tickets/tickets_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final recentTicketsProvider = StateNotifierProvider<TicketsNotifier, List<Ticket>>((ref) {
  final repository = ref.watch(ticketRepositoryProvider);
  return TicketsNotifier(
    fetchTickets: repository.getTickets,
    addTicket: repository.addTicket,
  );
});


typedef TicketCallback = Future<List<Ticket>> Function();
typedef TicketAddCallback = Future<void> Function(Ticket ticket);

class TicketsNotifier extends StateNotifier<List<Ticket>> {

  bool isLoading = false;
  final TicketCallback fetchTickets;
  final TicketAddCallback addTicket;

  TicketsNotifier({
    required this.fetchTickets,
    required this.addTicket,
  }) : super([]);

  Future<void> loadTickets() async {
    if (isLoading) return;
    isLoading = true;
    final List<Ticket> tickets = await fetchTickets();
    state.clear();
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
}
