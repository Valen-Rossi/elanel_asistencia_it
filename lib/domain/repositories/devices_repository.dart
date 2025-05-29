import 'package:elanel_asistencia_it/domain/entities/device.dart';


abstract class IDevicesRepository {
  
  Future<List<Device>> getDevices();
  Future<void> addDevice(Device device);
  Future<void> updateDevice(Device device);
  Future<void> deleteDevice(String id);
  
}