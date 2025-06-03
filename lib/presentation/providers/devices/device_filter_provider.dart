import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elanel_asistencia_it/domain/entities/device.dart';
import 'devices_provider.dart';

// Estado del filtro de dispositivos
class DeviceFilterState {
  final DeviceType? type;

  const DeviceFilterState({this.type});

  static const empty = DeviceFilterState();

  static const _noChange = Object();

  DeviceFilterState copyWith({Object? type = _noChange}) {
    return DeviceFilterState(
      type: type == _noChange ? this.type : type as DeviceType?,
    );
  }
}

// Provider del filtro
final deviceFilterProvider = StateProvider<DeviceFilterState>((ref) {
  return DeviceFilterState.empty;
});

// Provider de dispositivos filtrados
final filteredDevicesProvider = Provider<List<Device>>((ref) {
  final filter = ref.watch(deviceFilterProvider);
  final allDevices = ref.watch(devicesProvider);

  return allDevices.where((device) {
    final matchType = filter.type == null || device.type == filter.type;
    return matchType;
  }).toList();
});
