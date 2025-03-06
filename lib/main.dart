import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'common/strings.dart';
import 'core/styles/theme/dark_green_theme.dart';
import 'core/styles/theme/light_green_theme.dart';
import 'presentation/screens/split_screen.dart';
import 'services/theme_provider.dart';
import 'data/repository/ai_text_service.dart';
import 'presentation/providers/ai_improvement_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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
      ],
      child: const FlutterResumeBuilder(),
    ),
  );
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
