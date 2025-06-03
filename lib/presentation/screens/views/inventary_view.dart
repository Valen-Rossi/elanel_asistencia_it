import 'package:elanel_asistencia_it/domain/entities/device.dart';
import 'package:elanel_asistencia_it/presentation/providers/providers.dart';
import 'package:elanel_asistencia_it/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class InventaryView extends ConsumerStatefulWidget {

  static const name = 'inventary-view';

  const InventaryView({super.key});

  @override
  InventaryViewState createState() => InventaryViewState();
}

class InventaryViewState extends ConsumerState<InventaryView> {

  @override
  void initState() {
    super.initState();

    ref.read(devicesProvider.notifier).loadDevices();

  }

  @override
  Widget build(BuildContext context) {
    final filteredDevices = ref.watch(filteredDevicesProvider);
    final filters = ref.watch(deviceFilterProvider);
    final filterNotifier = ref.read(deviceFilterProvider.notifier);
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/new-device');
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(
          'Inventario',
          style: TextStyle(
            color: colors.primary,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              filterNotifier.state = DeviceFilterState.empty;
            },
            child: const Text('Limpiar filtros'),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: CustomDropdownFormField<DeviceType?>(
                    label: 'Tipo de dispositivo',
                    value: filters.type,
                    items: [
                      const DropdownMenuItem(
                          value: null, child: Text('Todos')),
                      ...DeviceType.values.map((type) => DropdownMenuItem(
                          value: type, child: Text(type.label)))
                    ],
                    onChanged: (type) => filterNotifier.state =
                        filterNotifier.state.copyWith(type: type),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredDevices.isEmpty
                ? Center(
                    child: Text(
                      'No se encontraron dispositivos.',
                      style: TextStyle(color: colors.onSurfaceVariant),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredDevices.length,
                    itemBuilder: (context, index) {
                      final device = filteredDevices[index];
                      return DeviceCard(device: device);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}