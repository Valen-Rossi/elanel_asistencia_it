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
                      
                      Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        children: [
                          
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: ticket.status.color,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              ticket.status.label,
                              style: TextStyle(
                                color: ticket.status.color.withAlpha(255),
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                                               
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: ticket.category.color,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              ticket.category == TicketCategory.other
                              ?ticket.otherCaregory
                              :ticket.category.label,
                              style: TextStyle(
                                color: ticket.category.color.withAlpha(255),
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                                               
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: ticket.priority.color,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              ticket.priority.label,
                              style: TextStyle(
                                color: ticket.priority.color.withAlpha(255),
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                        
                        ],
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