import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'common/strings.dart';
import 'common/styles/theme/dark_green_theme.dart';
import 'common/styles/theme/light_green_theme.dart';
import 'screens/split_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FlutterResumeBuilder());
}

class FlutterResumeBuilder extends StatelessWidget {
  const FlutterResumeBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: Strings.flutterResumeBuilder,
      darkTheme: greenDarkModeThemeData(),
      theme: greenLightModeThemeData(),
      routerConfig: GoRouter(
        routes: <RouteBase>[
          GoRoute(
            path: '/',
            builder: (BuildContext context, GoRouterState state) {
              return const SplitScreen();
            },
          ),
        ],
      ),
    );
  }
}
