import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';

import 'package:elanel_asistencia_it/domain/entities/ticket.dart';
import 'package:elanel_asistencia_it/presentation/providers/providers.dart';
import 'package:elanel_asistencia_it/presentation/widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
 const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {

  @override
  void initState() {
    super.initState();
    
    ref.read(usersProvider.notifier).loadUsers();
    ref.read(devicesProvider.notifier).loadDevices();
    ref.read(feedbacksProvider.notifier).loadFeedbacks();

  }

 @override
 Widget build(BuildContext context) {

  final user = ref.watch(currentAppUserProvider);
  
  ref.read(recentTicketsProvider.notifier).loadTickets(user);
  


  final recentTickets = ref.watch(recentTicketsProvider);
  final newTickets = ref.watch(newTicketsProvider);
  final inProgressTickets = ref.watch(inProgressTicketsProvider);
  final resolvedTickets = ref.watch(resolvedTicketsProvider);
  final currentUser = ref.watch(currentAppUserProvider);

  // final isLoading = ref.watch(recentTicketsProvider.notifier).isLoading;
  final colors = Theme.of(context).colorScheme;
  // final textTheme = Theme.of(context).textTheme;

  return (currentUser == null)
  ? const Center(child: CircularProgressIndicator())
  : Column(
    children: [

      const CustomAppbar(),

      // Todo: Centralizar los estilos de los textos
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        alignment: Alignment.centerLeft,
        child: Text('Hola ${currentUser.name}!',
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
        child: Text('Tickets recientes',
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
          physics: const BouncingScrollPhysics(),
          itemCount: recentTickets.length,
          itemBuilder: (context, index) {
        
            final ticket = recentTickets[index];
        
            return FadeIn(
              delay: Duration(milliseconds: 200+index * 100),
              child: TicketCard(ticket: ticket),
            );
          },
        ),
      ),

      SizedBox(height: 10,),

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