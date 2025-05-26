import 'package:elanel_asistencia_it/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class NewProductScreen extends StatefulWidget {

  static const name = 'new-product-screen';

  const NewProductScreen({super.key});

  @override
  State<NewProductScreen> createState() => _NewProductScreenState();
}

class _NewProductScreenState extends State<NewProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Producto'),
      ),
      body: const _NewProductView(),
    );
  }
}

class _NewProductView extends StatelessWidget {
 const _NewProductView();

 @override
 Widget build(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(8),
    child: Form(
      child: Column(
        spacing: 20,
        children: [

          CustomTextFormField(
            label: 'Nombre del Producto',
            hintText: 'Ingrese el nombre del producto',
            textCapitalization: TextCapitalization.words,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'El nombre del producto es obligatorio';
              }
              return null;
            },
          ),

          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.save_outlined),
            label: const Text('Guardar'),
          )

        ],
      ) 
    ),
  );
 }
}