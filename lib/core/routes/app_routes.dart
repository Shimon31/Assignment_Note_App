import 'package:assignment_note_app/modules/auth/login_screen.dart';
import 'package:assignment_note_app/modules/auth/register_screen.dart';
import 'package:assignment_note_app/modules/notes/add_note.dart';
import 'package:assignment_note_app/modules/notes/home.dart';
import 'package:assignment_note_app/modules/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';


class AppRoutes {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [

      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),

      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),

      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      GoRoute(
        path: '/home',
        builder: (context, state) => const Home(),
      ),

      GoRoute(
        path: '/add-note',
        builder: (context, state) => const AddNote(),
      ),
    ],
  );
}