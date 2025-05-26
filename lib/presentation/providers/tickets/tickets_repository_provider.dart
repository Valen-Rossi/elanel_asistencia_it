import 'package:elanel_asistencia_it/infrastructure/datasources/tickets_fb_datasource.dart';
import 'package:elanel_asistencia_it/infrastructure/repositories/tickets_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// repositorio inmutable solo lectura 
final ticketRepositoryProvider = Provider((ref) {
  return TicketsRepositoryImpl(TicketsFbDatasource());
});