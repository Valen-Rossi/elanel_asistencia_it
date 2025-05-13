import 'package:elanel_asistencia_it/domain/entities/ticket.dart';
import 'package:elanel_asistencia_it/presentation/providers/tickets/tickets_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final recentTicketsProvider = StateNotifierProvider<TicketsNotifier, List<Ticket>>((ref){ 
    
    final fetchTickets = ref.watch(ticketRepositoryProvider).getTickets;
    
    return TicketsNotifier(fetchTickets: fetchTickets);
  }
);

typedef TicketCallback = Future<List<Ticket>> Function();

class TicketsNotifier extends StateNotifier<List<Ticket>> {

  bool isLoading = false;
  TicketCallback fetchTickets;
  
  TicketsNotifier({
    required this.fetchTickets,
  }) : super([]);

  Future<void> loadTickets() async {
    if (isLoading) return;

    isLoading = true;

    final List<Ticket> tickets = await fetchTickets();

    state.clear();

    state= [...tickets];
    
    isLoading = false;
  }

}