import 'package:flutter/material.dart';

import '../../constants/padding.dart';
import '../../constants/radius.dart';
import 'colors.dart';

ThemeData greenLightModeThemeData() {
  final englishFont = 'Manrope';
  // final arabicFont = 'Rudaw';
  // final kurdishFont = 'Shabnam';

  final selectedFont = englishFont;

  // switch (locale.languageCode) {
  //   'en' => englishFont,
  //   'ar' => arabicFont,
  //   'ku' => kurdishFont,
  //   _ => englishFont,
  // };

  return ThemeData(
    primaryColor: LightColors.surfaceBrand,
    primaryColorDark: GlobalColors.forestGreen,
    appBarTheme: AppBarTheme(
      backgroundColor: LightColors.surfacePrimary,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontFamily: selectedFont,
        color: LightColors.textHeading,
        fontWeight: FontWeight.w600,
      ),
    ),
    // snackBarTheme: SnackBarThemeData(
    //   backgroundColor: GlobalColors.primaryLight,
    //   contentTextStyle: TextStyle(
    //     fontSize: 14,
    //     fontFamily: selectedFont,
    //     color: LightColors.textHeading,
    //   ),
    // ),
    tabBarTheme: TabBarTheme(
      labelColor: LightColors.textBody,
      unselectedLabelColor: LightColors.textPlaceholder,
      indicatorColor: LightColors.borderBrand,
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
            color: LightColors.borderBrand,
          ),
        ),
      ),
    ),
    scrollbarTheme: ScrollbarThemeData(
      thumbColor:
          WidgetStateProperty.all(GlobalColors.grey500.withValues(alpha: 0.1)),
    ),
    dataTableTheme: DataTableThemeData(
      headingTextStyle: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: LightColors.textBody,
        fontFamily: selectedFont,
        overflow: TextOverflow.ellipsis,
      ),
      dividerThickness: 0.5,
      dataTextStyle: TextStyle(
        fontSize: 14,
        color: LightColors.textBody,
      ),
      headingRowHeight: 42,
      headingRowColor:
          WidgetStateProperty.all(LightColors.background.surface.primary),
    ),
    textSelectionTheme:
        TextSelectionThemeData(cursorColor: LightColors.textBrand),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      hoverColor: Colors.transparent,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: LightColors.borderPrimary, width: 0.5),
        borderRadius: borderRadius8,
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: GlobalColors.error, width: 0.5),
        borderRadius: borderRadius8,
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: GlobalColors.error, width: 1),
        borderRadius: borderRadius8,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: LightColors.borderBrand, width: 1),
        borderRadius: borderRadius8,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: LightColors.borderPrimary, width: 0.5),
        borderRadius: borderRadius8,
      ),
      hintStyle: TextStyle(
        fontSize: 14,
        height: 1,
        fontWeight: FontWeight.normal,
        color: LightColors.textPlaceholder,
      ),
      errorStyle:
          const TextStyle(color: GlobalColors.error, fontSize: 10, height: 0.7),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 13.6),
      prefixIconColor: WidgetStateColor.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.focused)) {
          return GlobalColors.primary;
        }
        return LightColors.textPlaceholder;
      }),
      suffixIconColor: LightColors.textPlaceholder,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: LightColors.textBody,
      selectedItemColor: LightColors.textBrand,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      unselectedLabelStyle: const TextStyle(fontSize: 12),
      selectedLabelStyle: const TextStyle(fontSize: 12),
    ),
    dividerColor: LightColors.textPlaceholder.withAlpha(102),
    dividerTheme: DividerThemeData(
      space: 0,
      thickness: 1,
      color: LightColors.textPlaceholder.withAlpha(102),
    ),
    shadowColor: Colors.grey.shade200,
    splashColor: GlobalColors.malachite100,
    highlightColor: GlobalColors.malachite100,
    canvasColor: LightColors.surfacePrimary,
    cardColor: Colors.white,
    cardTheme: const CardTheme(
      shape: RoundedRectangleBorder(borderRadius: borderRadius8),
      color: Colors.white,
    ),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: SegmentedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: LightColors.textBody,
        selectedForegroundColor: LightColors.textHeading,
        selectedBackgroundColor: LightColors.background.surface.accent,
      ),
    ),
    textTheme: TextTheme(
      bodySmall: TextStyle(
        fontSize: 12,
        color: LightColors.textBody,
        fontFamily: selectedFont,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: LightColors.textHeading,
        fontFamily: selectedFont,
      ),
      bodyLarge: TextStyle(
        fontSize: 14,
        color: LightColors.textHeading,
        fontFamily: selectedFont,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: LightColors.textHeading,
        fontFamily: selectedFont,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: LightColors.textHeading,
        fontFamily: selectedFont,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: LightColors.textHeading,
        fontFamily: selectedFont,
      ),
      labelSmall: TextStyle(
        fontSize: 13,
        color: LightColors.textHeading,
        fontFamily: selectedFont,
      ),
      labelMedium: TextStyle(
        fontSize: 15,
        color: LightColors.textHeading,
        fontFamily: selectedFont,
        fontWeight: FontWeight.w600,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        color: LightColors.textHeading,
        fontFamily: selectedFont,
      ),
    ),
    primaryTextTheme: TextTheme(
      bodySmall: TextStyle(
        fontSize: 12,
        color: LightColors.textBody,
        fontFamily: selectedFont,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: LightColors.textHeading,
        fontFamily: selectedFont,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: LightColors.textHeading,
        fontFamily: selectedFont,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: LightColors.textHeading,
        fontFamily: selectedFont,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: LightColors.textHeading,
        fontFamily: selectedFont,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: LightColors.textHeading,
        fontFamily: selectedFont,
      ),
      labelSmall: TextStyle(
        fontSize: 12,
        color: LightColors.textHeading,
        fontFamily: selectedFont,
      ),
      labelMedium: TextStyle(
        fontSize: 14,
        color: LightColors.textHeading,
        fontFamily: selectedFont,
        fontWeight: FontWeight.w600,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        color: LightColors.textHeading,
        fontFamily: selectedFont,
      ),
    ),
    dialogTheme: DialogTheme(
      shape: const RoundedRectangleBorder(borderRadius: borderRadius8),
      actionsPadding: paddingAll16,
      backgroundColor: LightColors.surfacePrimary,
      surfaceTintColor: Colors.white,
      titleTextStyle: TextStyle(
        color: LightColors.textHeading,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: selectedFont,
      ),
      contentTextStyle: TextStyle(
        color: LightColors.textBody,
        fontSize: 13,
        fontFamily: selectedFont,
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      dayStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
      weekdayStyle: const TextStyle(fontSize: 14),
      yearStyle: const TextStyle(fontSize: 14),
      headerHeadlineStyle: const TextStyle(fontSize: 16),
      confirmButtonStyle: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        overlayColor: Colors.transparent,
      ),
    ),
    dropdownMenuTheme: const DropdownMenuThemeData(
      textStyle: TextStyle(
        fontSize: 14,
      ),
      menuStyle: MenuStyle(),
    ),
    listTileTheme: ListTileThemeData(
      selectedTileColor: LightColors.surfaceSecondary,
      textColor: LightColors.textHeading,
      tileColor: Colors.white,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: LightColors.surfacePrimary,
      labelTextStyle: WidgetStatePropertyAll(
        TextStyle(
          fontSize: 12,
          color: LightColors.textBody,
          fontFamily: selectedFont,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: const RoundedRectangleBorder(borderRadius: borderRadius12),
        padding: paddingV0,
        fixedSize: const Size.fromHeight(40),
        foregroundColor: LightColors.textHeading,
        overlayColor: GlobalColors.grey700,
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(borderRadius: borderRadius12),
        padding: paddingV0,
        fixedSize: const Size.fromHeight(40),
        backgroundColor: GlobalColors.primary,
        foregroundColor: LightColors.surfacePrimary,
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        overlayColor: GlobalColors.grey700,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: GlobalColors.primary,
        foregroundColor: LightColors.surfaceInvert,
        fixedSize: const Size.fromHeight(40),
        shape: const RoundedRectangleBorder(borderRadius: borderRadius12),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        overlayColor: GlobalColors.grey700,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(borderRadius: borderRadius12),
        side: const BorderSide(color: GlobalColors.primary, width: 0.5),
        foregroundColor: GlobalColors.primary,
        fixedSize: const Size(95, 36),
        textStyle: const TextStyle(
          fontSize: 13,
          color: GlobalColors.primary,
          overflow: TextOverflow.ellipsis,
        ),
        overlayColor: GlobalColors.grey700,
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStatePropertyAll(LightColors.iconSecondary),
        overlayColor: WidgetStatePropertyAll(
            LightColors.borderTertiary.withValues(alpha: 0.2)),
      ),
    ),
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: Colors.white,
      selectedIconTheme: IconThemeData(color: LightColors.textHeading),
      unselectedIconTheme: IconThemeData(color: LightColors.textBody),
      indicatorColor: GlobalColors.malachite50,
      selectedLabelTextStyle: TextStyle(
        color: LightColors.textHeading,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: selectedFont,
      ),
      unselectedLabelTextStyle: TextStyle(
        color: LightColors.textHeading,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontFamily: selectedFont,
      ),
    ),
    scaffoldBackgroundColor: LightColors.surfacePrimary,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      surface: LightColors.surfacePrimary,
      onSurface: LightColors.textBody,
      surfaceBright: GlobalColors.malachite50,
      primary: GlobalColors.primary,
      onPrimary: GlobalColors.malachite600,
      secondary: GlobalColors.malachite500,
      onSecondary: GlobalColors.malachite400,
      error: GlobalColors.error,
      onError: const Color.fromARGB(72, 178, 59, 59),
      tertiary: LightColors.borderTertiary,
      onTertiary: GlobalColors.grey100,
      outline: LightColors.background.surface.accent,
      outlineVariant: LightColors.borderPrimary,
      surfaceTint: LightColors.surfaceSecondary,
      onTertiaryFixedVariant: GlobalColors.primary.withAlpha(25),
      tertiaryFixedDim: GlobalColors.grey75,
      tertiaryFixed: GlobalColors.grey500,
      onTertiaryContainer: GlobalColors.grey50,
    ),
  );
}
