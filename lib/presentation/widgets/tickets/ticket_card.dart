import 'package:flutter/material.dart';
import 'package:elanel_asistencia_it/config/helpers/date_time_ago.dart';
import 'package:elanel_asistencia_it/domain/entities/ticket.dart';


class Ticket_Card extends StatelessWidget {
  const Ticket_Card({
    super.key,
    required this.ticket,
  });

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

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
  }
}