import 'package:elanel_asistencia_it/domain/entities/ticket.dart';
import 'package:elanel_asistencia_it/domain/entities/device.dart';
import 'package:elanel_asistencia_it/presentation/providers/providers.dart';
import 'package:flutter/material.dart';

import 'package:elanel_asistencia_it/presentation/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NewTicketScreen extends StatelessWidget {

  static const name = 'new-ticket-screen';

  const NewTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Ticket',
        style: TextStyle(
              color: colors.primary,
              fontSize: 22,
              fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: const _NewTicketView(),
    );
  }
}

class _NewTicketView extends ConsumerStatefulWidget {
 const _NewTicketView();

  @override
  _NewTicketViewState createState() => _NewTicketViewState();
}

class _NewTicketViewState extends ConsumerState<_NewTicketView> {

  @override
  void initState() {
    super.initState();

    ref.read(devicesProvider.notifier).loadDevices();

  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _deviceSearchController = TextEditingController();

  String ticketTitle = '';
  String ticketDescription = '';
  TicketCategory ticketCategory = TicketCategory.hardware;
  Device? selectedDevice;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final devices = ref.watch(devicesProvider);

    final List<Device> searchResults = _deviceSearchController.text.trim().isEmpty
        ? []
        : devices
            .where((d) => d.id.contains(_deviceSearchController.text.trim()))
            .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          spacing: 15,
          children: [

            CustomTextFormField(
              label: 'Título',
              hintText: 'Ejemplo: Problema con impresora',
              icon: Icons.title,
              onChanged: (value) => ticketTitle = value.trim(),
              validator: (value) {
                if (value == null || value.trim().isEmpty) return 'El título es requerido';
                if (value.length < 4) return 'Debe tener al menos 4 caracteres';
                if (value.length > 20) return 'Máximo 20 caracteres';
                return null;
              },
            ),

            CustomTextFormField(
              label: 'Descripción',
              hintText: 'Describe el problema',
              icon: Icons.description,
              maxLines: 8,
              onChanged: (value) => ticketDescription = value.trim(),
              validator: (value) {
                if (value == null || value.trim().isEmpty) return 'La descripción es requerida';
                if (value.length < 10) return 'Debe tener al menos 10 caracteres';
                if (value.length > 50) return 'Máximo 50 caracteres';
                return null;
              },
            ),

            CustomDropdownFormField<TicketCategory>(
              label: 'Categoría',
              hint: 'Selecciona una categoría',
              items: TicketCategory.values
                  .map((category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.label),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => ticketCategory = value);
                }
              },
              validator: (value) => value == null ? 'La categoría es requerida' : null,
            ),

            CustomTextFormField(
              controller: _deviceSearchController,
              textInputType: TextInputType.number,
              label: 'Buscar por ID de dispositivo',
              hintText: 'Por ejemplo: 001',
              icon: Icons.search_rounded,
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _deviceSearchController.clear();
                  setState(() => selectedDevice = null);
                },
              ),
              onChanged: (value) {
                final trimmedValue = value.trim();
                if (selectedDevice != null && selectedDevice!.id != trimmedValue) {
                  setState(() => selectedDevice = null);
                }
                setState(() {});
              },
              validator: (_) {
                if (selectedDevice == null) return 'Debe seleccionar un dispositivo';
                return null;
              },
            ),
            if (searchResults.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: colors.primary),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: searchResults.map((device) {
                    return ListTile(
                      title: Text(device.name),
                      subtitle: Text('ID: ${device.id}'),
                      trailing: Icon(device.type.icon, color: colors.primary),
                      onTap: () {
                        setState(() {
                          selectedDevice = device;
                          _deviceSearchController.text = device.id;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),

            FilledButton.tonalIcon(
              onPressed: isLoading
                  ? null
                  : () async {
                      final isValid = _formKey.currentState!.validate();
                      if (!isValid || selectedDevice == null) return;

                      setState(() => isLoading = true);

                      final ticket = Ticket(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: ticketTitle,
                        description: ticketDescription,
                        status: TicketStatus.newTicket,
                        priority: TicketPriority.low,
                        category: ticketCategory,
                        otherCaregory: '',
                        deviceId: selectedDevice!.id,
                        technicianId: '',
                        createdAt: DateTime.now(),
                      );

                      final updatedDevice = Device(
                        id: selectedDevice!.id,
                        name: selectedDevice!.name,
                        type: selectedDevice!.type,
                        ticketCount: selectedDevice!.ticketCount + 1,
                        lastMaintenance: DateTime.now(),
                      );

                      await ref.read(recentTicketsProvider.notifier).createTicket(ticket);
                      await ref.read(devicesProvider.notifier).updateDevice(updatedDevice);

                      setState(() => isLoading = false);

                      if (context.mounted) {
                        context.pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Ticket creado con éxito'),
                            backgroundColor: colors.primary,
                          ),
                        );
                      }
                    },
              label: const Text('Crear Ticket'),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
