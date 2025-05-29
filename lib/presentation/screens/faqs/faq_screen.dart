import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_markdown/flutter_markdown.dart'; // <- Importante
import 'package:elanel_asistencia_it/domain/entities/faq.dart';
import 'package:elanel_asistencia_it/presentation/providers/providers.dart';

class FAQScreen extends ConsumerWidget {
  static const name = 'faq-screen';
  final String faqId;

  const FAQScreen({super.key, required this.faqId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FAQ faq = ref.watch(faqByIdProvider(faqId));
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalle de la Solución',
          style: TextStyle(
            color: colors.primary,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: _FAQView(faq: faq),
    );
  }
}

class _FAQView extends StatelessWidget {
  const _FAQView({
    required this.faq,
  });

  final FAQ faq;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _InfoFAQ(faq: faq),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _InfoFAQ extends StatelessWidget {
  const _InfoFAQ({
    required this.faq,
  });

  final FAQ faq;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            faq.title,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: colors.primary,
            ),
          ),

          const SizedBox(height: 10),

          MarkdownBody(
            data: faq.description,
            selectable: true,
            styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
              p: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ),

        ],
      ),
    );
  }
}
