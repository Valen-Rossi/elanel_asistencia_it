import 'package:elanel_asistencia_it/domain/entities/user.dart';
import 'package:elanel_asistencia_it/presentation/providers/users/user_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago_flutter/timeago_flutter.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:elanel_asistencia_it/presentation/providers/providers.dart';
import 'package:elanel_asistencia_it/domain/entities/ticket.dart';

class TicketScreen extends ConsumerWidget {
  static const name = 'ticket-screen';
  final String ticketId;

  const TicketScreen({super.key, required this.ticketId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final Ticket ticket = ref.watch(ticketByIdProvider(ticketId));
    final List<User> users = ref.watch(usersProvider);
    
    final User? technician = (ticket.technicianId != '')
      ? ref.watch(userByIdProvider(ticket.technicianId))
      : null;

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
      body: _TicketView(ticket: ticket, technician: technician, users: users,),
    );
  }
}

class _TicketView extends ConsumerStatefulWidget {
  const _TicketView({
    required this.ticket,
    required this.users,
    this.technician,
  });

  final Ticket ticket;
  final List<User> users;
  final User? technician;

  @override
  ConsumerState<_TicketView> createState() => _TicketViewState();
}

class _TicketViewState extends ConsumerState<_TicketView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;

    return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                _InfoTicket(size: size, ticket: widget.ticket),

                const SizedBox(height: 20),

                 // Paso 1: Ticket creado
                TimelineTile(
                  isFirst: true,
                  indicatorStyle: IndicatorStyle(
                    width: 30,
                    height: 30,
                    indicator: CircleAvatar(
                      backgroundColor: colors.surface,
                      child: Icon(Icons.check_circle, 
                        color: colors.primary,
                        size: 32,
                      ),
                    ),
                  ),
                  afterLineStyle: LineStyle(color: colors.surface, thickness: 2),
                  endChild: Padding(
                    padding: const EdgeInsets.only(left: 8, top: 5, bottom: 5),
                    child: Text(
                      'Ticket creado',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: colors.primary),
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
                      child: Icon(Icons.account_circle,
                        size: 32,
                        color: widget.ticket.technicianId != '' 
                          ? colors.primary  
                          : colors.secondary
                      ),
                    ),
                  ),
                  afterLineStyle: LineStyle(color: Colors.grey.shade700, thickness: 2),
                  beforeLineStyle: LineStyle(color: Colors.grey.shade700, thickness: 2),
                  endChild: Padding(
                    padding: const EdgeInsets.only(left: 8, top: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Técnico asignado',
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: colors.primary),
                        ),
                        const SizedBox(height: 10),
                        FilledButton.tonalIcon(
                          style: ButtonStyle(
                            visualDensity: VisualDensity.compact,
                          ),
                          onPressed: () async {
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
                                      itemCount: widget.users.length,
                                      itemBuilder: (_, i) {
                                        final user = widget.users[i];
                                        return ListTile(
                                          visualDensity: VisualDensity.compact,
                                          leading: const Icon(Icons.person),
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
                              final updatedTicket =
                                  widget.ticket.copyWith(technicianId: selectedTech.id);

                              // Actualiza el ticket en el provider
                              await ref
                                  .read(recentTicketsProvider.notifier)
                                  .updateTicket(updatedTicket);
                            }
                          },

                          icon: Icon(Icons.person),
                          label: widget.technician != null
                              ? Text(widget.technician!.name)
                              : const Text('Asignar técnico'),
                        ),
                      ],
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
                      child: Icon(Icons.timelapse,
                        size: 32,
                        color: (widget.ticket.status == TicketStatus.inProgress || widget.ticket.status == TicketStatus.resolved)
                            ? colors.primary
                            : colors.secondary),
                    ),
                  ),
                  afterLineStyle: LineStyle(color: Colors.grey.shade700, thickness: 2),
                  beforeLineStyle: LineStyle(color: Colors.grey.shade700, thickness: 2),
                  endChild: Padding(
                    padding: const EdgeInsets.only(left: 8, top: 22, bottom: 20),
                    child: Text(
                      'En curso',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: (widget.ticket.status == TicketStatus.inProgress || widget.ticket.status == TicketStatus.resolved)
                            ? colors.primary
                            : colors.secondary,
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
                      child: Icon(Icons.check_circle,
                        size: 32,
                        color: widget.ticket.status == TicketStatus.resolved
                            ? colors.primary
                            : colors.secondary),
                    ),
                  ),
                  beforeLineStyle: LineStyle(color: Colors.grey.shade700, thickness: 2),
                  endChild: Padding(
                    padding: const EdgeInsets.only(left: 8, top: 32, bottom: 30),
                    child: Text(
                      'Resuelto',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: widget.ticket.status == TicketStatus.resolved
                            ? colors.primary
                            : colors.secondary,
                      ),
                    ),
                  ),
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
