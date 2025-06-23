import 'package:elanel_asistencia_it/presentation/widgets/shared/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:elanel_asistencia_it/presentation/providers/providers.dart';
import 'package:vibration/vibration.dart';
import 'package:vibration/vibration_presets.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const name = 'login-screen';
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String userEmail = '';
  String userPassword = '';
  bool isLoading = false;
  bool isPasswordVisible = false;

  String? error;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text('Iniciar sesión',
          style: TextStyle(
            color: colors.primary, 
            fontWeight: FontWeight.bold, 
            fontSize: 25
          ),
        )
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            spacing: 17,
            children: [

            if (error != null)
              Text(error!, style: const TextStyle(color: Colors.red)),

            CustomTextFormField(
              label: 'Correo electrónico',
              hintText: 'Por ejemplo: usuario@ejemplo.com',
              icon: Icons.mail_outline_rounded,
              onChanged: (value) => userEmail = value.trim(),
              textInputType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.none,
              validator: (value) {
                if (value == null || value.trim().isEmpty) return 'El correo del usuario es requerido';
                if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                  return 'El correo del usuario no tiene un formato válido';
                }
                return null;
              },
            ),
            CustomTextFormField(
              label: 'Contraseña',
              hintText: 'Ingresa tu contraseña',
              icon: Icons.lock_outline,
              onChanged: (value) => userPassword = value.trim(),
              obscureText: !isPasswordVisible,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() => isPasswordVisible = !isPasswordVisible);
                },
                icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
              ),
              textInputType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              textCapitalization: TextCapitalization.none,
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
            const SizedBox(height: 20),
            FilledButton(
              onPressed: isLoading ? null : () async {
                final isValid = _formKey.currentState!.validate();
                if (!isValid || isLoading) {
                  if (await Vibration.hasVibrator()) {
                    Vibration.vibrate(preset: VibrationPreset.doubleBuzz); // 100ms
                  }
                  return;
                }
                setState(() {
                  error = null;
                  isLoading = true;
                });

                try {
                  final authService = ref.read(authServiceProvider);
                  await authService.login(userEmail, userPassword);

                  if (context.mounted) {
                    context.go('/'); // Redirige al home o lo que uses
                  }

                } catch (e) {
                  setState(() {
                    error = 'Credenciales inválidas';
                  });
                }

                setState(() => isLoading = false);
              },
              child: isLoading
                ? const CircularProgressIndicator()
                : const Text('Entrar'),
            ),
          ],
        ),
      ),
    ),
  );
  }
}
