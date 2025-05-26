import 'package:flutter/material.dart';
import 'package:elanel_asistencia_it/presentation/widgets/shared/custom_text_form_field.dart';
import 'package:markdown_toolbar/markdown_toolbar.dart';

class NewFAQScreen extends StatefulWidget {
  static const name = 'new-faq-screen';

  const NewFAQScreen({super.key});

  @override
  State<NewFAQScreen> createState() => _NewFAQScreenState();
}

class _NewFAQScreenState extends State<NewFAQScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text.trim();
      final description = _descriptionController.text.trim();

      if (description.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('La descripción es obligatoria')),
        );
        return;
      }

      // Aquí puedes implementar la lógica para guardar el FAQ
      print('Título: $title');
      print('Descripción: $description');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('FAQ guardada correctamente')),
      );

      _titleController.clear();
      _descriptionController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva FAQ'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              CustomTextFormField(
                controller: _titleController,
                label: 'Título',
                hintText: 'Ingrese el título del problema',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'El título es obligatorio';
                  }
                  return null;
                },
              ),

              MarkdownToolbar(
                useIncludedTextField: false,
                controller: _descriptionController,
                alignment: WrapAlignment.center,
                width: 50,
                backgroundColor: colors.surface,
                iconColor: colors.onSurface,
              ),

              TextFormField(
                controller: _descriptionController,
                minLines: 10,
                maxLines: 25,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  hintText: 'Ingrese la descripción de la solución',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'La descripción es obligatoria';
                  }
                  return null;
                },
              ),

              ElevatedButton.icon(
                onPressed: _submit,
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
