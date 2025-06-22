import 'package:elanel_asistencia_it/domain/entities/user.dart';
import 'package:elanel_asistencia_it/presentation/providers/providers.dart';
import 'package:flutter/material.dart';

import 'package:elanel_asistencia_it/presentation/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vibration/vibration.dart';
import 'package:vibration/vibration_presets.dart';

class NewUserScreen extends StatelessWidget {

  static const name = 'new-user-screen';

  const NewUserScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Usuario',
        style: TextStyle(
              color: colors.primary,
              fontSize: 22,
              fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: const _NewUserView(),
    );
  }
}

class _NewUserView extends ConsumerStatefulWidget {
 const _NewUserView();

  @override
  _NewUserViewState createState() => _NewUserViewState();
}

class _NewUserViewState extends ConsumerState<_NewUserView> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String userName = '';
  String userEmail = '';
  String userPassword = '';
  UserRole userRole = UserRole.client;

  bool isPasswordVisible = false;
  

 @override
 Widget build(BuildContext context) {

  final colors = Theme.of(context).colorScheme;
  bool isLoading = false;

  return SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Form(
      key: _formKey,
      child: Column(
        spacing: 20,
        children: [
          
          CustomTextFormField(
            label: 'Nombre del Usuario',
            hintText: 'Ejemplo: Lautaro Rodríguez',
            icon: Icons.title,
            textCapitalization: TextCapitalization.words,
            onChanged: (value) => userName = value.trim(),
            validator: (value) {
              if (value == null || value.trim().isEmpty) return 'El nombre del usuario es requerido';
              if (value.length < 4) return 'El nombre del usuario debe tener al menos 4 caracteres';
              if (value.length > 20) return 'El nombre del usuario no puede tener más de 20 caracteres';
              return null;
            },
          ),
          
          CustomTextFormField(
            label: 'Correo del Usuario',
            hintText: 'Ejemplo: lautaro@gmail.com',
            icon: Icons.mail_outline_rounded,
            textCapitalization: TextCapitalization.none,
            textInputType: TextInputType.emailAddress,
            onChanged: (value) => userEmail = value.trim(),
            validator: (value) {
              if (value == null || value.trim().isEmpty) return 'El correo del usuario es requerido';
              if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                return 'El correo del usuario no tiene un formato válido';
              }
              return null;
            },
          ),

          CustomTextFormField(
            label: 'Contraseña del Usuario',
            hintText: 'Ingrese una contraseña',
            icon: Icons.lock_outline,
            textCapitalization: TextCapitalization.none,
            textInputType: TextInputType.visiblePassword,
            obscureText: !isPasswordVisible,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() => isPasswordVisible = !isPasswordVisible);
              },
              icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
            ),
            onChanged: (value) => userPassword = value.trim(),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'La contraseña del usuario es requerida';
              }
              if (value.length < 6) {
                return 'Debe tener al menos 6 caracteres';
              }
              if (!RegExp(r'\d').hasMatch(value)) {
                return 'Debe contener al menos un número';
              }
              return null;
            },
          ),


          CustomDropdownFormField<UserRole>(
            label: 'Rol de Usuario',
            hint: 'Seleccione el rol de usuario',
            items: UserRole.values
                .map((type) => DropdownMenuItem(
                      value: type,
                      child: Text(type.label),
                    ))
                .toList(),
            onChanged: (value) {
              if (value != null) setState(() => userRole = value);
            },
            validator: (value) {
              if (value == null) return 'El rol de usuario es obligatorio';
              return null;
            },
          ),


          FilledButton.icon(
            onPressed: () async {
              final isValid = _formKey.currentState!.validate();
              if (!isValid || isLoading) {
                if (await Vibration.hasVibrator()) {
                  Vibration.vibrate(preset: VibrationPreset.doubleBuzz); // 100ms
                }
                return;
              }

              setState(() => isLoading = true);

              final newUser = User(
                id: DateTime.now().millisecondsSinceEpoch.toString(), // ejemplo de id temporal
                name: userName,
                role: userRole,
                email: userEmail,
                password: userPassword,
              );

              await ref
                .read(usersProvider.notifier)
                .createUser(newUser);

              setState(() => isLoading = false);

              if (await Vibration.hasVibrator()) {
                Vibration.vibrate(preset: VibrationPreset.singleShortBuzz); // 100ms
              }

              if (context.mounted) {
                // Mostrar snackbar de éxito
                context.pop(newUser.id); // volver atrás devolviendo el id
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Usuario creado con éxito'),
                    duration: const Duration(seconds: 3),
                    backgroundColor: colors.primary,
                  ),
                );
              }
            },

            label: const Text(
              'Crear',
              style: TextStyle(
                fontWeight: FontWeight.w700
              ),
            ),

            icon: const Icon(Icons.save),
          ),
      ],
      ),
    ),
  );
 }
}