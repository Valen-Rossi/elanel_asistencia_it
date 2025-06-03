import 'package:elanel_asistencia_it/domain/entities/faq.dart';
import 'package:elanel_asistencia_it/presentation/providers/providers.dart';
import 'package:elanel_asistencia_it/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HelpView extends ConsumerStatefulWidget {

  static const name = 'help-view';

  const HelpView({super.key});

  @override
  HelpViewState createState() => HelpViewState();
}

class HelpViewState extends ConsumerState<HelpView> {

  @override
  void initState() {
    super.initState();

    ref.read(faqsProvider.notifier).loadFAQs();

  }

  @override
  Widget build(BuildContext context) {
    final faqs = ref.watch(filteredFaqsProvider);
    final selectedType = ref.watch(faqFilterProvider);
    final filterNotifier = ref.read(faqFilterProvider.notifier);
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          context.push('/new-faq');
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(
          'Preguntas Frecuentes',
          style: TextStyle(
            color: colors.primary,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => filterNotifier.state = null,
            child: const Text('Limpiar filtros'),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: CustomDropdownFormField<FAQType?>(
              label: 'Tipo',
              value: selectedType,
              items: [
                const DropdownMenuItem(value: null, child: Text('Todos')),
                ...FAQType.values.map((type) => DropdownMenuItem(
                    value: type, child: Text(type.label))),
              ],
              onChanged: (value) => filterNotifier.state = value,
            ),
          ),
          Expanded(
            child: faqs.isEmpty
                ? Center(
                    child: Text(
                      'No se encontraron preguntas con este filtro.',
                      style: TextStyle(color: colors.onSurfaceVariant),
                    ),
                  )
                : ListView.builder(
                    itemCount: faqs.length,
                    itemBuilder: (context, index) {
                      final faq = faqs[index];
                      return FAQCard(faq: faq);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}