import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vibration/vibration.dart';
import 'package:vibration/vibration_presets.dart';

import 'package:elanel_asistencia_it/presentation/providers/users/technician_users_provider.dart';
import 'package:elanel_asistencia_it/domain/entities/device.dart';
import 'package:elanel_asistencia_it/domain/entities/ticket.dart';
import 'package:elanel_asistencia_it/domain/entities/user.dart';
import 'package:elanel_asistencia_it/presentation/providers/providers.dart';
import 'package:elanel_asistencia_it/presentation/widgets/widgets.dart';

class TicketScreen extends ConsumerWidget {
  static const name = 'ticket-screen';
  final String ticketId;

  const TicketScreen({super.key, required this.ticketId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Ticket ticket = ref.watch(ticketByIdProvider(ticketId));
    final List<User> technicians = ref.watch(technicianUsersProvider);

    final User? technician = (ticket.technicianId != '')
        ? ref.watch(userByIdProvider(ticket.technicianId))
        : null;

    final Device device = ref.watch(deviceByIdProvider(ticket.deviceId));

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
      body: _TicketView(
        ticketId: ticket.id,
        technician: technician,
        technicians: technicians,
        device: device,
      ),
    );
  }
}

class _TicketView extends ConsumerStatefulWidget {
  const _TicketView({
    required this.ticketId,
    required this.technicians,
    this.technician,
    required this.device,
  });

  final String ticketId;
  final List<User> technicians;
  final User? technician;
  final Device device;

  @override
  ConsumerState<_TicketView> createState() => _TicketViewState();
}

class _TicketViewState extends ConsumerState<_TicketView> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentAppUserProvider);

    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;

    // ✅ Ticket actualizado dinámicamente
    final ticket = ref.watch(ticketByIdProvider(widget.ticketId));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoTicketCard(size: size, ticket: ticket, colors: colors),

          if (ticket.mediaUrls.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 17),
              const Text(
                'Archivos adjuntos',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: ticket.mediaUrls.map((url) {
                  final isImage = url.endsWith('.jpg') || url.endsWith('.jpeg') || url.endsWith('.png');
                  final isVideo = url.endsWith('.mp4') || url.endsWith('.mov') || url.endsWith('.avi');

                  return GestureDetector(
                    onTap: () {
                      context.push('/preview?url=${Uri.encodeComponent(url)}&isVideo=$isVideo');
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: isImage
                            ? Image.network(url, fit: BoxFit.cover)
                            : Stack(
                                fit: StackFit.expand,
                                children: [
                                  Container(color: Colors.black26),
                                  const Icon(Icons.play_circle, size: 30, color: Colors.white),
                                ],
                              ),
                      ),
                    ),
                  );
                }).toList(),
              ),

            ],
          ),


          InfoTicketTimeline(
            ticket: ticket,
            technician: widget.technician,
            technicians: widget.technicians,
            device: widget.device,
          ),

          const SizedBox(height: 20),

          // ✅ Usamos el ticket actualizado dinámicamente
          if (ticket.status != TicketStatus.resolved && widget.technician != null && user != null && user.role != UserRole.client)
            SizedBox(
              width: size.width,
              child: FilledButton(
                onPressed: () async {
                  final newStatus = ticket.status != TicketStatus.inProgress
                      ? TicketStatus.inProgress
                      : TicketStatus.resolved;

                  final updatedTicket = ticket.copyWith(
                    status: newStatus,
                    openedAt: newStatus == TicketStatus.inProgress ? DateTime.now() : ticket.openedAt,
                    closedAt: newStatus == TicketStatus.resolved ? DateTime.now() : ticket.closedAt,
                  );
                  await ref.read(recentTicketsProvider.notifier).updateTicket(updatedTicket);

                  if (await Vibration.hasVibrator()) {
                    Vibration.vibrate(preset: VibrationPreset.singleShortBuzz);
                  }

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          newStatus == TicketStatus.inProgress
                              ? 'El ticket ha sido abierto con éxito.'
                              : 'El ticket ha sido cerrado con éxito.',
                        ),
                        backgroundColor: colors.primary,
                      ),
                    );
                  }
                },
                child: Text(
                  ticket.status != TicketStatus.inProgress
                      ? 'Abrir Ticket'
                      : 'Cerrar Ticket',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),

          if (ticket.hasFeedback && ticket.status == TicketStatus.resolved)
            FeedbackCard(feedbackId: ticket.id),

          if (ticket.status == TicketStatus.resolved && !ticket.hasFeedback && user != null && user.role == UserRole.client)
            NewFeedbackCard(ticket: ticket),

          if (!(ticket.status != TicketStatus.resolved && widget.technician != null) &&
              !ticket.hasFeedback &&
              ticket.status != TicketStatus.resolved)
            const SizedBox.shrink(),
        ],
      ),
    );
  }
}
