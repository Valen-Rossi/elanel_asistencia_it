import 'package:elanel_asistencia_it/domain/datasources/devices_datasource.dart';
import 'package:elanel_asistencia_it/domain/entities/device.dart';


class DevicesFbDatasource extends IDevicesDatasource {

  final List<Device> devices = [
    Device(
      id: '001',
      name: 'Laptop Dell XPS 13',
      type: DeviceType.laptop,
    ),
    Device(
      id: '002',
      name: 'Smartphone Samsung Galaxy S21',
      type: DeviceType.phone,
    ),
    Device(
      id: '003',
      name: 'Monitor LG UltraWide 34"',
      type: DeviceType.monitor,
    ),
  ];

  @override
  Future<List<Device>> getDevices() async {
    return devices;
  }
  
  @override
  Future<void> addDevice(Device device) async {
    devices.insert(0, device);
  }
  
  @override
  Future<void> deleteDevice(String id) async {
  }
  
  @override
  Future<void> updateDevice(Device device) {
    // TODO: implement updateDevice
    throw UnimplementedError();
  }
  
}