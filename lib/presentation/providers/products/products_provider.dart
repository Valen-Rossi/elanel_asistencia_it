import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elanel_asistencia_it/domain/entities/product.dart';
import 'package:elanel_asistencia_it/presentation/providers/products/products_repository_provider.dart';


final productsProvider = StateNotifierProvider<ProductsNotifier, List<Product>>((ref) {
  final repository = ref.watch(productsRepositoryProvider);
  return ProductsNotifier(
    fetchProducts: repository.getProducts,
    addProduct: repository.addProduct,
  );
});

typedef ProductsCallback = Future<List<Product>> Function();
typedef AddProductCallback = Future<void> Function(Product product);

class ProductsNotifier extends StateNotifier<List<Product>> {
  bool isLoading = false;
  final ProductsCallback fetchProducts;
  final AddProductCallback addProduct;

  ProductsNotifier({
    required this.fetchProducts,
    required this.addProduct,
  }) : super([]);

  Future<void> loadProducts() async {
    if (isLoading) return;

    isLoading = true;

    final List<Product> products = await fetchProducts();
    state.clear();
    state = [...products];

    isLoading = false;
  }

  Future<void> createProduct(Product product) async {
    if (isLoading) return;

    isLoading = true;

    await addProduct(product);
    await loadProducts();

    isLoading = false;
  }
}