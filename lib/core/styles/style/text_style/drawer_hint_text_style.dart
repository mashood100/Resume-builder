import 'package:flutter/material.dart';

TextStyle drawerHintTextStyle(BuildContext context) => TextStyle(
      fontSize: 14,
      height: 0.1,
      color: Theme.of(context).inputDecorationTheme.hintStyle!.color,
    );
