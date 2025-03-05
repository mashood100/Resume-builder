import 'package:flutter/material.dart';

import '../../constants/radius.dart';



ButtonStyle deleteButtonStyleWithBG(BuildContext context) =>
    TextButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.error,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius6,
        side: BorderSide(color: Theme.of(context).colorScheme.error),
      ),
    );

ButtonStyle deleteButtonStyleWithoutBG(BuildContext context) =>
    TextButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.error,
      side: BorderSide(color: Theme.of(context).colorScheme.error),
      shape: const RoundedRectangleBorder(borderRadius: borderRadius6),
    );
