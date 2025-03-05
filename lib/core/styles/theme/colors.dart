import 'package:flutter/material.dart';

abstract class GlobalColors {
  static const grey50 = Color(0xFFF7F8F8);
  static const grey75 = Color.fromARGB(255, 244, 244, 244);
  static const grey100 = Color(0xFFEDEEF1);
  static const grey200 = Color(0xFFD8DBDF);
  static const grey300 = Color(0xFFB6BAC3);
  static const grey400 = Color(0xFF8E95A2);
  static const grey500 = Color(0xFF6B7280);
  static const grey600 = Color(0xFF5B616E);
  static const grey700 = Color(0xFF4A4E5A);
  static const grey800 = Color(0xFF40444C);
  static const grey900 = Color(0xFF383A42);
  static const grey950 = Color(0xFF25272C);

  static const primary = Color(0xFF0AD158);
  static const darkGreen = Color(0xFF052E14);
  static const hunterGreen = Color(0xFF0A4121);
  static const forestGreen = Color(0xFF0C9D46);
  static const white = Color(0xFFFFFFFF);
  static const bgCard = Color(0xFF0A4121);
  static const purpleDark = Color(0xFF6F42C1);
  static const purple = Color(0xFF8D79F6);
  static const purpleLight = Color(0xFFB09FFF);
  static const pink = Color(0xFFEE3264);
  static const pinkLight = Color(0xFFF87493);
  static const orange = Color(0xFFF25F33);
  static const orange200 = Color(0xFFFFA500);
  static const error = Color(0xFFDC3545);

  static const malachite50 = Color(0xFFE7FAF1);
  static const malachite100 = Color(0xFFD1FAE5);
  static const malachite200 = Color(0xFFA7F3D0);
  static const malachite300 = Color(0xFF6EE7B7);
  static const malachite400 = Color(0xFF34D399);
  static const malachite500 = Color(0xFF10B981);
  static const malachite600 = Color(0xFF059669);
  static const malachite700 = Color(0xFF047857);
  static const malachite800 = Color(0xFF065F46);
  static const malachite900 = Color(0xFF064E3B);
  static const malachite950 = Color(0xFF022C22);

  static const dainTree50 = Color(0xFFedfefe);
  static const dainTree100 = Color(0xFFC6F6D5);
  static const dainTree200 = Color(0xFFabf4f6);
  static const dainTree300 = Color(0xFF71eaef);
  static const dainTree400 = Color(0xFF30d7e0);
  static const dainTree500 = Color(0xFF14bac6);

  static const dainTree600 = Color(0xFF1495a6);
  static const dainTree700 = Color(0xFF177887);
  static const dainTree800 = Color(0xFF1c616e);
  static const dainTree900 = Color(0xFF1b515e);
  static const dainTree950 = Color(0xFF08232a);
}

class LightColors {
  // text colors
  static Color textHeading = GlobalColors.dainTree950;
  static Color textBody = GlobalColors.grey500;
  static Color textBrand = GlobalColors.primary;
  static Color textAccent = GlobalColors.dainTree500;
  static Color textPlaceholder = GlobalColors.grey300;
  static Color textInvert = GlobalColors.malachite50;

  // border colors
  static Color borderPrimary = GlobalColors.grey300;
  static Color borderSecondary = GlobalColors.malachite50;
  static Color borderTertiary = GlobalColors.grey200;
  static Color borderBrand = GlobalColors.primary;

  // surface colors
  static Color surfacePrimary = Colors.white;
  static Color surfaceSecondary = GlobalColors.malachite50;
  static Color surfaceAccent = GlobalColors.grey50;
  static Color surfaceBrand = GlobalColors.primary;
  static Color surfaceInvert = GlobalColors.forestGreen;

  // icon colors
  static Color iconPrimary = GlobalColors.dainTree950;
  static Color iconSecondary = GlobalColors.grey500;
  static Color iconAccent = GlobalColors.grey300;
  // we don't actually need this but because the design
  // used the iconInvert we just add it as a comment to remember
  // static Color iconInvert = surfacePrimary;

  // background colors
  static Background background = Background(false);

