import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:elanel_asistencia_it/presentation/screens/screens.dart';
import 'package:elanel_asistencia_it/presentation/screens/views/views.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  redirect: (context, state) {
    final user = FirebaseAuth.instance.currentUser;
    final isLoggingIn = state.uri.toString() == '/login';

    if (user == null && !isLoggingIn) return '/login';
    if (user != null && isLoggingIn) return '/';

    return null;
  },
  routes: [

    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),

    GoRoute(
      path: '/login',
      name: LoginScreen.name,
      builder: (context, state) => const LoginScreen(),
    ),

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

              GoRoute(
                path: "user/:id",
                name: UserScreen.name,
                builder: (context, state) {

                  final userId = state.pathParameters['id']?? '';

                  return UserScreen(userId: userId);
                }
              ),

              GoRoute(
                path: "device/:id",
                name: DeviceScreen.name,
                builder: (context, state) {

                  final deviceId = state.pathParameters['id']?? '';

                  return DeviceScreen(deviceId: deviceId);
                }
              ),

              GoRoute(
                path: "faq/:id",
                name: FAQScreen.name,
                builder: (context, state) {

                  final faqId = state.pathParameters['id']?? '';

                  return FAQScreen(faqId: faqId);
                }
              ),

            ]
          ),

          GoRoute(
            path: '/tickets',
            builder: (context, state) => const TicketsView(),
          ),

          GoRoute(
            path: '/users',
            builder: (context, state) => const UsersView(),
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

      GoRoute(
        path: '/new-faq',
        builder: (context, state) => const NewFAQScreen(),
      ),

      GoRoute(
        path: '/new-user',
        builder: (context, state) => const NewUserScreen(),
      ),

      GoRoute(
        path: '/new-device',
        builder: (context, state) => const NewDeviceScreen(),
      ),

      GoRoute(
        path: '/ticket-qr-scan',
        name: TicketQRScanScreen.name,
        builder: (context, state) => const TicketQRScanScreen(),
      ),

      GoRoute(
        path: '/preview',
        name: 'preview',
        builder: (context, state) {
          final url = state.uri.queryParameters['url']!;
          final isVideo = state.uri.queryParameters['isVideo'] == 'true';
          return MediaPreviewScreen(url: url, isVideo: isVideo);
        },
      ),


    ],

);