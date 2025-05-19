import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago_flutter/timeago_flutter.dart';
import 'package:elanel_asistencia_it/domain/entities/ticket.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({
    super.key,
    required this.ticket,
  });

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Material(
        color: colors.onInverseSurface,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () => context.push('/ticket/${ticket.id}'),
          highlightColor: colors.primary.withAlpha(70),
          splashColor: colors.primary.withAlpha(50),
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
            child: Row(
              children: [

                Expanded(
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
                ),

                Timeago(
                  date: ticket.createdAt,
                  locale: 'es',
                  builder: (_, value) => Text(value),
                  refreshRate: const Duration(seconds: 30),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}