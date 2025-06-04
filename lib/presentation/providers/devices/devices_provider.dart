import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elanel_asistencia_it/domain/entities/device.dart';
import 'package:elanel_asistencia_it/presentation/providers/devices/devices_repository_provider.dart';


final devicesProvider = StateNotifierProvider<DevicesNotifier, List<Device>>((ref) {
  final repository = ref.watch(devicesRepositoryProvider);
  return DevicesNotifier(
    fetchDevices: repository.getDevices,
    addDevice: repository.addDevice,
    deviceUpdate: repository.updateDevice,
  );
});

typedef DevicesCallback = Future<List<Device>> Function();
typedef AddDeviceCallback = Future<void> Function(Device device);
typedef DeviceUpdateCallback = Future<void> Function(Device device);


class DevicesNotifier extends StateNotifier<List<Device>> {
  bool isLoading = false;
  final DevicesCallback fetchDevices;
  final AddDeviceCallback addDevice;
  final DeviceUpdateCallback deviceUpdate;

  DevicesNotifier({
    required this.fetchDevices,
    required this.addDevice,
    required this.deviceUpdate,
  }) : super([]);

  Future<void> loadDevices() async {
    if (isLoading) return;

    isLoading = true;

    final List<Device> devices = await fetchDevices();
    state.clear();
    state = [...devices];

    isLoading = false;
  }

  Future<void> createDevice(Device device) async {
    if (isLoading) return;

    isLoading = true;

    await addDevice(device);
    state = [device, ...state];

    isLoading = false;
  }

  Future<void> updateDevice(Device updatedDevice) async {
    if (isLoading) return;

    isLoading = true;

    await deviceUpdate(updatedDevice);

    state = state.map((device) {
      return device.id == updatedDevice.id ? updatedDevice : device;
    }).toList();

    isLoading = false;
  }
}