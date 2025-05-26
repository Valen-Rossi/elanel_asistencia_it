import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elanel_asistencia_it/domain/entities/faq.dart';
import 'package:elanel_asistencia_it/presentation/providers/faqs/faqs_repository_provider.dart';

final faqsProvider = StateNotifierProvider<FAQsNotifier, List<FAQ>>((ref) {
  final repository = ref.watch(faqsRepositoryProvider);
  return FAQsNotifier(
    fetchFAQs: repository.getFAQs,
    addFAQ: repository.addFAQ,
  );
});

typedef FAQsCallback = Future<List<FAQ>> Function();
typedef AddFAQCallback = Future<void> Function(FAQ faq);

class FAQsNotifier extends StateNotifier<List<FAQ>> {
  bool isLoading = false;
  final FAQsCallback fetchFAQs;
  final AddFAQCallback addFAQ;

  FAQsNotifier({
    required this.fetchFAQs,
    required this.addFAQ,
  }) : super([]);

  Future<void> loadFAQs() async {
    if (isLoading) return;

    isLoading = true;

    final List<FAQ> faqs = await fetchFAQs();
    state.clear();
    state = [...faqs];

    isLoading = false;
  }

  Future<void> createFAQ(FAQ faq) async {
    if (isLoading) return;

    isLoading = true;

    await addFAQ(faq);
    await loadFAQs();

    isLoading = false;
  }
  
}