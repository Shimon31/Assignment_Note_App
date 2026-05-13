import 'package:assignment_note_app/modules/auth/login_page.dart';
import 'package:assignment_note_app/modules/auth/register_page.dart';
import 'package:assignment_note_app/modules/notes/add_note_page.dart';
import 'package:assignment_note_app/modules/notes/home_page.dart';
import 'package:assignment_note_app/modules/splash/splash_page.dart';
import 'package:go_router/go_router.dart';


class AppRoutes {
  static final router = GoRouter(
    initialLocation: '/home',
    routes: [

      GoRoute(
        path: '/',
        builder: (context, state) => const SplashPage(),
      ),

      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),

      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),

      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),

      GoRoute(
        path: '/add-note',
        builder: (context, state) => const AddNotePage(),
      ),
    ],
  );
}