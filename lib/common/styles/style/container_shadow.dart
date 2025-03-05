import 'package:flutter/material.dart';

BoxShadow containerShadow(BuildContext context) => BoxShadow(
  color: Theme.of(context).colorScheme.tertiary,
  blurRadius: 3,
  offset: const Offset(-1, 1),
);
