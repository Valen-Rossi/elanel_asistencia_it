import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elanel_asistencia_it/domain/entities/faq.dart';
import 'faqs_provider.dart';

final faqFilterProvider = StateProvider<FAQType?>((ref) => null);

final filteredFaqsProvider = Provider<List<FAQ>>((ref) {
  final filter = ref.watch(faqFilterProvider);
  final allFaqs = ref.watch(faqsProvider);

  if (filter == null) return allFaqs;

  return allFaqs.where((faq) => faq.type == filter).toList();
});
