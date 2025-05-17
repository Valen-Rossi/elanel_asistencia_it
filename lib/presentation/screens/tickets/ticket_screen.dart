import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elanel_asistencia_it/presentation/providers/providers.dart';
import 'package:elanel_asistencia_it/domain/entities/ticket.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

class TicketScreen extends ConsumerWidget {
  static const name = 'ticket-screen';
  final String ticketId;

  const TicketScreen({super.key, required this.ticketId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final Ticket ticket = ref.watch(ticketByIdProvider(ticketId));
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalle del ticket',
          style: TextStyle(
              color: colors.primary,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
        ),
      ),
      body: _TicketView(ticket: ticket),
    );
  }
}

class _TicketView extends StatelessWidget {
  const _TicketView({
    required this.ticket,
  });

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;

    return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                _InfoTicket(size: size, ticket: ticket),

                const SizedBox(height: 20),

                Row(
                  children: [

                    Icon(Icons.check_circle,
                      color: colors.primary,
                      size: 34,
                    ),
                    
                    const SizedBox(width: 10),

                    Text(
                      'Ticket creado',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: colors.primary,
                      ),
                    ),

                  ],
                ),

                SizedBox(height: 20),

                Row(
                  children: [

                    Icon(Icons.account_circle,
                      color: ticket.technicianId != ''
                          ? colors.primary
                          : colors.secondary,
                      size: 34,
                    ),
                    
                    const SizedBox(width: 10),

                    Text(
                      'Técnico asignado',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: colors.primary,
                      ),
                    ),

                  ],
                ),

                SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 37),
                  child: ticket.technicianId != ''
                      ? Text(
                        ticket.technicianId,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: colors.primary,
                        ),
                      )
                      : FilledButton.tonal(
                        style: ButtonStyle(
                          visualDensity: VisualDensity.compact, 
                        ),
                        onPressed: () {
                          
                        },
                        child: const Text('Asignar técnico'),
                      ),
                ),

                SizedBox(height: 20),

                Row(
                  children: [

                    Icon(Icons.timelapse,
                      color: ticket.status == TicketStatus.inProgress || ticket.status == TicketStatus.resolved
                          ? colors.primary
                          : colors.secondary,
                      size: 34,
                    ),
                    
                    const SizedBox(width: 10),

                    Text(
                      'En curso',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: ticket.status == TicketStatus.inProgress || ticket.status == TicketStatus.resolved
                          ? colors.primary
                          : colors.secondary,
                      ),
                    ),

                  ],
                ),

                SizedBox(height: 20),

                Row(
                  children: [

                    Icon(Icons.check_circle,
                      color: ticket.status == TicketStatus.resolved
                          ? colors.primary
                          : colors.secondary,
                      size: 34,
                    ),
                    
                    const SizedBox(width: 10),

                    Text(
                      'Resuelto',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: ticket.status == TicketStatus.resolved
                          ? colors.primary
                          : colors.secondary,
                      ),
                    ),

                  ],
                ),

              ],
            ),
          );
  }
}

class _InfoTicket extends StatelessWidget {
  const _InfoTicket({
    required this.size,
    required this.ticket,
  });

  final Size size;
  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onInverseSurface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
    
          Text(
            ticket.title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
    
          const SizedBox(height: 5),
    
          Row(
            children: [
    
              Text(
                'Ticket ID: ${ticket.id} - ',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
    
              Timeago(
                date: ticket.createdAt,
                locale: 'es',
                builder: (_, value) => Text('Creado $value'),
                refreshRate: const Duration(seconds: 30),
              ),
    
            ],
          ),
    
          const SizedBox(height: 10),
    
          Text(
            ticket.description,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
    
          const SizedBox(height: 10),
    
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: ticket.status == TicketStatus.newTicket
                  ? const Color.fromARGB(123, 10, 167, 240)
                  : ticket.status == TicketStatus.inProgress
                      ? const Color.fromARGB(132, 241, 138, 21)
                      : const Color.fromARGB(124, 42, 243, 92),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(ticket.status.name),
          ),
    
        ],
      ),
    );
  }
}
