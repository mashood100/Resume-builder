import 'package:flutter/material.dart';
import '../../constants/padding.dart';
import '../../constants/radius.dart';
import '../theme/colors.dart';

ButtonStyle outlineButtonStyleSmall(BuildContext context) {
  return OutlinedButton.styleFrom(
    side: BorderSide(
      color: Theme.of(context).colorScheme.outlineVariant,
      width: 0.5,
    ),
    fixedSize: const Size.fromHeight(36),
    foregroundColor: Theme.of(context).colorScheme.outline,
    overlayColor: Theme.of(context).colorScheme.tertiaryFixed,
    textStyle: TextStyle(
      fontSize: 13,
      color: Theme.of(context).textTheme.bodySmall?.color,
      overflow: TextOverflow.ellipsis,
      fontWeight: FontWeight.w500,
    ),
    padding: const EdgeInsets.symmetric(horizontal: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );
}

ButtonStyle outlineButtonStyleBig(BuildContext context) {
  return outlineButtonStyleSmall(context).copyWith(
    fixedSize: WidgetStateProperty.all(const Size.fromHeight(40)),
    textStyle: WidgetStateProperty.all(
      const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

ButtonStyle primaryOutlinedButtonStyle(BuildContext context) {
  final theme = Theme.of(context);
  final isDark = theme.brightness == Brightness.dark;
  if (isDark) {
    // dark theme
    return OutlinedButton.styleFrom(
      shape: const RoundedRectangleBorder(borderRadius: borderRadius12),
      side: BorderSide(color: theme.primaryColor, width: 0.5),
      foregroundColor: theme.primaryColor,
      fixedSize: const Size(100, 36),
      padding: paddingAll0,
      textStyle: TextStyle(
        fontSize: 13,
        color: theme.primaryColor,
        overflow: TextOverflow.ellipsis,
      ),
      overlayColor: GlobalColors.grey700,
    );
  } else {
    // light theme
    return OutlinedButton.styleFrom(
      shape: const RoundedRectangleBorder(borderRadius: borderRadius12),
      side: BorderSide(color: theme.primaryColor, width: 0.5),
      foregroundColor: theme.primaryColor,
      padding: paddingAll0,
      fixedSize: const Size(100, 36),
      textStyle: TextStyle(
        fontSize: 13,
        color: theme.primaryColor,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
