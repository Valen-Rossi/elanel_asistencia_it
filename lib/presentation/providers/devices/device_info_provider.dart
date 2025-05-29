import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elanel_asistencia_it/domain/entities/device.dart';
import 'package:elanel_asistencia_it/presentation/providers/devices/devices_provider.dart';

// Device by id provider
final deviceByIdProvider = Provider.family<Device, String>((ref, id) {
  final devices = ref.watch(devicesProvider);
  return devices.firstWhere((device) => device.id == id);
});