import 'package:elanel_asistencia_it/config/helpers/date_time_ago.dart';
import 'package:elanel_asistencia_it/domain/entities/ticket.dart';
import 'package:elanel_asistencia_it/presentation/providers/providers.dart';
import 'package:elanel_asistencia_it/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {

  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const _HomeView(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
 const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {

  @override
  void initState() {
    super.initState();
    
    ref.read(recentTicketsProvider.notifier).loadTickets();

  }

 @override
 Widget build(BuildContext context) {

  final recentTickets = ref.watch(recentTicketsProvider);
  final List<Ticket> newTickets = ref.watch(recentTicketsProvider).where((ticket) => ticket.status == TicketStatus.newTicket).toList();
  final List<Ticket> inProgressTickets = ref.watch(recentTicketsProvider).where((ticket) => ticket.status == TicketStatus.inProgress).toList();
  final List<Ticket> resolvedTickets = ref.watch(recentTicketsProvider).where((ticket) => ticket.status == TicketStatus.resolved).toList();
  final isLoading = ref.watch(recentTicketsProvider.notifier).isLoading;
  final colors = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return Column(
    children: [

      CustomAppbar(),

      // Todo: Centralizar los estilos de los textos
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        alignment: Alignment.centerLeft,
        child: Text('Hola Tintin!',
          style: TextStyle(
            color: colors.primary,
            fontSize: 27,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 17,
          children: [
            _CustomCard(color: Colors.blue, tickets: newTickets, title: 'Nuevos',),
            _CustomCard(color: Colors.orange, tickets: inProgressTickets, title: 'En Curso',),
            _CustomCard(color: Colors.green, tickets: resolvedTickets, title: 'Resueltos',),
          ],
        ),
      ),

      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        alignment: Alignment.centerLeft,
        child: Text('Tickets Recientes',
          style: TextStyle(
            color: colors.primary,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(),
          itemCount: recentTickets.length,
          itemBuilder: (context, index) {
        
            final ticket = recentTickets[index];
        
            return Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              padding: const EdgeInsets.symmetric(vertical: 17),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: colors.onInverseSurface,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(ticket.title,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: ticket.status == TicketStatus.newTicket ? Color.fromARGB(123, 10, 167, 240) : 
                                   ticket.status == TicketStatus.inProgress ? Color.fromARGB(132, 241, 138, 21) : Color.fromARGB(124, 42, 243, 92),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(ticket.status.name),
                        ),
                      ],
                    ),

                    const Spacer(),

                    Text(DateTimeAgo.getTimeAgoFormat(ticket.createdAt)),

                  ],
                )
              )
            );
          },
        ),
      ),

    ],
  );
 }
}

class _CustomCard extends StatelessWidget {
  const _CustomCard({
    required this.color,
    required this.tickets, 
    required this.title,
  });

  final MaterialColor color;
  final List<Ticket> tickets;
  final String title;

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 11),
        decoration: BoxDecoration(
          color: colors.onInverseSurface,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(5),
            topLeft: Radius.circular(5),
            bottomRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            Text(title),
            Text('${tickets.length}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}