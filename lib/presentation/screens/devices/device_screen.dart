import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elanel_asistencia_it/domain/entities/device.dart';
import 'package:elanel_asistencia_it/presentation/providers/providers.dart';

class DeviceScreen extends ConsumerWidget {
  static const name = 'device-screen';
  final String deviceId;

  const DeviceScreen({super.key, required this.deviceId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final Device device = ref.watch(deviceByIdProvider(deviceId));
    
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalle del Dispositivo',
          style: TextStyle(
              color: colors.primary,
              fontSize: 22,
              fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: _DeviceView(device: device),
    );
  }
}

class _DeviceView extends StatelessWidget {
  const _DeviceView({
    required this.device, 
  });

  final Device device;

  @override
  Widget build(BuildContext context) {

    return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                _InfoDevice(device: device),

                const SizedBox(height: 20),

              ],
            ),
          );
  }
}

class _InfoDevice extends StatelessWidget {
  const _InfoDevice({
    required this.device,
  });

  final Device device;

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onInverseSurface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          CircleAvatar(
            backgroundColor: colors.onSecondary,
            radius: 47,
            child: Icon(
              color: colors.primary,
              size: 57,
              device.type.icon
            ),
          ),

          const SizedBox(height: 7),
    
          Text(
            device.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
    
          const SizedBox(height: 5),
    
          Text(
            'ID: ${device.id} - ${device.type.label}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
    
          const SizedBox(height: 37),

          Text(
            'Cantidad de tickets referidos: ${device.ticketCount}',
          ),
    
          const SizedBox(height: 5),

          (device.ticketCount !=0)
          ? Text(
              'Último mantenimiento: ${device.lastMaintenance.day.toString().padLeft(2, '0')}/${device.lastMaintenance.month.toString().padLeft(2, '0')}/${device.lastMaintenance.year}',
            )
          : Text('Este dispositivo aún no tuvo mantenimientos')
    
        ],
      ),
    );
  }
}