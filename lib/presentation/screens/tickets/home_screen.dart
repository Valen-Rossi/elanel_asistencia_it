import 'package:elanel_asistencia_it/presentation/providers/users/users_provider.dart';
import 'package:flutter/material.dart';

import 'package:elanel_asistencia_it/presentation/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {

  static const name = 'home-screen';

  final Widget childView;

  const HomeScreen({
    super.key, 
    required this.childView
  });

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {

  @override
  void initState() {
    super.initState();

    ref.read(usersProvider.notifier).fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.childView,
      bottomNavigationBar: const CustomBottomNavigationBar(
        // currentIndex: 0,
      ),
    );
  }
}
