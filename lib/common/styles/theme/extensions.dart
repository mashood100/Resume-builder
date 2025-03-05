// get colors according to the theme

import 'package:flutter/material.dart';

import 'colors.dart';
// import 'dark_green_theme.dart';
// import 'light_green_theme.dart';

extension ThemeColors on BuildContext {

  // check the theme
  bool get isDarkTheme => Theme.of(this).brightness == Brightness.dark;

  Background get background =>
      isDarkTheme ? DarkColors.background : LightColors.background;

  Foreground get foreground =>
      isDarkTheme ? DarkColors.foreground : LightColors.foreground;
}
