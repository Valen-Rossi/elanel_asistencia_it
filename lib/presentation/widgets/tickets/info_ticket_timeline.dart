import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:vibration/vibration.dart';
import 'package:vibration/vibration_presets.dart';

import 'package:elanel_asistencia_it/domain/entities/ticket.dart';
import 'package:elanel_asistencia_it/domain/entities/user.dart';
import 'package:elanel_asistencia_it/domain/entities/device.dart';
import 'package:elanel_asistencia_it/presentation/providers/providers.dart';

class InfoTicketTimeline extends ConsumerWidget {
  final Ticket ticket;
  final User? technician;
  final List<User> technicians;
  final Device device;

  const InfoTicketTimeline({
    super.key,
    required this.ticket,
    required this.technician,
    required this.technicians,
    required this.device,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final user = ref.watch(currentAppUserProvider);

    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Paso 1: Ticket creado
        TimelineTile(
          isFirst: true,
          indicatorStyle: IndicatorStyle(
            width: 30,
            height: 30,
            indicator: CircleAvatar(
              backgroundColor: colors.surface,
              child: Icon(
                Icons.check_circle,
                color: colors.primary,
                size: 32,
              ),
            ),
          ),
          afterLineStyle: LineStyle(color: Colors.grey.shade700, thickness: 2),
          endChild: SizedBox(
            height: 120,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [

                      Text(
                        'Ticket creado',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: colors.primary,
                        ),
                      ),
                      Spacer(),
                      Text(
                        '${ticket.createdAt.day.toString()
                          .padLeft(2, '0')}-${ticket.createdAt.month.toString()
                          .padLeft(2, '0')}-${ticket.createdAt.year} | ${ticket.createdAt.hour.toString()
                          .padLeft(2, '0')}:${ticket.createdAt.minute.toString()
                          .padLeft(2, '0')}',
                        style: TextStyle(
                          fontSize: 14,
                          color: colors.onSurface.withAlpha(157),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  FilledButton.tonalIcon(
                    icon: Icon(device.type.icon),
                    label: Text(device.name),
                    style: ButtonStyle(visualDensity: VisualDensity.compact),
                    onPressed: () => context.push('/device/${device.id}'),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Paso 2: Técnico asignado
        TimelineTile(
          indicatorStyle: IndicatorStyle(
            width: 30,
            height: 30,
            indicator: CircleAvatar(
              backgroundColor: colors.surface,
              child: Icon(
                Icons.account_circle,
                size: 32,
                color: ticket.technicianId != '' ? colors.primary : colors.secondary,
              ),
            ),
          ),
          beforeLineStyle: LineStyle(color: Colors.grey.shade700, thickness: 2),
          afterLineStyle: LineStyle(color: Colors.grey.shade700, thickness: 2),
          endChild: SizedBox(
            height: 120,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      
                      Text(
                        'Técnico asignado',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: colors.primary,
                        ),
                      ),
                      Spacer(),
                      Text(
                        technician != null
                        ?'${ticket.assignedAt.day.toString()
                          .padLeft(2, '0')}-${ticket.assignedAt.month.toString()
                          .padLeft(2, '0')}-${ticket.assignedAt.year} | ${ticket.assignedAt.hour.toString()
                          .padLeft(2, '0')}:${ticket.assignedAt.minute.toString()
                          .padLeft(2, '0')}'
                        :'Pendiente',
                        style: TextStyle(
                          fontSize: 14,
                          color: colors.onSurface.withAlpha(157),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  FilledButton.tonalIcon(
                    style: ButtonStyle(visualDensity: VisualDensity.compact),
                    onPressed: () async {
                      if (user == null || user.role != UserRole.admin) {
                        return;
                      }
                      final selectedTech = await showDialog<User>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Seleccionar técnico'),
                            content: SizedBox(
                              width: double.maxFinite,
                              child: ListView.separated(
                                separatorBuilder: (_, __) => const Divider(),
                                shrinkWrap: true,
                                itemCount: technicians.length,
                                itemBuilder: (_, i) {
                                  final user = technicians[i];
                                  return ListTile(
                                    visualDensity: VisualDensity.compact,
                                    leading: Icon(Icons.person, color: colors.primary),
                                    title: Text(user.name),
                                    onTap: () => Navigator.pop(context, user),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      );

                      if (selectedTech != null) {
                        final updatedTicket = ticket.copyWith(technicianId: selectedTech.id, assignedAt: DateTime.now());
                        await ref.read(recentTicketsProvider.notifier).updateTicket(updatedTicket);

                        if (await Vibration.hasVibrator()) {
                          Vibration.vibrate(preset: VibrationPreset.singleShortBuzz);
                        }
                      }
                    },
                    icon: Icon(Icons.person),
                    label: technician != null
                        ? Text(technician!.name)
                        : const Text('Asignar técnico'),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Paso 3: En curso
        TimelineTile(
          indicatorStyle: IndicatorStyle(
            width: 30,
            height: 30,
            indicator: CircleAvatar(
              backgroundColor: colors.surface,
              child: Icon(
                Icons.timelapse,
                size: 32,
                color: (ticket.status == TicketStatus.inProgress ||
                        ticket.status == TicketStatus.resolved)
                    ? colors.primary
                    : colors.secondary,
              ),
            ),
          ),
          beforeLineStyle: LineStyle(color: Colors.grey.shade700, thickness: 2),
          afterLineStyle: LineStyle(color: Colors.grey.shade700, thickness: 2),
          endChild: SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [

                    Text(
                      'En curso',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: (ticket.status == TicketStatus.inProgress ||
                                ticket.status == TicketStatus.resolved)
                            ? colors.primary
                            : colors.secondary,
                      ),
                    ),
                    Spacer(),
                      Text(
                        (ticket.status == TicketStatus.inProgress ||
                        ticket.status == TicketStatus.resolved)
                        ?'${ticket.openedAt.day.toString()
                          .padLeft(2, '0')}-${ticket.openedAt.month.toString()
                          .padLeft(2, '0')}-${ticket.openedAt.year} | ${ticket.openedAt.hour.toString()
                          .padLeft(2, '0')}:${ticket.openedAt.minute.toString()
                          .padLeft(2, '0')}'
                        :'Pendiente',
                        style: TextStyle(
                          fontSize: 14,
                          color: colors.onSurface.withAlpha(157),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Paso 4: Resuelto
        TimelineTile(
          isLast: true,
          indicatorStyle: IndicatorStyle(
            width: 30,
            height: 30,
            indicator: CircleAvatar(
              backgroundColor: colors.surface,
              child: Icon(
                Icons.check_circle,
                size: 32,
                color: ticket.status == TicketStatus.resolved
                    ? colors.primary
                    : colors.secondary,
              ),
            ),
          ),
          beforeLineStyle: LineStyle(color: Colors.grey.shade700, thickness: 2),
          endChild: SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    
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
                    Spacer(),
                      Text(
                        ticket.status == TicketStatus.resolved
                        ?'${ticket.closedAt.day.toString()
                          .padLeft(2, '0')}-${ticket.closedAt.month.toString()
                          .padLeft(2, '0')}-${ticket.closedAt.year} | ${ticket.closedAt.hour.toString()
                          .padLeft(2, '0')}:${ticket.closedAt.minute.toString()
                          .padLeft(2, '0')}'
                        :'Pendiente',
                        style: TextStyle(
                          fontSize: 14,
                          color: colors.onSurface.withAlpha(157),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}
