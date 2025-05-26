import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';

import 'package:elanel_asistencia_it/presentation/providers/providers.dart';
import 'package:elanel_asistencia_it/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

class TicketsView extends ConsumerStatefulWidget {
 const TicketsView({super.key});

  @override
  TicketsViewState createState() => TicketsViewState();
}

class TicketsViewState extends ConsumerState<TicketsView> {

  @override
  void initState() {
    super.initState();
    
    ref.read(recentTicketsProvider.notifier).loadTickets();
    ref.read(usersProvider.notifier).loadUsers();

  }

 @override
 Widget build(BuildContext context) {

  final recentTickets = ref.watch(recentTicketsProvider);
  final isLoading = ref.watch(recentTicketsProvider.notifier).isLoading;
  final colors = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return Scaffold(
    floatingActionButton: FloatingActionButton(
      shape: CircleBorder(),
        onPressed: () {
          context.push('/new-ticket');
        },
        child: const Icon(Icons.add),
      ),
    body: Column(
      children: [
    
        // Todo: Centralizar los estilos de los textos
    
        SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            alignment: Alignment.centerLeft,
            child: Text('Tickets recientes',
              style: TextStyle(
                color: colors.primary,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
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
    ),
  );
 }
}