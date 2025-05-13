import 'package:elanel_asistencia_it/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {

  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elanel Asistencia IT'),
      ),
      body: const _HomeView(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
 const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {

  @override
  void initState() {
    super.initState();
    
    ref.read(recentTicketsProvider.notifier).loadTickets();

  }

 @override
 Widget build(BuildContext context) {

  final recentTickets = ref.watch(recentTicketsProvider);

  return ListView.builder(
    itemCount: recentTickets.length,
    itemBuilder: (context, index) {

      final ticket = recentTickets[index];

      return ListTile(
        title: Text(ticket.title),
        subtitle: Text(ticket.description),
        trailing: Text(ticket.status.toString()),
        onTap: () {
          // Handle ticket tap
        },
      );
    },
  );
 }
}