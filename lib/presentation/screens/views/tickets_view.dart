import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';

import 'package:elanel_asistencia_it/presentation/providers/providers.dart';
import 'package:elanel_asistencia_it/presentation/widgets/widgets.dart';
import 'package:elanel_asistencia_it/domain/entities/ticket.dart';

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
    ref.read(devicesProvider.notifier).loadDevices();
  }

  @override
  Widget build(BuildContext context) {
    final filteredTickets = ref.watch(filteredTicketsProvider);
    final filters = ref.watch(ticketFilterProvider);
    final filterNotifier = ref.read(ticketFilterProvider.notifier);
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () => context.push('/new-ticket'),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tickets recientes',
                      style: TextStyle(
                        color: colors.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      )),
                  TextButton(
                    onPressed: () {
                      filterNotifier.state = TicketFilterState.empty;
                    },
                    child: const Text('Limpiar filtros'),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [

                Expanded(
                  child: CustomDropdownFormField<TicketStatus?>(
                    label: 'Estado',
                    value: filters.status,
                    items: [
                      const DropdownMenuItem(value: null, child: Text('Todos')),
                      ...TicketStatus.values.map((e) => DropdownMenuItem(
                          value: e, child: Text(e.label)))
                    ],
                    onChanged: (status) => filterNotifier.state =
                        filterNotifier.state.copyWith(status: status),
                  ),
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: CustomDropdownFormField<TicketPriority?>(
                    label: 'Prioridad',
                    value: filters.priority,
                    items: [
                      const DropdownMenuItem(value: null, child: Text('Todas')),
                      ...TicketPriority.values.map((e) => DropdownMenuItem(
                          value: e, child: Text(e.label)))
                    ],
                    onChanged: (priority) => filterNotifier.state =
                        filterNotifier.state.copyWith(priority: priority),
                  ),
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: CustomDropdownFormField<TicketCategory?>(
                    label: 'Categoría',
                    value: filters.category,
                    items: [
                      const DropdownMenuItem(value: null, child: Text('Todas')),
                      ...TicketCategory.values.map((e) => DropdownMenuItem(
                          value: e, child: Text(e.label)))
                    ],
                    onChanged: (category) => filterNotifier.state =
                        filterNotifier.state.copyWith(category: category),
                  ),
                ),
              ],
            ),
          ),

          // debajo del Row de filtros
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: filters.fromDate ?? DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: filters.toDate ?? DateTime.now(),
                      );
                      if (selectedDate != null) {
                        filterNotifier.state = filterNotifier.state.copyWith(fromDate: selectedDate);
                      }
                    },
                    icon: const Icon(Icons.calendar_today_rounded, size: 18),
                    label: Text(
                      filters.fromDate != null
                          ? 'Desde: ${filters.fromDate!.day}/${filters.fromDate!.month}/${filters.fromDate!.year}'
                          : 'Desde: -',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: filters.toDate ?? DateTime.now(),
                        firstDate: filters.fromDate ?? DateTime(2020),
                        lastDate: DateTime.now(),
                      );
                      if (selectedDate != null) {
                        filterNotifier.state = filterNotifier.state.copyWith(toDate: selectedDate);
                      }
                    },
                    icon: const Icon(Icons.event, size: 18),
                    label: Text(
                      filters.toDate != null
                          ? 'Hasta: ${filters.toDate!.day}/${filters.toDate!.month}/${filters.toDate!.year}'
                          : 'Hasta: -',
                    ),
                  ),
                ),
                if (filters.fromDate != null || filters.toDate != null)
                  IconButton(
                    icon: const Icon(Icons.clear_rounded),
                    onPressed: () {
                      filterNotifier.state = filterNotifier.state.copyWith(fromDate: null, toDate: null);
                    },
                  ),
              ],
            ),
          ),


          const SizedBox(height: 10),

          Expanded(
            child: filteredTickets.isEmpty
                ? Center(
                    child: Text(
                      'No se encontraron tickets con estos filtros.',
                      style: TextStyle(color: colors.onSurfaceVariant),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(),
                    physics: const BouncingScrollPhysics(),
                    itemCount: filteredTickets.length,
                    itemBuilder: (context, index) {
                      final ticket = filteredTickets[index];
                      return FadeIn(
                        delay: Duration(milliseconds: 200 + index * 100),
                        child: TicketCard(ticket: ticket),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}