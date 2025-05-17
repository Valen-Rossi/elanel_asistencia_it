import 'package:go_router/go_router.dart';
import 'package:elanel_asistencia_it/presentation/screens/screens.dart';

final appRouter = GoRouter(

    initialLocation: '/',
    routes: [

        GoRoute(
            path: "/",
            name: HomeScreen.name,
            builder: (context, state) => const HomeScreen(),
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

    ],

);