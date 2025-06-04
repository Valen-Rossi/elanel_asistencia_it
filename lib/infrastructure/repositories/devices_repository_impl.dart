import 'package:elanel_asistencia_it/domain/datasources/devices_datasource.dart';
import 'package:elanel_asistencia_it/domain/entities/device.dart';
import 'package:elanel_asistencia_it/domain/repositories/devices_repository.dart';


class DevicesRepositoryImpl extends IDevicesRepository {

  final IDevicesDatasource datasource;
  
  DevicesRepositoryImpl(this.datasource);

  @override
  Future<List<Device>> getDevices() {
    return datasource.getDevices();
  }

  @override
  Future<void> addDevice(Device device) {
    return datasource.addDevice(device);
  }

  @override
  Future<void> deleteDevice(String id) {
    // TODO: implement deleteDevice
    throw UnimplementedError();
  }

  @override
  Future<void> updateDevice(Device device) {
    // TODO: implement updateDevice
    return datasource.updateDevice(device);
  }
  
}