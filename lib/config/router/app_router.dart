import 'package:go_router/go_router.dart';
import 'package:elanel_asistencia_it/presentation/screens/screens.dart';
import 'package:elanel_asistencia_it/presentation/screens/views/views.dart';

final appRouter = GoRouter(

    initialLocation: '/',
    routes: [

      ShellRoute(
        builder: (context, state, child) => HomeScreen(childView: child),
        routes: [

          GoRoute(
            path: '/',
            builder: (context, state) => const HomeView(),
            routes: [

              GoRoute(
                path: "ticket/:id",
                name: TicketScreen.name,
                builder: (context, state) {

                  final ticketId = state.pathParameters['id']?? '';

                  return TicketScreen(ticketId: ticketId);
                }
              ),

            ]
          ),

          GoRoute(
            path: '/tickets',
            builder: (context, state) => const TicketsView(),
          ),

          GoRoute(
            path: '/inventary',
            builder: (context, state) => const InventaryView(),
          ),

          GoRoute(
            path: '/help',
            builder: (context, state) => const HelpView(),
          ),

        ]
      ),

      GoRoute(
        path: '/new-ticket',
        builder: (context, state) => const NewTicketScreen(),
      ),

    ],

);