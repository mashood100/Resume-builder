import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'common/strings.dart';
import 'core/styles/theme/dark_green_theme.dart';
import 'core/styles/theme/light_green_theme.dart';
import 'screens/split_screen.dart';
import 'services/theme_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FlutterResumeBuilder());
}

class FlutterResumeBuilder extends StatelessWidget {
  const FlutterResumeBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: Strings.flutterResumeBuilder,
            darkTheme: greenDarkModeThemeData(),
            theme: greenLightModeThemeData(),
            themeMode: themeProvider.themeMode,
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
        },
      ),
    );
  }
}
