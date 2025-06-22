import 'package:elanel_asistencia_it/config/permissions/permissions_handler.dart';
import 'package:elanel_asistencia_it/domain/entities/ticket.dart';
import 'package:elanel_asistencia_it/domain/entities/device.dart';
import 'package:elanel_asistencia_it/presentation/providers/providers.dart';
import 'package:flutter/material.dart';

import 'package:elanel_asistencia_it/presentation/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vibration/vibration.dart';
import 'package:vibration/vibration_presets.dart';

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
  String otherCategory = '';
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

            (ticketCategory==TicketCategory.other)
            ?CustomTextFormField(
              label: 'Otra Categoría',
              hintText: 'Por ejemplo: Celular personal',
              icon: Icons.devices_other,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) => otherCategory = value.trim(),
              validator: (value) {
                if (value == null || value.trim().isEmpty) return 'El nombre de la otra es requerida';
                if (value.length < 4) return 'Debe tener al menos 4 caracteres';
                if (value.length > 20) return 'Máximo 20 caracteres';
                return null;
              },
            )
            : SizedBox(),

           CustomTextFormField(
            controller: _deviceSearchController,
            label: 'Buscar por ID de dispositivo',
            hintText: 'Por ejemplo: 001',
            textCapitalization: TextCapitalization.none,
            icon: Icons.search_rounded,
            suffixIcon: _deviceSearchController.text.isNotEmpty
            ? IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _deviceSearchController.clear();
                setState(() => selectedDevice = null);
              },
            )
            : null,
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
                    trailing: selectedDevice!=null
                      ? IconButton(
                        icon: Icon(Icons.clear), 
                        onPressed: () { 
                          setState(() {
                            _deviceSearchController.clear();
                            selectedDevice = null;
                          });
                        },
                      )
                      :null,
                    leading: Icon(device.type.icon, color: colors.primary),
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

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [

                FilledButton.tonalIcon(
                  label: Text('Escanear'),
                  onPressed: () async {
                    final granted = await PermissionsService.requestCameraPermission();

                    if (context.mounted) {
                      if (!granted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('No se pudo acceder a la cámara')),
                        );
                        await PermissionsService.openAppSettingsIfPermanentlyDenied();
                        return;
                      }

                      // Ir a pantalla de escaneo y esperar el resultado
                      final result = await context.push<String>('/ticket-qr-scan');

                      if (result != null && result.isNotEmpty) {
                        final devices = ref.read(devicesProvider);
                        Device? matchedDevice;

                        try {
                          matchedDevice = devices.firstWhere((d) => d.id == result);
                        } catch (_) {
                          matchedDevice = null;
                        }

                        if (matchedDevice != null) {
                          // Vibración corta si está disponible
                          if (await Vibration.hasVibrator()) {
                            Vibration.vibrate(preset: VibrationPreset.singleShortBuzz); // 100ms
                          }
                          setState(() {
                            selectedDevice = matchedDevice!;
                            _deviceSearchController.text = matchedDevice.id;
                          });
                        } else {
                          if (await Vibration.hasVibrator()) {
                            Vibration.vibrate(preset: VibrationPreset.doubleBuzz); // 100ms
                          }
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(
                                'Dispositivo con ID "$result" no encontrado',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )),
                            );
                          }
                        }
                      }
                    }
                  },
                  icon: Icon(Icons.qr_code),
                ),


                FilledButton.tonalIcon(
                  label: Text('Agregar'),
                  onPressed: () async {
                    final newDeviceId = await context.push<String>('/new-device');
                    if (newDeviceId != null) {
                      final deviceList = ref.read(devicesProvider);
                      final newDevice = deviceList.firstWhere(
                        (d) => d.id == newDeviceId,
                      );
                      setState(() {
                        selectedDevice = newDevice;
                        _deviceSearchController.text = newDevice.id;
                      });
                    }
                  },
                  icon: Icon(Icons.add),
                ),

              ],
            ),

            FilledButton.icon(
              onPressed: isLoading
                  ? null
                  : () async {
                      final isValid = _formKey.currentState!.validate();
                      if (!isValid || selectedDevice == null || isLoading) {
                        if (await Vibration.hasVibrator()) {
                          Vibration.vibrate(preset: VibrationPreset.doubleBuzz); // 100ms
                        }
                        return;
                      }

                      setState(() => isLoading = true);

                      final ticket = Ticket(
                        id: '',
                        title: ticketTitle,
                        description: ticketDescription,
                        status: TicketStatus.newTicket,
                        priority: TicketPriority.low,
                        category: ticketCategory,
                        otherCaregory: otherCategory,
                        createdById: '16jtPLSwjWgH9iiUfTZDRZhBBUM2',
                        createdByName: 'Leiva Franco',
                        createdByEmail: 'leesingripex006@gmail.com',
                        deviceId: selectedDevice!.id,
                        technicianId: '',
                        createdAt: DateTime.now(),
                        assignedAt: DateTime.now(),
                        openedAt: DateTime.now(),
                        closedAt: DateTime.now(),
                        hasFeedback: false,
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

                      if (await Vibration.hasVibrator()) {
                        Vibration.vibrate(preset: VibrationPreset.singleShortBuzz); // 100ms
                      }

                      if (context.mounted) {
                        context.pop(ticket.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Ticket creado con éxito'),
                            backgroundColor: colors.primary,
                          ),
                        );
                      }
                    },
              label: const Text(
                'Crear Ticket',
                style: TextStyle(
                  fontWeight: FontWeight.w700
                ),
              ),
              icon: const Icon(Icons.confirmation_num_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
