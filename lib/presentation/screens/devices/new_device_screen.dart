import 'package:elanel_asistencia_it/domain/entities/device.dart';
import 'package:elanel_asistencia_it/presentation/providers/providers.dart';
import 'package:flutter/material.dart';

import 'package:elanel_asistencia_it/presentation/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NewDeviceScreen extends StatelessWidget {

  static const name = 'new-device-screen';

  const NewDeviceScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Dispositivo',
        style: TextStyle(
              color: colors.primary,
              fontSize: 22,
              fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: const _NewDeviceView(),
    );
  }
}

class _NewDeviceView extends ConsumerStatefulWidget {
 const _NewDeviceView();

  @override
  _NewDeviceViewState createState() => _NewDeviceViewState();
}

class _NewDeviceViewState extends ConsumerState<_NewDeviceView> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String deviceName = '';
  DeviceType deviceType = DeviceType.printer;

 @override
 Widget build(BuildContext context) {

  final colors = Theme.of(context).colorScheme;
  bool isLoading = false;

  return SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Form(
      key: _formKey,
      child: Column(
        spacing: 20,
        children: [
          
          CustomTextFormField(
            label: 'Nombre del Dispositivo',
            hintText: 'Ejemplo: Impresora HP LaserJet',
            icon: Icons.title,
            onChanged: (value) => deviceName = value,
            validator: (value) {
              if (value == null || value.trim().isEmpty) return 'El nombre del dispositivo es requerido';
              if (value.length < 4) return 'El nombre del dispositivo debe tener al menos 4 caracteres';
              if (value.length > 20) return 'El nombre del dispositivo no puede tener más de 20 caracteres';
              return null;
            },
          ),


          FilledButton.tonalIcon(
            onPressed: () async {
              final isValid = _formKey.currentState!.validate();
              if (!isValid || isLoading) return;

              setState(() => isLoading = true);

              final newDevice = Device(
                id: DateTime.now().millisecondsSinceEpoch.toString(), // ejemplo de id temporal
                name: deviceName,
                type: deviceType
              );

              await ref
                .read(devicesProvider.notifier)
                .createDevice(newDevice);

              setState(() => isLoading = false);

              if (context.mounted) {
                // Mostrar snackbar de éxito
                context.pop(); // volver atrás
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Dispositivo creado con éxito'),
                    duration: const Duration(seconds: 3),
                    backgroundColor: colors.primary,
                  ),
                );
              }
            },

            label: const Text('Guardar'),
            icon: const Icon(Icons.add),
          ),
      ],
      ),
    ),
  );
 }
}