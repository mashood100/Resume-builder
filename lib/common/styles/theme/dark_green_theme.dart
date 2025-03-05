import 'package:flutter/material.dart';
import '../../constants/padding.dart';
import '../../constants/radius.dart';
import 'colors.dart';

ThemeData greenDarkModeThemeData() {
  final englishFont = 'Manrope';
  // final arabicFont = 'Rudaw';
  // final kurdishFont = 'Shabnam';

  final selectedFont = englishFont;

  //  switch (locale.languageCode) {
  //   'en' => englishFont,
  //   'ar' => arabicFont,
  //   'ku' => kurdishFont,
  //   _ => englishFont,
  // };

  return ThemeData(
    primaryColor: DarkColors.surfaceBrand,
    primaryColorDark: GlobalColors.forestGreen,
    // appBarTheme: AppBarTheme(
    //   backgroundColor: DarkColors.surfacePrimary,
    //   surfaceTintColor: Colors.transparent,
    //   titleTextStyle: TextStyle(
    //     fontSize: 16,
    //     fontFamily: selectedFont,
    //     color: DarkColors.textPrimary,
    //     fontWeight: FontWeight.w600,
    //   ),
    // ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: GlobalColors.hunterGreen,
      contentTextStyle: TextStyle(
        fontSize: 14,
        fontFamily: selectedFont,
        color: GlobalColors.white,
      ),
    ),
    textSelectionTheme:
        TextSelectionThemeData(cursorColor: DarkColors.textBrand),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: DarkColors.surfaceSecondary,
      filled: true,
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1),
        borderRadius: borderRadius8,
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2),
        borderRadius: borderRadius8,
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent, width: 0),
        borderRadius: borderRadius8,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: DarkColors.borderBrand, width: 2),
        borderRadius: borderRadius8,
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent, width: 0),
        borderRadius: borderRadius8,
      ),
      hintStyle: TextStyle(
        fontSize: 14,
        height: 1,
        fontWeight: FontWeight.normal,
        color: DarkColors.textPlaceholder,
      ),
      errorStyle: const TextStyle(color: Colors.red, fontSize: 10, height: 0.7),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 13.7, horizontal: 12),
      prefixIconColor: WidgetStateColor.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.focused) &&
            !states.contains(WidgetState.error)) {
          return GlobalColors.primary;
        }
        return DarkColors.textPlaceholder;
      }),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: DarkColors.textSecondary,
      unselectedLabelColor: DarkColors.textPlaceholder,
      indicatorColor: DarkColors.borderBrand,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.normal,
      ),
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: DarkColors.borderBrand,
          ),
        ),
      ),
    ),
    dividerColor: DarkColors.textPlaceholder.withAlpha(102),
    dividerTheme: DividerThemeData(
      space: 0,
      thickness: 1,
      color: DarkColors.textPlaceholder.withAlpha(102),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: DarkColors.textSecondary,
      selectedItemColor: DarkColors.textBrand,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      unselectedLabelStyle: const TextStyle(fontSize: 11),
      selectedLabelStyle: const TextStyle(fontSize: 11),
      backgroundColor: DarkColors.surfaceSecondary,
      elevation: 10,
    ),
    shadowColor: Colors.black.withAlpha(51),
    splashColor: GlobalColors.malachite500.withAlpha(25),
    canvasColor: DarkColors.surfacePrimary,
    textTheme: _darkTextTheme(TextTheme(
      bodyLarge: TextStyle(
        fontSize: 15,
        color: DarkColors.textPrimary,
        fontFamily: selectedFont,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Colors.white.withAlpha(153),
        fontFamily: selectedFont,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: DarkColors.textSecondary,
        fontFamily: selectedFont,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white.withAlpha(153),
        fontFamily: selectedFont,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white.withAlpha(153),
        fontFamily: selectedFont,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white.withAlpha(153),
        fontFamily: selectedFont,
      ),
      labelSmall: TextStyle(
        fontSize: 12,
        color: DarkColors.textBrand,
        fontFamily: selectedFont,
      ),
      labelMedium: TextStyle(
        fontSize: 14,
        color: DarkColors.textSecondary,
        fontFamily: selectedFont,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        color: DarkColors.textPrimary,
        fontFamily: selectedFont,
      ),
    )),
    cardColor: DarkColors.surfaceSecondary,
    cardTheme: CardTheme(
      shape: const RoundedRectangleBorder(borderRadius: borderRadius8),
      color: DarkColors.surfaceSecondary,
      elevation: 10,
    ),
    dialogTheme: DialogTheme(
      shape: const RoundedRectangleBorder(borderRadius: borderRadius8),
      actionsPadding: paddingAll16,
      backgroundColor: DarkColors.surfaceSecondary,
      titleTextStyle: TextStyle(
        color: DarkColors.textPrimary,
        fontSize: 18,
        fontFamily: selectedFont,
      ),
      surfaceTintColor: GlobalColors.bgCard,
    ),
    listTileTheme: ListTileThemeData(
      selectedTileColor: DarkColors.surfaceSecondary,
      textColor: DarkColors.textPrimary,
      tileColor: DarkColors.surfaceSecondary,
    ),
    datePickerTheme: DatePickerThemeData(
      surfaceTintColor: DarkColors.surfaceSecondary,
      backgroundColor: DarkColors.surfaceSecondary,
      dayStyle: const TextStyle(fontSize: 14),
      weekdayStyle: const TextStyle(fontSize: 14),
      yearStyle: const TextStyle(fontSize: 14),
      headerHeadlineStyle: const TextStyle(fontSize: 16),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: const TextStyle(fontSize: 14),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(DarkColors.surfaceSecondary),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: DarkColors.surfacePrimary,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: DarkColors.surfacePrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: const RoundedRectangleBorder(borderRadius: borderRadius24),
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        foregroundColor: DarkColors.textPrimary,
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(borderRadius: borderRadius24),
        padding: paddingV0,
        fixedSize: const Size(double.infinity, 62),
        backgroundColor: GlobalColors.primary,
        foregroundColor: DarkColors.surfacePrimary,
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: GlobalColors.primary,
        foregroundColor: DarkColors.surfaceInvert,
        shape: const RoundedRectangleBorder(borderRadius: borderRadius24),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(borderRadius: borderRadius24),
        padding: paddingV0,
        side: const BorderSide(color: GlobalColors.primary),
        foregroundColor: GlobalColors.primary,
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    ),
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: Colors.black,
      selectedIconTheme:
          IconThemeData(color: GlobalColors.malachite50.withAlpha(25)),
      unselectedIconTheme: const IconThemeData(color: Colors.grey),
      selectedLabelTextStyle: TextStyle(
        color: DarkColors.textBrand,
        fontFamily: selectedFont,
      ),
      unselectedLabelTextStyle: TextStyle(
        color: Colors.grey,
        fontFamily: selectedFont,
      ),
    ),
    scaffoldBackgroundColor: DarkColors.surfacePrimary,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      surface: DarkColors.surfacePrimary,
      onSurface: DarkColors.textPrimary,
      surfaceBright: GlobalColors.malachite50,
      primary: GlobalColors.primary,
      onPrimary: GlobalColors.malachite950,
      secondary: GlobalColors.malachite500,
      onSecondary: GlobalColors.malachite600,
      error: Colors.red,
      onError: const Color.fromARGB(84, 244, 67, 54),
      tertiary: GlobalColors.grey200,
      onTertiary: const Color.fromARGB(255, 47, 47, 47),
      outline: DarkColors.textSecondary,
      outlineVariant: DarkColors.borderInput,
      surfaceTint: DarkColors.surfaceSecondary,
      onTertiaryFixedVariant: GlobalColors.primary.withAlpha(25),
      tertiaryFixed: GlobalColors.grey950,
      tertiaryFixedDim: DarkColors.surfaceSecondary,
    ),
  );
}

TextTheme _darkTextTheme(TextTheme textTheme) {
  return textTheme.copyWith(
    bodyLarge: textTheme.bodyLarge,
    bodyMedium: textTheme.bodyMedium,
    bodySmall: textTheme.bodySmall,
    titleLarge: textTheme.titleLarge,
    titleMedium: textTheme.titleMedium,
    titleSmall: textTheme.titleSmall,
    labelSmall: textTheme.labelSmall,
    labelMedium: textTheme.labelMedium,
    labelLarge: textTheme.labelLarge,
  );
}
