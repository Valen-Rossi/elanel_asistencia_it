import 'package:elanel_asistencia_it/domain/entities/faq.dart';
import 'package:elanel_asistencia_it/presentation/providers/faqs/faqs_provider.dart';
import 'package:elanel_asistencia_it/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markdown_toolbar/markdown_toolbar.dart';

class NewFAQScreen extends ConsumerStatefulWidget {
  static const name = 'new-faq-screen';

  const NewFAQScreen({super.key});

  @override
  NewFAQScreenState createState() => NewFAQScreenState();
}

class NewFAQScreenState extends ConsumerState<NewFAQScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _descriptionController = TextEditingController();

  String faqTitle = '';
  FAQType faqType = FAQType.hardware;
  bool isLoading = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nueva Pregunta Frecuente',
          style: TextStyle(
            color: colors.primary,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 20,
            children: [

              CustomTextFormField(
                label: 'Título',
                hintText: 'Ingrese el título del problema',
                icon: Icons.title,
                onChanged: (value) => faqTitle = value.trim(),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'El título es obligatorio';
                  }
                  return null;
                },
              ),

              MarkdownToolbar(
                useIncludedTextField: false,
                hideCheckbox: true,
                hideQuote: true,
                hideLink: true,
                hideImage: true,
                hideHorizontalRule: true,
                controller: _descriptionController,
                alignment: WrapAlignment.center,
                alignCollapseButtonEnd: true,
                width: 50,
                backgroundColor: colors.surface,
                iconColor: colors.onSurface,
              ),

              CustomTextFormField(
                label: 'Descripción',
                hintText: 'Detalla la solución del problema',
                controller: _descriptionController,
                minLines: 10,
                maxLines: 25,
                textInputAction: TextInputAction.newline,
                textInputType: TextInputType.multiline,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'La descripción es obligatoria';
                  }
                  return null;
                },
              ),
              
            CustomDropdownFormField<FAQType>(
              label: 'Tipo de problema',
              hint: 'Elija el tipo de problema',
              // prefixIcon: Icons.category,
              items: FAQType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(
                    type.name[0].toUpperCase() + type.name.substring(1),
                  ),
                );
              }).toList(),
              validator: (value) {
                if (value == null) return 'El tipo de problema es obligatorio';
                return null;
              },
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    faqType = value;
                  });
                }
              },
            ),



              FilledButton.tonalIcon(
                onPressed: () async {
                  final isValid = _formKey.currentState!.validate();
                  if (!isValid || isLoading) return;

                  setState(() => isLoading = true);

                  final newFAQ = FAQ(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    title: faqTitle,
                    description: _descriptionController.text.trim(),
                    type: faqType,
                  );

                  await ref
                      .read(faqsProvider.notifier)
                      .createFAQ(newFAQ);

                  setState(() => isLoading = false);

                  if (context.mounted) {
                    Navigator.of(context).pop();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('FAQ creada con éxito'),
                        duration: const Duration(seconds: 3),
                        backgroundColor: colors.primary,
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
