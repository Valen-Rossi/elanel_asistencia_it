import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

import 'package:elanel_asistencia_it/presentation/providers/tickets/tickets_providers.dart';
import 'package:elanel_asistencia_it/domain/entities/ticket.dart';
import 'package:vibration/vibration.dart';
import 'package:vibration/vibration_presets.dart';

class InfoTicket extends ConsumerStatefulWidget {
  const InfoTicket({
    super.key,
    required this.size,
    required this.ticket,
    required this.colors,
  });

  final Size size;
  final Ticket ticket;
  final ColorScheme colors;

  @override
  InfoTicketState createState() => InfoTicketState();
}

class InfoTicketState extends ConsumerState<InfoTicket> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width,
      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onInverseSurface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.ticket.title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: widget.ticket.status.color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  widget.ticket.status.label,
                  style: TextStyle(
                    color: widget.ticket.status.color.withAlpha(255),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 5),

          Wrap(
            spacing: 10,
            runSpacing: 5,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                'Ticket ID: ${widget.ticket.id} - ',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),

              Timeago(
              date: widget.ticket.createdAt,
              locale: 'es',
              builder: (_, value) => Text(
                'Creado $value',
                style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                ),
              ),
              refreshRate: const Duration(seconds: 30),
              ),

            ],
          ),

          const SizedBox(height: 10),

          Text(
            widget.ticket.description,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: widget.ticket.category.color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  widget.ticket.category == TicketCategory.other
                    ?widget.ticket.otherCaregory
                    :widget.ticket.category.label,
                  style: TextStyle(
                    color: widget.ticket.category.color.withAlpha(255),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              FilledButton.tonal(
                style: ButtonStyle(
                  visualDensity: VisualDensity.compact,
                  backgroundColor:
                      WidgetStateProperty.all(widget.ticket.priority.color),
                ),
                onPressed: () async {
                  final selectedPriority = await showDialog<TicketPriority>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Cambiar prioridad'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: TicketPriority.values.map((priority) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: priority.color.withAlpha(100),
                                radius: 15,
                              ),
                              title: Text(priority.label),
                              onTap: () => Navigator.pop(context, priority),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  );

                  if (selectedPriority != null && selectedPriority != widget.ticket.priority) {
                    final updatedTicket = widget.ticket.copyWith(priority: selectedPriority);

                    await ref.read(recentTicketsProvider.notifier).updateTicket(updatedTicket);

                    if (await Vibration.hasVibrator()) {
                      Vibration.vibrate(preset: VibrationPreset.singleShortBuzz); // 100ms
                    }
                  }
                },
                child: Text(
                  widget.ticket.priority.label,
                  style: TextStyle(
                    color: widget.ticket.priority.color.withAlpha(255),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
