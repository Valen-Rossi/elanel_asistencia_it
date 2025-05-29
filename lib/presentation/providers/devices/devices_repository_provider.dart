import 'package:elanel_asistencia_it/infrastructure/datasources/devices_fb_datasource.dart';
import 'package:elanel_asistencia_it/infrastructure/repositories/devices_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final devicesRepositoryProvider = Provider((ref) {
  return DevicesRepositoryImpl(DevicesFbDatasource());
});