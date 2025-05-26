import 'package:elanel_asistencia_it/infrastructure/datasources/products_fb_datasource.dart';
import 'package:elanel_asistencia_it/infrastructure/repositories/products_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final productsRepositoryProvider = Provider((ref) {
  return ProductsRepositoryImpl(ProductsFbDatasource());
});