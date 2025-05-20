import 'package:flutter/material.dart';

class NewTicketScreen extends StatelessWidget {

  static const name = 'new-ticket-screen';

  const NewTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NewTicket'),
      ),
      body: const _NewTicketView(),
    );
  }
}

class _NewTicketView extends StatelessWidget {
 const _NewTicketView();

 @override
 Widget build(BuildContext context) {
  return const Center(
    child: Text('NewTicketView'),
  );
 }
}