  // foreground colors
  static Foreground foreground = Foreground(false);
}

class DarkColors {
  // text colors
  static Color textPrimary = GlobalColors.malachite50;
  static Color textSecondary = GlobalColors.grey300;
  static Color textBrand = GlobalColors.primary;
  static Color textInvert = GlobalColors.darkGreen;
  static Color textPlaceholder = GlobalColors.grey500;

  // surface colors
  static Color surfacePrimary = const Color.fromARGB(255, 8, 9, 8);
  static Color surfaceSecondary = const Color.fromARGB(255, 20, 21, 21);
  static Color surfaceAccent = GlobalColors.grey50;
  static Color surfaceBrand = GlobalColors.primary;
  static Color surfaceInvert = GlobalColors.malachite50;

  // border colors
  static Color borderPrimary = GlobalColors.grey300;
  static Color borderSecondary = GlobalColors.hunterGreen;
  static Color borderBrand = GlobalColors.primary;
  static Color borderInput = GlobalColors.grey500;

  // background colors
  static Background background = Background(true);

  // foreground colors
  static Foreground foreground = Foreground(true);
}

class Background {
  Background(this.isDarkTheme) {
    surface = BackgroundSurface(isDarkTheme);
    fill = BackgroundFill(isDarkTheme);
  }
  final bool isDarkTheme;
  late final BackgroundSurface surface;
  late final BackgroundFill fill;
}

class BackgroundSurface {
  BackgroundSurface(this.isDarkTheme);
  final bool isDarkTheme;
  Color get primary =>
      isDarkTheme ? GlobalColors.malachite50 : GlobalColors.malachite50;
  Color get secondary =>
      isDarkTheme ? GlobalColors.dainTree50 : GlobalColors.dainTree50;
  Color get accent => isDarkTheme ? GlobalColors.grey50 : GlobalColors.grey50;

  // purple
  Color get purple => isDarkTheme
      ? GlobalColors.purpleDark.withValues(alpha: 0.1)
      : GlobalColors.purpleDark.withValues(alpha: 0.1);

  // dark green
  Color get darkGreen =>
      isDarkTheme ? GlobalColors.darkGreen : GlobalColors.darkGreen;

  // forest green
  Color get forestGreen =>
      isDarkTheme ? GlobalColors.forestGreen : GlobalColors.forestGreen;

  // hunter green
  Color get hunterGreen =>
      isDarkTheme ? GlobalColors.hunterGreen : GlobalColors.hunterGreen;
}

// background fill colors
class BackgroundFill {
  BackgroundFill(this.isDarkTheme);
  final bool isDarkTheme;
  Color get primary =>
      isDarkTheme ? GlobalColors.malachite500 : GlobalColors.malachite500;
  Color get secondary =>
      isDarkTheme ? GlobalColors.dainTree950 : GlobalColors.dainTree950;
  Color get accent =>
      isDarkTheme ? GlobalColors.malachite100 : GlobalColors.malachite100;

  // purple
  Color get purple =>
      isDarkTheme ? GlobalColors.purpleDark : GlobalColors.purpleDark;
  Color get purpleLight =>
      isDarkTheme ? GlobalColors.purpleLight : GlobalColors.purpleLight;

  // orange
  Color get orange => isDarkTheme ? GlobalColors.orange : GlobalColors.orange;
  Color get primaryDark =>
      isDarkTheme ? GlobalColors.darkGreen : GlobalColors.darkGreen;
}

class Foreground {
  Foreground(this.isDarkTheme);
  final bool isDarkTheme;
  Color get textAccent =>
      isDarkTheme ? GlobalColors.dainTree500 : GlobalColors.dainTree500;
  Color get textInvert =>
      isDarkTheme ? GlobalColors.malachite50 : GlobalColors.malachite50;

  Color get iconAccent =>
      isDarkTheme ? GlobalColors.grey300 : LightColors.iconAccent;

  Color get borderTertiary =>
      isDarkTheme ? DarkColors.borderBrand : LightColors.borderTertiary;

  Color get borderPrimary =>
      isDarkTheme ? DarkColors.borderPrimary : LightColors.borderPrimary;
}
