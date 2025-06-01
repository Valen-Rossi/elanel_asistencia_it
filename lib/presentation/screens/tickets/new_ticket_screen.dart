import 'package:elanel_asistencia_it/domain/entities/ticket.dart';
import 'package:elanel_asistencia_it/presentation/providers/tickets/tickets_providers.dart';
import 'package:flutter/material.dart';

import 'package:elanel_asistencia_it/presentation/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NewTicketScreen extends StatelessWidget {

  static const name = 'new-ticket-screen';

  const NewTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Ticket',
        style: TextStyle(
              color: colors.primary,
              fontSize: 22,
              fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: const _NewTicketView(),
    );
  }
}

class _NewTicketView extends ConsumerStatefulWidget {
 const _NewTicketView();

  @override
  _NewTicketViewState createState() => _NewTicketViewState();
}

class _NewTicketViewState extends ConsumerState<_NewTicketView> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String ticketTitle = '';
  String ticketDescription = '';

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
            label: 'Título',
            hintText: 'Ejemplo: Problema con impresora',
            icon: Icons.title,
            onChanged: (value) => ticketTitle = value.trim(),
            validator: (value) {
              if (value == null || value.trim().isEmpty) return 'El título del ticket es requerido';
              if (value.length < 4) return 'El título del ticket debe tener al menos 4 caracteres';
              if (value.length > 20) return 'El título del ticket no puede tener más de 20 caracteres';
              return null;
            },
          ),

          CustomTextFormField(
            label: 'Descripción',
            hintText: 'Describe el problema en detalle',
            icon: Icons.description,
            maxLines: 10,
            onChanged: (value) => ticketDescription = value.trim(),
            validator: (value) {
              if (value == null || value.trim().isEmpty) return 'La descripción del ticket es requerida';
              if (value.length < 10) return 'La descripción del ticket debe tener al menos 10 caracteres';
              if (value.length > 50) return 'La descripción del ticket no puede tener más de 50 caracteres';
              return null;
            },
          ),

          FilledButton.tonalIcon(
            onPressed: () async {
              final isValid = _formKey.currentState!.validate();
              if (!isValid || isLoading) return;

              setState(() => isLoading = true);

              final newTicket = Ticket(
                id: DateTime.now().millisecondsSinceEpoch.toString(), // ejemplo de id temporal
                title: ticketTitle,
                description: ticketDescription,
                status: TicketStatus.newTicket,
                priority: TicketPriority.low,
                category: TicketCategory.hardware,
                otherCaregory: '',
                deviceId: '',
                technicianId: '',
                createdAt: DateTime.now(),
              );

              await ref
                .read(recentTicketsProvider.notifier)
                .createTicket(newTicket);

              setState(() => isLoading = false);

              if (context.mounted) {
                // Mostrar snackbar de éxito
                context.pop(); // volver atrás
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Ticket creado con éxito'),
                    duration: const Duration(seconds: 3),
                    backgroundColor: colors.primary,
                  ),
                );
              }
            },

            label: const Text('Crear Ticket'),
            icon: const Icon(Icons.add),
          ),
      ],
      ),
    ),
  );
 }
}