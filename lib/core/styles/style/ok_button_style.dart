import 'package:flutter/material.dart';
import '../../constants/radius.dart';

ButtonStyle okButtonStyle(BuildContext context) => TextButton.styleFrom(
  
      backgroundColor:
          Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.1),
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      shape: const RoundedRectangleBorder(borderRadius: borderRadius6),
      textStyle: Theme.of(context).textTheme.bodyMedium,
    );
