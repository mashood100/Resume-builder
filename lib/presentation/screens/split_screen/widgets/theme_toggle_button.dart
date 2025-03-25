import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../common/strings.dart';
import '../../../../services/theme_provider.dart';

/// Button to toggle between light and dark theme
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return IconButton(
          icon: Icon(
            themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
          ),
          tooltip: themeProvider.isDarkMode
              ? Strings.switchToLightMode
              : Strings.switchToDarkMode,
          onPressed: () {
            themeProvider.toggleTheme();
          },
        );
      },
    );
  }
}
