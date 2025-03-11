import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'common/strings.dart';
import 'core/styles/theme/dark_green_theme.dart';
import 'core/styles/theme/light_green_theme.dart';
import 'presentation/screens/split_screen.dart';
import 'services/theme_provider.dart';
import 'data/repository/ai_text_service.dart';
import 'presentation/providers/ai_improvement_provider.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'presentation/screens/auth/signup_screen.dart';
import 'presentation/screens/auth/forgot_password_screen.dart';
import 'presentation/screens/auth/account_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyBwP4zqrF8UzzV46kf6BOdaVzg50a2_NeY",
        appId: "1:454199426978:web:03a9d13803b3faca0bbcfb",
        messagingSenderId: "454199426978",
        projectId: "resume-builder-4230d",
      ),
    );
  } catch (e, stack) {
    print('Firebase initialization error: $e');
    print('Stack trace: $stack');
  }
  // Create the AI service
  final aiTextService = AITextService(
    baseUrl: 'https://api.openai.com/v1',
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AIImprovementProvider(aiTextService: aiTextService),
        ),
        ChangeNotifierProvider(
          create: (_) => AppAuthProvider(),
        ),
      ],
      child: const FlutterResumeBuilder(),
    ),
  );
}

class FlutterResumeBuilder extends StatelessWidget {
  const FlutterResumeBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: Strings.flutterResumeBuilder,
          darkTheme: greenDarkModeThemeData(),
          theme: greenLightModeThemeData(),
          themeMode: themeProvider.themeMode,
          routerConfig: _router,
        );
      },
    );
  }
}

// GoRouter configuration
final GoRouter _router = GoRouter(
  initialLocation: '/login',
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
      builder: (context, state) => const LoginScreen(),
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
      builder: (context, state) => const SignupScreen(),
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
