import 'package:flutter_resume_builder/presentation/providers/auth_provider.dart';
import 'package:flutter_resume_builder/presentation/screens/auth/account_screen.dart';
import 'package:flutter_resume_builder/presentation/screens/auth/forgot_password_screen.dart';
import 'package:flutter_resume_builder/presentation/screens/split_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplitScreen(),
      redirect: (context, state) {
        final authProvider =
            Provider.of<AppAuthProvider>(context, listen: false);
        if (!authProvider.isAuthenticated) {
          return '/login';
        }
        return null;
      },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const SplitScreen(),
      redirect: (context, state) {
        final authProvider =
            Provider.of<AppAuthProvider>(context, listen: false);
        if (authProvider.isAuthenticated) {
          return '/';
        }
        return null;
      },
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SplitScreen(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/account',
      builder: (context, state) => const AccountScreen(),
      redirect: (context, state) {
        final authProvider =
            Provider.of<AppAuthProvider>(context, listen: false);
        if (!authProvider.isAuthenticated) {
          return '/login';
        }
        return null;
      },
    ),
  ],
);
