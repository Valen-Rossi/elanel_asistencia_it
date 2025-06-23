import 'package:elanel_asistencia_it/domain/entities/ticket.dart';
import 'package:elanel_asistencia_it/domain/entities/user.dart';
import 'package:elanel_asistencia_it/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final recentTicketsProvider = StateNotifierProvider<TicketsNotifier, List<Ticket>>((ref) {
  final repository = ref.watch(ticketRepositoryProvider);

  return TicketsNotifier(
    fetchTickets: repository.getTickets,
    addTicket: repository.addTicket,
    ticketUpdate: repository.updateTicket,
  );
});



typedef TicketCallback = Future<List<Ticket>> Function(User? user);
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
  

  Future<void> loadTickets(User? user) async {
    if (isLoading) return;
    if (user == null) return;

    isLoading = true;
    final tickets = await fetchTickets(user);
    state = [...tickets];
    isLoading = false;
  }


  Future<void> createTicket(Ticket ticket) async {
    
    if (isLoading) return;

    isLoading = true;
    
    await addTicket(ticket);
    
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
